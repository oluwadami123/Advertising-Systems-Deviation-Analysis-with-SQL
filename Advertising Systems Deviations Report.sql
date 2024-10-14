CREATE DATABASE systems;

USE systems;

CREATE TABLE Customers(
id INT NOT NULL,
first_name VARCHAR(100),
last_name VARCHAR(100)
);

INSERT INTO Customers(id, first_name, last_name) VALUES
(1,"Carolyn", "O'Lunny"),
(2,"Matteo", "Husthwaite"),
(3,"Melessa", "Rowesby");

CREATE TABLE campaigns(
id INT NOT NULL,
customer_id INT NOT NULL,
name VARCHAR(100)
);

INSERT INTO campaigns(id, customer_id, name) VALUES
(2,1,"Overcoming Challenges"),
(4,1,"Business Rules"),
(3,2,"YUI"),
(1,3,"Quantitative Finance"),
(5,3,"MMC");

CREATE TABLE events(
campaign_id INT NOT NULL,
status VARCHAR(100) NOT NULL
);

INSERT INTO events(campaign_id, status) VALUES
(1, 'success'),
(1, 'success'),
(2, 'success'),
(2, 'success'),
(2, 'success'),
(2, 'success'),
(2, 'success'),
(3, 'success'),
(3, 'success'),
(3, 'success'),
(4, 'success'),
(4, 'success'),
(4, 'failure'),
(4, 'failure'),
(5, 'failure'),
(5, 'failure'),
(5, 'failure'),
(5, 'failure'),
(5, 'failure'),
(5, 'failure'),
(4, 'success'),
(5, 'success'),
(5, 'success'),
(1, 'failure'),
(1, 'failure'),
(1, 'failure'),
(2, 'failure'),
(3, 'failure');

SELECT *
FROM events;

SELECT *
FROM campaigns;

SELECT *
FROM Customers;


WITH CTE AS(
	SELECT 
		CONCAT(first_name, " ", last_name) AS customers_name,
	   GROUP_CONCAT(DISTINCT name," ") AS campaigns,
		ev.status AS event_type,
		COUNT(1) AS Total,
		RANK() OVER(PARTITION BY status ORDER BY COUNT(1) DESC) AS rnk
	FROM Customers c
	JOIN campaigns cp
	ON c.id = cp.customer_id
	JOIN events as ev
	ON ev.campaign_id = cp.id
	GROUP BY customers_name, status)
SELECT 
	event_type,
    customers_name,
    campaigns,
    total
FROM CTE
WHERE rnk = 1
ORDER BY event_type, total DESC;


