# 🎬 Netflix Data Analytics

A SQL-based **Netflix Data Analytics Database Project** built using **MySQL**.

This project analyzes Netflix movies and TV shows to identify trends and insights related to **content types, countries, ratings, genres, directors, release years, movie duration, and TV show seasons**.

The project demonstrates practical SQL and data analytics skills using a structured Netflix dataset.

---

## 📌 Project Overview

The **Netflix Data Analytics** project is designed to simulate a real-world data analytics workflow.

The database stores Netflix content information and uses SQL queries to analyze the data and generate meaningful business insights.

### Key Areas Analyzed

* 🎬 Movies vs TV Shows
* 🌍 Country-wise content distribution
* ⭐ Rating-wise content analysis
* 📅 Release year trends
* 🎭 Genre analysis
* 🎥 Director analysis
* ⏱️ Movie duration analysis
* 📺 TV show season analysis
* 🇮🇳 Indian content
* 🇰🇷 South Korean content
* 🇯🇵 Japanese content
* 📊 Business insights
* 🏆 Top countries and directors

---

## 🛠️ Technologies Used

| Technology      | Purpose                               |
| --------------- | ------------------------------------- |
| MySQL           | Database Management                   |
| SQL             | Data Analysis                         |
| MySQL Workbench | Query Execution & Database Management |
| GitHub          | Project Repository                    |

---

## 🗂️ Project Structure

```text
netflix-data-analytics/
│
├── netflix_database.sql
├── netflix_analysis_queries.sql
├── README.md
│
└── screenshots/
    ├── database.png
    ├── tables.png
    ├── queries.png
    └── reports.png
```

---

## 🗄️ Database Structure

### Database Name

```text
netflix_analytics
```

### Main Table

```text
netflix_content
```

### Table Columns

| Column        | Data Type | Description                |
| ------------- | --------- | -------------------------- |
| show_id       | INT       | Unique content ID          |
| title         | VARCHAR   | Movie or TV show title     |
| content_type  | VARCHAR   | Movie or TV Show           |
| director      | VARCHAR   | Director name              |
| country       | VARCHAR   | Country of production      |
| date_added    | DATE      | Date added to Netflix      |
| release_year  | INT       | Original release year      |
| rating        | VARCHAR   | Content rating             |
| duration      | INT       | Movie minutes / TV seasons |
| duration_unit | VARCHAR   | Minutes or Seasons         |
| listed_in     | VARCHAR   | Genres/categories          |
| description   | TEXT      | Content description        |

---

# 📊 SQL Analysis

This project contains SQL queries covering multiple levels of analysis.

## 🔹 Basic SQL

* SELECT
* WHERE
* ORDER BY
* LIMIT
* DISTINCT
* COUNT
* AVG

## 🔹 Intermediate SQL

* GROUP BY
* HAVING
* Aggregate Functions
* LIKE
* Multiple Conditions
* CASE Expressions
* Subqueries

## 🔹 Advanced SQL

* CTEs
* Window Functions
* RANK()
* Multi-column GROUP BY
* Analytical Queries
* Business Insight Queries

---

# 🔍 Key Analysis Questions

The project answers questions such as:

### Content Analysis

1. How many total titles are available?
2. How many Movies and TV Shows are present?
3. What percentage of Netflix content is Movies vs TV Shows?
4. Which years have the highest number of titles?
5. What is the latest released content?

### 🌍 Country Analysis

6. Which countries have the most Netflix content?
7. How many Indian titles are available?
8. How many South Korean titles are available?
9. How many Japanese titles are available?
10. What is the distribution of Movies and TV Shows by country?

### ⭐ Rating Analysis

11. Which ratings occur most frequently?
12. How many TV-MA titles are available?
13. How many PG-13 movies are available?
14. What is the relationship between ratings and content types?

### 🎥 Director Analysis

15. Which directors have multiple titles?
16. Which directors have the highest number of titles?
17. How can directors be ranked based on their content count?

### ⏱️ Duration Analysis

18. What is the average movie duration?
19. Which movies are longer than 150 minutes?
20. Which are the longest movies?
21. What is the average number of TV show seasons?

### 🎭 Genre Analysis

22. How many Action titles are available?
23. How many Crime titles are available?
24. How many Drama titles are available?
25. How many Anime titles are available?

---

