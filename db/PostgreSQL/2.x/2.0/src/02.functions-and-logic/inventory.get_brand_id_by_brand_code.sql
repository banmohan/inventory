DROP FUNCTION IF EXISTS inventory.get_brand_id_by_brand_code(text);

CREATE FUNCTION inventory.get_brand_id_by_brand_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN brand_id
        FROM inventory.brands
        WHERE brand_code=$1;
END
$$
LANGUAGE plpgsql;
