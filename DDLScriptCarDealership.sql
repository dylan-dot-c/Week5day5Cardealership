--SQL SCRIPT FOR DDL
--1st table
create table city(
	city_id serial primary key,
	city varchar(50) not null
);

--2nd table
create table address(
	address_id serial primary key,
	street_address varchar(50) not null,
	zipcode integer not null,
	state varchar(50) not null,
	city_id integer not null,
	foreign key(city_id) references city(city_id)
);

--3rd table
create table customer (
	customer_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email_address varchar(50) not null unique,
	address integer not null,
	start_date timestamp default now(),
	foreign key(address) references address(address_id)
);

--4th table
create table make (
	make_id serial primary key,
	make varchar(30) not null,
	year_founded integer not null
);

--5th table
create table car(
	serial_number serial primary key,
	model varchar(30) not null,
	release_year integer not null,
	make_id integer not null,
	foreign key(make_id) references make(make_id)
);

--altering the table so that I can set the staeting value of the serial
-- number to 1000 instead of 1
--SYNTAX
----ALTER SEQUENCE tablename_columnname_seq RESTART WITH anynumber;
--alter sequence car_serial_number_seq
--restart with 1000; 
--**NOTE** It still wasnt working so I just went along with the normal indices

--6th table
create table inventory(
	inventory_id serial primary key,
	stock_amount integer not null,
	cost integer not null,
	serial_number integer not null,
	foreign key(serial_number) references car(serial_number)
);

--7th table
create table salesperson(
	salesperson_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email_address varchar(50) not null unique,
	address integer not null,
	start_date TIMESTAMP default now(),
	foreign key(address) references address(address_id)
);

--8th table
create table mechanic(
	mechanic_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email_address varchar(50) not null unique,
	address integer not null,
	start_date TIMESTAMP default now(),
	foreign key(address) references address(address_id)
);

--9th table
create table serviced_cars(
	serial_number serial primary key,
	model varchar(30) not null,
	release_year integer not null,
	make_id integer not null,
	foreign key(make_id) references make(make_id)
);

--10th table
create table service_tickets(
	ticket_id serial primary key,
	amount integer not null,
	date_serviced TIMESTAMP default now(),
	serial_number integer not null,
	description varchar(150) not null default 'Serviced Car',
	foreign key(serial_number) references serviced_cars(serial_number),
	customer_id integer not null,
	foreign key(customer_id) references customer(customer_id)
);

--11th table
create table service_history(
	mechanic_id integer not null,
	foreign key(mechanic_id) references mechanic(mechanic_id),
	ticket_id integer not null,
	foreign key(ticket_id) references mechanic(mechanic_id)
);

--12th and last table
create table invoices(
	invoice_id serial primary key,
	amount integer not null,
	date_invoiced timestamp default now(),
	inventory_id integer not null,
	foreign key(inventory_id) references inventory(inventory_id),
	customer_id integer not null,
	foreign key(customer_id) references customer(customer_id),
	salesperson_id integer not null,
	foreign key(salesperson_id) references salesperson
);