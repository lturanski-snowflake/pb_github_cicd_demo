CREATE OR REPLACE VIEW active_customers AS
SELECT 
    customer_id,
    customer_name,
    email,
    registration_date,
    DATEDIFF('day', registration_date, CURRENT_DATE()) as days_since_registration
FROM demo_customers 
WHERE status = 'ACTIVE'
ORDER BY registration_date DESC;