-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/99.sample-data/inventory.sample.sql --<--<--
INSERT INTO inventory.brands(brand_code, brand_name)
SELECT 'DEF', 'Default';

INSERT INTO inventory.units(unit_code, unit_name)
SELECT 'PC', 'Piece'        UNION ALL
SELECT 'FT', 'Feet'         UNION ALL
SELECT 'MTR', 'Meter'       UNION ALL
SELECT 'LTR', 'Liter'       UNION ALL
SELECT 'GM', 'Gram'         UNION ALL
SELECT 'KG', 'Kilogram'     UNION ALL
SELECT 'DZ', 'Dozen'        UNION ALL
SELECT 'BX', 'Box';


INSERT INTO inventory.compound_units(base_unit_id, compare_unit_id, value)
SELECT inventory.get_unit_id_by_unit_code('PC'), inventory.get_unit_id_by_unit_code('DZ'), 12     UNION ALL
SELECT inventory.get_unit_id_by_unit_code('DZ'), inventory.get_unit_id_by_unit_code('BX'), 100    UNION ALL
SELECT inventory.get_unit_id_by_unit_code('GM'), inventory.get_unit_id_by_unit_code('KG'), 1000;

INSERT INTO inventory.brands(brand_code, brand_name)
SELECT 'APP', 'Apple'       UNION ALL
SELECT 'MS',  'Microsoft'    UNION ALL
SELECT 'IBM', 'IBM'         UNION ALL
SELECT 'ACR', 'Acer'        UNION ALL
SELECT 'SNG', 'Samsung'     UNION ALL
SELECT 'ITX', 'Index';

INSERT INTO inventory.item_types(item_type_code, item_type_name, is_component)
SELECT 'GEN', 'General',        false      UNION ALL
SELECT 'COM', 'Component',      true       UNION ALL
SELECT 'MAF', 'Manufacturing',  false;

INSERT INTO inventory.customer_types(customer_type_code, customer_type_name, account_id) 
SELECT 'A', 'Agent', finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'C', 'Customer', finance.get_account_id_by_account_number('10400');

INSERT INTO inventory.supplier_types(supplier_type_code, supplier_type_name, account_id) 
SELECT 'S', 'Supplier', finance.get_account_id_by_account_number('20100');

INSERT INTO inventory.suppliers(supplier_code, supplier_name, supplier_type_id, company_name, account_id)
SELECT 'APP', 'Apple', inventory.get_supplier_type_id_by_supplier_type_code('S'),       'Apple',        finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'MIC', 'Microsoft', inventory.get_supplier_type_id_by_supplier_type_code('S'),   'Microsoft',    finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'SAM', 'Samsung', inventory.get_supplier_type_id_by_supplier_type_code('S'),     'Samsung',      finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'ACE', 'Acer', inventory.get_supplier_type_id_by_supplier_type_code('S'),        'Acer',         finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'DEL', 'Dell', inventory.get_supplier_type_id_by_supplier_type_code('S'),        'Dell',         finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'IBM', 'IBM', inventory.get_supplier_type_id_by_supplier_type_code('S'),         'IBM',          finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'MIX', 'MixERP', inventory.get_supplier_type_id_by_supplier_type_code('S'),      'MixERP',       finance.get_account_id_by_account_number('20100') UNION ALL
SELECT 'ITX', 'Intex', inventory.get_supplier_type_id_by_supplier_type_code('S'),       'Intext',       finance.get_account_id_by_account_number('20100');


INSERT INTO inventory.shippers(shipper_name, company_name, account_id)
SELECT 'Default', 'Default', finance.get_account_id_by_account_number('20110');


INSERT INTO inventory.item_groups(item_group_code, item_group_name, sales_account_id, sales_discount_account_id, sales_return_account_id, purchase_account_id, purchase_discount_account_id, inventory_account_id, cost_of_goods_sold_account_id)
SELECT 'DEF', 'Default', finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200');


INSERT INTO inventory.item_groups(item_group_code, item_group_name, parent_item_group_id, sales_account_id, sales_discount_account_id, sales_return_account_id, purchase_account_id, purchase_discount_account_id, inventory_account_id, cost_of_goods_sold_account_id)
SELECT 'ELE', 'Electronics & Computers',                NULL,												    finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'TVV', 'TV & Video',                             inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'HAT', 'Home Audio & Theater',                   inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'CPV', 'Camera, Photo & Video',                  inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'CPA', 'Cell Phones & Accessories',              inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'VGM', 'Video Games',                            inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'PAA', 'Portable Audio & Accessories',           inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'CEG', 'Car Electronics & GPS',                  inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'MUI', 'Musical Instruments',                    inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'ELA', 'Electronics Accessories',                inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'WRT', 'Wearable Technology',                    inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'LPT', 'Laptops & Tablets',                      inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'DEM', 'Desktops & Monitors',                    inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'CAP', 'Computer Accessories & Peripherals',     inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'CPC', 'Computer Parts & Components',            inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'SFT', 'Software',                               inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'PRI', 'Printers & Ink',                         inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200')	UNION ALL
SELECT 'OSS', 'Office & School Supplies',               inventory.get_item_group_id_by_item_group_code('ELE'),	finance.get_account_id_by_account_number('30100'), finance.get_account_id_by_account_number('40270'), finance.get_account_id_by_account_number('20701'), finance.get_account_id_by_account_number('40100'), finance.get_account_id_by_account_number('30700'), finance.get_account_id_by_account_number('10700'), finance.get_account_id_by_account_number('40200');    


