create database adventure_works;

USE adventure_works;

SHOW TABLES;
SELECT COUNT(*) AS Old_Sales_Rows
FROM factinternetsales;

SELECT COUNT(*) AS New_Sales_Rows
FROM fact_internet_sales_new;

-- Question-0--
SELECT *
FROM factinternetsales

UNION ALL

SELECT *
FROM fact_internet_sales_new;
CREATE TABLE combined_sales AS
SELECT *
FROM factinternetsales

UNION ALL

SELECT *
FROM fact_internet_sales_new;
SELECT COUNT(*) AS Total_Rows
FROM combined_sales;

-- Question-1--
DESCRIBE dimproduct;
SELECT
    s.`ï»¿ProductKey` AS ProductKey,
    p.EnglishProductName
FROM combined_sales AS s
LEFT JOIN dimproduct AS p
    ON s.`ï»¿ProductKey` = p.`ï»¿ProductKey`;
    
    -- Question-2--
    DESCRIBE dimcustomer;
    SELECT
    s.`ï»¿ProductKey` AS ProductKey,
    s.CustomerKey,
    CONCAT_WS(' ', c.FirstName, c.MiddleName, c.LastName) AS CustomerFullName,
    p.UnitPrice
FROM combined_sales AS s
LEFT JOIN dimcustomer AS c
    ON s.CustomerKey = c.CustomerKey
LEFT JOIN dimproduct AS p
    ON s.`ï»¿ProductKey` = p.`ï»¿ProductKey`;
    DESCRIBE dimproduct;
    DESCRIBE dimcustomer;
   SELECT `Unit price`
FROM dimproduct
LIMIT 5;
DESCRIBE combined_sales;
SELECT
    s.`ï»¿ProductKey` AS ProductKey,
    CONCAT_WS(' ', c.FirstName, c.MiddleName, c.LastName) AS CustomerFullName,
    p.`Unit price` AS UnitPrice
FROM combined_sales AS s
LEFT JOIN dimcustomer AS c
    ON s.CustomerKey = c.`ï»¿CustomerKey`
LEFT JOIN dimproduct AS p
    ON s.`ï»¿ProductKey` = p.`ï»¿ProductKey`;
    
    -- Question-3--
    SELECT
    OrderDateKey,
    STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d') AS OrderDate
FROM combined_sales
LIMIT 10;

SELECT
    OrderDateKey,

    STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d') AS OrderDate,

    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Year,

    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthNo,

    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthFullName,

    CONCAT('Q', QUARTER(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))) AS Quarter,

    DATE_FORMAT(
        STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'),
        '%Y-%b'
    ) AS YearMonth,

    WEEKDAY(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 1 AS WeekdayNo,

    DAYNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS WeekdayName,

    CASE
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) >= 4
        THEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) - 3
        ELSE MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 9
    END AS FinancialMonth,

    CASE
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter

FROM combined_sales;

-- Question-4--
SELECT
    `ï»¿ProductKey` AS ProductKey,
    UnitPrice,
    OrderQuantity,
    DiscountAmount,
    (UnitPrice * OrderQuantity) - DiscountAmount AS SalesAmount
FROM combined_sales
LIMIT 10;
SELECT
    `ï»¿ProductKey` AS ProductKey,
    UnitPrice,
    OrderQuantity,
    DiscountAmount,
    (UnitPrice * OrderQuantity) - DiscountAmount AS SalesAmount
FROM combined_sales
LIMIT 10;

-- Question-5--
DESCRIBE combined_sales;
SELECT
    `ï»¿ProductKey` AS ProductKey,
    OrderQuantity,
    TotalProductCost AS ProductionCost
FROM combined_sales
LIMIT 10;

-- Question-6--
SELECT
    `ï»¿ProductKey` AS ProductKey,
    OrderQuantity,
    UnitPrice,
    DiscountAmount,
    TotalProductCost AS ProductionCost,
    ((UnitPrice * OrderQuantity) - DiscountAmount) AS SalesAmount,
    (((UnitPrice * OrderQuantity) - DiscountAmount) - TotalProductCost) AS Profit
FROM combined_sales
LIMIT 10;

USE adventure_works;

SHOW TABLES;
-- Q0: Combine Fact Internet Sales and Fact Internet Sales New

SELECT COUNT(*) AS Combined_Sales_Rows
FROM combined_sales;

-- Q1: Lookup Product Name

SELECT
    s.`ï»¿ProductKey` AS ProductKey,
    p.EnglishProductName AS ProductName
FROM combined_sales AS s
LEFT JOIN dimproduct AS p
    ON s.`ï»¿ProductKey` = p.`ï»¿ProductKey`
LIMIT 10;

-- Q2: Customer Full Name and Unit Price

SELECT
    s.CustomerKey,

    CONCAT_WS(' ',
        c.FirstName,
        c.MiddleName,
        c.LastName
    ) AS CustomerFullName,

    s.`ï»¿ProductKey` AS ProductKey,

    p.`Unit price` AS UnitPrice

FROM combined_sales AS s

LEFT JOIN dimcustomer AS c
    ON s.CustomerKey = c.`ï»¿CustomerKey`

LEFT JOIN dimproduct AS p
    ON s.`ï»¿ProductKey` = p.`ï»¿ProductKey`

LIMIT 10;

DESCRIBE combined_sales;

-- Q3: Create Date-related fields

SELECT
    OrderDateKey,

    STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d') AS OrderDate,

    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Year,

    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthNo,

    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthFullName,

    CONCAT('Q', QUARTER(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))) AS Quarter,

    DATE_FORMAT(
        STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'),
        '%Y-%b'
    ) AS YearMonth,

    WEEKDAY(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 1 AS WeekdayNo,

    DAYNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS WeekdayName,

    CASE
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) >= 4
        THEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) - 3
        ELSE MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 9
    END AS FinancialMonth,

    CASE
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter

FROM combined_sales;

-- Q4: Calculate Sales Amount

SELECT
    `ï»¿ProductKey` AS ProductKey,
    UnitPrice,
    OrderQuantity,
    DiscountAmount,
    (UnitPrice * OrderQuantity) - DiscountAmount AS SalesAmount
FROM combined_sales;

-- Q5: Calculate Production Cost

SELECT
    `ï»¿ProductKey` AS ProductKey,
    OrderQuantity,
    TotalProductCost AS ProductionCost
FROM combined_sales;

-- Q6: Calculate Profit

SELECT
    `ï»¿ProductKey` AS ProductKey,
    UnitPrice,
    OrderQuantity,
    DiscountAmount,
    TotalProductCost AS ProductionCost,
    (UnitPrice * OrderQuantity) - DiscountAmount AS SalesAmount,
    ((UnitPrice * OrderQuantity) - DiscountAmount) - TotalProductCost AS Profit
FROM combined_sales;