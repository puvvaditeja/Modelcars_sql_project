-- Solutions of 35 business problems
-- Find the top 10 customers by credit limit.

select 
	customername,creditlimit 
from customers 
order by creditlimit 
desc limit 10; 

-- Find the average credit limit for customers in each country.

select 
	city,avg(creditlimit) 
from customers 
group by city; 

-- Find the number of customers in each state.

select 
	state,count(customername) as count 
from customers 
group by state 
order by count desc;

-- Find the customers who haven't placed any orders.

select * from customers as c 
left join orders as o 
on c.customerNumber=o.customernumber where orderNumber IS NULL;

-- Calculate total sales for each customer.

create view sales_views as select c.customernumber,sum(quantityinstock*buyprice) as sales from customers c left join orders o on c.customernumber=o.customernumber
 join orderdetails od on o.ordernumber=od.ordernumber 
right join products p on od.productcode=p.productcode group by c.customernumber; 
select * from sales_views;

-- List customers with their assigned sales representatives.

select * from customers 
left join employees on customers.salesrepemployeenumber=employees.employeenumber ;

-- Retrieve customer information with their most recent payment details.

select * from customers 
left join payments on customers.customernumber=payments.customernumber 
order by paymentdate desc limit 1;

-- Identify the customers who have exceeded their credit limit.

select c.customernumber,sum(quantityinstock*buyprice) as sales,creditlimit from customers c 
join orders o on c.customernumber=o.customernumber 
join orderdetails od on o.ordernumber=od.ordernumber 
join products p on p.productcode=od.productcode 
group by c.customernumber having sales>creditlimit;

-- Find the names of all customers who have placed an order for a product from a specific product line.

create view product_view as select distinct customername,c.customernumber from customers c  
join orders o on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber 
join products p on od.productcode=p.productcode where productline="ships"  ; 
select * from product_view;
 
-- Find the names of all customers who have placed an order for the most expensive product.

create view expensive_view as select customername,c.customernumber from customers c 
left join orders o on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber 
right join products p on od.productcode=p.productcode order by buyprice desc limit 1;
select * from expensive_view;
 
-- Count the number of employees working in each office.

select 
	offices.officecode,count(employeenumber) as count 
from employees 
left join offices on employees.officecode=offices.officecode 
group by officecode ;

-- Identify the offices with less than a certain number of employees.

select 
	o.officecode, COUNT(e.employeenumber) as count 
from offices  o
left join employees e on o.officecode = e.officecode 
group by o.officecode 
having count(e.employeenumber) < 10;

-- List offices along with their assigned territories.

select 
	o.officecode,o.territory 
from offices o 
left join employees as e on o.officecode = e.officecode 
group by officecode;

-- Find the offices that have no employees assigned to them.

select * from employees 
left join offices on employees.officecode=offices.officecode 
where offices.officecode is null;

-- Retrieve the most profitable office based on total sales.

create view profit_view as select o.officecode,sum(quantityinstock*buyprice) as sales from offices o join employees e on o.officecode=e.officecode 
join customers c on e.employeenumber=c.salesrepemployeenumber 
join orders on c.customernumber=orders.customernumber join orderdetails od on orders.ordernumber=od.ordernumber 
join products p on od.productcode=p.productcode group by o.officecode order by sales desc limit 1;
select * from profit_view;

-- Find the office with the highest number of employees.

select offices.officecode,count(employeenumber) as count from employees 
left join offices on employees.officecode=offices.officecode 
group by officecode 
order by count desc limit 1;

-- Find the average credit limit for customers in each office.

select e.officecode,avg(creditlimit) from customers c 
join employees e on c.salesrepemployeenumber=e.employeenumber 
group by officecode;

-- Find the number of offices in each country.

select country,count(officecode) from offices 
group by country;

-- Count the number of products in each product line.

select productline,count(productname) from products  
group by productline ;

-- Find the product line with the highest average product price.

select productline,avg(msrp) as count from products  
group by productline 
order by count desc limit 1;

-- Find all products with a price above or below a certain amount (MSRP should be between 50 and 100).

select * from products 
where msrp not between 50 and 100;

-- Find the total sales amount for each product line.

select 
	productline,sum(quantityinstock*buyprice) as sales 
from products 
group by productline;

-- Identify products with low inventory levels (less than a specific threshold value of 10 for quantityInStock).

select * from products where quantityinstock<10;

-- Retrieve the most expensive product based on MSRP.

select * from products order by msrp desc limit 1;

-- Calculate total sales for each product.

select 
	productname,sum(quantityinstock*buyprice) as sales 
from products 
group by productname; 

-- Identify the top selling products based on total quantity ordered using a stored procedure. The procedure should accept an input parameter to specify the number of top-selling products to retrieve.

delimiter //
create procedure top_selling_products(in x int)
begin
select od.productcode,productname,sum(quantityordered) as quantityordered from products p join 
orderdetails od on p.productcode=od.productcode group by productcode order by quantityordered desc limit x;
end //
delimiter ;
call top_selling_products(5);

-- Retrieve products with low inventory levels (less than a threshold value of 10 for quantityInStock) within specific product lines ('Classic Cars', 'Motorcycles').

select * from products 
where productline in ("classic cars","motorcycles") and quantityinstock<10;

-- Find the names of all products that have been ordered by more than 10 customers.

select productname,count(c.customernumber) as count_c from customers c 
join orders o on c.customernumber=o.customernumber 
join orderdetails od on o.ordernumber=od.ordernumber 
join products p on od.productcode=p.productcode 
group by productname having count_c>10;

-- Identify the most profitable orders based on total revenue.

select o.ordernumber,sum(quantityinstock*buyprice) as revenue from orders o 
join orderdetails od on o.ordernumber=od.ordernumber 
join products p on p.productcode=od.productcode 
group by o.ordernumber 
order by revenue desc limit 1;

-- List all orders with detailed product information.

select * from orders o 
join orderdetails od on o.ordernumber=od.ordernumber 
join products p on p.productcode=od.productcode ;

-- Identify orders with delayed shipping (shippedDate > requiredDate).

select * from orders where shippeddate > requireddate;

-- Find the most popular product combinations within orders.

select p.productname,count(o.ordernumber) as count from orders o 
join orderdetails od on o.ordernumber=od.ordernumber 
join products p on od.productcode=od.productcode 
group by productname 
order by count desc limit 1; 

-- Calculate revenue for each order and identify the top 10 most profitable.

select o.ordernumber,sum(quantityinstock*buyprice) as revenue from orders o 
join orderdetails od on o.ordernumber=od.ordernumber 
join products p on p.productcode=od.productcode
 group by o.ordernumber 
 order by revenue desc limit 10;

-- Create a trigger that automatically updates a customer's credit limit after a new order is placed, reducing it by the order total.

delimiter //
create trigger update_credit_limit
after insert on orders
for each row
begin
  declare order_total decimal(10,2);
  select sum(quantityOrdered * priceEach) into order_total
  from orderdetails
  where orderNumber = new.orderNumber;

  update customers
  set creditLimit = creditLimit - order_total
  where customerNumber = new.customerNumber;
end //
DELIMITER ;

insert into orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
values (1001, CURDATE(), DATE_ADD(CURDATE(), interval 7 day), NULL, 'Pending', 'Order placed automatically', 123);

