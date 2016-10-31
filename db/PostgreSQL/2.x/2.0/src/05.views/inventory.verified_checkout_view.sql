DROP MATERIALIZED VIEW IF EXISTS inventory.verified_checkout_view;

CREATE MATERIALIZED VIEW inventory.verified_checkout_view
AS
SELECT * FROM inventory.checkout_view
WHERE verification_status_id > 0;

ALTER MATERIALIZED VIEW inventory.verified_checkout_view
OWNER TO frapid_db_user;