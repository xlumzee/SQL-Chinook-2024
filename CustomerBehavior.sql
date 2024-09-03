USE Chinook;

-- Who are the top 5 customers in terms of total purchases?

SELECT c.FirstName AS 'First Name', c.LastName AS 'Last Name', i.Total AS 'Total Purchases'
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
ORDER BY i.Total DESC
LIMIT 5;

-- How many customers have made more than one invoice?

SELECT c.FirstName AS 'First Name', c.LastName AS 'Last Name', i.CustomerId AS 'Customer ID', COUNT(*) AS 'Invoice Count'
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY i.CustomerId
HAVING COUNT(*) > 1
;

-- OR -- 

SELECT c.CustomerId, c.FirstName, c.LastName, COUNT(i.InvoiceId) AS InvoiceCount
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
HAVING COUNT(i.InvoiceId) > 1
ORDER BY InvoiceCount DESC;

-- Which customers have spent more than $40 in total purchases?

SELECT  c.FirstName, c.LastName, SUM(i.Total) AS 'Total Purchases'
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName 
HAVING SUM(i.Total) > 40 ;

-- What is the total number of tracks purchased by each customer?

SELECT c.FirstName, c.LastName, COUNT(il.Quantity) AS TotalTracksPurchased       -- SUM(il.Quantity) AS TotalTracksPurchased
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY c.CustomerId, c.FirstName, c.LastName      -- HAVING COUNT(il.Quantity) > 1 - can use this as well
ORDER BY TotalTracksPurchased DESC;