INSERT INTO inventory.store_types(store_type_code,store_type_name)
SELECT 'GOD', 'Godown'                              UNION ALL
SELECT 'SAL', 'Sales Center'                        UNION ALL
SELECT 'WAR', 'Warehouse'                           UNION ALL
SELECT 'PRO', 'Production';



INSERT INTO inventory.stores(office_id, store_code, store_name, city, store_type_id, allow_sales)
SELECT 1, 'STORE-1', 'Store 1',     'Office', inventory.get_store_type_id_by_store_type_code('SAL'), true   UNION ALL
SELECT 1, 'GODOW-1', 'Godown 1',    'Office', inventory.get_store_type_id_by_store_type_code('GOD'), false  UNION ALL
SELECT 1, 'STORE-2', 'Store 2',     'Office', inventory.get_store_type_id_by_store_type_code('SAL'), true   UNION ALL
SELECT 1, 'GODOW-2', 'Godown 2',    'Office', inventory.get_store_type_id_by_store_type_code('GOD'), false  UNION ALL
SELECT 1, 'STORE-3', 'Store 3',     'Office', inventory.get_store_type_id_by_store_type_code('SAL'), true   UNION ALL
SELECT 1, 'GODOW-3', 'Godown 3',    'Office', inventory.get_store_type_id_by_store_type_code('GOD'), false;


INSERT INTO inventory.items(item_code, item_name, item_group_id, item_type_id, brand_id, preferred_supplier_id, unit_id, hot_item, reorder_level, maintain_inventory, cost_price, selling_price, reorder_unit_id, reorder_quantity)
SELECT 'RMBP',  'Macbook Pro 15'''' Retina',            inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    1800,    2250, inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT '13MBA', 'Macbook Air 13''''',                   inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    1300,    1550, inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT '11MBA', 'Macbook Air 11''''',                   inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    1100,    1350, inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'IPA',   'iPad Air',                             inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    50,     true,    530,     700,  inventory.get_unit_id_by_unit_code('PC'), 100  UNION ALL
SELECT 'IPR',   'iPad Air Retina',                      inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    630,     800,  inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'IPM',   'iPad Mini',                            inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    330,     500,  inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'IPMR',  'iPad Mini Retina',                     inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    530,     700,  inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'IPH6',  'iPhone 6',                             inventory.get_item_group_id_by_item_group_code('CPA'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    930,     1050, inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'IPH6P', 'iPhone 6 Plus',                        inventory.get_item_group_id_by_item_group_code('CPA'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('APP'),       inventory.get_supplier_id_by_supplier_code('APP'),  inventory.get_unit_id_by_unit_code('PC'), false,    100,    true,    1030,    1150, inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'ITP',   'IBM Thinkpadd II Laptop',              inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('IBM'),       inventory.get_supplier_id_by_supplier_code('IBM'),  inventory.get_unit_id_by_unit_code('PC'), false,    50,     true,    800,     1250, inventory.get_unit_id_by_unit_code('PC'), 100  UNION ALL
SELECT 'AIT',   'Acer Iconia Tab',                      inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('ACR'),       inventory.get_supplier_id_by_supplier_code('ACE'),  inventory.get_unit_id_by_unit_code('PC'), true,     10,     true,    400,     650,  inventory.get_unit_id_by_unit_code('PC'), 20   UNION ALL
SELECT 'IXM',   'Intex Mouse',                          inventory.get_item_group_id_by_item_group_code('CAP'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('ITX'),       inventory.get_supplier_id_by_supplier_code('ITX'),  inventory.get_unit_id_by_unit_code('PC'), false,    1000,   true,    2.00,    3.50, inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'MSO',   'Microsoft Office Premium Edition',     inventory.get_item_group_id_by_item_group_code('SFT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('MS'),        inventory.get_supplier_id_by_supplier_code('MIC'),  inventory.get_unit_id_by_unit_code('PC'), true,     100,    true,    300,     350,  inventory.get_unit_id_by_unit_code('PC'), 200  UNION ALL
SELECT 'MNP',   'MixNP Classifieds',                    inventory.get_item_group_id_by_item_group_code('SFT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('DEF'),       inventory.get_supplier_id_by_supplier_code('MIX'),  inventory.get_unit_id_by_unit_code('PC'), true,     0,      false,   1500,    1500, inventory.get_unit_id_by_unit_code('PC'), 0    UNION ALL
SELECT 'MIX',   'MixERP Community Edition',             inventory.get_item_group_id_by_item_group_code('SFT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('DEF'),       inventory.get_supplier_id_by_supplier_code('MIX'),  inventory.get_unit_id_by_unit_code('PC'), true,     0,      false,   400,     400,  inventory.get_unit_id_by_unit_code('PC'), 0    UNION ALL
SELECT 'SGT',   'Samsung Galaxy Tab 10.1',              inventory.get_item_group_id_by_item_group_code('LPT'),	inventory.get_item_type_id_by_item_type_code('GEN'), inventory.get_brand_id_by_brand_code('SNG'),       inventory.get_supplier_id_by_supplier_code('SAM'),  inventory.get_unit_id_by_unit_code('PC'), false,    10,     true,    300,     450,  inventory.get_unit_id_by_unit_code('PC'), 20;


UPDATE inventory.items
SET photo = '/dashboard/inventory/services/attachments/' || item_code || '.jpg';
--ROLLBACK TRANSACTION;

