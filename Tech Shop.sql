-- Task 1

create database TechShop;

use TechShop;

create table Customers(
CustomerID int primary key,
FirstName varchar(30) not null,
LastName varchar(30) not null,
Email varchar(30) unique,
Phone varchar(15) unique, -- country formats
Address varchar(30) not null
);

create table Products(
ProductID int primary key,
ProductName varchar(30) not null,
Description varchar(100) not null,
Price decimal(10,2) not null
);

create table Orders(
OrderID int primary key,
CustomerID int,
OrderDate date not null,
TotalAmount decimal(10,2) not null,
foreign key (CustomerID) references Customers(CustomerID)
);

create table OrderDetails(
OrderDetailID int primary key,
OrderID int,
ProductID int,
Quantity int not null,
foreign key(OrderID) references Orders(OrderID),
foreign key(ProductID) references Products(ProductID)
);

create table Inventory(
InventoryID int primary key,
ProductID int,
QuantityInStock int not null,
LastStockUpdate date not null,
foreign key (ProductID) references Products(ProductID)
);

insert into Customers values 
(1, 'Joshua', 'Aaron', 'joshuanothing@gmail.com', '9876543210', 'Tiruppur'),
(2, 'Koushik', 'Manoharan', 'koushikmano@gmail.com', '9123456780', 'Tiruppur'),
(3, 'Gowtham', 'Siva', 'gowthamsiva90@gmail.com', '9988776655', 'Tiruppur'),
(4, 'Gowtham', 'R', 'gowhtamramachandran@gmail.com', '9112233445', 'Coimbatore'),
(5, 'Banuputra', 'BVK', 'banubvk@gmail.com', '9001122334', 'Gobi'),
(6, 'Pavish', 'v', 'pavish2003@gmail.com', '9223344556', 'Gobi'),
(7, 'Joseph', 'Bharath', 'josephbhaeath@gmail.com', '9334455667', 'Conoor'),
(8, 'Dharani', 'M', 'dharanim9080@gmail.com', '9445566778', 'Bangalore'),
(9, 'Abishek', 'K', 'abishek@gmail.com', '9556677889', 'Chennai'),
(10, 'Gowthan', 'V', 'gowthamv2003@gmail.com', '9667788990', 'Coimbatore');

insert into Products values 
(1, 'Laptop', '14-inch gaming laptop with 16GB RAM', 85000),
(2, 'Smartphone', '6.5-inch display, 128GB storage', 25000),
(3, 'Headphones', 'Wireless over-ear headphones', 5000),
(4, 'Keyboard', 'Mechanical RGB keyboard', 3000),
(5, 'Mouse', 'Wireless mouse with ergonomic design', 1500),
(6, 'Monitor', '24-inch Full HD monitor', 12000),
(7, 'Printer', 'All-in-one wireless printer', 7000),
(8, 'Router', 'Dual-band WiFi 6 router', 4000),
(9, 'Webcam', '1080p USB webcam', 2500),
(10, 'External HDD', '1TB USB 3.0 hard drive', 4500);

insert into Orders values 
(1, 1, '2025-04-01', 85000),
(2, 2, '2025-04-02', 3000),
(3, 3, '2025-04-02', 26500),
(4, 4, '2025-04-03', 4500),
(5, 5, '2025-04-03', 13500),
(6, 6, '2025-04-04', 12000),
(7, 7, '2025-04-04', 7000),
(8, 8, '2025-04-05', 2500),
(9, 9, '2025-04-06', 25000),
(10, 10, '2025-04-06', 1500);

insert into OrderDetails values
(1, 1, 1, 1),
(2, 2, 4, 3),
(3, 3, 2, 8),
(4, 3, 5, 4),
(5, 4, 10, 2),
(6, 5, 6, 1),
(7, 5, 5, 9),
(8, 6, 6, 15),
(9, 7, 7, 2),
(10, 8, 9, 6);

insert into Inventory values
(1, 1, 10, '2025-03-30'),
(2, 2, 20, '2025-03-30'),
(3, 3, 15, '2025-03-29'),
(4, 4, 25, '2025-03-29'),
(5, 5, 30, '2025-03-28'),
(6, 6, 18, '2025-03-28'),
(7, 7, 12, '2025-03-27'),
(8, 8, 20, '2025-03-27'),
(9, 9, 14, '2025-03-26'),
(10, 10, 10, '2025-03-26');

-- Task 2

# Question 1
select concat(FirstName, ' ', LastName) as 'Full Name', Email from Customers;

# Question 2
select o.Orderdate, concat(c.FirstName, ' ', c.LastName) as 'Full Name'
from Orders o
join Customers c on o.customerID = c.CustomerID;

# Question 3
insert into Customers values (11, 'Jevaa', 'Kharthik', 'jevaakharthik@gmail.com', '9600477188', 'Tiruppur');

# Question 4
update Prodcuts set Price = Price * 1.1;

# Question 5
delete from OrderDetails where OrderID = 1;
delete from Orders where OrderID = 1;

