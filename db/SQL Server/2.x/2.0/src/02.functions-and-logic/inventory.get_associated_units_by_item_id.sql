IF OBJECT_ID('inventory.get_associated_units_by_item_id') IS NOT NULL
DROP FUNCTION inventory.get_associated_units_by_item_id;

GO

CREATE FUNCTION inventory.get_associated_units_by_item_id(@item_id integer)
RETURNS @result TABLE
(
    unit_id integer, 
    unit_code national character varying(24), 
    unit_name national character varying(500)
)
AS
BEGIN
    DECLARE @unit_id integer;

    SELECT inventory.items.unit_id INTO @unit_id
    FROM inventory.items
    WHERE inventory.items.item_id = @item_id
    AND inventory.items.deleted = 0;

    INSERT INTO @result
    SELECT * FROM inventory.get_associated_units(@unit_id);

    RETURN;
END;

GO

IF OBJECT_ID('inventory.get_associated_units_by_item_code') IS NOT NULL
DROP FUNCTION inventory.get_associated_units_by_item_code;

GO

CREATE FUNCTION inventory.get_associated_units_by_item_code(@item_code national character varying(24))
RETURNS @result TABLE
(
    unit_id integer, 
    unit_code national character varying(24), 
    unit_name national character varying(500)
)
AS
BEGIN
    DECLARE @unit_id integer;

    SELECT inventory.items.unit_id INTO @unit_id
    FROM inventory.items
    WHERE LOWER(item_code) = LOWER(@item_code)
    AND inventory.items.deleted = 0;

    INSERT INTO @result
    SELECT * FROM inventory.get_associated_units(@unit_id);

    RETURN;
END;


GO
