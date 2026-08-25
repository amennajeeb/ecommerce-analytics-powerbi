USE ecommerce_analytics;

-- Channel performance
SELECT Channel, COUNT(*) AS Campaign_Records,
       SUM(Spend) AS Total_Spend,
       SUM(Conversion) AS Total_Conversions,
       ROUND(SUM(Spend) / NULLIF(SUM(Conversion), 0), 2) AS Cost_Per_Conversion,
       ROUND(SUM(Conversion) / COUNT(*) * 100, 2) AS Conversion_Rate
FROM marketing
GROUP BY Channel
ORDER BY Conversion_Rate DESC;

-- Channel revenue and profit
SELECT m.Channel,
       COUNT(DISTINCT m.Customer_ID) AS Customers,
       SUM(m.Spend) AS Marketing_Spend,
       COUNT(DISTINCT CASE WHEN o.Order_Status = 'Delivered'
                           THEN o.Order_ID END) AS Delivered_Orders,
       SUM(CASE WHEN o.Order_Status = 'Delivered'
                THEN o.Sales ELSE 0 END) AS Revenue,
       SUM(CASE WHEN o.Order_Status = 'Delivered'
                THEN o.Profit ELSE 0 END) AS Profit
FROM marketing m
LEFT JOIN orders o ON m.Customer_ID = o.Customer_ID
GROUP BY m.Channel
ORDER BY Revenue DESC;

-- Marketing spend and conversions
SELECT m.Channel,
       COUNT(DISTINCT m.Customer_ID) AS Customers,
       SUM(m.Spend) AS Marketing_Spend,
       SUM(m.Conversion) AS Conversions,
       ROUND(SUM(m.Spend) / NULLIF(SUM(m.Conversion), 0), 2)
           AS Cost_Per_Conversion
FROM marketing m
GROUP BY m.Channel
ORDER BY Marketing_Spend DESC;
