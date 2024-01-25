from flask import Flask
import mysql.connector

app = Flask(__name__)


#function to establish MySQL connection
def get_mysql_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="abhi_root",
        database="leaderboard"
    )

@app.route("/")
def welcome():
    welcome_message = {
        "API Instructions":{
            "API_1": "For accessing the 1st API, use the link '/API_1'",
            "API_2": "For accessing the 2nd API, use the link '/API_2/CountryCode' (Choose Country codes from [IN, US, JP, RU, GB, ES, MX, SA, PT, BR, KR, AF])",
            "API_3": "For accessing the 3rd API, use the link '/API_3/userID'",
        }
    }
    return {"Welcome BlackLight Gaming":welcome_message}

#For API 1: Display current week leaderboard (Top 200)
@app.route("/API_1", methods=["GET"])
def current_week_leaderboard():
    try:
        conn = get_mysql_connection()
        cur = conn.cursor(dictionary=True)

        #MYSQL query for getting the required data
        cur.execute("SELECT * FROM user WHERE TimeStamp >= CURDATE() - INTERVAL WEEKDAY(CURDATE()) DAY ORDER BY Score DESC LIMIT 200;")

        res = cur.fetchall()
    except:
        print("Error is there")
    finally:
        # Close the cursor and connection in the finally block
        if cur:
            cur.close()
        if conn:
            conn.close()

    if len(res)>0:
        return {"result": res}
    else:
        return {"message":"NO MATCHING ROWS FOR GIVEN API-QUERY"}
 
#For API 2: Display last week leaderboard given a country by the user (Top 200)
@app.route("/API_2/<country_code>", methods=["GET"])
def last_week_leaderboard(country_code):
    try:
        conn = get_mysql_connection()
        cur = conn.cursor(dictionary=True)
        
        #MYSQL query for getting the required data
        cur.execute("""SELECT * FROM user 
            WHERE TimeStamp >= CURDATE() - INTERVAL WEEKDAY(CURDATE()) + 1 DAY - INTERVAL 1 WEEK 
              AND TimeStamp < CURDATE() - INTERVAL WEEKDAY(CURDATE()) + 1 DAY 
              AND Country = %s
            ORDER BY Score DESC LIMIT 200;""", (country_code,))
        
        res = cur.fetchall()
    except:
        print("Error is there")
    finally:
        #close the cursor and connection
        if cur:
            cur.close()
        if conn:
            conn.close()

    if len(res)>0:
        return {"result": res}
    else:
        return {"message":"NO MATCHING ROWS FOR GIVEN API-QUERY"}

#For API 3: Fetch user rank, given the userId
@app.route("/API_3/<user_id>", methods=["GET"])
def user_rank(user_id):
    try:
        conn = get_mysql_connection()
        cur = conn.cursor(dictionary=True)

        #MYSQL query for getting the required data
        cur.execute("SELECT UID, Name, Score, Country, 1000 - Score + 1 AS User_Rank FROM user WHERE UID = %s;", (user_id,))
        
        res = cur.fetchone()
    except:
        print("Error is there")
    finally:
        #close the cursor and connection
        if cur:
            cur.close()
        if conn:
            conn.close()

    if len(res)>0:
        return {"result": res}
    else:
        return {"message":"NO MATCHING ROWS FOR GIVEN API-QUERY"}

if __name__ == "__main__":
    app.run(debug=True)