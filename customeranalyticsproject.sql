-- 1. CREATE TABLE
CREATE TABLE final_customer_analytics (
    transaction_id TEXT,
    customer_id TEXT,
    transaction_date DATE,
    transaction_amount NUMERIC,
    payment_mode TEXT,
    channel TEXT,
    gender TEXT,
    age INT,
    city TEXT,
    customer_segment TEXT,
    signup_date DATE,
    value_segment TEXT,
    year_month TEXT
);

-- 2. VIEW DATA
SELECT * 
FROM final_customer_analytics;

-- 3. TOTAL ROWS
SELECT COUNT(*) AS total_rows
FROM final_customer_analytics;

-- 4. DATE RANGE
SELECT 
    MIN(transaction_date) AS first_date,
    MAX(transaction_date) AS last_date
FROM final_customer_analytics;

-- 5. TOTAL CUSTOMERS
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers
FROM final_customer_analytics;

-- 6. TOTAL TRANSACTIONS
SELECT 
    COUNT(transaction_id) AS total_transactions
FROM final_customer_analytics;

-- 7. TOTAL REVENUE
SELECT 
    SUM(transaction_amount) AS total_revenue
FROM final_customer_analytics;

-- 8. AVERAGE ORDER VALUE (AOV)
SELECT 
    SUM(transaction_amount) / COUNT(transaction_id) AS avg_order_value
FROM final_customer_analytics;

-- 9. REVENUE PER CUSTOMER
SELECT 
    SUM(transaction_amount) / COUNT(DISTINCT customer_id) AS revenue_per_customer
FROM final_customer_analytics;

-- 10. REVENUE BY VALUE SEGMENT
SELECT 
    value_segment,
    SUM(transaction_amount) AS revenue
FROM final_customer_analytics
GROUP BY value_segment
ORDER BY revenue DESC;

-- 11. TRANSACTIONS BY CITY
SELECT 
    city,
    COUNT(transaction_id) AS total_transactions
FROM final_customer_analytics
GROUP BY city
ORDER BY total_transactions DESC;

-- 12. REVENUE BY CITY (FOR PIE CHART)
SELECT 
    city,
    SUM(transaction_amount) AS total_revenue
FROM final_customer_analytics
GROUP BY city
ORDER BY total_revenue DESC;

-- 13. PAYMENT METHOD DISTRIBUTION
SELECT 
    payment_mode,
    COUNT(*) AS total_transactions,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM final_customer_analytics
GROUP BY payment_mode
ORDER BY total_transactions DESC;

-- 14. MONTHLY REVENUE TREND
SELECT 
    year_month,
    SUM(transaction_amount) AS monthly_revenue
FROM final_customer_analytics
GROUP BY year_month
ORDER BY year_month;

-- 15. CUSTOMER SEGMENT CONTRIBUTION
SELECT 
    value_segment,
    SUM(transaction_amount) AS revenue
FROM final_customer_analytics
GROUP BY value_segment
ORDER BY revenue DESC;

-- 16. CHANNEL ANALYSIS (Mobile App vs Website)
SELECT 
    channel,
    SUM(transaction_amount) AS revenue,
    COUNT(*) AS transactions
FROM final_customer_analytics
GROUP BY channel;

-- 17. GENDER ANALYSIS
SELECT 
    gender,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(transaction_amount) AS revenue
FROM final_customer_analytics
GROUP BY gender;

-- 18. AGE GROUP ANALYSIS
SELECT 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 40 THEN '25-40'
        WHEN age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_transactions,
    SUM(transaction_amount) AS revenue
FROM final_customer_analytics
GROUP BY age_group
ORDER BY revenue DESC;

-- 19. TOP 5 CUSTOMERS (HIGH VALUE USERS)
SELECT 
    customer_id,
    SUM(transaction_amount) AS total_spent
FROM final_customer_analytics
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 20. CUSTOMER RETENTION (Repeat Customers)
SELECT 
    customer_id,
    COUNT(transaction_id) AS purchase_count
FROM final_customer_analytics
GROUP BY customer_id
HAVING COUNT(transaction_id) > 1
ORDER BY purchase_count DESC;
