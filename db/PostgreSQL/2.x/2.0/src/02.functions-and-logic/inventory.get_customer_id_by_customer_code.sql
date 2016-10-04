DROP FUNCTION IF EXISTS inventory.get_customer_id_by_customer_code(text);

CREATE FUNCTION inventory.get_customer_id_by_customer_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN customer_id
        FROM inventory.customers
        WHERE customer_code=$1;
END
$$
LANGUAGE plpgsql;
