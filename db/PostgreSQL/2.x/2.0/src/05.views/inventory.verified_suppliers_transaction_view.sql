
DROP VIEW IF EXISTS inventory.verified_suppliers_transaction_view;

CREATE VIEW inventory.verified_suppliers_transaction_view
AS
	SELECT 
		suppliers.supplier_id,
		suppliers.supplier_code, 
		suppliers.supplier_name,
		suppliers.account_id,
		purchases.checkout_id,
		transaction_master.value_date,
		transaction_master.book_date,
		checkout_detail_view.amount,
		checkout_detail_view.discount,
		checkout_detail_view.tax,
		checkout_detail_view.price,
		checkout_detail_view.quantity,
		checkout_detail_view.base_quantity,
		checkout_detail_view.item_id,
		checkout_detail_view.item_code,
		checkout_detail_view.item_name,
		checkout_detail_view.total,
		suppliers.deleted,
		suppliers.audit_user_id,
		suppliers.audit_ts
	FROM purchase.purchases 
	LEFT JOIN inventory.checkout_detail_view
		ON checkout_detail_view.checkout_id = purchases.checkout_id
	LEFT JOIN inventory.suppliers
		ON suppliers.supplier_id = purchases.supplier_id
	LEFT JOIN finance.transaction_master
		ON transaction_master.transaction_master_id = checkout_detail_view.transaction_master_id
	WHERE transaction_master.verification_status_id = 1
	AND NOT suppliers.deleted
	AND NOT transaction_master.deleted
	AND checkout_detail_view.transaction_type = 'Dr'





