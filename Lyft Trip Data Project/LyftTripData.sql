-- Lift Trip Data
-- Practice joins by combining rows from different tables
-- Suppose you are a Data Analyst at Lyft, a ride-sharing platform.
-- For a project, you were given three tables
-- trips: trip information
-- riders: user data
-- cars: autonomous cars

-- 1. Examine the three tables
SELECT * FROM trips;
SELECT * FROM riders;
SELECT * FROM cars;

-- 2. Cross join between riders and cars

SELECT riders.first,
riders.last,
cars.model
FROM riders, cars;

-- 3. Suppose we want to create a Trip Log with the trips and its users. 
-- Find the columns to join between trips and riders and combine the two tables using a LEFT JOIN.
-- Let trips be the left table

SELECT trips.date, 
trips.pickup, 
trips.dropoff, 
trips.type, 
trips.cost,
riders.first, 
riders.last,
riders.username
FROM trips
LEFT JOIN riders 
ON trips.rider_id = riders.id;

-- 4. Suppose we want to create a link between the trips and the cars used during those trips.
-- Find the columns to join on and combine the trips and cars table using an INNER JOIN.

SELECT * 
FROM trips
JOIN cars

-- 5. The new rideres data are in! There are three new users this month. 
-- Stack the riders table on top of the new table named riders2.

SELECT * 
FROM riders
UNION
SELECT * 
FROM riders2;

-- 6. What is the average cost for a trip? 
-- Round to 2 decimal places

SELECT ROUND(AVG(cost), 2)
FROM trips;

-- 7. Lyft is looking to do an email campaign for all the irregular users. 
-- Find allt he riders who have used Lyft less than 500 times.

SELECT *
FROM riders 
WHERE total_trips < 500
UNION
SELECT *
FROM riders2
WHERE total_trips < 500;

-- 8. Calculate the number of cars that are active.
SELECT COUNT(*)
FROM cars
WHERE status = 'active';