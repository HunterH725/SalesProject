SELECT *
FROM retailsales

SELECT *
FROM retailsales2

-- Total net sales for each product type
SELECT [Product Type], SUM([Total Net Sales]) AS [Total Net Sales]
FROM retailsales
WHERE [Product Type] is not null
GROUP BY [Product Type];

-- Top 5 Products based on total net sales
SELECT TOP 5 [Product Type], SUM([Total Net Sales]) AS [Total Net Sales]
FROM retailsales
GROUP BY [Product Type]
ORDER BY [Total Net Sales] DESC;

-- Determines if the quanitity of a product type is high, low, or medium
SELECT [Product Type], [Net Quantity],
       CASE
         WHEN [Net Quantity] > 30 THEN 'High'
         WHEN [Net Quantity] > 15 THEN 'Medium'
         ELSE 'Low'
       END AS [Quantity Category]
FROM retailsales;

-- Avg gross sales and discounts every month during 2017
SELECT Month, AVG([Gross Sales]) AS [Average Gross Sales], AVG([Discounts]) AS [Average Discounts]
FROM retailsales2
WHERE year = 2017
GROUP BY Month;

-- Use CTE's to determine Profit and Revenue for a specific product type and time
WITH Prof AS (
  SELECT [Product Type], [Net Quantity], [Gross Sales], [Discounts], 
  [Returns], [Total Net Sales], ([Gross Sales] - [Discounts] - [Returns]) AS [Profit]
  FROM retailsales
  WHERE [Product Type] = 'Christmas'
), Rev AS (
  SELECT Month, Year, [Total Orders], [Gross Sales], [Discounts], [Net Sales], ([Gross Sales] - [Discounts]) AS [Revenue]
  FROM retailsales2
  WHERE Month = 'December'
)
SELECT Prof.[Product Type], Prof.[Net Quantity], Prof.Profit, Rev.Month, Rev.Year, Rev.[Total Orders], Rev.Revenue
FROM Prof, Rev;