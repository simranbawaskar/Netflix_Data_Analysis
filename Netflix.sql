select * from ['Netflix Data$'];

# List the top 10 movies with the Highest Rathing.
select TOP (10) TITLE, IMDB_SCORE from ['Netflix Data$'] where TYPE = 'MOVIE' order by IMDB_SCORE DESC ;


# List the top 10 movies with the Highest Average Rathing.
select top 10 TITLE, avg(IMDB_SCORE) AS Avg_Rating
from ['Netflix Data$']
Group by TITLE
order by Avg_rating DESC;

# Calculate the percentage of movie that belong to each genre in the database.
select GENRE, count(*) AS Movie_count, ((count(*)*100)/(select count(*) from ['Netflix Data$'])) AS Percentage
from ['Netflix Data$']
group by GENRE
order by Percentage desc;


# Rank the movie & TV Series on the Basis of their IMDB Score
select TITLE,IMDB_SCORE,RANK() OVER (ORDER BY IMDB_SCORE DESC) AS Rank 
from ['Netflix Data$'];


#  Find which country has highest and lowest movie make
SELECT
    Count_of_production,
    PRODUCTION_COUNTRIES
FROM (
    SELECT 
        COUNT(ID) AS Count_of_production,
        PRODUCTION_COUNTRIES,
        ROW_NUMBER() OVER (ORDER BY COUNT(ID) DESC) AS RowNumDesc,
        ROW_NUMBER() OVER (ORDER BY COUNT(ID) ASC) AS RowNumAsc
    FROM 
        ['Netflix Data$']
    GROUP BY 
        PRODUCTION_COUNTRIES
) AS RankedResults
WHERE RowNumDesc = 1 OR RowNumAsc = 1;


#  Find the Average Rating for the Movie that Belong to Multiple Genres
select GENRE,avg(IMDB_SCORE) AS Avg_score from ['Netflix Data$']
group by GENRE
order by Avg_score DESC;


# Categories the Genre on the according to age certification
select 
 CASE 
     WHEN Age_Certification <= 'PG' THEN 'Children'
     WHEN Age_Certification = 'PG-13' THEN 'Teen'
     WHEN Age_Certification IN ('R','TV-MA') THEN 'Adult'
ELSE 'Unknown'
END AS Age_Category, Genre,
count(*) AS Genre_Count
FROM ['Netflix Data$']
GROUP BY AGE_CERTIFICATION, GENRE ;

# Find the 2nd Highest Movie that were made in the year 2022
WITH RankMovie AS 
(select TITLE,IMDB_SCORE,RANK() OVER (ORDER BY IMDB_SCORE DESC) AS Movie_Rank FROM ['Netflix Data$'] WHERE RELEASE_YEAR = 2022)
select TITLE, IMDB_SCORE, Movie_Rank FROM RankMovie WHERE Movie_Rank = 2;  