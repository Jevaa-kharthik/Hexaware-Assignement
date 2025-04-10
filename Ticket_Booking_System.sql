-- Task 1

create database TicketBookingSystem;

use TicketBookingSystem;

create table venue(
venue_id int primary key,
venuename varchar(30) not null,
address varchar(30) not null
);

create table event(
event_id int primary key,
event_name varchar(30) not null,
event_date date not null,
venue_id int,
total_seats int not null,
avaiable_seats int not null,
ticket_price decimal(10,2) not null,
event_type varchar(30) not null,
foreign key(venue_id) references venue(venue_id)
);

create table customer(
customer_id int primary key,
customer_name varchar(40) not null,
email varchar(50) unique,
phone_number varchar(10) not null
);


create table booking(
booking_id int primary key,
customer_id int,
event_id int,
num_tickets int not null,
total_cost decimal(10,2) not null,
booking_date date not null,
foreign key(customer_id) references customer(customer_id),
foreign key(event_id) references event(event_id)
); 

-- Task 2
# Question 1

insert into venue values
(1, 'Nehru Stadium', 'Chennai'),
(2, 'Salt Lake', 'Kolkata'),
(3, 'BKC Hall', 'Mumbai'),
(4, 'Siri Fort', 'Delhi'),
(5, 'Shilpakala', 'Hyderabad'),
(6, 'BIC', 'Bangalore'),
(7, 'Kala Mandir', 'Kolkata'),
(8, 'JLN Stadium', 'Delhi'),
(9, 'PVR ICON', 'Chennai'),
(10, 'Phoenix Arena', 'Hyderabad');

insert into event values
(1, 'Kuhad Live', '2025-06-20', 1, 5000, 1200, 999.00, 'Concert'),
(2, 'Ind vs Aus', '2025-07-12', 2, 65000, 8000, 1800.00, 'Sports'),
(3, 'Short Films Youtube', '2025-06-25', 3, 300, 2999, 350.00, 'Movie'),
(4, 'Armaan Live', '2025-08-05', 4, 2500, 400, 1100.00, 'Concert'),
(5, 'Good Bad Ugly', '2025-09-01', 5, 10000, 2500, 500.00, 'Movie'),
(6, 'Tech Summit', '2025-10-15', 6, 3000, 1000, 1500.00, 'Concert'),
(7, 'IPL Final', '2025-11-10', 2, 32000, 6000, 750.00, 'Sports'),
(8, 'Selina Gomez', '2025-07-22', 5, 1500, 250, 2700.00, 'Concert'),
(9, 'South India Film City', '2025-08-10', 7, 1200.00, 75, 299.00, 'Movie'),
(10, 'DJ Adam', '2025-10-05', 10, 8000, 2000, 600.00, 'Concert');

INSERT INTO customer VALUES
(1, 'Joshua Aaron', 'joshuanothing@gmail.com', '9876543210'),
(2, 'Koushik Manoharan', 'koushikmano@gmail.com', '9123456780'),
(3, 'Gowtham Siva', 'gowthamsiva90@gmail.com', '9988776655'),
(4, 'Gowtham R', 'gowhtamramachandran@gmail.com', '9112233445'),
(5, 'Banuputra BVK','banubvk@gmail.com', '9001122334'),
(6, 'Pavish V','pavish2003@gmail.com', '9223344556'),
(7, 'Joseph Bharath', 'josephbhaeath@gmail.com', '9334455667'),
(8, 'Dharani M', 'dharanim9080@gmail.com', '9445566778'),
(9, 'Abishek K','abishek@gmail.com', '9556677889'),
(10, 'Gowthan V', 'gowthamv2003@gmail.com', '9667788990');

insert into booking values 
(1, 1, 2, 4, 7200.00, '2025-06-01'),
(2, 2, 1, 2, 1998.00, '2025-06-05'),   
(3, 3, 3, 3, 1050.00, '2025-06-10'),   
(4, 1, 5, 5, 2500.00, '2025-06-15'),   
(5, 4, 4, 2, 2200.00, '2025-06-16'),   
(6, 5, 6, 1, 1500.00, '2025-06-20'),   
(7, 2, 9, 2, 598.00, '2025-06-25'),    
(8, 6, 10, 4, 2400.00, '2025-06-28'),  
(9, 3, 7, 3, 2250.00, '2025-07-01'),   
(10, 7, 8, 2, 1800.00, '2025-07-03'),  
(11, 8, 4, 1, 1100.00, '2025-07-04'),  
(12, 9, 2, 2, 3600.00, '2025-07-06'),  
(13, 5, 10, 3, 1800.00, '2025-07-08'), 
(14, 10, 5, 2, 1000.00, '2025-07-10'), 
(15, 1, 8, 3, 2700.00, '2025-07-12'); 

# Question 2
select event_name from event;

# Question 3
select event_name, avaiable_seats as 'Avaiable Tickets' from event;

# Question 4
select event_name from event where event_name like '%cup%';

# Question 5
select event_name, ticket_price from event where ticket_price between 1000 and 3000;

# Question 6
select event_name, event_date from event where event_date between '2025-01-01' and '2025-12-31';

# Question 7
select event_name, avaiable_seats as 'Avaiable Tickets' from event where event_type like '%Concert%';

# Question 8
select * from customer limit 5 offset 5;

# Question 9
select * from booking where num_tickets > 4;

# Question 10
select * from customer where phone_number like '%334';

# Question 11
select * from event where total_seats > 3000;

# Question 12
select event_name from event where event_name not like 'z%' and event_name not like 'y%' and event_name not like 'x%';

