USE ecommerce_analytics;

-- Overall business KPIs
SELECT COUNT(DISTINCT Order_ID) AS Total_Orders,
       COUNT(DISTINCT Customer_ID) AS Total_Customers,
       SUM(Sales) AS Total_Revenue,
       SUM(Profit) AS Total_Profit,
       AVG(Sales) AS Average_Order_Value
FROM orders
WHERE Order_Status = 'Delivered';

-- Top customers
SELECT c.Customer_ID, c.Customer_Name, c.City, c.State,
       COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       SUM(o.Sales) AS Revenue, SUM(o.Profit) AS Profit
FROM orders o
JOIN customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Order_Status = 'Delivered'
GROUP BY c.Customer_ID, c.Customer_Name, c.City, c.State
ORDER BY Revenue DESC
LIMIT 10;

-- Customer recency and value
SELECT c.Customer_ID, c.Customer_Name,
       COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       SUM(o.Sales) AS Total_Revenue,
       MAX(o.Order_Date) AS Last_Order_Date,
       DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                MAX(o.Order_Date)) AS Days_Since_Last_Order
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Status = 'Delivered'
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Revenue DESC;

-- Customer segmentation
SELECT Customer_ID, Customer_Name, Total_Orders, Total_Revenue,
       Days_Since_Last_Order,
       CASE
         WHEN Days_Since_Last_Order <= 30 AND Total_Orders >= 15
              AND Total_Revenue >= 500000 THEN 'VIP Active'
         WHEN Days_Since_Last_Order <= 60 AND Total_Orders >= 10 THEN 'Loyal'
         WHEN Days_Since_Last_Order > 120 AND Total_Revenue >= 400000
              THEN 'High Value At Risk'
         WHEN Days_Since_Last_Order > 120 THEN 'Inactive'
         WHEN Days_Since_Last_Order <= 60 THEN 'Active'
         ELSE 'Needs Attention'
       END AS Customer_Segment
FROM (
    SELECT c.Customer_ID, c.Customer_Name,
           COUNT(DISTINCT o.Order_ID) AS Total_Orders,
           SUM(o.Sales) AS Total_Revenue,
           DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                    MAX(o.Order_Date)) AS Days_Since_Last_Order
    FROM customers c
    JOIN orders o ON c.Customer_ID = o.Customer_ID
    WHERE o.Order_Status = 'Delivered'
    GROUP BY c.Customer_ID, c.Customer_Name
) AS customer_summary;

-- Customer segment performance
SELECT Customer_Segment,
       COUNT(*) AS Customer_Count,
       ROUND(SUM(Total_Revenue), 2) AS Total_Revenue,
       ROUND(AVG(Total_Revenue), 2) AS Avg_Customer_Revenue,
       ROUND(AVG(Total_Orders), 2) AS Avg_Orders
FROM (
    SELECT c.Customer_ID, c.Customer_Name,
           COUNT(DISTINCT o.Order_ID) AS Total_Orders,
           SUM(o.Sales) AS Total_Revenue,
           DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                    MAX(o.Order_Date)) AS Days_Since_Last_Order,
           CASE
             WHEN DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                           MAX(o.Order_Date)) <= 30
                  AND COUNT(DISTINCT o.Order_ID) >= 15
                  AND SUM(o.Sales) >= 500000 THEN 'VIP Active'
             WHEN DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                           MAX(o.Order_Date)) <= 60
                  AND COUNT(DISTINCT o.Order_ID) >= 10 THEN 'Loyal'
             WHEN DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                           MAX(o.Order_Date)) > 120
                  AND SUM(o.Sales) >= 400000 THEN 'High Value At Risk'
             WHEN DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                           MAX(o.Order_Date)) > 120 THEN 'Inactive'
             WHEN DATEDIFF((SELECT MAX(Order_Date) FROM orders),
                           MAX(o.Order_Date)) <= 60 THEN 'Active'
             ELSE 'Needs Attention'
           END AS Customer_Segment
    FROM customers c
    JOIN orders o ON c.Customer_ID = o.Customer_ID
    WHERE o.Order_Status = 'Delivered'
    GROUP BY c.Customer_ID, c.Customer_Name
) AS customer_segments
GROUP BY Customer_Segment
ORDER BY Total_Revenue DESC;
