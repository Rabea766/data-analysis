with RFM_BASE as (
select e.EmployeeID,

e.FirstName +'  ' + e.LastName as FULLNAME,
count(DISTINCT o.OrderID) AS TOTALORDERS,
SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalRevenue,
SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))/count(DISTINCT o.OrderID) AS bestemployee

from Employees e
JOIN Orders o ON e.EmployeeID =o.EmployeeID
JOIN [Order Details] od ON o.OrderID =od.OrderID
group by e.EmployeeID , e.FirstName,e.LastName
)
select * ,
NTILE(5) OVER (ORDER BY bestemployee ASC) AS F_Score
FROM RFM_BASE
ORDER BY bestemployee DESC;
