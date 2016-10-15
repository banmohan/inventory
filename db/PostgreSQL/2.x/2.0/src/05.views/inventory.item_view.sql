DROP VIEW IF EXISTS inventory.item_view;

CREATE VIEW inventory.item_view
AS
SELECT 
        item_id,
        item_code,
        item_name,
        item_group_code || ' (' || item_group_name || ')' AS item_group,
        item_type_code || ' (' || item_type_name || ')' AS item_type,
        maintain_inventory,
        brand_code || ' (' || brand_name || ')' AS brand,
        supplier_code || ' (' || supplier_name || ')' AS preferred_supplier,
        lead_time_in_days,
        inventory.units.unit_code || ' (' || inventory.units.unit_name || ')' AS unit,
        base_unit.unit_code || ' (' || base_unit.unit_name || ')' AS base_unit,
        hot_item,
        cost_price,
        selling_price,
        reorder_unit.unit_code || ' (' || reorder_unit.unit_name || ')' AS reorder_unit,
        reorder_level,
        reorder_quantity
FROM inventory.items
INNER JOIN inventory.item_groups
ON inventory.items.item_group_id = inventory.item_groups.item_group_id
INNER JOIN inventory.item_types
ON inventory.items.item_type_id = inventory.item_types.item_type_id
INNER JOIN inventory.brands
ON inventory.items.brand_id = inventory.brands.brand_id
INNER JOIN inventory.suppliers
ON inventory.items.preferred_supplier_id = inventory.suppliers.supplier_id
INNER JOIN inventory.units
ON inventory.items.unit_id = inventory.units.unit_id
INNER JOIN inventory.units AS base_unit
ON inventory.get_root_unit_id(inventory.items.unit_id) = inventory.units.unit_id
INNER JOIN inventory.units AS reorder_unit
ON inventory.items.reorder_unit_id = reorder_unit.unit_id;