-- Task 3
# Question 1
select 
	e.event_name,
    avg(b.total_cost / b.num_tickets) as AverageTicketPrice
from booking b
join event e on b.event_id = e.event_id
group by e.event_id;

# Question 2
select
	e.event_id,
    e.event_name,
    sum(b.total_cost) as TotalRevenue
from event e
join booking b on e.event_id = b.event_id
group by e.event_id;

# Question 3
select
	e.event_name,
    sum(b.num_tickets) as TotalTickets
from event e
join booking b on e.event_id = b.event_id
group by e.event_id, e.event_name
order by TotalTickets desc
limit 1;

# Question 4
select 
	e.event_id,
	e.event_name,
    sum(b.num_tickets) as TotalTickets
from event e
join booking b on e.event_id = b.event_id
group by e.event_id, e.event_name;

# Question 5
select 
	*
from event e
left join booking b on e.event_id = b.event_id
where b.num_tickets is null;

# Question 6
select 
	c.customer_name,
    sum(b.num_tickets) as MaxTickets
from customer c
join booking b on c.customer_id = b.customer_id
group by c.customer_id
order by maxtickets desc
limit 1;

# Question 7
select
	e.event_name,
    sum(b.num_tickets) as TotalTickets,
    monthname(b.booking_date) as yearMonth,
    year(b.booking_date) as yearYear
from event e
join booking b on e.event_id = b.event_id
group by e.event_name, yearMonth, yearYear
order by yearMonth, yearYear, e.event_name;
    
# Question 8
select
	v.venuename,
   round(avg(b.total_cost / b.num_tickets), 2) as AverageTicketPrice
from booking b
join event e on b.event_id = e.event_id
join venue v on e.venue_id = v.venue_id
group by v.venuename, v.venue_id;

# Question 9
select 
	e.event_name,
    round(avg(b.num_tickets),2) as AverageTicketSold
from event e
join booking b on e.event_id = b.event_id
group by e.event_id, e.event_name;

# Question 10
select
	e.event_name,
	sum(b.num_tickets * e.ticket_price) as TotalRevenue,
    year(b.booking_date) as yearYear
from booking b
join event e on b.event_id = e.event_id
group by e.event_name, yearYear
order by e.event_name, yearYear desc;

# Question 11
select
    c.customer_name,
	c.email,
    c.phone_number,
    count(distinct event_id) as TotalEvents
from customer c
join booking b on c.customer_id = b.customer_id
group by c.customer_id
having TotalEvents > 1;

# Question 12
select
	c.customer_name,
	c.email,
    c.phone_number,
    sum(b.total_cost) as TotalRevenue
from customer c
join booking b on c.customer_id = b.customer_id
group by c.customer_id, c.customer_name
order by TotalRevenue desc;

# Question 13
select 
    e.event_type,
    avg(e.ticket_price) as AverageTicket,
    v.venuename
from event e
join venue v on e.venue_id = v.venue_id
group by e.event_type, v.venuename
order by e.event_type, v.venuename;

# Question 14
select 
	c.customer_name,
    sum(b.num_tickets) as TotalTickets
from customer c
join booking b on c.customer_id = b.customer_id
where b.booking_date > curdate() - interval 30 day
group by c.customer_name
order by TotalTickets desc;

-- Task 4
# Question 1
select 
	v.venuename, (
		select 
			avg(e.ticket_price)
		from event e
        where e.venue_id = v.venue_id
    ) as TicketAverage
from venue v;

# Question 2
select
	e.event_name,
    e.event_id
from event e
where(
	select sum(b.num_tickets)
    from booking b
    where b.event_id = e.event_id
) > e.total_seats / 2;

# Question 3
select
	e.event_name,
	(select 
		sum(b.num_tickets)
    from booking b
	where e.event_id = b.event_id
    ) as TotalTickets
from event e;

# Question 4
select * from customer c
where not exists(
select 1 from booking b
where b.customer_id = c.customer_id
);

# Question 5
select * from event e
where event_id not in (
	select distinct event_id from booking
);

# Question 6
select 
	b.event_type,
    sum(b.Total) as TotalTickets
from (
	select
		e.event_type,
        b.num_tickets as Total
	from event e
    join booking b on e.event_id = b.event_id
) as b
group by e.event_type;

# Question 7
select *
from event e
where (
	select
		avg(e.ticket_price) as AverageTicket
	from event e
) < e.ticket_price;

# Question 8
select
	c.customer_name,
    (
		select 
			sum(b.num_tickets * e.ticket_price)
		from booking b
        join event e on b.event_id = e.event_id
        where b.customer_id = c.customer_id
    )as TotalRevenue
from customer c;

# Question 9
select * from customer
where customer_id in (
	select
		b.customer_id
	from booking b
    join event e on b.event_id = e.event_id
    where e.event_id = 2
);
    
# Question 10
select
	av.event_type,
	sum(av.num_tickets) as TotalTickets
from
    (
		select e.event_type, b.num_tickets
        from booking b
        join event e on b.event_id = e.event_id
    ) as av
group by av.event_type;

# Question 11
select 
	c.customer_id,
    c.customer_name,
    date_format(b.booking_date, '%Y-%m') as BookingMonth
from booking b
join customer c on b.customer_id = c.customer_id
where date_format(b.booking_date, '%Y-%m') in (select distinct date_format(b.booking_date, '%Y-%m') from booking b)
group by c.customer_id, date_format(b.booking_date, '%Y-%m')
order by customer_id;

# Question 12
select
	v.venue_id,
	v.venuename,
    (
		select avg(e.ticket_price) 
        from event e
        where e.venue_id = v.venue_id
    ) as AverageTicket
from venue v
order by AverageTicket desc ;



    

