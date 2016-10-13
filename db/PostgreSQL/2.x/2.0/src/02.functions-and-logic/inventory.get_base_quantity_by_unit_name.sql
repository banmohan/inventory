DROP FUNCTION IF EXISTS inventory.get_base_quantity_by_unit_name(text, integer);

CREATE FUNCTION inventory.get_base_quantity_by_unit_name(text, integer)
RETURNS decimal
STABLE
AS
$$
	DECLARE _unit_id integer;
	DECLARE _root_unit_id integer;
	DECLARE _factor decimal;
BEGIN
    _unit_id := inventory.get_unit_id_by_unit_name($1);
    _root_unit_id = inventory.get_root_unit_id(_unit_id);
    _factor = inventory.convert_unit(_unit_id, _root_unit_id);

    RETURN _factor * $2;
END
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS inventory.get_base_quantity_by_unit_id(integer, integer);

CREATE FUNCTION inventory.get_base_quantity_by_unit_id(integer, integer)
RETURNS decimal
STABLE
AS
$$
	DECLARE _root_unit_id integer;
	DECLARE _factor decimal;
BEGIN
    _root_unit_id = inventory.get_root_unit_id($1);
    _factor = inventory.convert_unit($1, _root_unit_id);

    RETURN _factor * $2;
END
$$
LANGUAGE plpgsql;
