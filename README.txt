This Folder contains the following contents:
API Folder under which the work for the API is done and "app.py" is present
MYSQL_database folder which contains the dump folder of database and SQL code to create that database

STEPS to Run the assignment on your local machine:
MYSQL_BACKEND Work-
1) Open the MYSQL Workbench and create a new sql query file
2) Copy-paste the code present in MYSQL_database folder with name "leaderboard_sql_code"
3) Your database is made and you can now move on to API code

API_code in Vscode(or other ide's)-
1) In you laptop python & pip should be installed and updated
2) Open new terminal and move to the folder API of this assignment and do the following
    a) To create a new virtual environment- python -m venv newvenv
    b) To start the new environment- ./newvenv/Scripts/activate
    c) To install dependencies- pip install -r requirements.txt
    d) $env:FLASK_APP="app";$env:FLASK_ENV="development";$env:PYTHONDONTWRITEBYTECODE=1
    e) Now, run the code by - flask run
    NOTE-
        If you get any error at a or b step then use this command:
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser 
3) After this you can follow the link provided and use the APIs (general without hosting on Local machine)