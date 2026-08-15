DECLARE @maxdate DATE = (SELECT MAX(OrderDate) FROM Orders);

WITH RFM_Base AS (
    SELECT
        c.CustomerID,
        c.CompanyName,
        DATEDIFF(DAY, MAX(o.OrderDate), @maxdate) AS Recency,
        COUNT(DISTINCT o.OrderID) AS Frequency,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Monetary
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CompanyName
),
RFM_Scores AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM_Base
)
SELECT
    *,
    CASE
        WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4 THEN 'Champions'
        WHEN R_Score >= 4 AND F_Score <= 2 THEN 'New Customers'
        WHEN R_Score <= 2 AND F_Score >= 4 AND M_Score >= 4 THEN 'At Risk'
        WHEN R_Score <= 2 AND F_Score <= 2 AND M_Score <= 2 THEN 'Lost'
        ELSE 'Regular'
    END AS Segment
FROM RFM_Scores
ORDER BY Monetary DESC;
