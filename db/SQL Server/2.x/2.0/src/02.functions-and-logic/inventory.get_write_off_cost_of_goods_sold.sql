IF OBJECT_ID('inventory.get_write_off_cost_of_ods_sold') IS NOT NULL
DROP FUNCTION inventory.get_write_off_cost_of_ods_sold;

GO

CREATE FUNCTION inventory.get_write_off_cost_of_ods_sold(@checkout_id bigint, @item_id integer, @unit_id integer, @quantity integer)
RETURNS dbo.money_strict2
AS
BEGIN
    DECLARE @base_unit_id integer;
    DECLARE @factor decimal;

    @base_unit_id    = inventory.get_root_unit_id(@unit_id);
    @factor          = inventory.convert_unit(@unit_id, @base_unit_id);


    RETURN
    (
	    SELECT
	        SUM((cost_of_ods_sold / base_quantity) * @factor * @quantity)     
	         FROM inventory.checkout_details
	    WHERE checkout_id = @checkout_id
	    AND item_id = @item_id
	);    
END;




--SELECT * FROM inventory.get_write_off_cost_of_ods_sold(7, 3, 1, 1);


GO
