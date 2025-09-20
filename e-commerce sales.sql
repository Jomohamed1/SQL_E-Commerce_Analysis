--Q1. How many customers, orders, and products are in the dataset?

SELECT 
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM Orders) AS total_orders,
    (SELECT COUNT(*) FROM Products) AS total_products;

--Q2. What are the top 10 customers by total spending?

SELECT TOP 10
c.customer_name , SUM(od.total_amount) AS total_spent
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
JOIN Order_Details AS od ON o.order_id = od.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

--Q3. Which product categories generate the most revenue?

SELECT p.category, ROUND(SUM(od.total_amount),2) AS revenue
FROM Products AS p
JOIN Order_Details AS od 
ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY revenue DESC;

--Q4. What is the monthly revenue trend?

SELECT 
    DATEPART(YEAR, o.order_date) AS year,
    DATEPART(MONTH, o.order_date) AS month,
    ROUND(SUM(od.total_amount),2) AS monthly_revenue
FROM Orders AS o
JOIN Order_Details AS od ON o.order_id = od.order_id
GROUP BY DATEPART(YEAR, o.order_date), DATEPART(MONTH, o.order_date)
ORDER BY year, month DESC;

--Q5. Which shipping mode is most used?

SELECT ship_mode, COUNT(*) AS total_orders
FROM Orders
GROUP BY ship_mode
ORDER BY total_orders DESC;

--Q6. What is the impact of discounts on revenue?

SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount < 0.1 THEN 'Low Discount'
        WHEN discount < 0.3 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_level,
    ROUND(SUM(total_amount),2) AS revenue
FROM Order_Details
GROUP BY 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount < 0.1 THEN 'Low Discount'
        WHEN discount < 0.3 THEN 'Medium Discount'
        ELSE 'High Discount'
    END
ORDER BY revenue DESC;

--Q7. Which regions contribute the highest sales?

SELECT c.region, SUM(od.total_amount) AS revenue
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
JOIN Order_Details AS od ON o.order_id = od.order_id
GROUP BY c.region
ORDER BY revenue DESC;

--Q8. What is the average order value (AOV)?

SELECT ROUND(AVG(order_value),2) AS avg_order_value
FROM (
    SELECT o.order_id, SUM(od.total_amount) AS order_value
    FROM Orders AS o
    JOIN Order_Details AS od ON o.order_id = od.order_id
    GROUP BY o.order_id
) sub;

--Q9. Top 10 products by quantity sold?

SELECT TOP 10
p.product_name, SUM(od.quantity) AS total_sold
FROM Products AS p
JOIN ORDER_DETAILS od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Q10. Which products have the highest margins?

SELECT TOP 10
p.product_name, ROUND(SUM(od.total_amount - (p.price * od.quantity)),2) AS profit
FROM Products AS p
JOIN Order_Details AS od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY profit DESC
