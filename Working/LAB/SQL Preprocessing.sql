#Select all the actors with the first name "Scarlett
Select first_name from actor
where first_name='Scarlett';

#How many films (movies) are available for rent and how many films have been rented?
Select count(distinct(inventory_id)) from inventory;
select count(*) from rental;

#What are the shortest and longest movie duration? Name the values max_duration and min_duration.
Select MAX(length) AS max_duration, MIN(length) AS min_duration
from film;

#What's the average movie duration expressed in format (hours, minutes)?
Select convert(avg(length),time) from film; # Not correct way
Select sec_to_time(avg(length)*60) from film; 
select floor(avg(length)/60) as hours, round(avg(length)%60) as minutes from film; 

#How many distinct (different) actors' last names are there?
Select count(distinct(last_name)) from actor;

#Since how many days has the company been operating (check DATEDIFF() function)?
Select Datediff(max(rental_date),min(rental_date)) as company_life from rental;

#Show rental info with additional columns month and weekday. Get 20 results.

Select date_format(rental_date,'%M') as month, date_format(rental_date,'%W') as weekday FROM rental
LIMIT 20;

#Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

select date_format(rental_date,"%M") as month, date_format(rental_date,"%W") as day,
case date_format(rental_date, '%W')
when 'Saturday' then 'Weekend'
when 'Sunday' then 'Weekend'
else 'Weekday'
end
as day_type from rental
limit 20;

#How many rentals were in the last month of activity?

Select date(max(rental_date))-interval 30 day, date(max(rental_date))
from rental

Select count(*)
from rental 
where date(rental_date) between date('2006-01-15') and date('2006-02-14');


select count(*)
from rental where rental_date
>=
(select max(rental_date)-interval 30 day from rental);

