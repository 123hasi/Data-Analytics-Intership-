-- Customer Dimension
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

-- Product Dimension
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    brand VARCHAR(50)
);

-- Date Dimension
CREATE TABLE Date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    quarter INT,
    year INT
);

-- Region Dimension
CREATE TABLE Region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50),
    country VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50)
);
CREATE TABLE Sales (
    sales_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    date_id INT,
    region_id INT,
    sales_amount DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (date_id) REFERENCES Date(date_id),
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);
-- Insert into Customer
INSERT INTO Customer (customer_id, customer_name, segment, age, gender)
VALUES (1, 'Hasina Mulani', 'Consumer', 25, 'Female');

-- Insert into Product
INSERT INTO Product (product_id, product_name, category, sub_category, brand)
VALUES (101, 'Laptop X', 'Technology', 'Computers', 'Dell');

-- Insert into Date
INSERT INTO Date (date_id, full_date, day, month, quarter, year)
VALUES (20240101, '2024-01-01', 1, 1, 1, 2024);

-- Insert into Region
INSERT INTO Region (region_id, region_name, country, state, city)
VALUES (501, 'West', 'India', 'Maharashtra', 'Pune');
--insert into sales 
INSERT INTO Sales (sales_id, customer_id, product_id, date_id, region_id, sales_amount, quantity, discount, profit)
VALUES (10001, 1, 101, 20240101, 501, 50000.00, 2, 5.00, 8000.00);
--create index
CREATE INDEX idx_sales_customer ON Sales(customer_id);
CREATE INDEX idx_sales_product ON Sales(product_id);
CREATE INDEX idx_sales_date ON Sales(date_id);
CREATE INDEX idx_sales_region ON Sales(region_id);

--find total sales
SELECT c.customer_name, SUM(s.sales_amount) AS total_sales
FROM Sales s
JOIN Customer c ON s.customer_id = c.customer_id
GROUP BY c.customer_name;
SELECT p.category, p.product_name, SUM(s.sales_amount) AS total_sales
FROM Sales s
JOIN Product p ON s.product_id = p.product_id
GROUP BY p.category, p.product_name
ORDER BY p.category, total_sales DESC;
SELECT d.year, d.month, SUM(s.sales_amount) AS monthly_sales
FROM Sales s
JOIN Date d ON s.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;
SELECT r.region_name, SUM(s.sales_amount) AS total_sales, SUM(s.profit) AS total_profit
FROM Sales s
JOIN Region r ON s.region_id = r.region_id
GROUP BY r.region_name;





