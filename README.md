# Model Cars Database Analysis (SQL Project)
## Project Objective
- To analyze a modelcar sales database using SQL to extract meaningful insights related to inventory management, customer orders, sales performance, and employee contributions.
- The key goals include:
- Understanding Sales Performance – Identify top-selling model cars and revenue trends.
- Customer Behavior Analysis – Segment customers based on purchase history and order frequency.
- Inventory Optimization – Evaluate stock levels and identify frequently reordered products.
- Operational Efficiency – Assess order processing time and employee performance.
- Revenue Trends – Analyze sales patterns across different time periods and locations.

## Dataset used
- <a href="https://github.com/puvvaditeja/Modelcars_sql_project/blob/main/modelcarsdb.sql">Dataset</a>

## Database Schema
![image](https://github.com/user-attachments/assets/3f1c769b-1a39-4a04-a82f-b944004ede72)

## Questions
- Find the top 10 customers by credit limit.
- Find the average credit limit for customers in each country.
- Find the number of customers in each state.
- Find the customers who haven't placed any orders.
- Calculate total sales for each customer.
- List customers with their assigned sales representatives.
- Retrieve customer information with their most recent payment details.
- Identify the customers who have exceeded their credit limit.
- Find the names of all customers who have placed an order for a product from a specific product line.
- Find the names of all customers who have placed an order for the most expensive product.
- Count the number of employees working in each office.
- Identify the offices with less than a certain number of employees.
- List offices along with their assigned territories.
- Find the offices that have no employees assigned to them
- Retrieve the most profitable office based on total sales.
- Find the office with the highest number of employees.
- Find the average credit limit for customers in each office.
- Find the number of offices in each country.
- Count the number of products in each product line.
- Find the product line with the highest average product price.
- Find all products with a price above or below a certain amount (MSRP should be between 50 and 100).
- Find the total sales amount for each product line.
- Identify products with low inventory levels (less than a specific threshold value of 10 for quantityInStock).
- Retrieve the most expensive product based on MSRP.
- Calculate total sales for each product.
- Identify the top selling products based on total quantity ordered using a stored procedure. The procedure should accept an input parameter to specify the number of top-selling products to retrieve.
- Retrieve products with low inventory levels (less than a threshold value of 10 for quantityInStock) within specific product lines ('Classic Cars', 'Motorcycles').
- Find the names of all products that have been ordered by more than 10 customers.
- Identify the most profitable orders based on total revenue.
- List all orders with detailed product information.
- Identify orders with delayed shipping (shippedDate > requiredDate).
- Find the most popular product combinations within orders.
- Calculate revenue for each order and identify the top 10 most profitable.
- Create a trigger that automatically updates a customer's credit limit after a new order is placed, reducing it by the order total.

## Project Insights
- 'California' as the state with the highest customer concentration, followed by 'New York' and 'Texas'.
- About 24 customers who haven't placed any orders
- office code '1' has the highest number of employees, followed by offices '2' and '3'
- office code '4' has the most profitable office based on sales
- 'USA' has the highest number of offices
- 'classic cars' product line has the highest number of products followed by vintage cars
- 'classic cars' product line has the highest average product price.
- '1952 Alpine Renault 1300' product is the most expensive product based on MSRP.
- '1992 Ferrari 360 Spider red' product is the most consistent product ordered by customers

## Conclusion
- In this project, we successfully designed, queried, and analyzed a relational database for a model car sales system. The database consisted of multiple interconnected tables, including products, orders, customers, employees, and payments, enabling a structured approach to managing business operations.
