DROP FUNCTION IF EXISTS inventory.get_unit_id_by_unit_code(text);

CREATE FUNCTION inventory.get_unit_id_by_unit_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN unit_id
        FROM inventory.units
        WHERE unit_code=$1;
END
$$
LANGUAGE plpgsql;
