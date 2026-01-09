-- 1.

SELECT SUM(Amount) AS Total_Credit_Amount
FROM `debit and credit banking_data`
WHERE `Transaction Type` = 'Credit';


-- 2.

SELECT SUM(Amount) AS Total_Debit_Amount
FROM `debit and credit banking_data`
WHERE `Transaction Type` = 'Debit';


-- 3.

SELECT 
    SUM(CASE WHEN `Transaction Type`='Credit' THEN Amount END) /
    SUM(CASE WHEN `Transaction Type`='Debit' THEN Amount END) 
        AS Credit_to_Debit_Ratio
FROM `debit and credit banking_data`;


--  4.

SELECT 
    SUM(CASE WHEN `Transaction Type`='Credit' THEN Amount 
             WHEN `Transaction Type`='Debit' THEN -Amount END)
        AS Net_Transaction_Amount
FROM `debit and credit banking_data`;


-- 5.

SELECT 
    `Account Number`,
    COUNT(*) * 1.0 / MAX(Balance) AS Account_Activity_Ratio
FROM `debit and credit banking_data`
GROUP BY `Account Number`;


-- 6.

SELECT 
    DATE(`Transaction Date`) AS Day,
    COUNT(*) AS Transactions_Per_Day
FROM `debit and credit banking_data`
GROUP BY DATE(`Transaction Date`);

SELECT 
    YEARWEEK(`Transaction Date`) AS Week,
    COUNT(*) AS Transactions_Per_Week
FROM `debit and credit banking_data`
GROUP BY YEARWEEK(`Transaction Date`);


SELECT 
    DATE_FORMAT(`Transaction Date`,'%Y-%m') AS Month,
    COUNT(*) AS Transactions_Per_Month
FROM `debit and credit banking_data`
GROUP BY DATE_FORMAT(`Transaction Date`,'%Y-%m');


-- 7.

SELECT 
    Branch,
    SUM(Amount) AS Total_Transaction_Amount
FROM `debit and credit banking_data`
GROUP BY Branch;


-- 8.

SELECT 
    `Bank Name`,
    SUM(Amount) AS Transaction_Volume
FROM `debit and credit banking_data`
GROUP BY `Bank Name`;


-- 9.

SELECT 
    `Transaction Method`,
    COUNT(*) AS Total_Transactions
FROM `debit and credit banking_data`
GROUP BY `Transaction Method`;


-- 10.

SELECT 
    Branch,
    DATE_FORMAT(`Transaction Date`,'%Y-%m') AS Month,
    SUM(Amount) AS Total_Amount,
    LAG(SUM(Amount)) OVER (PARTITION BY Branch ORDER BY DATE_FORMAT(`Transaction Date`,'%Y-%m'))
        AS Previous_Month,
    (SUM(Amount) - LAG(SUM(Amount)) OVER (PARTITION BY Branch ORDER BY DATE_FORMAT(`Transaction Date`,'%Y-%m')))
        / LAG(SUM(Amount)) OVER (PARTITION BY Branch ORDER BY DATE_FORMAT(`Transaction Date`,'%Y-%m'))
        AS Growth_Percentage
FROM `debit and credit banking_data`
GROUP BY Branch, DATE_FORMAT(`Transaction Date`,'%Y-%m');


-- 11.

SELECT *
FROM `debit and credit banking_data`
WHERE Amount > 5000;


-- 12.

SELECT 
    COUNT(*) AS Suspicious_Transactions
FROM `debit and credit banking_data`
WHERE Amount > 5000;
