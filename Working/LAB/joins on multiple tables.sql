use sakila;

##Write a query to display for each store its store ID, city and country.

select store_id, city, country from store
join address using (address_id)
join city using (city_id)
join country using (country_id);

##Write a query to display how much benefit amount, in dollars, each store brought in

select store_id, sum(amount) as benefit from payment
join staff using(staff_id)
join store using(store_id)
group by store_id;

#What is the average running time of films by category?

select avg(length), name as category from film
join film_category using(film_id)
join category using(category_id)
group by category;

#Which film categories are longest on average?

select avg(length), name as category from film
join film_category using(film_id)
join category using (category_id)
group by category
order by avg(length) DESC
limit 3;

#Display the most frequently rented movies in descending order.

select count(rental_id) as frequency, title from rental
join inventory using(inventory_id)
join film using(film_id)
group by title
order by frequency DESC;

