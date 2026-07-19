/*Creating a database that will store the dataset for EDA*/
CREATE DATABASE loanCredit_db;
USE loanCredit_db;

/*Load the dataset */
SELECT * FROM  loancredit_data;

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

/*Diagnostic Analysis
We are asking the question of why did it so happen that we are looking for defaulting customers*/

/*1. Why are some customers defaulting*/
SELECT COUNT(default) as numOfDefault
FROM loancredit_data;



