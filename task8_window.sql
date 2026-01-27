use eccommerce;
select * from purchase;
SELECT 
    User_ID,
    SUM(Final_Price(Rs.)) AS total_sales
FROM 
    purchase
GROUP BY 
    User_ID;
SELECT 
  Category,
Product_ID,
    SUM(Final_Price(Rs.)) AS total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY   Category
        ORDER BY SUM(Final_Price(Rs.)) DESC
    ) AS sales_rank
FROM 
    sales
GROUP BY 
    Category,Product_ID
ORDER BY 
      Category, sales_rank;
      SELECT 
    User_ID,
    Purchase_Date,
   Product_ID,
  Final_Price(Rs.),
    SUM(Final_Price(Rs.)) OVER (
        ORDER BY Purchase_Date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM 
    purchase
ORDER BY 
    Purchase_Date;
    WITH product_sales AS (
    SELECT 
        category_id,
        product_id,
        SUM(sales_amount) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category_id 
            ORDER BY SUM(sales_amount) DESC
        ) AS sales_rank
    FROM 
        sales
    GROUP BY 
        category_id, product_id
)
SELECT 
    category_id,
    product_id,
    total_sales,
    sales_rank
FROM 
    product_sales
WHERE 
    sales_rank <= 3
ORDER BY 
    category_id, sales_rank;




