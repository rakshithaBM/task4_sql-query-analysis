CREATE TABLE product_sales (
    AgentID INT,
    CallID INT PRIMARY KEY,
    CustomerID INT,
    PickedUp INT,
    Duration INT,
    ProductSold INT,
    Agent_Name TEXT
);


INSERT INTO product_sales VALUES
(0, 7999, 519, 1, 117, 0, 'Michele Williams'),
(0, 7100, 469, 1, 235, 0, 'Michele Williams'),
(0, 3752, 74, 1, 185, 0, 'Michele Williams'),
(0, 3751, 562, 1, 121, 0, 'Michele Williams'),
(0, 6783, 30, 1, 102, 1, 'Michele Williams'),
(1, 1234, 210, 0, 0, 0, 'John Smith'),
(2, 2345, 310, 1, 300, 1, 'Emily Davis');

--Basic Filtering Query--
SELECT * 
FROM product_sales
WHERE PickedUp = 1
ORDER BY Duration DESC;

--Aggregation: Total Calls per Agent--
SELECT Agent_Name, COUNT(*) AS total_calls
FROM product_sales
GROUP BY Agent_Name
ORDER BY total_calls DESC;

--Average Call Duration by Agent--
SELECT Agent_Name, AVG(Duration) AS avg_duration
FROM product_sales
WHERE PickedUp = 1
GROUP BY Agent_Name;

--Create Customers Table for JOIN Example--
CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    Customer_Name TEXT
);

INSERT INTO customers VALUES
(519, 'Alice Brown'),
(469, 'David Lee'),
(74, 'Chris Evans'),
(562, 'Sophia White'),
(30, 'Michael Clark');

--JOIN Example--
SELECT ps.CallID, c.Customer_Name, ps.Agent_Name, ps.Duration
FROM product_sales ps
INNER JOIN customers c ON ps.CustomerID = c.CustomerID;

--Subquery Example--
SELECT Agent_Name, AVG(Duration) AS avg_duration
FROM product_sales
GROUP BY Agent_Name
HAVING avg_duration > (
    SELECT AVG(Duration) FROM product_sales
);

--create view--
CREATE VIEW high_performance_agents AS
SELECT Agent_Name,
       SUM(ProductSold) AS products_sold,
       COUNT(*) AS total_calls,
       (SUM(ProductSold) * 100.0 / COUNT(*)) AS conversion_rate
FROM product_sales
GROUP BY Agent_Name
HAVING conversion_rate > 50;


SELECT * FROM high_performance_agents;


