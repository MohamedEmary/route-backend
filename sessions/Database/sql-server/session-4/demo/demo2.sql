-- -- Declare and set the date variable
-- DECLARE @Today DATE = '2024-12-18';

-- -- Using CAST
-- SELECT CAST(@Today AS VARCHAR(MAX));  -- Basic conversion

-- -- Using CONVERT with different style numbers
-- SELECT CONVERT(VARCHAR(MAX), @Today, 101);  -- 
-- SELECT CONVERT(VARCHAR(MAX), @Today, 102);  -- 
-- SELECT CONVERT(VARCHAR(MAX), @Today, 110);  -- 
-- SELECT CONVERT(VARCHAR(MAX), @Today, 111);  -- 


-- SELECT GETDATE();
-- SELECT GETUTCDATE();

-- SELECT DAY(GETDATE()) -- 15
-- SELECT MONTH(GETDATE()) -- 12
-- SELECT YEAR(GETDATE()) -- 2024


-- SELECT DATEPART(DAY, GETDATE()) -- 15
-- SELECT DATEPART(MONTH, GETDATE()) -- 12
-- SELECT DATEPART(YEAR, GETDATE()) -- 2024

-- SELECT DATENAME(DAY, GETDATE()) -- 15
-- SELECT DATENAME(MONTH, GETDATE()) -- 12

-- SELECT DATEPART(QUARTER, GETDATE()) -- 4
-- SELECT DATEPART(QQ, GETDATE()) -- 4
-- SELECT DATENAME(QQ, GETDATE()) -- 4

-- SELECT DATEPART(WEEK, GETDATE()) -- 50
-- SELECT DATEPART(WEEKDAY, GETDATE()) -- 5 -> Friday

-- SELECT DATEPART(HOUR, GETDATE()) -- 



-- IF ISDATE('2024-12-15') = 1
--     SELECT 'Valid Date';
-- ELSE
--     SELECT 'Invalid Date';



-- SELECT EOMONTH('2024-12-15') -- 2024-12-31



SELECT DATEDIFF(DAY, '2024-12-15', '2024-12-31')
-- 16
SELECT DATEDIFF(MONTH, '2024-10-15', '2024-12-31')
-- 2
SELECT DATEDIFF(YEAR, '2025-12-15', '2025-12-31') -- 0