USE Chinook;

-- What is the total revenue generated by the store?

SELECT SUM(Total) AS TotalRevenue
FROM Invoice;

-- Which albums have generated more than $10 in sales?

SELECT alb.Title AS Album_Title, SUM(il.UnitPrice * il.Quantity) AS Total_Sales
FROM Album alb
JOIN Track t ON alb.AlbumId = t.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY alb.Title
HAVING SUM(il.UnitPrice * il.Quantity) > 10
ORDER BY Total_Sales DESC;

-- Which genres contribute the most to the total sales revenue?

SELECT g.Name, SUM(il.UnitPrice * il.Quantity) AS Total_Sales_Revenue
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.Name
ORDER BY Total_Sales_Revenue DESC;

-- What is the average revenue per invoice

SELECT AVG(Total) AS AverageRevenuePerInvoice
FROM Invoice;

-- What are the top 5 best-selling tracks by revenue in each genre?

SELECT
    Genre,
    Track,
    Revenue
FROM (
    SELECT
        g.Name AS Genre,
        t.Name AS Track,
        SUM(il.UnitPrice * il.Quantity) AS Revenue,
        ROW_NUMBER() OVER (PARTITION BY g.Name ORDER BY SUM(il.UnitPrice * il.Quantity) DESC) AS RowNum
    FROM
        InvoiceLine il
        JOIN Track t ON il.TrackId = t.TrackId
        JOIN Genre g ON t.GenreId = g.GenreId
    GROUP BY
        g.Name, t.Name
) AS GenreTrackRevenue
WHERE RowNum <= 5
ORDER BY
    Genre,
    Revenue DESC;






