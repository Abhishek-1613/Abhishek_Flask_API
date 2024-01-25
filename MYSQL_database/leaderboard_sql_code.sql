-- only use this when you already have this database
-- DROP DATABASE IF EXISTS leaderboard;

-- creating a database named 'leaderboard' if it does not exist N' using it
CREATE DATABASE IF NOT EXISTS leaderboard;
USE leaderboard;

-- creating a table named 'user' within the 'leaderboard' database
CREATE TABLE IF NOT EXISTS user (
    UID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Score INT NOT NULL,
    Country CHAR(2) NOT NULL,
    TimeStamp TIMESTAMP NOT NULL
);

-- now we will fill the table with 10000+ random data but with certain conditions
-- UID will be between 1-10000+ and there will be 10000 rows
-- name is a random 5-letter word
-- Score is between 500-1000
-- Country is chosen from the given set of list (as it will be easy for us when we create a query for 2nd API)
-- TimeStamp will be within 15 days from the current date and time (it will be easy when we create a query for 1st and 2nd API)

-- i have to create a procedure to run while loop so that
-- 400 rows is added for 25 times which makes the table according to our need
DELIMITER //
CREATE PROCEDURE InsertUserWithSequentialUID()
BEGIN
    -- batch size and total number of batches
    SET @batch_size = 400;
    SET @total_batches = 26;
    -- WHILE loop begins
    WHILE @total_batches > 0 DO
        -- starting UID for the current batch is calculated
        SET @start_uid = (@batch_size * (@total_batches - 1));
        -- current_uid for tracking in current batch
        SET @current_uid = @start_uid;
        -- rwos are inserted in table user
        INSERT INTO user (UID, Name, Score, Country, TimeStamp)
        SELECT
            @current_uid := @current_uid + 1 AS UID,
            SUBSTRING(MD5(RAND()), 1, 5) AS Name,
            FLOOR(RAND() * 501) + 500 AS Score,
            CASE
                WHEN RAND() < 0.05 THEN 'IN'
                WHEN RAND() < 0.1 THEN 'US'
                WHEN RAND() < 0.15 THEN 'JP'
                WHEN RAND() < 0.2 THEN 'RU'
                WHEN RAND() < 0.25 THEN 'GB'
                WHEN RAND() < 0.3 THEN 'ES'
                WHEN RAND() < 0.35 THEN 'MX'
                WHEN RAND() < 0.4 THEN 'SA'
                WHEN RAND() < 0.45 THEN 'PT'
                WHEN RAND() < 0.5 THEN 'BR'
                WHEN RAND() < 0.55 THEN 'KR'
                WHEN RAND() < 0.6 THEN 'AF'
                WHEN RAND() < 0.65 THEN 'IN'
                WHEN RAND() < 0.7 THEN 'US'
                WHEN RAND() < 0.75 THEN 'JP'
                WHEN RAND() < 0.8 THEN 'RU'
                WHEN RAND() < 0.85 THEN 'GB'
                WHEN RAND() < 0.9 THEN 'ES'
                WHEN RAND() < 0.95 THEN 'MX'
                WHEN RAND() < 1.0 THEN 'SA'
                ELSE 'IN'
            END AS Country,
            NOW() - INTERVAL FLOOR(RAND() * 15) DAY
        FROM
            (SELECT 1 AS dummy UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
             SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20) dummy_table1
            CROSS JOIN
            (SELECT 1 AS dummy UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
             SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20) dummy_table2
        ORDER BY RAND()
        LIMIT 400;

        -- Decrement the total batches for the next run
        SET @total_batches = @total_batches - 1;
    END WHILE;
END //
DELIMITER ;
-- calling the procedure to add rows to the table
CALL InsertUserWithSequentialUID();
--
-- code completes here for creation of database and table user

-- query for different API's 

