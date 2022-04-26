#Film titles
SELECT title FROM film;
#Get unique list of film languages under the alias language. 
#Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future
select distinct(name) from language;
#Find out how many stores does the company have?
Select count(distinct store_id) from store;
#Find out how many employees staff does the company have?
Select count(distinct staff_id) from staff;
#Return a list of employee first names only?
Select first_name from staff;