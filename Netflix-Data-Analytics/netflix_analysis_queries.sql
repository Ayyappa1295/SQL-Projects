USE netflix_analytics;

-- ==========================================
-- BASIC ANALYSIS
-- ==========================================

-- 1. Display all Netflix content
SELECT *
FROM netflix_content;


-- 2. Total number of titles
SELECT COUNT(*) AS total_titles
FROM netflix_content;


-- 3. Movies vs TV Shows
SELECT
    content_type,
    COUNT(*) AS total
FROM netflix_content
GROUP BY content_type;


-- 4. Percentage of Movies and TV Shows
SELECT
    content_type,
    COUNT(*) AS total,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM netflix_content),2
    ) AS percentage
FROM netflix_content
GROUP BY content_type;


-- ==========================================
-- YEAR ANALYSIS
-- ==========================================

-- 5. Titles by release year
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY release_year
ORDER BY release_year;


-- 6. Most productive release years
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY release_year
ORDER BY total_titles DESC;


-- 7. Latest released content
SELECT *
FROM netflix_content
ORDER BY release_year DESC;


-- ==========================================
-- COUNTRY ANALYSIS
-- ==========================================

-- 8. Content by country
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY country
ORDER BY total_titles DESC;


-- 9. Indian content
SELECT *
FROM netflix_content
WHERE country = 'India';


-- 10. South Korean content
SELECT *
FROM netflix_content
WHERE country = 'South Korea';


-- 11. Japanese content
SELECT *
FROM netflix_content
WHERE country = 'Japan';


-- ==========================================
-- RATING ANALYSIS
-- ==========================================

-- 12. Content by rating
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY rating
ORDER BY total_titles DESC;


-- 13. TV-MA content
SELECT
    title,
    content_type,
    release_year
FROM netflix_content
WHERE rating = 'TV-MA';


-- 14. PG-13 movies
SELECT
    title,
    release_year,
    duration
FROM netflix_content
WHERE rating = 'PG-13';


-- ==========================================
-- DIRECTOR ANALYSIS
-- ==========================================

-- 15. Number of titles per director
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY director
ORDER BY total_titles DESC;


-- 16. Directors with more than one title
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY director
HAVING COUNT(*) > 1;


-- ==========================================
-- MOVIE ANALYSIS
-- ==========================================

-- 17. Longest movies
SELECT
    title,
    duration,
    duration_unit
FROM netflix_content
WHERE content_type = 'Movie'
ORDER BY duration DESC;


-- 18. Movies longer than 150 minutes
SELECT
    title,
    duration
FROM netflix_content
WHERE content_type = 'Movie'
AND duration > 150
ORDER BY duration DESC;


-- 19. Average movie duration
SELECT
    ROUND(AVG(duration),2) AS average_movie_duration
FROM netflix_content
WHERE content_type = 'Movie';


-- 20. Shortest movies
SELECT
    title,
    duration
FROM netflix_content
WHERE content_type = 'Movie'
ORDER BY duration ASC;


-- ==========================================
-- TV SHOW ANALYSIS
-- ==========================================

-- 21. TV shows with more than 3 seasons
SELECT
    title,
    duration AS seasons
FROM netflix_content
WHERE content_type = 'TV Show'
AND duration > 3
ORDER BY duration DESC;


-- 22. Average number of seasons
SELECT
    ROUND(AVG(duration),2) AS average_seasons
FROM netflix_content
WHERE content_type = 'TV Show';


-- ==========================================
-- GENRE ANALYSIS
-- ==========================================

-- 23. Action content
SELECT
    title,
    content_type,
    listed_in
FROM netflix_content
WHERE listed_in LIKE '%Action%';


-- 24. Crime content
SELECT
    title,
    content_type
FROM netflix_content
WHERE listed_in LIKE '%Crime%';


-- 25. Drama content
SELECT
    title,
    content_type
FROM netflix_content
WHERE listed_in LIKE '%Drama%';


-- 26. Anime content
SELECT
    title,
    country,
    listed_in
FROM netflix_content
WHERE listed_in LIKE '%Anime%';


-- ==========================================
-- ADVANCED ANALYSIS
-- ==========================================

-- 27. Content released after 2020
SELECT
    title,
    content_type,
    release_year
FROM netflix_content
WHERE release_year > 2020
ORDER BY release_year DESC;


-- 28. Content added after 2021
SELECT
    title,
    date_added
FROM netflix_content
WHERE date_added >= '2021-01-01'
ORDER BY date_added;


-- 29. Most recent content added
SELECT
    title,
    date_added
FROM netflix_content
ORDER BY date_added DESC
LIMIT 10;


-- 30. Country and content type analysis
SELECT
    country,
    content_type,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY country, content_type
ORDER BY country, total_titles DESC;


-- 31. Rating and content type analysis
SELECT
    rating,
    content_type,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY rating, content_type
ORDER BY rating;


-- 32. Average duration by content type
SELECT
    content_type,
    ROUND(AVG(duration),2) AS average_duration
FROM netflix_content
GROUP BY content_type;


-- ==========================================
-- SUBQUERY
-- ==========================================

-- 33. Titles released in the most common release year
SELECT *
FROM netflix_content
WHERE release_year = (
    SELECT release_year
    FROM netflix_content
    GROUP BY release_year
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- 34. Movies longer than average movie duration
SELECT
    title,
    duration
FROM netflix_content
WHERE content_type = 'Movie'
AND duration > (
    SELECT AVG(duration)
    FROM netflix_content
    WHERE content_type = 'Movie'
)
ORDER BY duration DESC;


-- ==========================================
-- CTE
-- ==========================================

-- 35. Country performance using CTE
WITH country_summary AS (
    SELECT
        country,
        COUNT(*) AS total_titles
    FROM netflix_content
    GROUP BY country
)
SELECT *
FROM country_summary
ORDER BY total_titles DESC;


-- ==========================================
-- WINDOW FUNCTIONS
-- ==========================================

-- 36. Rank countries by number of titles
WITH country_summary AS (
    SELECT
        country,
        COUNT(*) AS total_titles
    FROM netflix_content
    GROUP BY country
)
SELECT
    country,
    total_titles,
    RANK() OVER (
        ORDER BY total_titles DESC
    ) AS country_rank
FROM country_summary;


-- 37. Rank directors
WITH director_summary AS (
    SELECT
        director,
        COUNT(*) AS total_titles
    FROM netflix_content
    GROUP BY director
)
SELECT
    director,
    total_titles,
    RANK() OVER (
        ORDER BY total_titles DESC
    ) AS director_rank
FROM director_summary;


-- ==========================================
-- BUSINESS INSIGHTS
-- ==========================================

-- 38. Movies vs TV Shows by year
SELECT
    release_year,
    SUM(content_type = 'Movie') AS movies,
    SUM(content_type = 'TV Show') AS tv_shows
FROM netflix_content
GROUP BY release_year
ORDER BY release_year;


-- 39. Top 5 countries
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_content
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;


-- 40. Top 10 longest movies
SELECT
    title,
    country,
    duration
FROM netflix_content
WHERE content_type = 'Movie'
ORDER BY duration DESC
LIMIT 10;
