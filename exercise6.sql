-- Create table for disaster_data
CREATE TABLE disaster_data (
	Year INT,
	Disaster_Group VARCHAR(100), 
	Disaster_Subgroup VARCHAR(100),
	Disaster_Type VARCHAR(100),
	Disaster_Subtype VARCHAR(100),
	Region VARCHAR(100),
	Continent VARCHAR(100),
	Origin VARCHAR(100),
	Associate_Disaster VARCHAR(100),
	OFDA_Response VARCHAR(100),
	Disaster_Magnitude_Value INT,
	Start_Year INT,
	End_Year INT,
	Total_Deaths INT,
	Num_Injured INT,
	Num_Affected INT,
	Num_Homeless INT,
	Total_Affected INT,
	Total_Damages_USD INT,
	Total_Damages_Adjusted_USD INT,
	Country VARCHAR(100),
	Location VARCHAR(100)
);

-- Check if data properly imported into database
SELECT *
FROM disaster_data

-- Q1: What are the top 5 disasters?

SELECT disaster_type, COUNT(*) AS num_occurences
FROM disaster_data
GROUP BY disaster_type
ORDER BY num_occurences DESC
LIMIT 5;

-- Q2: What are the number of responses to these disasters?
	
SELECT disaster_type, COUNT(*) AS num_occurences, COUNT(*) FILTER(WHERE ofda_response = 'Yes') AS num_responses
FROM disaster_data
GROUP BY disaster_type
ORDER BY num_occurences DESC
LIMIT 5;

-- Q3: Which country is worst hit by these disasters?

SELECT country, SUM(total_damages_usd) AS total_loss_usd
FROM disaster_data
GROUP BY country
ORDER BY total_loss_usd DESC
LIMIT 1;

--Q4: Which country and location are hardest hit by floods?

SELECT country, COUNT(*) AS num_occurences
FROM disaster_data
WHERE disaster_type = 'Flood'
GROUP BY country
ORDER BY num_occurences DESC
LIMIT 1;

-- Q5 What is the trend of transport accident occurences by year?

SELECT year, COUNT(*) AS num_accidents
FROM disaster_data
WHERE disaster_type = 'Transport accident'
GROUP BY year
ORDER BY year;

/* 
INSIGHTS
- Floods is the most commonly occuring disaster and the most affected country is Indonesia.
- The response rate is less than 1% to the top 5 disasters.
- Year 2000 and 2014 had the highest number of transport accidents which has been on a downward trend.

RECOMMENDATIONS
- It is quite alarming that the response rate to disasters is less than 1%. Funding should be directed towards disaster 
preparedness and response.
*/



