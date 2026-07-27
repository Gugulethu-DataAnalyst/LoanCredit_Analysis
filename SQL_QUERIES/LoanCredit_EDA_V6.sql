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

/*LOAN amount range*/
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
        ELSE '91K +'
	END AS income_range,
    COUNT(*) AS Income_count
FROM loancredit_data
GROUP BY income_range
ORDER BY income_range DESC;

/*Objective 2: Understanding the loan approval of our clients*/
/*1. What is the percentage of the loan applications being approved?*/
SELECT 
	ROUND(AVG(loanApproved) * 100, 0) AS approval_percentage
FROM loancredit_data;

/*How does the approval rate vary by employment type?
now we must include the employment type column*/
SELECT
	employmenttype,
    Round(AVG(loanApProved) * 100, 0) AS Approved_rate_percentage
FROM loancredit_data
GROUP BY employmenttype
ORDER BY Approved_rate_percentage DESC;

/*How does the approval rate vary by city?
now we must include the city column*/
SELECT 
	city,
    ROUND(AVG(loanApproved) * 100, 0) AS approved_rate_byCity_Percentage
FROM loancredit_data
GROUP BY city
ORDER BY approved_rate_byCity_Percentage DESC;

/*Lets investigate if the aplicants with higher credit scores recieve more approved loans?*/
SELECT 
	CASE 
		WHEN creditscore < 600 THEN 'Poor'
        WHEN creditscore BETWEEN  600  AND 699 THEN 'Poor'
        WHEN creditscore BETWEEN  700  AND 749 THEN 'Good'
        WHEN creditscore  >= 750 THEN 'Excellent'
	END AS credit_score_band,
	ROUND(AVG(loanApproved) * 100, 0) AS approval_rate_percentage
    from loancredit_data
GROUP BY
CASE
WHEN creditscore < 600 THEN 'Poor'
WHEN creditscore BETWEEN  600  AND 699 THEN 'Poor'
WHEN creditscore BETWEEN  700  AND 749 THEN 'Good'
WHEN creditscore  >= 750 THEN 'Excellent'
END 
Order by approval_rate_percentage DESC;


/*How does the income feature influence the apporval of loans?
Lets look at the average income  grouped by the loan approved*/
  
SELECT 
	loanapproved,
    ROUND(AVG(income),0) AS AverageIncome
FROM loancredit_data
GROUP BY loanapproved;

/*To understand the approval of loans being influenced by income, lets consider the 
creation of distribution*/
SELECT 
	CASE 
		WHEN income < 30000 THEN 'Low Income'
        WHEN income BETWEEN 30000 AND  60000 THEN 'Middle Income'
        ELSE 'High Income'
	END AS IncomeBand,
    
    COUNT(*) AS Applicants
FROM loancredit_data
group by IncomeBand
ORDER BY IncomeBand;

/*Lets now conisider he loan approval feature*/
SELECT 
	CASE 
		WHEN income < 30000 THEN 'Low Income'
        WHEN income BETWEEN 30000 AND  60000 THEN 'Middle Income'
        ELSE 'High Income'
	END AS IncomeBand,
    loanapproved,
    COUNT(*) AS Applicants
FROM loancredit_data
group by IncomeBand,loanapproved
ORDER BY IncomeBand;

/*Calculating the approval rate*/
SELECT 
	CASE 
		WHEN income < 30000 THEN 'Low income'
        WHEN income between 30000 AND 60000 THEN 'Middle income'
        ELSE 'High Income'
	END AS IncomeBand,
    COUNT(*) AS TotalApplicant,
    
    SUM(loanapproved) AS ApprovedApplicants
FROM loancredit_data
GROUP BY incomeband;

/*Calculating the approval percentage*/
SELECT 
	CASE 
		WHEN income < 30000 THEN 'Low income'
        WHEN income between 30000 AND 60000 THEN 'Middle income'
        ELSE 'High Income'
	END AS IncomeBand,
    COUNT(*) AS TotalApplicant,    
    SUM(loanapproved) AS ApprovedApplicants,
    
    #Percentage calculation
    ROUND(SUM(loanApproved) *100 / COUNT(*), 2) AS ApprovalRate
FROM loancredit_data
GROUP BY incomeband;
    
/*Approval Rate for the years of experience */
SELECT 
	CASE 
		WHEN yearsexperience < 1 THEN '0-1 Years'
        WHEN yearsexperience Between 2 AND 5 THEN '2-5 Years'
		WHEN yearsexperience Between 2 AND 5 THEN '6-10 Years'
        ELSE '18+ Years'
	END AS ExperienceBand,
    
    COUNT(*) AS TotalApplicants,
    SUM(loanApproved) AS ApprovedApplicants,
    
    ROUND(SUM(LoanApproved) * 100 / COUNT(*), 2) AS ApprovalRate 
    
FROM loancredit_data
GROUP BY ExperienceBand;

/*Avergae loan amount approved*/
SELECT 
	loanApproved,
    ROUND(AVG(loanAmount), 2) AS AverageLoanAmount
FROM LOANCREDIT_DATA
GROUP BY loanApproved;
    
SELECT
	EmploymentType,
	ROUND(AVG(loanamount), 2 ) AS AverageLoanApproved
FROM loancredit_data
WHERE loanApproved = 1
GROUP BY EMPLOYMENTTYPE
ORDER BY AverageLoanApproved DESC;

/*Objective 3: 
Identifying high risk applicant profiles*/
SELECT 
	CASE 
		WHEN `DeptToIncome(%)` < 36 THEN 'Low'
        WHEN `DeptToIncome(%)` BETWEEN 36 and 43 THEN 'Moderate'
        ELSE 'High'
	END AS RatioLevels,
    COUNT(*) AS Applicants
FROM loancredit_data
GROUP BY  RatioLevels
ORDER BY Applicants DESC;

/*Which applicants have a high ratio level by employemet tyoe*/
SELECT 
    case 
		WHEN `DeptToIncome(%)` < 36 THEN 'Low'
        WHEN `DeptToIncome(%)` BETWEEN 36 and 43 THEN 'Moderate'
        ELSE 'High'
	END AS RatioLevels,
    employmenttype,
    COUNT(*) AS applicants
FROM loancredit_data
GROUP BY  RatioLevels, employmenttype
HAVING Ratiolevels = 'High'
ORDER BY Applicants DESC;

SELECT 
    case 
		WHEN `DeptToIncome(%)` < 36 THEN 'Low'
        WHEN `DeptToIncome(%)` BETWEEN 36 and 43 THEN 'Moderate'
        ELSE 'High'
	END AS RatioLevels,
    city,
    COUNT(*) AS applicants
FROM loancredit_data
GROUP BY  RatioLevels, city
HAVING Ratiolevels = 'High'
ORDER BY Applicants DESC;

SELECT 
    case 
		WHEN `DeptToIncome(%)` < 36 THEN 'Low'
        WHEN `DeptToIncome(%)` BETWEEN 36 and 43 THEN 'Moderate'
        ELSE 'High'
	END AS RatioLevels,
    gender,
    COUNT(*) AS applicants
FROM loancredit_data
GROUP BY  RatioLevels, gender
HAVING Ratiolevels = 'High'
ORDER BY Applicants DESC;

/*which group requests largest loans relative to their imcome, considering their employment type*/
SELECT
	employmenttype,
    ROUND(AVG(`DeptToIncome(%)`), 2) AS AVGDeptToIncome
fROM loancredit_data
GROUP BY employmenttype
ORDER BY AVGDeptToIncome DESC;