INSERT INTO demo_customers (customer_name, email, phone, registration_date, status) VALUES
    ('John Smith', 'john.smith@email.com', '555-0101', '2024-01-15', 'ACTIVE'),
    ('Jane Doe', 'jane.doe@email.com', '555-0102', '2024-01-16', 'ACTIVE'),
    ('Bob Johnson', 'bob.johnson@email.com', '555-0103', '2024-01-17', 'ACTIVE'),
    ('Alice Brown', 'alice.brown@email.com', '555-0104', '2024-01-18', 'INACTIVE'),
    ('Charlie Wilson', 'charlie.wilson@email.com', '555-0105', '2024-01-19', 'ACTIVE');

-- Verify data was inserted
SELECT COUNT(*) as total_customers FROM demo_customers;
