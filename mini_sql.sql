create database fraud_analysis;
use fraud_analysis;

show tables;

SELECT *
FROM credit_card_transactions
LIMIT 10;

-- counts the total row-- 
SELECT COUNT(*)
FROM credit_card_transactions;

-- give the datatype of col , null values
DESCRIBE credit_card_transactions;

select count(*) as total_rows from credit_card_transactions;

SELECT * FROM credit_card_transactions LIMIT 5;


-- How many fraudulent transactions do we have? 
SELECT 
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraudulent_transactions
FROM credit_card_transactions;

-- Count total transactions
select count(*) as total_transactions from credit_card_transactions;

-- Total transaction amount
select round(sum(amt), 2) as total_transactions_amount from credit_card_transactions;

-- Find fraudulent transactions.  
select * from credit_card_transactions where is_fraud = 1;

SELECT 
    trans_num,
    trans_date_trans_time,
    cc_num,
    merchant,
    category,
    amt,
    city,
    state,
    is_fraud
FROM credit_card_transactions
WHERE is_fraud = 1;

--  Calculate fraud percentage.  
select round((sum(is_fraud)/ count(*)) * 100, 2) as fraud_percentage
from credit_card_transactions;

--  Find customers with the highest transaction value.  
-- cc_num identifies the card/customer and amt is the transaction amount. 
-- group transactions by customer and add their transaction amounts.
select cc_num, round(sum(amt), 2) as total_transaction_value
from credit_card_transactions
group by cc_num
order by total_transaction_value desc
limit 10;


--  Analyze transactions by merchant category.  
SELECT 
    category,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amt), 2) AS total_transaction_value
FROM credit_card_transactions
GROUP BY category
ORDER BY total_transaction_value DESC;

--  Find hourly transaction trends.  
SELECT
    HOUR(trans_date_trans_time) AS transaction_hour,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amt), 2) AS total_transaction_value
FROM credit_card_transactions
GROUP BY HOUR(trans_date_trans_time)
ORDER BY transaction_hour;


--  Rank customers by transaction amount.  
SELECT
    cc_num,
    ROUND(SUM(amt), 2) AS total_transaction_value,
    RANK() OVER (
        ORDER BY SUM(amt) DESC
    ) AS customer_rank
FROM credit_card_transactions
GROUP BY cc_num;


--  Calculate average transaction amount.  
SELECT 
    ROUND(AVG(amt), 2) AS average_transaction_amount
FROM credit_card_transactions;


--  Identify suspicious transaction locations. 
SELECT 
    state,
    city,
    COUNT(*) AS fraudulent_transactions
FROM credit_card_transactions
WHERE is_fraud = 1
GROUP BY state, city
ORDER BY fraudulent_transactions DESC;
