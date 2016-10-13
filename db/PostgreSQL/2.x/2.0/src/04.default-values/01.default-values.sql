INSERT INTO inventory.inventory_setup(office_id, inventory_system, cogs_calculation_method)
SELECT office_id, 'Perpetual', 'FIFO'
FROM core.offices;
