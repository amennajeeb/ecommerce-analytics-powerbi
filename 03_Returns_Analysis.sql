USE ecommerce_analytics;

-- Delivery status
SELECT Delivery_Status, COUNT(*) AS Orders,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM delivery), 2)
           AS Percentage
FROM delivery
GROUP BY Delivery_Status
ORDER BY Orders DESC;

-- Delivery status vs returns
SELECT d.Delivery_Status,
       COUNT(DISTINCT d.Order_ID) AS Delivered_Orders,
       COUNT(DISTINCT r.Order_ID) AS Returned_Orders,
       ROUND(COUNT(DISTINCT r.Order_ID) * 100.0 /
             COUNT(DISTINCT d.Order_ID), 2) AS Return_Rate
FROM delivery d
LEFT JOIN returns r ON d.Order_ID = r.Order_ID
GROUP BY d.Delivery_Status;

-- Total returns
SELECT COUNT(*) AS total_returns FROM returns;

-- Return validation
SELECT COUNT(*) AS total_returns,
       COUNT(DISTINCT r.Order_ID) AS unique_return_orders,
       COUNT(DISTINCT CASE WHEN o.Order_ID IS NOT NULL
                           THEN r.Order_ID END) AS returns_matching_orders
FROM returns r
LEFT JOIN orders o ON r.Order_ID = o.Order_ID;

-- Returned orders with delivery records
SELECT COUNT(DISTINCT r.Order_ID) AS returned_orders,
       COUNT(DISTINCT d.Order_ID) AS returned_orders_with_delivery
FROM returns r
LEFT JOIN delivery d ON r.Order_ID = d.Order_ID;

-- Return reasons
SELECT Return_Reason, COUNT(*) AS Return_Count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM returns), 2)
           AS Return_Percentage
FROM returns
GROUP BY Return_Reason
ORDER BY Return_Count DESC;
