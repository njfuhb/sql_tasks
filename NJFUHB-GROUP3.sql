/* GROUP 3 Tasks against Chinook.db  Vigh Zoltán György - NJFUHB */

/* 1st task - List the name of the second 10(10-20) Customer.*/

SELECT FirstName, LastName FROM Customer WHERE CustomerId BETWEEN '10' AND '20';

/* 2nd task - List the forth 10 track what's name contains 'You' */

SELECT Name FROM Track WHERE Name LIKE '%you%' AND TrackID BETWEEN '40' AND '50';

/* 3rd task - List all employee who hired before 2003' */

SELECT FirstName FROM Employee WHERE HireDate BETWEEN "1950-02-20" AND "2003-01-01";

/* 4th task - List all Customer who's name 'Emma Jones' */

SELECT * FROM Customer WHERE FirstName LIKE '%Emma%' AND LastName LIKE '%Jones%';

/* 5th task - List all Customer's name, address, city, state, country and postal code who are living in the Spain, Austria or Ireland  */

SELECT FirstName, LastName, Address, City, State, Country, PostalCode FROM Customer WHERE Country = 'Spain' OR Country = 'Austria' OR Country = 'Ireland';

/* 6th task - List all the cities where customer lives. Make sure you list only once each city.*/

SELECT DISTINCT(City) FROM Customer;

/* 7th task - Select the average unit price of the tracks but in HUF(with 242 USD/HUF exchange rate) */

SELECT AVG(UnitPrice) * 242 FROM Track;

/* 8th task - List the first 100 Invoice grouped by billing countries and billing states and order the list by billing countries descending  */

SELECT * FROM Invoice GROUP BY BillingCountry, BillingState ORDER BY BillingCountry DESC Limit 100;
 
/* 9th task - List the customer's full name for the first 30 invoice. */

SELECT c.FirstName, c.LastName FROM Invoice i INNER JOIN Customer c ON c.CustomerId = i.CustomerId limit 30;

/* 10rd task - Insert your name, BGF as company and the school's country,city, post code,address to Customer. Then write a query what's result will be only your record.
Now you need to submit the insert query only and result as proof it's inserted. */

INSERT INTO Customer (FirstName, LastName, Company, Country, City, PostalCode, Address, Email) VALUES ('Zoltan','Vigh','BGF', 'Magyarorszag', 'Budapest' , 1149 , 'Buzogany utca 11-13.', 'zolivigh1@gmail.com');
SELECT * FROM Customer WHERE Company IS 'BGF';

/* 11th task - Now update ONLY this record. So the task is change the postcode to something else. Write a query again what is containing your record again same as in the previous task. */

UPDATE Customer SET PostalCode = '1148' WHERE PostalCode = '1149';
SELECT * FROM Customer WHERE Company IS 'BGF';

/* 12th task - List the name of the track with id 90,81,99 respectively and list all possible media type for each. So basically we want to see the names of the tracks with all media type. (The track's name occurs multiple times but the media type only once for each) */

SELECT t.Name, m.Name FROM Track t INNER JOIN MediaType m ON t.MediaTypeId = m.MediaTypeId WHERE t.TrackId = '81' OR t.TrackId = '90' OR t.TrackId ='89' ORDER BY t.TrackId ASC;

/* 13th task - Select the genres's name of a track and the price what is the most expensive. Pls use subquery to get the results. */

/* Basic solution: SELECT g.Name, MAX(t.UnitPrice) FROM Track t INNER JOIN Genre g ON g.GenreId = t.GenreId;*/

SELECT Name,(SELECT MAX(t.UnitPrice) FROM Track t WHERE t.GenreId = g.GenreId) FROM Genre g;

/* 14th task - Select how many times occur each country in the invoice table. Only list the first 5 highest occurrence. */

SELECT BillingCountry, COUNT(*) FROM Invoice GROUP BY BillingCountry ORDER BY COUNT(*) DESC LIMIT 5;

/* 15th task -  Select how many times occur each country in the invoice table. */

SELECT BillingCountry, COUNT(*) FROM Invoice GROUP BY BillingCountry;

/* 16th task - List all of the track name, composer, genre name what is on invoice with '2013-11-13' as invoice date. */

SELECT t.Name, t.Composer, g.Name FROM (Invoice i INNER JOIN InvoiceLine l ON i.InvoiceId = l.InvoiceId) INNER JOIN (Genre g INNER JOIN Track t ON g.GenreId = t.GenreId) ON l.TrackId = t.TrackId WHERE InvoiceDate LIKE "%2013-11-13%";

/* 17th task - List all customer name and state who's state is listed over 10 times as invoice's billing state and it is not NULL. Please use having for this task. */

SELECT c.FirstName, c.LastName, c.State, i.BillingState FROM Customer c INNER JOIN Invoice i ON i.CustomerId = c.CustomerId WHERE c.State IS NOT NULL GROUP BY c.State HAVING COUNT(i.BillingState)>10;

/* 18th task - Select all artist name, album name, track name, genre name, media type name, unit price grouped and order by artist descending which have not yet purchased and the track is on Album named 'The Best Of Van Halen', 'Vol. I and All That You Can't Leave Behind'. */

SELECT a.Name, al.Title, t.Name, g.Name, m.Name, t.UnitPrice FROM MediaType m INNER JOIN ((Artist a INNER JOIN Album al ON a.ArtistId = al.ArtistId) INNER JOIN (Genre g INNER JOIN Track t ON g.GenreId = t.GenreId) ON al.AlbumId = t.AlbumId) ON m.MediaTypeId = t.MediaTypeId WHERE al.Title LIKE '%The Best of Van Halen%' GROUP BY a.Name ORDER BY a.Name DESC;
