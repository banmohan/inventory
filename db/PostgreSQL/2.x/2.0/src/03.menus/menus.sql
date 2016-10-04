SELECT * FROM core.create_app('Inventory', 'Inventory', '1.0', 'MixERP Inc.', 'December 1, 2015', 'cart teal', '/dashboard/inventory/home', NULL::text[]);

SELECT * FROM core.create_menu('Inventory', 'Tasks', '', 'lightning', '');
SELECT * FROM core.create_menu('Inventory', 'Home', '/dashboard/inventory/home', 'user', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer', '/dashboard/inventory/tasks/inventory-transfer', 'user', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Adjustments', '/dashboard/inventory/tasks/inventory-adjustments', 'ticket', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Request', '/dashboard/inventory/tasks/inventory-transfer/request', 'food', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Authorization', '/dashboard/inventory/tasks/inventory-transfer/authorization', 'keyboard', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Delivery', '/dashboard/inventory/tasks/inventory-transfer/delivery', 'users', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks');

SELECT * FROM core.create_menu('Inventory', 'Setup', 'square outline', 'configure', '');
SELECT * FROM core.create_menu('Inventory', 'Inventory Items', '/dashboard/inventory/setup/inventory-items', 'users', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Item Groups', '/dashboard/inventory/setup/item-groups', 'users', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Item Types', '/dashboard/inventory/setup/item-types', 'users', 'Setup');
--SELECT * FROM core.create_menu('Inventory', 'Selling Prices', '/dashboard/inventory/setup/selling-prices', 'money', 'Setup');
--SELECT * FROM core.create_menu('Inventory', 'Cost Prices', '/dashboard/inventory/setup/cost-prices', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Store Types', '/dashboard/inventory/setup/store-types', 'desktop', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Stores', '/dashboard/inventory/setup/stores', 'film', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Counters', '/dashboard/inventory/setup/counters', 'square outline', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Customer Types', '/dashboard/inventory/setup/customer-types', 'clock', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Supplier Types', '/dashboard/inventory/setup/supplier-types', 'clock', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Customers', '/dashboard/inventory/setup/customers', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Suppliers', '/dashboard/inventory/setup/suppliers', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Brands', '/dashboard/inventory/setup/brands', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Units of Measure', '/dashboard/inventory/setup/units-of-measure', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Compound Units of Measure', '/dashboard/inventory/setup/compound-units-of-measure', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Shippers', '/dashboard/inventory/setup/shippers', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Attributes', '/dashboard/inventory/setup/attributes', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Variants', '/dashboard/inventory/setup/variants', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Item Variants', '/dashboard/inventory/setup/item-variants', 'money', 'Setup');

SELECT * FROM core.create_menu('Inventory', 'Reports', '', 'configure', '');
SELECT * FROM core.create_menu('Inventory', 'Inventory Account Statement', '/dashboard/inventory/reports/inventory-account-statement', 'money', 'Reports');

SELECT * FROM auth.create_app_menu_policy
 (
    'Admin', 
    core.get_office_id_by_office_name('PCP'), 
    'Inventory',
    '{*}'::text[]
);

