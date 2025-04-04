-- Database Formation:-

create database assignment;
use assignment;

-- Table Formation:-

create table  Fifa_details(
ID	INT PRIMARY KEY,
Name	VARCHAR(60),
Age	INT,
Nationality	VARCHAR(50),
Overall_rating	INT,
Potential_rating	INT,
Club	VARCHAR(60),
Value	DECIMAL(10,2),
Wage	INT,
Preferred_Foot	VARCHAR(10),
Jersey_No	INT,
Joined	DATE,
Height	INT,
Weight	INT,
Penalties INT
);
desc Fifa_details;



 -- Load Data:-

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/fifa/FIFA_CLEAN_Final.csv"
INTO TABLE Fifa_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID, Name, Age, Nationality, Overall_rating, Potential_rating, Club, Value, Wage, Preferred_Foot, Jersey_No, Joined, Height, Weight, Penalties)
SET 
    ID = TRIM(ID) + 0; 



-- 1. Retrieve all players' information from the table. 

 select * from fifa_details; 
 
 -- 2. Get the names and ages of players with an overall rating above 85.

select name, age from Fifa_Details 
where Overall_rating>85;

-- 3. Find the nationality and potential rating of players with a value over 50 million. 

select nationality, potential_rating from Fifa_Details
where value >50;

-- 4. List the names, clubs, and wages of players who prefer their left foot.

select name, club, wage from fifa_details
where preferred_foot like 'le%';

-- 5. Retrieve players' names, ages, and weights who weight over 70 kg and have a penalty rating above 70.

SELECT * FROM Fifa_Details WHERE Weight < 40 OR Weight > 100;

UPDATE Fifa_Details      -- To remove outlier
SET Weight = 75
WHERE Weight < 40 OR Weight > 100;

SELECT * FROM Fifa_Details WHERE Weight < 40 OR Weight > 100;

select name, age, weight from fifa_details
where  weight >70 and Penalties >70;
-- There is nothing like this condition.

-- 6. Get the average overall rating of players in the table. 

select avg(Overall_rating) as average_overall_rating from fifa_details;

-- 7. Find the tallest player's name, height, and jersey number. 

select height from fifa_details;   -- It is shown that height column is in 'inch' unit, so it should  in 'centimeter' unit

UPDATE Fifa_details
SET Height = Height * 2.54;

select height from fifa_details;

SELECT Name, Height, Jersey_No  FROM fifa_details  
ORDER BY Height DESC  
LIMIT 1;


-- 8. List the name of the player whose age is between 18 to 25 .

select name, age from fifa_details
where age between 18 and 25
order by age asc;


-- 9. Find the nationality, value, and preferred foot of players with a potential rating above 90. 

select nationality, value, preferred_foot from Fifa_Details
where potential_rating >90;


-- 10. Retrieve players with a wage greater than 100,000 and a potential rating above 85. 

select name, wage, potential_rating from Fifa_Details
where wage >100000 and potential_rating >85;


-- 11. List the names and heights of players who are taller than 180 cm and weight less than 75 kg. 

select name, height from Fifa_Details
where height >180 and weight <75;


-- 12. Retrieve players with a potential rating greater than their overall rating. 

select name, potential_rating, Overall_rating from Fifa_Details
where potential_rating > Overall_rating;


-- 13. Find the average value of players from each nationality, ordered by average value in descending order. 

SELECT Nationality, AVG(Value) AS Avg_Value
FROM fifa_details
GROUP BY Nationality
ORDER BY Avg_Value DESC;


-- 14. List the names and jersey numbers of players who have joined the club before 2019 and have a wage above 50,000 .

select name, Jersey_No, Joined, wage from Fifa_Details
where Joined < 2019-01-01 and wage > 50000 ;              


-- 15. Get the total number of players in the table. 

SELECT count(*) AS total_players FROM fifa_details;


-- 16.	Find the average age of players who prefer their right foot. 

