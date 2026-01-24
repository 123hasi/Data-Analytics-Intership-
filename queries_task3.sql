USE superstone;
SELECT * FROM sales;
-- View first 10 rows
SELECT * 
FROM sales
LIMIT 10;
SELECT COUNT(*) AS missing_customer_id
FROM sales
WHERE customer_id IS NULL;
-- Find all sales records in the Technology category
SELECT *
FROM sales
WHERE category = 'Technology';
-- Total sales, average profit, and record count per category
SELECT 
    category,
    SUM(sales) AS total_sales,
    AVG(profit) AS avg_profit,
    COUNT(*) AS record_count
FROM sales
GROUP BY category
ORDER BY total_sales DESC;
SELECT 
    category,
    region,
    SUM(sales) AS total_sales
FROM sales
GROUP BY category, region
HAVING SUM(sales) > 100000
ORDER BY category, total_sales DESC;







	
