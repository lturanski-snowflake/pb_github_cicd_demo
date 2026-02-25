CREATE OR REPLACE PROCEDURE merge_demo_customers_from_stream()
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
AS
$$
  // This stored procedure merges records from a stream into a target table.
  // It handles inserts and updates based on the DML metadata from the stream.

  var sql_command = "";

  // The MERGE statement is the core of the incremental logic.
  // It joins the target table with the stream to apply changes.
  // The 'customer_id' is used as the join key to find matching records.
  sql_command = `
    MERGE INTO demo_customers AS target
    USING (
      SELECT
        customer_id,
        customer_name,
        email,
        phone,
        status,
        METADATA$ACTION AS action,
        METADATA$ISUPDATE AS is_update
      FROM demo_stream
    ) AS source
    ON target.customer_id = source.customer_id

    // When there's a new record in the stream (INSERT)
    WHEN NOT MATCHED AND source.action = 'INSERT' THEN
        INSERT (customer_name, email, phone, status)
        VALUES (source.customer_name, source.email, source.phone, source.status)
    
    // When there's an update to an existing record
    WHEN MATCHED AND source.action = 'INSERT' AND source.is_update = true THEN
        UPDATE SET
            target.customer_name = source.customer_name,
            target.email = source.email,
            target.phone = source.phone,
            target.status = source.status;
  `;

  try {
    snowflake.execute({ sqlText: "BEGIN TRANSACTION;" });
    var result = snowflake.execute({ sqlText: sql_command });
    snowflake.execute({ sqlText: "COMMIT;" });
    return "Successfully merged stream data into demo_customers.";
  } catch (err) {
    snowflake.execute({ sqlText: "ROLLBACK;" });
    return "Failed to merge stream data. Transaction rolled back. Error: " + err;
  }
$$;
