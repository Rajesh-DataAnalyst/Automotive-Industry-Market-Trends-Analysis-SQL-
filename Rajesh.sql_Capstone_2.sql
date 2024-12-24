-- PROJECT -2 (SQL) --

-- 1).Display the entire data.  
SELECT * FROM CAPSTONE_2;

-- 2).What is the median highway mpg of cars for each drive wheels type? 
select DRIVE_WHEELS,Median(HIGHWAY_MPG) 
as Median_HIGHWAY_MPG 
from CAPSTONE_2
group by DRIVE_WHEELS
Order by Median_HIGHWAY_MPG desc;

-- 3).How many cars have both ‘gas’ fuel type and ‘turbo’ aspiration? 
select count(*) as num_of_car
from CAPSTONE_2
where FUEL_TYPE =  'gas' and ASPIRATION = 'turbo';

--4).What is the total curb weight of cars for each body style, where the length of the car is greater than the average 
--length for all the cars.
SELECT SUM(CURB_WEIGHT) AS total_curb_weight,
BODY_STYLE
from CAPSTONE_2
where LENGTH > (SELECT avg(LENGTH) 
as avg_length from CAPSTONE_2) 
GROUP BY BODY_STYLE
order by total_curb_weight desc;

-- 5).Which ‘make’ has the highest average highway mpg among cars with a compression ratio greater than 9? 
SELECT MAKE, highest_avg_highway_mpg
FROM (
SELECT MAKE, ROUND(AVG(HIGHWAY_MPG), 2) 
AS highest_avg_highway_mpg
FROM CAPSTONE_2
WHERE COMPRESSION_RATIO > 9
GROUP BY MAKE
ORDER BY highest_avg_highway_mpg DESC) 
WHERE ROWNUM = 1;

-- 6).What is the average price of cars for each fuel type, where the number of cylinders is greater than 6? 
SELECT FUEL_TYPE,AVG(PRICE) 
AS average_price_of_cars
FROM CAPSTONE_2
WHERE NUM_OF_CYLINDERS >'6'
GROUP BY FUEL_TYPE
ORDER BY average_price_of_cars DESC;

--7).What is the average price of cars for each make?
SELECT MAKE,ROUND(AVG(PRICE),2) 
AS average_price_of_cars
FROM CAPSTONE_2
GROUP BY MAKE
ORDER BY average_price_of_cars DESC;

-- 8).How many cars have a city mpg greater than 90th percentile city mpg? 
SELECT count(*),PERCENTILE_CONT(0.9) WITHIN GROUP 
(ORDER BY CITY_MPG) AS percentile_90
from CAPSTONE_2
WHERE CITY_MPG > (SELECT PERCENTILE_CONT(0.9) 
WITHIN GROUP (ORDER BY CITY_MPG) AS percentile_90
from CAPSTONE_2);

-- 9).What is the average length to width ratio of cars for each body style? 
SELECT BODY_STYLE,ROUND(AVG(LENGTH/WIDTH),2) 
AS AVG_RATIO
FROM CAPSTONE_2 
GROUP BY BODY_STYLE
ORDER BY AVG_RATIO DESC;

-- 10).How many cars have a price within one standard deviation of the average price? 
SELECT COUNT(*) AS cars_within_one_stddev
FROM CAPSTONE_2
WHERE price BETWEEN 
(SELECT AVG(price) - STDDEV(price) FROM CAPSTONE_2) 
AND (SELECT AVG(price) + STDDEV(price) FROM CAPSTONE_2);

-- 11).How many cars have a price greater than higher than the 75th percentile price? 
SELECT COUNT(*) AS Num_of_Cars
from CAPSTONE_2
WHERE PRICE >(SELECT PERCENTILE_CONT(0.75)
WITHIN GROUP (ORDER BY PRICE) AS percentile_75
from CAPSTONE_2);

-- 12).Select the maker and price range of the vehicles that are safest. 
SELECT MAKE,PRICE,SYMBOLING
FROM CAPSTONE_2
WHERE SYMBOLING IN (SELECT MIN(SYMBOLING) FROM CAPSTONE_2)
ORDER BY PRICE DESC;

-- 13).What is the make of 4wd cars that have only 2 doors?
SELECT MAKE,NUM_OF_DOORS,DRIVE_WHEELS
FROM CAPSTONE_2
WHERE  DRIVE_WHEELS = '4wd' AND NUM_OF_DOORS = 'two' ;

-- 14).What is the average horsepower of diesel type cars?
SELECT FUEL_TYPE,AVG(HORSEPOWER) AS HORSEPOWER
FROM CAPSTONE_2
WHERE FUEL_TYPE = 'diesel'
GROUP BY FUEL_TYPE;

