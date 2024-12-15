--CAPSTONE PROJECT -2 (SQL)

-- 1).Display the entire data.  
SELECT * FROM CAPSTONE_2;


-- 2).What is the median highway mpg of cars for 
--each drive wheels type? 
select DRIVE_WHEELS,Median(HIGHWAY_MPG) 
as Median_HIGHWAY_MPG 
from CAPSTONE_2
group by DRIVE_WHEELS
Order by Median_HIGHWAY_MPG desc;


-- 3).How many cars have both 
--‘gas’ fuel type and ‘turbo’ aspiration? 
select count(*) as num_of_car
from CAPSTONE_2
where FUEL_TYPE =  'gas' and ASPIRATION = 'turbo';


--4).What is the total curb weight of cars for 
--each body style, where the 
--length of the car is greater than the average 
--length for all the cars.
SELECT SUM(CURB_WEIGHT) AS total_curb_weight,
BODY_STYLE
from CAPSTONE_2
where LENGTH > (SELECT avg(LENGTH) 
as avg_length from CAPSTONE_2) 
GROUP BY BODY_STYLE
order by total_curb_weight desc;


-- 5).Which ‘make’ has the highest 
--average highway mpg among cars with a 
--compression ratio greater than 9? 


SELECT MAKE, highest_avg_highway_mpg
FROM (
SELECT MAKE, ROUND(AVG(HIGHWAY_MPG), 2) 
AS highest_avg_highway_mpg
FROM CAPSTONE_2
WHERE COMPRESSION_RATIO > 9
GROUP BY MAKE
ORDER BY highest_avg_highway_mpg DESC) 
WHERE ROWNUM = 1;


-- 6).What is the average price of 
--cars for each fuel type, where the 
--number of cylinders is greater than 6? 
SELECT FUEL_TYPE,AVG(PRICE) 
AS average_price_of_cars
FROM CAPSTONE_2
WHERE NUM_OF_CYLINDERS >'6'
GROUP BY FUEL_TYPE
ORDER BY average_price_of_cars DESC;


--7).What is the average price 
--of cars for each make?
SELECT MAKE,ROUND(AVG(PRICE),2) 
AS average_price_of_cars
FROM CAPSTONE_2
GROUP BY MAKE
ORDER BY average_price_of_cars DESC;




-- 8).How many cars have a city mpg greater than 
--90th percentile city mpg? 
SELECT count(*),PERCENTILE_CONT(0.9) WITHIN GROUP 
(ORDER BY CITY_MPG) AS percentile_90
from CAPSTONE_2
WHERE CITY_MPG > (SELECT PERCENTILE_CONT(0.9) 
WITHIN GROUP (ORDER BY CITY_MPG) AS percentile_90
from CAPSTONE_2);


-- 9).What is the average length to width ratio of 
--cars for each body style? 
SELECT BODY_STYLE,ROUND(AVG(LENGTH/WIDTH),2) 
AS AVG_RATIO
FROM CAPSTONE_2 
GROUP BY BODY_STYLE
ORDER BY AVG_RATIO DESC;



--- 10).How many cars have a price within one standard 
--deviation of the average price? 

SELECT COUNT(*) AS cars_within_one_stddev
FROM CAPSTONE_2
WHERE price BETWEEN 
(SELECT AVG(price) - STDDEV(price) FROM CAPSTONE_2) 
AND (SELECT AVG(price) + STDDEV(price) FROM CAPSTONE_2);



-- 11).How many cars have a price 
--greater than higher than the 
--75th percentile price? 

SELECT COUNT(*) AS Num_of_Cars
from CAPSTONE_2
WHERE PRICE >(SELECT PERCENTILE_CONT(0.75)
WITHIN GROUP (ORDER BY PRICE) AS percentile_75
from CAPSTONE_2);


-- 12).Select the maker and price 
--range of the vehicles that are safest. 

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

-- 15).What is the average horsepower 
--of gas type cars having only 4 doors?
SELECT FUEL_TYPE,ROUND(AVG(HORSEPOWER),2) AS HORSEPOWER
FROM CAPSTONE_2
WHERE FUEL_TYPE = 'gas' AND NUM_OF_DOORS = 'four'
GROUP BY FUEL_TYPE; 


