/*Creating a database that will store the dataset for EDA*/
CREATE DATABASE loanCredit_db;
USE loanCredit_db;

/*Load the dataset */
SELECT * FROM  loancredit_data;

/*Updating the dept to income column to have values be rounded up to 2 decimal places*/
/*REMOVE THE SAFETY FEATURE*/
SET SQL_SAFE_UPDATES = 0;

UPDATE loancredit_data
SET `DeptToIncome(%)` = ROUND(`DeptToIncome(%)`, 0);

/*LOAD DATA AGAIN*/
SELECT * FROM  loancredit_data;

/*REMOVE THE SAFETY FEATURE*/
SET SQL_SAFE_UPDATES = 1;

/*Descriptive analysis
For this stage of the analysis we look at questions that answer questions that 
describe our dataset.*/
/*1. How many loan applicants are there?*/
SELECT COUNT(*) AS NumberOfApplicants
FROM loancredit_data;

/* Query to look at the customer's characteristics:
1. What is the average applicants income?
2. What is the average credit score for our dataset
3. What is the average age for our dataset
4. What is the Average loan amount that is applied for by applicants*/
SELECT 
ROUND(AVG(age), 0) as Average_Age,
ROUND(AVG(Income), 2) as Average_Income,
ROUND(AVG(creditscore), 0) as Average_CreditScore,
ROUND(AVG(loanamount), 2) as Average_LoanAmount
FROM loancredit_data;

/* Which employment type has the most loan applications*/
SELECT employmentType,
COUNT(employmentType) AS Number_of_Applicants
FROM loancredit_data
GROUP BY employmentType;

/*Which city has the most application?*/
SELECT city,
COUNT(city) AS Total_applicationByCity
FROM loancredit_data
GROUP BY city
ORDER BY Total_applicationByCity DESC;

/*Finding the distribution of the customers age by range*/

/**/

/*Diagnostic Analysis
We are asking the question of why did it so happen that we are looking for defaulting customers*/
SELECT age_group,
COUNT(*) AS Count
FROM loancredit_data
group by age_group
order by age_group desc;

/*I can also range it by age values to help us understand what each category of age means*/
SELECT
CASE
WHEN age between 0 AND 35 THEN '0 - 35'
WHEN age between 36 AND 45 THEN '36 - 45'
WHEN age between 46 AND 59 THEN '46 - 59'
ELSE '60+'
END AS age_range,
count(*) as count
FROM loancredit_data
GROUP BY age_range
ORDER BY age_range DESC;

/*RANGES income*/
SELECT
	CASE
		WHEN income between 0 and 10000 then '0 - 10K'
		When income between 10001 and 20000 then '10K - 20K'
		WHEN income between 20001 and 30000 then '20K - 30K'
		When income between 30001 and 40000 then '30K - 40K'
		When income between 40001 and 50000 then '40K - 50K'
		WHEN income between 50001 and 60000 then '50K - 60K'
		When income between 60001 and 70000 then '60K - 70K'
		When income between 70001 and 80000 then '70K - 80K'
		When income between 80001 and 90000 then '80K - 90K'
		ELSE '91K'
	END AS income_range,
	COUNT(*) AS Income_count
FROM loancredit_data
GROUP BY income_range
ORDER BY income_count desc;

/*RANGES credit score*/
SELECT
	CASE
		WHEN creditscore between 0 and 579 then 'Poor'
		When creditscore  between 580 and 669 then 'fair'
		WHEN creditscore  between 670 and 739 then 'Good'
		When creditscore  between 740 and 799 then 'Very Good'
        When creditscore  between 800 and 900 then 'Exellent'
		ELSE 'No record'
	END AS score_range,
	COUNT(*) AS credit_count
FROM loancredit_data
GROUP BY score_range
ORDER BY score_range desc;