-- 15).What is the average horsepower of gas type cars having only 4 doors?
SELECT FUEL_TYPE,ROUND(AVG(HORSEPOWER),2) AS HORSEPOWER
FROM CAPSTONE_2
WHERE FUEL_TYPE = 'gas' AND NUM_OF_DOORS = 'four'
GROUP BY FUEL_TYPE; 


-- Reoprt and Summary--
--Here’s a detailed report and summary based on the queries executed on the CAPSTONE_2 table:

-- 1. Display the Entire Data
-- Query:  SELECT * FROM CAPSTONE_2;
-- Description: This query retrieves all the columns and rows from the dataset. 
-- It provides an overview of the entire dataset, which is crucial for understanding the structure and available attributes.

-- 2. Median Highway MPG by Drive Wheels Type
-- Query: Calculates the median highway MPG for each type of drive wheels (DRIVE_WHEELS).
-- Result: Displays drive wheel types sorted by their median highway MPG in descending order. 
-- Useful for identifying which drive type is most fuel-efficient on highways.

-- 3. Number of Cars with ‘Gas’ Fuel Type and ‘Turbo’ Aspiration
-- Query: Counts cars that have FUEL_TYPE = 'gas' and ASPIRATION = 'turbo'.
-- Result: Returns the count of cars matching these criteria. Highlights a niche category of vehicles.

-- 4. Total Curb Weight of Cars by Body Style (Length > Average Length)
-- Query: Aggregates the total curb weight of cars by body style for cars longer than the average car length.
-- Result: Ranks body styles based on their total curb weight. 
-- Indicates how body style influences car weight among longer vehicles.

-- 5. Make with the Highest Average Highway MPG (Compression Ratio > 9)
-- Query:Identifies the make with the highest average highway MPG for cars with a compression ratio greater than 9.
-- Result: Highlights the most fuel-efficient manufacturer among high-compression cars.

-- 6. Average Price of Cars by Fuel Type (Cylinders > 6)
-- Query: Calculates the average price of cars for each fuel type where the number of cylinders is greater than 6.
-- Result: Indicates the pricing trends of high-cylinder vehicles based on their fuel type.

-- 7. Average Price of Cars by Make
-- Query: Computes the average price of cars for each make.
-- Result: Provides insights into the pricing hierarchy of different car manufacturers.

-- 8. Cars with City MPG > 90th Percentile.
-- Query: Counts cars whose city MPG exceeds the 90th percentile.
-- Result: Highlights cars that are exceptionally fuel-efficient in city conditions.

-- 9. Average Length-to-Width Ratio by Body Style
-- Query: Calculates the average length-to-width ratio for each body style.
-- Result: Provides insights into car design proportions across different body styles.


-- 10. Cars with Price Within One Standard Deviation of the Average
-- Query: Counts cars priced within one standard deviation of the average price.
-- Result: Highlights cars with moderate pricing relative to the dataset's average price.


-- 11. Cars with Price Greater than the 75th Percentile
-- Query: Counts cars priced above the 75th percentile.
-- Result: Identifies premium or high-priced vehicles.


-- 12. Safest Cars (Maker and Price Range)
-- Query: Retrieves the make and price of cars with the safest rating (`SYMBOLING` value being the minimum).
-- Result: Highlights the safest cars and their associated price ranges.

-- 13. 4WD Cars with 2 Doors
-- Query: Retrieves makes of 4WD cars with only 2 doors.
-- Result: Lists vehicles meeting the specified drive type and door count criteria.

-- 14. Average Horsepower of Diesel Cars
-- Query: Calculates the average horsepower for cars with FUEL_TYPE = 'diesel'.
-- Result: Highlights the power performance of diesel vehicles.

-- 15. Average Horsepower of Gas Cars with 4 Doors
-- Query: Calculates the average horsepower for cars with FUEL_TYPE = 'gas' and 4 doors.
-- Result: Highlights the power characteristics of family-oriented gas cars.


-- Summary:
-- This analysis provides a comprehensive understanding of the dataset, including trends, relationships, 
-- and notable patterns. Key takeaways include:
-- 1. Insights into fuel efficiency, pricing, and power across various categories.
-- 2. Identification of niche vehicle segments (e.g., gas-turbo cars, 4WD cars with 2 doors).
-- 3. Safety and design characteristics, such as safest cars and length-to-width ratios.
-- 4. Statistical observations, such as median, percentile thresholds, and standard deviations.

-- These findings offer valuable inputs for decision-making in vehicle manufacturing, marketing, and customer targeting.
