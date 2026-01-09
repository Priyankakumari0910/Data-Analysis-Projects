

SELECT * FROM banking_data;
/* 01 - Total Clients */
SELECT COUNT(DISTINCT `Client id`) AS Total_Clients
FROM banking_data;


 /* 02 Active Clients*/
SELECT COUNT(DISTINCT `Client id`) AS Active_Clients
FROM banking_data
WHERE `Loan Status` = 'Active';

 /* 03 New Clients (first loan in selected period) */
 
 SELECT COUNT(*) AS New_Clients
FROM (
    SELECT `Client id`,
           MIN(`Disbursement Date`) AS FirstLoanDate
    FROM banking_data
    GROUP BY `Client id`
) AS t
WHERE FirstLoanDate BETWEEN '2020-01-01' AND '2020-12-31';

/* 04  Total Loan Amount Disbursed*/
SELECT SUM(`Loan Amount`) AS Total_Loan_Disbursement
FROM banking_data;

/* 05 Total Funded Amount */
SELECT SUM(`Funded Amount`) AS Total_Funded_Amount
FROM banking_data;

/* 06 Average Loan Size */
SELECT AVG(`Loan Amount`) AS Average_Loan_Size
FROM banking_data;


/* 07 Default Rate */
SELECT 
    (SUM(CASE WHEN `Loan Status` = 'Default' THEN 1 ELSE 0 END) / COUNT(*)) * 100 
    AS Default_Rate
FROM banking_data;

/* 08 Delinquency Rate*/
SELECT 
    (SUM(CASE WHEN `Loan Status` = 'Active' THEN 1 ELSE 0 END) / COUNT(*)) * 100 
    AS Delinquency_Rate
FROM banking_data;

/* 09  Loan Distribution by Branch*/
SELECT `Branch Name_y`, SUM(`Loan Amount`) AS Total_Loan
FROM banking_data
GROUP BY `Branch Name_y`
ORDER BY Total_Loan DESC;

/* 10 Product-wise Loan Volume */
SELECT `Product Id`, SUM(`Loan Amount`) AS Product_Loan_Volume
FROM banking_data
GROUP BY `Product Id`;

/* 11 Branch Performance Summary */

select BranchID,sum(`Loan Amount`) as total_loan
from banking_data
group by BranchID
order by total_loan desc;

/* Default Rate = Loans with Is Default Loan = Y ÷ Total Loans */

SELECT 
    (SUM(CASE WHEN `Is Default Loan` = 'Y' THEN 1 ELSE 0 END) / COUNT(*)) AS DefaultRate
FROM banking_data;

/* Delinquency Rate = Loans with Is Delinquent Loan = Y ÷ Total Loans */

SELECT 
    SUM(CASE WHEN `Is Delinquent Loan` = 'Y' THEN 1 ELSE 0 END) / COUNT(*) AS DelinquencyRate
FROM banking_data;

/* On-Time Repayment % = Repayments with Repayment Behavior = On-Time ÷ Total Repayments */

SELECT 
    SUM(CASE WHEN `Repayment Behavior` = 'On-Time' THEN 1 ELSE 0 END) / COUNT(*) 
        AS OnTimeRepaymentRate
FROM banking_data;

/* Loan Distribution by Branch (Total Loan Amount per Branch) */

SELECT 
    `Branch Name_x` AS Branch,
    SUM(`Loan Amount`) AS Total_Loan_Amount
FROM banking_data
GROUP BY `Branch Name_x`
ORDER BY Total_Loan_Amount DESC;

/* Branch Performance Category Split (from Dim Branch) */

SELECT 
    `Branch Performance Category`,
    COUNT(*) AS Total_Branches
FROM banking_data
GROUP BY `Branch Performance Category`
ORDER BY Total_Branches DESC;

/* Product-wise Loan Volume = Loan Amount by Product */
SELECT 
    `Product Id`,
    SUM(`Loan Amount`) AS Total_Loan_Amount
FROM banking_data
GROUP BY `Product Id`
ORDER BY Total_Loan_Amount DESC;

/* Product Profitability = Interest Income per Product */

SELECT 
    `Product Id`,
    SUM(`Loan Amount` * `Int Rate` / 100) AS Total_Interest_Income
FROM banking_data
GROUP BY `Product Id`
ORDER BY Total_Interest_Income DESC;