# Question 6
insert into Orders (OrderID, CustomerID, OrderDate, TotalAmount) values
(11, 10, curdate(), 40000);

# Question 7
update Customers set Email = 'aaronjos996@gmail.com', Address = 'Tiruppur'
where CustomerID = 1;

# Question 8
update Orders o
join (
	select
		od.OrderID,
        sum(p.Price * od.Quantity) as totalcost
	from OrderDetails
    join Products p on od.ProductId = p.ProductID
) as total on o.OrderID = total.OrderID
set o.TotalAmount = total.totalcost;

# Question 9
delete from OrderDetails 
where OrderId in (select OrderID from Orders where CustomerID = 3);

delete OrderID from Orders where CustomerID = 3;

# Question 10
insert into Products values
(11,'iMac', '32-inch iMac with 32GB RAM and 1TB Storage', 240000);

# Question 11
-- Assume Status

update Orders
set Status = 'Pending'
where OrderID = 4;

# Question 12
update Customers c
set TotalOrders = (
	select o.OrderID, count(*)
    from Orders
    where o.CustomerID = c.CustomerID
);

-- Task 3
# Question 1
select 
	c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    c.Phone,
    c.Address,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
from Customers c
join Orders o on c.CustomerID = o.CustomerID;

# Question 2
select 
	p.ProductName,
    sum(p.Price * od.Quantity) as TotalRevenue
from OrderDetails od
join Products p on od.ProductID = p.ProductID
group by p.ProductID;

# Question 3
select 
	concat(c.FirstName, ' ', c.LastName) as 'Full Name',
    c.Email,
    c.Phone,
    c.Address
from Customers c
join Orders o on c.CustomerID = o.CustomerID;

# Question 4
select 
	p.ProductName,
    od.Quantity
from Products p
join OrderDetails od on p.ProductID = od.ProductID
order by od.Quantity desc
limit 1;

# Question 5
-- there is no categories 
-- Assume

-- select ProductName, Category from Product where category = 'Electronics Gadgets'

select ProductID, ProductName from Products where ProductName = 'Monitor' group by ProductID, ProductName;

# Question 6
select
	c.CustomerID,
    c.FirstName,
    c.LastName,
    avg(o.TotalAmount) as TotalAverage
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID, c.FirstName, c.LastName;

# Question 7
select 
	o.OrderID,
    c.FirstName,
    c.LastName,
    c.Email,
    c.Phone,
    c.Address,
    sum(p.Price * od.Quantity) as TotalRevenue
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
group by o.OrderID, c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, c.Address
order by TotalRevenue desc
limit 1;

# Question 8
select
	p.ProductName,
    count(od.OrderDetailID) as TotalOrder
from Products p
join OrderDetails od on p.ProductID = od.ProductID
where p.ProductName = 'Laptop'
group by p.ProductID, p.ProductName
order by TotalOrder desc;

# Question 9
select c.*,p.ProductName from Customers c
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
where p.ProductName = 'Monitor';

# Question 10
select 
	sum(od.Quantity * p.Price) as TotalRevenue
from OrderDetails od
join Products p on od.ProductID = p.ProductID
join Orders o on od.OrderID = o.OrderID
where o.OrderDate between '2024-01-01' and curdate();

-- Task 4
# Question 1
select * from Customers where CustomerID not in (
select
	CustomerID
    from Orders
);

# Question 2
select
	count(QuantityInStock) as AvaiableTotalProduct
from Inventory;

# Question 3
select
	sum(p.Price * od.Quantity) as TotalRevenue
from OrderDetails od 
join Products p on od.ProductID = p.ProductID;

# Quesion 4
select 
	avg(od.Quantity) as AverageQuantity,
    p.ProductName
from OrderDetails od
join Products p on od.ProductID = p.ProductID
where p.ProductName = 'Monitor'
group by p.ProductID, p.ProductName;

# Question 5
select
	c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as FullName,
	sum(p.Price * od.Quantity) as TotalRevenue
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
where c.CustomerID = 8;

# Question 6
select 
	c.CustomerID,
	count(o.OrderID) as TotalOrders
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID
order by TotalOrders desc
limit 1;

# Question 7
select 
	p.ProductName,
    od.Quantity
from Products p
join OrderDetails od on p.ProductID = od.ProductID
where od.Quantity = (select max(Quantity) from OrderDetails);

# Question 8
select 
	concat(c.FirstName, ' ', c.LastName) as FullName,
    sum(p.Price * od.Quantity) as TotalSpending
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
where ProductName = 'Monitor'
group by c.CustomerID
order by TotalSpending
limit 1;
    
# Quesion 9
select
	c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as FullName,
    round(sum(p.Price * od.Quantity) / count(distinct o.OrderID)) as TotalRevenue
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
group by c.CustomerID;

# Question 10
select
	concat(c.FirstName, ' ', c.LastName) as FullName,
    count(distinct o.OrderID) as TotalOrders
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID
	
