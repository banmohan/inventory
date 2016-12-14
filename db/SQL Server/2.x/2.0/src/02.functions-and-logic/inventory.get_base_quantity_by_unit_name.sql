IF OBJECT_ID('inventory.get_base_quantity_by_unit_name') IS NOT NULL
DROP FUNCTION inventory.get_base_quantity_by_unit_name;

GO

CREATE FUNCTION inventory.get_base_quantity_by_unit_name(@unit_name national character varying(500), @multiplier numeric(24, 23))
RETURNS decimal
AS
BEGIN
    DECLARE @unit_id integer;
    DECLARE @root_unit_id integer;
    DECLARE @factor decimal;

    @unit_id = inventory.get_unit_id_by_unit_name(@unit_name);
    @root_unit_id = inventory.get_root_unit_id(@unit_id);
    @factor = inventory.convert_unit(@unit_id, @root_unit_id);

    RETURN @factor * @multiplier;
END;

GO


IF OBJECT_ID('inventory.get_base_quantity_by_unit_id') IS NOT NULL
DROP FUNCTION inventory.get_base_quantity_by_unit_id;

GO

CREATE FUNCTION inventory.get_base_quantity_by_unit_id(@unit_id integer, @multiplier numeric(24, 23))
RETURNS decimal
AS
BEGIN
    DECLARE @root_unit_id integer;
    DECLARE @factor decimal;

    @root_unit_id = inventory.get_root_unit_id(@unit_id);
    @factor = inventory.convert_unit(@root_unit_id, @root_unit_id);

    RETURN @factor * @multiplier;
END;




GO
