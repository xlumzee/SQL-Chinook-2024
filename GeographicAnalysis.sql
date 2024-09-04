USE Chinook;

-- Which country generates the most revenue from invoices?

SELECT BillingCountry AS Country, SUM(Total) as TotalRevenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalRevenue DESC;

-- What is the average invoice amount for each country?

SELECT BillingCountry AS Country, AVG(Total) as AvgInvoiceAmt
FROM Invoice
GROUP BY BillingCountry
ORDER BY AvgInvoiceAmt DESC;

-- Which cities have the highest number of customers?

SELECT i.BillingCity AS City, COUNT(DISTINCT i.CustomerId) AS NumberOfCustomers
FROM Invoice i
GROUP BY i.BillingCity
ORDER BY NumberOfCustomers DESC;



