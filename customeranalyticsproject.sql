






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

select * from final_customer_analytics;

SELECT COUNT(*) AS total_rows
FROM final_customer_analytics;

SELECT 
    MIN(transaction_date) AS first_date,
    MAX(transaction_date) AS last_date
FROM final_customer_analytics;

-- Calculate total revenue generated across all transactions
SELECT 
    SUM(transaction_amount) AS total_revenue
FROM final_customer_analytics;

-- Calculate revenue contribution by customer value segment
-- Helps identify High, Mid, and Low value customers

select value_segment,SUM(transaction_amount) as revenue
from final_customer_analytics
Group By value_segment
Order by revenue desc;

-- Analyze revenue distribution across different cities
-- Useful for geographic performance analysis

select city,SUM(transaction_amount)as revenue
from 



