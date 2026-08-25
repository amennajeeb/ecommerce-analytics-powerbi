USE ecommerce_analytics;

-- Monthly revenue and profit
SELECT YEAR(Order_Date) AS Year, MONTH(Order_Date) AS Month,
       SUM(Sales) AS Revenue, SUM(Profit) AS Profit,
       COUNT(DISTINCT Order_ID) AS Orders
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- Top products by profit
SELECT p.Product_ID, p.Product_Name, p.Category,
       SUM(o.Quantity) AS Units_Sold,
       SUM(o.Sales) AS Revenue, SUM(o.Profit) AS Profit
FROM orders o
JOIN products p ON o.Product_ID = p.Product_ID
WHERE o.Order_Status = 'Delivered'
GROUP BY p.Product_ID, p.Product_Name, p.Category
ORDER BY Profit DESC
LIMIT 10;

-- Category performance
SELECT p.Category, SUM(o.Quantity) AS Units_Sold,
       SUM(o.Sales) AS Revenue, SUM(o.Profit) AS Profit,
       ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM orders o
JOIN products p ON o.Product_ID = p.Product_ID
WHERE o.Order_Status = 'Delivered'
GROUP BY p.Category
ORDER BY Profit DESC;

-- Top returned products
SELECT p.Product_ID, p.Product_Name, p.Category,
       COUNT(r.Return_ID) AS Return_Count, SUM(o.Sales) AS Revenue
FROM returns r
JOIN orders o ON r.Order_ID = o.Order_ID
JOIN products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name, p.Category
ORDER BY Return_Count DESC
LIMIT 10;

-- Product return rate
SELECT p.Product_ID, p.Product_Name, p.Category,
       COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       COUNT(DISTINCT r.Return_ID) AS Returns,
       ROUND(COUNT(DISTINCT r.Return_ID) * 100.0 /
             COUNT(DISTINCT o.Order_ID), 2) AS Return_Rate
FROM orders o
JOIN products p ON o.Product_ID = p.Product_ID
LEFT JOIN returns r ON o.Order_ID = r.Order_ID
WHERE o.Order_Status = 'Delivered'
GROUP BY p.Product_ID, p.Product_Name, p.Category
HAVING COUNT(DISTINCT r.Return_ID) > 0
ORDER BY Return_Rate DESC
LIMIT 10;

-- Category return rate
SELECT p.Category,
       COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       COUNT(DISTINCT r.Return_ID) AS Returns,
       ROUND(COUNT(DISTINCT r.Return_ID) * 100.0 /
             COUNT(DISTINCT o.Order_ID), 2) AS Return_Rate
FROM orders o
JOIN products p ON o.Product_ID = p.Product_ID
LEFT JOIN returns r ON o.Order_ID = r.Order_ID
GROUP BY p.Category
ORDER BY Return_Rate DESC;

-- State performance
SELECT c.State,
       COUNT(DISTINCT c.Customer_ID) AS Customers,
       COUNT(DISTINCT o.Order_ID) AS Orders,
       SUM(o.Sales) AS Revenue, SUM(o.Profit) AS Profit,
       ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM orders o
JOIN customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Order_Status = 'Delivered'
GROUP BY c.State
ORDER BY Revenue DESC;
