IF OBJECT_ID('inventory.count_item_in_stock') IS NOT NULL
DROP FUNCTION inventory.count_item_in_stock;

GO

CREATE FUNCTION inventory.count_item_in_stock(@item_id integer, @unit_id integer, @store_id integer)
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @debit decimal(30, 6);
    DECLARE @credit decimal(30, 6);
    DECLARE @balance decimal(30, 6);

    SET @debit = inventory.count_purchases(@item_id, @unit_id, @store_id);
    SET @credit = inventory.count_sales(@item_id, @unit_id, @store_id);

    SET  @balance= @debit - @credit;    
    return @balance;  
END;




--SELECT * FROM inventory.count_item_in_stock(1, 1, 1);

GO