# 📈 Advanced SQL Analytics

The project also demonstrates advanced SQL techniques.

### Subqueries

Used to compare individual records against calculated values such as:

* Average movie duration
* Most common release year

### CTE

Common Table Expressions are used to create temporary analytical result sets.

Example:

```sql
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
```

### Window Functions

Ranking is performed using:

```sql
RANK() OVER (
    ORDER BY total_titles DESC
)
```

This allows countries and directors to be ranked based on their total content.

---

# 💡 Business Insights

The analysis can be used to identify:

* Content distribution across countries
* Growth of Netflix content over different years
* Popular content ratings
* Movie vs TV Show distribution
* Countries producing significant amounts of content
* Directors with multiple Netflix titles
* Long-duration movies
* International content trends
* Genre/category patterns

These insights demonstrate how SQL can be used for **real-world business and data analysis**.

---

# 📸 Screenshots

The project includes screenshots demonstrating the database and analysis results.

### Database

```text
screenshots/database.png
```

### Tables

```text
screenshots/tables.png
```

### SQL Queries

```text
screenshots/queries.png
```

### Reports

```text
screenshots/reports.png
```

---

# 🚀 How to Run the Project

## Step 1 — Install MySQL

Install **MySQL Server** and **MySQL Workbench**.

## Step 2 — Create the Database

Open MySQL Workbench and run:

```sql
CREATE DATABASE netflix_analytics;

USE netflix_analytics;
```

## Step 3 — Create the Table

Run the complete:

```text
netflix_database.sql
```

file.

## Step 4 — Insert the Data

Execute the INSERT statements included in the database SQL file.

## Step 5 — Run Analytics

Open:

```text
netflix_analysis_queries.sql
```

Run the queries individually or execute the complete file.

## Step 6 — Analyze Results

Review the SQL output and identify:

* Content trends
* Country trends
* Rating distribution
* Genre patterns
* Director analysis
* Movie duration
* TV show seasons

---

# 📚 SQL Concepts Demonstrated

```text
✔ Database Creation
✔ Table Creation
✔ Data Insertion
✔ SELECT
✔ WHERE
✔ DISTINCT
✔ ORDER BY
✔ LIMIT
✔ LIKE
✔ COUNT()
✔ AVG()
✔ SUM()
✔ GROUP BY
✔ HAVING
✔ CASE
✔ Subqueries
✔ CTE
✔ Window Functions
✔ RANK()
✔ Data Analysis
✔ Business Insights
```

---

# 🎯 Project Goals

The main goals of this project are:

1. Build a structured SQL database.
2. Store Netflix content information.
3. Perform exploratory data analysis using SQL.
4. Practice beginner to advanced SQL concepts.
5. Generate useful business insights.
6. Demonstrate practical database skills.
7. Build a portfolio-ready GitHub project.

---

# 💼 Skills Demonstrated

This project demonstrates practical knowledge of:

* **SQL**
* **MySQL**
* **Database Management**
* **Data Cleaning Concepts**
* **Data Analysis**
* **Exploratory Data Analysis**
* **Business Intelligence Concepts**
* **Analytical SQL**
* **Problem Solving**
* **Data Visualization Preparation**

---

# 👨‍💻 Author

**Ayyappa**

GitHub:

```text
https://github.com/Ayyappa1295
```

---

# ⭐ Project Highlights

```text
🎬 Netflix Content Database
📊 SQL Data Analytics
🌍 Country Analysis
⭐ Rating Analysis
🎭 Genre Analysis
🎥 Director Analysis
📅 Release Trend Analysis
⏱️ Duration Analysis
📈 Advanced SQL
🏆 Business Insights
```

---

## 📌 Future Improvements

The project can be extended with:

* Real-world Netflix dataset
* Data cleaning using Python
* Exploratory Data Analysis using Pandas
* Data visualization using Power BI
* Interactive Netflix dashboard
* MySQL + Python integration
* Automated data pipeline
* Advanced KPI dashboard
* Genre-wise visualizations
* Country-wise maps
* Monthly content addition trends

---

## ⭐ Conclusion

The **Netflix Data Analytics** project demonstrates how SQL and database technologies can be used to transform structured content data into meaningful analytical insights.

It is designed as a **portfolio project for aspiring SQL Developers, Data Analysts, Business Analysts, and Database Developers**.