select avg(age) as avg_age from fifa_details
where preferred_foot like 'ri%';


-- 17. Retrieve players with a value greater than 30 million and a wage less than 100,000. 

select name, value, wage from Fifa_Details
where value > 30000000 and wage < 100000 ;  


-- 18. List the names and clubs of players whose jersey number is less than 10 and have a potential rating above 80. 

select name, club, Jersey_No, potential_rating from fifa_details
where Jersey_No < 10 and potential_rating > 80;


-- 19. How many nationalities do these players belong to? 

select count(Nationality) as total_nationality from fifa_details;


-- 20. What is the total wage given to all players? What's the average and standard deviation? 

SELECT 
    SUM(wage) AS total_wage, 
    AVG(wage) AS average_wage, 
    STDDEV(wage) AS standard_dev_wage
FROM fifa_details;


-- 21. Which player has the highest wage? Who has the lowest? 

SELECT Name, Wage FROM fifa_details          -- Highest paid player
ORDER BY Wage DESC
LIMIT 1;

SELECT Name, Wage FROM fifa_details          -- Lowest paid player
ORDER BY Wage asc
LIMIT 1;


-- 22. The player having the best overall rating? Worst overall rating? 

SELECT Name, Overall_rating FROM fifa_details          -- Best overall rating 
ORDER BY Wage desc
LIMIT 1;

SELECT Name, Overall_rating FROM fifa_details          -- worst overall rating
ORDER BY Wage asc
LIMIT 1;


-- 23. Club having the highest total of overall rating? Highest average of overall rating? 

SELECT Club, SUM(Overall_rating) AS Highest_total_Overall_rating         -- Highest club in the basis of total overall rating
FROM fifa_details
GROUP BY Club
ORDER BY Total_Overall_rating  DESC
LIMIT 1;

SELECT Club, avg(Overall_rating) AS highest_avg_Overall_rating              -- Highest club in the basis of average overall rating
FROM fifa_details
GROUP BY Club
ORDER BY avg_Overall_rating  desc
LIMIT 1;


-- 24. What are the top 5 clubs based on the average ratings of their players? 

SELECT Club, avg(Overall_rating) AS avg_rating              
FROM fifa_details
GROUP BY Club
ORDER BY avg_rating  desc
LIMIT 5;


-- 25. What is the distribution of players whose preferred foot is left vs right? 

SELECT Preferred_Foot, COUNT(*) AS Player_Count
FROM fifa_details
WHERE Preferred_Foot = 'Left' OR Preferred_Foot = 'Right'
GROUP BY Preferred_Foot;


-- 26.	Which jersey number is the luckiest? 

select Jersey_No, max(Overall_rating) as luckiest from Fifa_Details
where potential_rating > Overall_rating
group by Jersey_No
LIMIT 1;


-- 27. What is the frequency distribution of nationalities among players whose club name starts with M? 

SELECT Nationality, COUNT(*) AS Player_Count
FROM fifa_details
WHERE Club LIKE 'M%'
GROUP BY Nationality
ORDER BY Player_Count DESC;


-- 28. How many players have joined their respective clubs in the date range 20 May 2018 to 10 April 2019 (both inclusive)? 

SELECT COUNT(*) AS Player_Count
FROM fifa_details
WHERE Joined BETWEEN '2018-05-20' AND '2019-04-10';                 


SELECT COUNT(*) AS Player_Count
FROM fifa_details
WHERE Joined='2018-05-20'; 

SELECT * from fifa_details;



-- 29. How many players have joined their respective clubs date-wise?   

SELECT Joined, COUNT(*) AS Player_Count
FROM fifa_details
GROUP BY Joined
ORDER BY Joined;


-- 30. How many players have joined their respective clubs yearly?    

SELECT YEAR(Joined) AS Year, COUNT(*) AS Player_Count
FROM fifa_details
GROUP BY YEAR(Joined)
ORDER BY Year;



 