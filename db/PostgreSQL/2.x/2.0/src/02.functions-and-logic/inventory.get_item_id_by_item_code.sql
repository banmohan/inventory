DROP FUNCTION IF EXISTS inventory.get_item_id_by_item_code(_item_code text);

CREATE FUNCTION inventory.get_item_id_by_item_code(_item_code text)
RETURNS integer
AS
$$
BEGIN
    RETURN item_id
    FROM inventory.items
    WHERE item_code = _item_code;
END
$$
LANGUAGE plpgsql;