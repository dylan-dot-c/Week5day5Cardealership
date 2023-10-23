--DQL
--just added some queries for transparency

--showing all customers and their addresses
select * from customer
join address a
on a.address_id = customer.address;

--showing all cars and their make
select c.serial_number, c.model, m.make, c.release_year, m.year_founded from car c
join make m 
on m.make_id = c.make_id;

--showing all inventory, the amount in stock and the cost for the car
select  i.serial_number, i.stock_amount, i.cost, c.model, m.make from inventory i
join car c 
on i.serial_number = c.serial_number
join make m 
on m.make_id = c.make_id ;

--selecting all invoices, date, customer, amount and sales_person name
select i.date_invoiced, concat(c.first_name, ' ', c.last_name) as customer_name, i.amount, 
concat(s.first_name, ' ', s.last_name) as salesperson_name
from invoices i 
join customer c 
on c.customer_id = i.customer_id
join salesperson s 
on i.salesperson_id = s.salesperson_id;

--selecting all service tickets and description and date
select 
concat(c.first_name, ' ', c.last_name) as customer_name,
st.date_serviced,
st.description
from service_tickets st 
join customer c 
on c.customer_id = st.customer_id;

select * from service_tickets st ;

--finding mechs that work on ticket id 1
select concat(m.first_name, ' ', m.last_name) as mechanic
from service_history sh 
join mechanic m 
on m.mechanic_id = sh.mechanic_id
where sh.ticket_id = 1;