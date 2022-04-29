use sakila;

#Write a query to display for each store its store ID, city and country.

Select store_id, city, country FROM store
inner join address
using(address_id)
inner join city
using(city_id)
inner join country
using(country_id)
group by store_id;

#Write a query to display how much benefit amount, in dollars, each store brought in.

Select store_id, sum(amount) from staff
inner join payment 
using(staff_id)
group by store_id; 

#What is the average running time of films by category?

Select category_id, avg(length) from film
inner join film_actor
using(film_id)
inner join film_category
using(film_id)
group by category_id;

#Which film categories are longest on average?

Select category_id, max(length) from film
inner join film_actor
using(film_id)
inner join film_category
using(film_id)
group by category_id
order by max(length)DESC;

#Display the most frequently rented movies in descending order.


select title, count(distinct inventory_id) as n_times from film
inner join inventory
using(film_id)
inner join rental
using(inventory_id)
group by title
order by n_times DESC;