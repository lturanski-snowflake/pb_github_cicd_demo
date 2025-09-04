CREATE OR REPLACE TABLE demo_customers (
    customer_id INTEGER AUTOINCREMENT START 1 INCREMENT 1,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),  -- NEW: Added phone column
    registration_date DATE DEFAULT CURRENT_DATE(),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    PRIMARY KEY (customer_id)
);

-- Add comment to table
COMMENT ON TABLE demo_customers IS 'Customer table for integration demo - contains basic customer information with phone support';
