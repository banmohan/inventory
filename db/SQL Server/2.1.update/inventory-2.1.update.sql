-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.1.update/src/01.types-domains-tables-and-constraints/tables-and-constraints.sql --<--<--
IF COL_LENGTH('inventory.inventory_setup', 'validate_returns') IS NULL
BEGIN
    ALTER TABLE inventory.inventory_setup
    ADD validate_returns bit NOT NULL DEFAULT(1)
END



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.1.update/src/02.functions-and-logic/inventory.get_cost_of_goods_sold.sql --<--<--
IF OBJECT_ID('inventory.get_cost_of_goods_sold') IS NOT NULL
DROP FUNCTION inventory.get_cost_of_goods_sold;

GO

CREATE FUNCTION inventory.get_cost_of_goods_sold(@item_id integer, @unit_id integer, @store_id integer, @quantity numeric(30, 6))
RETURNS numeric(30, 6)
AS
BEGIN
	IF(@quantity = 0)
	BEGIN
		RETURN 0;
	END;

    DECLARE @backup_quantity            numeric(30, 6);
    DECLARE @base_quantity              numeric(30, 6);
    DECLARE @base_unit_id               integer;
    DECLARE @base_unit_cost             numeric(30, 6);
    DECLARE @total_sold                 integer;
    DECLARE @office_id                  integer = inventory.get_office_id_by_store_id(@store_id);
    DECLARE @method                     national character varying(1000) = inventory.get_cost_of_good_method(@office_id);

    --backup base quantity in numeric(30, 6)
    SET @backup_quantity                = inventory.get_base_quantity_by_unit_id(@unit_id, @quantity);
    --convert base quantity to whole number
    SET @base_quantity                  = CEILING(@backup_quantity);
    SET @base_unit_id                   = inventory.get_root_unit_id(@unit_id);
        
    IF(@method = 'MAVCO')
    BEGIN
        RETURN inventory.get_mavcogs(@item_id, @store_id, @base_quantity, 1.00);
    END; 

	--GET THE SUM TOTAL QUANTITIES SOLD IN THIS STORE
    SELECT @total_sold = COALESCE(SUM(base_quantity), 0)
    FROM inventory.verified_checkout_details_view
    WHERE transaction_type='Cr'
    AND item_id = @item_id
	AND store_id = @store_id;

	IF(@method = 'FIFO')
	BEGIN
		WITH all_purchases
		AS
		(
			SELECT ROW_NUMBER() OVER(ORDER BY value_date, checkout_detail_id) AS id, *
			FROM inventory.verified_checkout_details_view
			WHERE item_id = @item_id
			AND store_id = @store_id
			AND transaction_type = 'Dr'
		), purchase_prices
		AS
		(
			SELECT
				(
					SELECT SUM(base_quantity)
					FROM all_purchases AS i
					WHERE  i.id <= v.id
				) AS total,
				*
			FROM all_purchases AS v
		)
		SELECT TOP 1
			@base_unit_cost = (purchase_prices.price * purchase_prices.quantity) / purchase_prices.base_quantity
		FROM purchase_prices
		WHERE total > @total_sold
		ORDER BY total;

		SET @base_unit_cost = @base_unit_cost * @base_quantity;		
	END;

	IF(@method = 'LIFO')
	BEGIN
		WITH all_purchases
		AS
		(
			SELECT ROW_NUMBER() OVER(ORDER BY value_date, checkout_detail_id) AS id, *
			FROM inventory.verified_checkout_details_view
			WHERE item_id = @item_id
			AND store_id = @store_id
			AND transaction_type = 'Dr'
		), purchase_prices
		AS
		(
			SELECT
				(
					SELECT SUM(base_quantity)
					FROM all_purchases AS i
					WHERE  i.id >= v.id
				) AS total,
				*
			FROM all_purchases AS v
		)
		SELECT TOP 1
			@base_unit_cost = (purchase_prices.price * purchase_prices.quantity) / purchase_prices.base_quantity
		FROM purchase_prices
		WHERE total > @total_sold
		ORDER BY total;

		SET @base_unit_cost = @base_unit_cost * @base_quantity;		
	END;

	IF(@base_unit_cost IS NULL)
	BEGIN
		SET @base_unit_cost = inventory.get_item_cost_price(@item_id, @base_unit_id) * @base_quantity;
	END;

    --APPLY numeric(30, 6) QUANTITY PROVISON
    SET @base_unit_cost = @base_unit_cost * (@backup_quantity / @base_quantity);


    RETURN @base_unit_cost;
END;




GO

--SELECT inventory.get_cost_of_goods_sold(1025, 6, 1, 1);




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.1.update/src/03.menus/menus.sql --<--<--
EXECUTE core.create_menu 'MixERP.Inventory', 'InventorySetup','Inventory Setup', '/dashboard/inventory/setup/is', 'child', 'Setup';

DECLARE @office_id integer = core.get_office_id_by_office_name('Default');
EXECUTE auth.create_app_menu_policy
'Admin', 
@office_id, 
'MixERP.Inventory',
'{*}';


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.1.update/src/99.ownership.sql --<--<--
EXEC sp_addrolemember  @rolename = 'db_owner', @membername  = 'frapid_db_user'
GO

EXEC sp_addrolemember  @rolename = 'db_datareader', @membername  = 'report_user'
GO

DECLARE @proc sysname
DECLARE @cmd varchar(8000)

DECLARE cur CURSOR FOR 
SELECT '[' + schema_name(schema_id) + '].[' + name + ']' FROM sys.objects
WHERE type IN('FN')
AND is_ms_shipped = 0
ORDER BY 1
OPEN cur
FETCH next from cur into @proc
WHILE @@FETCH_STATUS = 0
BEGIN
     SET @cmd = 'GRANT EXEC ON ' + @proc + ' TO report_user';
     EXEC (@cmd)

     FETCH next from cur into @proc
END
CLOSE cur
DEALLOCATE cur

GO

