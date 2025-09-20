# SQL EDA Project – E-Commerce Sales Analysis

## 📊 Project Overview
This project demonstrates **Exploratory Data Analysis (EDA)** using **SQL Server** on an **E-Commerce Sales Dataset**.  
The analysis focuses on understanding customer behavior, sales performance, and revenue insights using SQL queries.

---

## 🗄️ Database Schema

The database consists of the following main tables:

<img width="1679" height="753" alt="Screenshot 2025-09-19 190326" src="https://github.com/user-attachments/assets/7e3d1658-1559-499a-a381-61ad1a2a8fce" />

---

## 🔍 EDA SQL Queries & Insights

## Q1. How many customers, orders, and products are in the dataset?
```sql
SELECT 
    (SELECT COUNT(*) FROM Customers) AS total_customers,
    (SELECT COUNT(*) FROM Orders) AS total_orders,
    (SELECT COUNT(*) FROM Products) AS total_products;
```
### Result 
<img width="316" height="68" alt="Screenshot 2025-09-20 184404" src="https://github.com/user-attachments/assets/b69ab6c9-2495-4fc4-9340-aefe60cbd8a4" />

## Q2. What are the top 10 customers by total spending?
```sql
SELECT TOP 10
c.customer_name , SUM(od.total_amount) AS total_spent
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
JOIN Order_Details AS od ON o.order_id = od.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;
```
### Result 
<img width="278" height="254" alt="Screenshot 2025-09-20 184419" src="https://github.com/user-attachments/assets/610312d1-f020-43de-acc8-060f11e164aa" />

## Q3. Which product categories generate the most revenue?

```sql
SELECT p.category, ROUND(SUM(od.total_amount),2) AS revenue
FROM Products AS p
JOIN Order_Details AS od 
ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY revenue DESC;
```
### Result 
<img width="219" height="104" alt="Screenshot 2025-09-20 184433" src="https://github.com/user-attachments/assets/b681f622-bdf6-48b6-8885-612dcf588ee3" />

## Q4. What is the monthly revenue trend?
```sql
SELECT 
    DATEPART(YEAR, o.order_date) AS year,
    DATEPART(MONTH, o.order_date) AS month,
    ROUND(SUM(od.total_amount),2) AS monthly_revenue
FROM Orders AS o
JOIN Order_Details AS od ON o.order_id = od.order_id
GROUP BY DATEPART(YEAR, o.order_date), DATEPART(MONTH, o.order_date)
ORDER BY year, month DESC;
```
### Result 
<img width="248" height="552" alt="Screenshot 2025-09-20 184529" src="https://github.com/user-attachments/assets/d0abc7b3-444c-4497-8423-083036dfa4a0" />

## Q5. Which shipping mode is most used?
```sql
SELECT ship_mode, COUNT(*) AS total_orders
FROM Orders
GROUP BY ship_mode
ORDER BY total_orders DESC;
```
### Result 
<img width="219" height="148" alt="Screenshot 2025-09-20 184548" src="https://github.com/user-attachments/assets/6618fadf-93bc-40eb-857a-136d461f7393" />

## Q6. What is the impact of discounts on revenue?
```sql
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
```
### Result 
<img width="213" height="98" alt="Screenshot 2025-09-20 184601" src="https://github.com/user-attachments/assets/b243026b-8a1a-4cd2-b7d2-32c3305b8697" />

## Q7. Which regions contribute the highest sales?
```sql
SELECT c.region, SUM(od.total_amount) AS revenue
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
JOIN Order_Details AS od ON o.order_id = od.order_id
GROUP BY c.region
ORDER BY revenue DESC;
```
### Result 
<img width="227" height="140" alt="Screenshot 2025-09-20 184621" src="https://github.com/user-attachments/assets/98c2fad6-ff42-4d73-826c-e96c9bf82ec2" />

## Q8. What is the average order value (AOV)?
```sql
SELECT ROUND(AVG(order_value),2) AS avg_order_value
FROM (
    SELECT o.order_id, SUM(od.total_amount) AS order_value
    FROM Orders AS o
    JOIN Order_Details AS od ON o.order_id = od.order_id
    GROUP BY o.order_id
) sub;
```
### Result 
<img width="169" height="84" alt="Screenshot 2025-09-20 184639" src="https://github.com/user-attachments/assets/e2519f52-d6c7-44cd-850c-c9378988ad58" />

## Q9. Top 10 products by quantity sold?
```sql
SELECT TOP 10
p.product_name, SUM(od.quantity) AS total_sold
FROM Products AS p
JOIN ORDER_DETAILS od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
```
### Result 
<img width="364" height="250" alt="Screenshot 2025-09-20 184705" src="https://github.com/user-attachments/assets/699b0595-7e1a-48d3-8655-3474fc2c9473" />

## Q10. Which products have the highest margins?
```sql
SELECT TOP 10
p.product_name, ROUND(SUM(od.total_amount - (p.price * od.quantity)),2) AS profit
FROM Products AS p
JOIN Order_Details AS od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY profit DESC
```
### Result 
<img width="337" height="231" alt="Screenshot 2025-09-20 184721" src="https://github.com/user-attachments/assets/574c2067-7b2d-4d19-a228-0cdd1ddd002a" />

---

### 📌 Key Insights

1. Identified top customers contributing most to revenue.
2. Found best-performing product categories.
3. Analyzed monthly revenue trends for growth monitoring.
4. Measured impact of discounts on revenue.
5. Determined top products by sales and profit margin.
6. Provided KPIs like Average Order Value (AOV).
---
🚀 Tools & Technologies

> SQL Server (T-SQL)

> E-commerce dataset

> Exploratory Data Analysis (EDA)

