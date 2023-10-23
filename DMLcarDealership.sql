--Data Manipulation Langages Script
--procedure 

--Inserting cities into table
insert into city(city)
select UNNEST(ARRAY['New York',
	'Los Angeles',
	'Chicago',
	'Houston',
	'Philadelphia',
	'San Diego',
	'Dallas',
	'Indianapolis',
	'Jacksonville',
	'Austin',
	'Florida']);
	
--inserting address fields
insert into address(street_address, zipcode,state,city_id)
values 
	('123 Main Street', '10433', 'CA', 5),
	('456 Elm St', 67890, 'NY', 6), 
    ('789 Oak St', 54321, 'TX', 7),
    ('101 Park Ave', 30303, 'GA', 8),  
    ('246 Cedar St', 78701, 'TX', 9), 
    ('555 Pine St', 98101, 'WA', 10),  
    ('777 Maple St', 60601, 'IL',11);
    
-- creating a procedure for inserting into customer or employee or saleperson column
--   this only works because all tables have the same format
create or replace procedure add_person(table_name varchar, f_name varchar, l_name varchar, email varchar, add_id integer)
language plpgsql
as $$
begin
	EXECUTE format('INSERT INTO %I (first_name, last_name, email_address, address) VALUES ($1, $2, $3, $4)', table_name)
	USING f_name, l_name, email, add_id;
end;
$$

--adding myself as a customer a sales person and as a mechanic lol
call add_person('salesperson', 'Dylan', 'Heslop', 'heslopd23@gmail.com', 1);
call add_person('mechanic', 'Dylan', 'Heslop', 'heslopd23@gmail.com', 1);
call add_person('customer', 'Dylan', 'Heslop', 'heslopd23@gmail.com', 1);

--adding sales person
call add_person('salesperson', 'Craig', 'Miller', 'craig@gmail.com', 2);
call add_person('salesperson', 'Doriene', 'Orridge', 'doriene@gmail.com', 3);
call add_person('salesperson', 'Anna', 'Jackson', 'jacksonAnna@gmail.com', 3);
call add_person('salesperson', 'Craig', 'Black', 'craigblack@gmail.com', 5);

--adding mechanics
call add_person('mechanic', 'Derrick', 'Miller', 'dmiller@gmail.com', 6);
call add_person('mechanic', 'Yvonne', 'Green', 'YGreen@gmail.com', 7);
call add_person('mechanic', 'Michal', 'Jackson', 'mjack@gmail.com', 3);
call add_person('mechanic', 'Orange', 'Fruit', 'ofruit@gmail.com', 2);

--entering different car manufacturers
insert into make(make, year_founded)
values ('Mitsubishi', 1997),
('Toyota', 2000),
('Mercedes', 1980),
('Ferrari', 1991),
('Bugatti', 2000),
('Honda', 1987),
('Hyundai', 2001),
('Nissan', 2000),
('KIA', 1999);

--adding cars now
insert into car(model, release_year, make_id)
values ('Roadster', 2020, 1),
('Python', 2010, 3),
('Evo10', 2019, 1),
('Frontier', 2023, 8),
('Tuscon', 2020, 7),
('CL50', 2014, 3), 
('Supra', 2020, 2),
('Benz', 2014, 3),
('Speedster', 2020, 4),
('Dune Buggy', 2018, 5),
('Accord', 2020, 6);

insert into inventory(stock_amount, cost, serial_number) values
(50, 20000, 1),
(10, 10000, 2),
(20, 15000,3),
(13, 12000, 4),
(14, 10000, 5),
(23, 15000, 6),
(20, 20000, 7),
(15, 13000, 8),
(20, 15000, 9),
(10, 12000, 10),
(5, 10000, 11);


--by now all generic data have been generated
--now we can create the actual data by scenarios

--SCENARIO 1
-- I (Dylan Heslop) a customer bought a mercedes frontier for 15000 today(now) and my good friend
-- Craig Miller sold it to me
insert into invoices(amount, inventory_id, customer_id, salesperson_id) values
(15000, 4, 1, 2);
--Scenario 2 a new customer that dont exists as yet in the table Jack Brown has bought
--a car from my nephew Doriene Orridge and he brought the Hyundai Tuscon
--creating new customer first
call add_person('customer', 'Jack', 'Brown', 'jackB@gmail.com', 7); 
insert into invoices(amount, inventory_id, customer_id, salesperson_id) values
(13000, 5, 2, 3);

 
--Scenario 3
-- a new customer Jason Greenwood comes into our store to service his Tesla CyberTruck
--today, he fixed his tires and replaced the charging slot... this was done by some mechanics
-- and paid 3000 to fix it
insert into make(make, year_founded) values('Tesla', 2019);
call add_person('customer', 'Jason', 'Greenwood', 'jasonGreen@gmail.com', 4); 
insert into serviced_cars(model, release_year, make_id) values
('cyberTruck', 2023, 9);
insert into service_tickets(amount, serial_number, customer_id) values
(3000,1,3 );

insert into service_history(mechanic_id, ticket_id) values
(1, 1),
(2, 1),
(3, 1);
