# Customer RFM Analysis (SQL Server / T-SQL)

## Question
Which customers are most valuable, and which ones are at risk of churn?

## Data
Microsoft's Northwind sample database (Customers, Orders, Order Details tables).

## Approach
- Calculated Recency, Frequency, and Monetary value per customer using JOINs and GROUP BY
- Scored each metric 1–5 using the NTILE window function
- Segmented customers into groups (Champions, At Risk, Lost, Regular, New Customers) using CASE WHEN

## Tools
SQL Server, T-SQL, CTEs (WITH), Window Functions (NTILE)

## Result
89 customers segmented into 5 groups based on purchase behavior.
