-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x.update/src/01.types-domains-tables-and-constraints/tables-and-constraints.sql --<--<--
IF COL_LENGTH('inventory.inventory_setup', 'validate_returns') IS NULL
BEGIN
    ALTER TABLE inventory.inventory_setup
    ADD validate_returns bit NOT NULL DEFAULT(1)
END



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x.update/src/03.menus/menus.sql --<--<--
EXECUTE core.create_menu 'MixERP.Inventory', 'InvestorySetup','Investory Setup', '/dashboard/inventory/setup/is', 'child', 'Setup';

DECLARE @office_id integer = core.get_office_id_by_office_name('Default');
EXECUTE auth.create_app_menu_policy
'Admin', 
@office_id, 
'MixERP.Inventory',
'{*}';


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x.update/src/99.ownership.sql --<--<--
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

