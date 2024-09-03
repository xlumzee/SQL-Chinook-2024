USE Chinook;
-- How many tracks are there in each genre?

SELECT g.Name, COUNT(g.GenreId) AS Count
FROM Genre g
JOIN Track t ON g.GenreID = t.GenreId
GROUP BY g.GenreId, g.Name
ORDER BY Count DESC;

-- Which album has the most tracks, and how many tracks does it contain?

SELECT a.Title, COUNT(t.TrackId) AS Count
FROM Album a
JOIN Track t ON a.AlbumId = t.AlbumId
GROUP BY a.Title
ORDER BY Count DESC
; -- Gives all the albums and the top one is the album with most tracks 

-- OR --

SELECT a.Title AS AlbumTitle, COUNT(t.TrackId) AS NumberOfTracks
FROM Album a
JOIN Track t ON a.AlbumId = t.AlbumId
GROUP BY a.AlbumId, a.Title
ORDER BY NumberOfTracks DESC
LIMIT 1; -- Shows only 1


-- Which genres have the most tracks, and how many tracks do they contain?

SELECT  g.Name, COUNT(t.TrackId) AS Count
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY Count DESC
;

-- How many albums are there for each artist?

SELECT  ar.Name, COUNT(al.ArtistID) AS Count
FROM Album al
JOIN Artist ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY Count DESC
;

-- List the top 5 composers with the most tracks, excluding those where the composer name is missing.

SELECT t.Composer, COUNT(t.TrackId) AS NumberOfTracks
FROM Track t
WHERE t.Composer IS NOT NULL AND t.Composer != ''
GROUP BY t.Composer
ORDER BY NumberOfTracks DESC
LIMIT 5;
