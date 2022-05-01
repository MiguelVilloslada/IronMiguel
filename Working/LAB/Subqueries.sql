use sakila;

# 1 How many copies of the film Hunchback Impossible exist in the inventory system?
select title ,count(title) from film
join inventory using (film_id)
where title = 'Hunchback Impossible';

# 2 List all films whose length is longer than the average of all the films.

select title, length from film 
where length >
(select avg(length) from film)
order by length ASC;

# 3 Use subqueries to display all actors who appear in the film Alone Trip.

select first_name, last_name from actor where actor_id in
(select actor_id from film_actor where film_id =
(select film_id from film where title= 'Alone Trip'));
	
    # using joins
select title ,first_name, last_name from film
join film_actor using(film_id)
join actor using(actor_id)
where title = 'Alone Trip';

# 4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

select title from film where film_id in
(select film_id from film_category where category_id=
(select category_id from category where name = 'Family')); 

	# using joins
select title, name, category_id from film
join film_category using (film_id)
join category using (category_id)
where name = 'Family';

# 5 Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

select c.first_name, c.last_name, c.email, country from customer as c
join sakila.address using(address_id)
join sakila.city using(city_id)
inner join (select * from country where country='Canada') can
using(country_id);

#using joins
select first_name, last_name, email, country from customer
join address using(address_id)
join city using(city_id)
join country using(country_id)
where country = 'Canada';

#Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

#Sian's answer
-- outer query
#select films if actor is..filmids
#join to film table to get titles
-- inner
#select actor id from
-- inner
#select actor name - if that actor has acteed in the most films
#count(films) - group by actor
#order by no of films, and pick the biggest

select title from film 
join film_actor using(film_id)
where actor_id
=(
select actor_id from
(select actor_id, count(film_id)
from film_actor
group by actor_id
order by count(film_id) DESC
limit 1) af
);

#Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select title from film
join inventory using(film_id)
join rental using(inventory_id)
where customer_id=
(select customer_id from
(select customer_id, sum(amount) from payment 
group by customer_id
order by sum(amount) DESC 
limit 1)c);

#Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client

select customer_id, sum(amount) from payment
group by customer_id having sum(amount)>
(select avg(avgtotal) from 
(select customer_id, sum(amount) as avgtotal from payment 
group by customer_id) c)
order by sum(amount) DESC;



