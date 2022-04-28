use sakila

#Using the rental table, find out how many rentals were processed by each employee.
select * from rental;
Select count(rental_id) as rental_processed, staff_id from rental
group by staff_id;

#Using the film table, find out how many films were released.
select * from film;
Select count(distinct(title)) as films_released from film
where release_year is not null;

#Using the film table, find out how many films there are of each rating. Sort the results in descending order of the number of films.
Select count(distinct(title)), rating from film
group by rating;

#Which kind of movies (rating) have a mean duration of more than two hours?
select * from film;
Select rating, avg(length) from film
group by rating
having avg(length)>120;
