SELECT name
from Passenger;

select name from company;

select * from Trip
where town_from = 'Moscow'

select name from passenger
where name like '%man';

select count(*) as count from Trip
where plane = 'TU-134';

SELECT Company.name as name
FROM Trip 
JOIN Company ON Company.id = Trip.company WHERE plane = 'Boeing' GROUP BY company;

select plane from Trip
where town_to = 'Moscow'
group by plane

select name
from Company as c
	join Trip on c.id = Trip.company
where town_from = 'Vladivostok'
group by company

select *
from Trip
where time_out >= '1900-01-01T10:00:00.000Z'
	and time_out <= '1900-01-01T14:00:00.000Z'

SELECT t.id,
	COUNT(passenger) AS count
FROM Trip t
	LEFT JOIN Pass_in_trip pt ON t.id = pt.trip
GROUP BY t.id;

SELECT t.town_to
FROM Trip t
	JOIN Pass_in_trip ON t.id = Pass_in_trip.trip
	JOIN Passenger ON Passenger.id = Pass_in_trip.passenger
WHERE name = 'Bruce Willis'

SELECT SUM(price * items) AS income_from_female
FROM Purchases
WHERE user_gender IN ('female', 'f')

SELECT employees.name
FROM Employee AS employees,
	Employee AS chieves
WHERE chieves.id = employees.chief_id
	AND employees.salary > chieves.salary;

  SELECT c.name as country_name
from Countries c
	JOIN Regions r on r.countryid = c.id #JOIN Cities ct on  r.id = ct.id
	JOIN Cities ct ON r.id = ct.regionid
WHERE ct.name = "Salzburg"

select *
from Trip
where time_out >= '1900-01-01T10:00:00.000Z'
	and time_out <= '1900-01-01T14:00:00.000Z'
