DELETE FROM auth.menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'Inventory'
);

DELETE FROM auth.group_menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'Inventory'
);

DELETE FROM core.menus
WHERE app_name = 'Inventory';


EXECUTE core.create_app 'Inventory', 'Inventory', '1.0', 'MixERP Inc.', 'December 1, 2015', 'cart teal', '/dashboard/inventory/tasks/inventory-transfers', NULL;

EXECUTE core.create_menu 'Inventory', 'Tasks', '', 'lightning', '';
EXECUTE core.create_menu 'Inventory', 'Inventory Transfers', '/dashboard/inventory/tasks/inventory-transfers', 'exchange', 'Tasks';
EXECUTE core.create_menu 'Inventory', 'Inventory Adjustments', '/dashboard/inventory/tasks/inventory-adjustments', 'grid layout', 'Tasks';
EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Verification', '/dashboard/inventory/tasks/inventory-transfers/verification', 'checkmark box', 'Tasks';
EXECUTE core.create_menu 'Inventory', 'Inventory Adjustment Verification', '/dashboard/inventory/tasks/inventory-adjustments/verification', 'checkmark', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Request', '/dashboard/inventory/tasks/inventory-transfer/request', 'food', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Authorization', '/dashboard/inventory/tasks/inventory-transfer/authorization', 'keyboard', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Delivery', '/dashboard/inventory/tasks/inventory-transfer/delivery', 'users', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks';

EXECUTE core.create_menu 'Inventory', 'Setup', 'square outline', 'configure', '';
EXECUTE core.create_menu 'Inventory', 'Inventory Items', '/dashboard/inventory/setup/inventory-items', 'content', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Item Groups', '/dashboard/inventory/setup/item-groups', 'cubes', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Item Types', '/dashboard/inventory/setup/item-types', 'ellipsis vertical', 'Setup';
--EXECUTE core.create_menu 'Inventory', 'Cost Prices', '/dashboard/inventory/setup/cost-prices', 'money', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Store Types', '/dashboard/inventory/setup/store-types', 'block layout', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Stores', '/dashboard/inventory/setup/stores', 'cube', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Counters', '/dashboard/inventory/setup/counters', 'square outline', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Customer Types', '/dashboard/inventory/setup/customer-types', 'users', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Supplier Types', '/dashboard/inventory/setup/supplier-types', 'spy', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Customers', '/dashboard/inventory/setup/customers', 'user', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Suppliers', '/dashboard/inventory/setup/suppliers', 'male', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Brands', '/dashboard/inventory/setup/brands', 'bold', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Units of Measure', '/dashboard/inventory/setup/units-of-measure', 'underline', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Compound Units of Measure', '/dashboard/inventory/setup/compound-units-of-measure', 'move', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Shippers', '/dashboard/inventory/setup/shippers', 'ship', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Attributes', '/dashboard/inventory/setup/attributes', 'crosshairs', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Variants', '/dashboard/inventory/setup/variants', 'align center', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Item Variants', '/dashboard/inventory/setup/item-variants', 'unordered list', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Opening Inventory', '/dashboard/inventory/setup/opening-inventory', 'toggle on', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Opening Inventory Verification', '/dashboard/inventory/setup/opening-inventory/verification', 'check circle outline', 'Setup';

EXECUTE core.create_menu 'Inventory', 'Reports', '', 'block layout', '';
EXECUTE core.create_menu 'Inventory', 'Inventory Account Statement', '/dashboard/reports/view/Areas/MixERP.Inventory/Reports/AccountStatement.xml', 'book', 'Reports';
EXECUTE core.create_menu 'Inventory', 'Physical Count', '/dashboard/reports/view/Areas/MixERP.Inventory/Reports/PhysicalCount.xml', 'circle', 'Reports';
EXECUTE core.create_menu 'Inventory', 'Customer Contacts', '/dashboard/reports/view/Areas/MixERP.Inventory/Reports/CustomerContacts.xml', 'users', 'Reports';
EXECUTE core.create_menu 'Inventory', 'Low Inventory Report', '/dashboard/reports/view/Areas/MixERP.Inventory/Reports/LowInventory.xml', 'battery low', 'Reports';
EXECUTE core.create_menu 'Inventory', 'Profit Status by Item', '/dashboard/reports/view/Areas/MixERP.Inventory/Reports/ProfitStatusByItem.xml', 'bar chart', 'Reports';



DECLARE @office_id integer = core.get_office_id_by_office_name('Default');
EXECUTE auth.create_app_menu_policy
'Admin', 
@office_id, 
'Inventory',
'{*}';

GO
