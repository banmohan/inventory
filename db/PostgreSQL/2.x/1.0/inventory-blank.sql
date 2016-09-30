-->-->-- C:/Users/nirvan/Desktop/mixerp/frapid/src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/1.x/1.0/src/01.types-domains-tables-and-constraints/auditing.sql --<--<--


-->-->-- C:/Users/nirvan/Desktop/mixerp/frapid/src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/1.x/1.0/src/01.types-domains-tables-and-constraints/tables-and-constraints.sql --<--<--
DROP SCHEMA IF EXISTS inventory CASCADE;

CREATE SCHEMA inventory;

--TODO: CREATE UNIQUE INDEXES

CREATE TABLE inventory.units
(
    unit_id                                 SERIAL PRIMARY KEY,
    unit_code                               national character varying(24) NOT NULL,
    unit_name                               national character varying(500) NOT NULL,    
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.compound_units
(
    compound_unit_id                        SERIAL PRIMARY KEY,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    value                                   smallint NOT NULL DEFAULT(0) CHECk(value > 0),
    compare_unit_id                         integer NOT NULL REFERENCES inventory.units,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.suppliers
(
    supplier_id                             SERIAL PRIMARY KEY,
    supplier_code                           national character varying(24) NOT NULL,
    supplier_name                           national character varying(500) NOT NULL,
    company_name                            national character varying(1000),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    public.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   public.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.customers
(
    customer_id                             SERIAL PRIMARY KEY,
    customer_code                           national character varying(24) NOT NULL,
    customer_name                           national character varying(500) NOT NULL,
    company_name                            national character varying(1000),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    public.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   public.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.item_groups
(
    item_group_id                           SERIAL PRIMARY KEY,
    item_group_code                         national character varying(24) NOT NULL,
    item_group_name                         national character varying(500) NOT NULL,
    exclude_from_purchase                   boolean NOT NULL DEFAULT(false),
    exclude_from_sales                      boolean NOT NULL DEFAULT(false),    
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.brands
(
    brand_id                                SERIAL PRIMARY KEY,
    brand_code                              national character varying(24) NOT NULL,
    brand_name                              national character varying(500) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.items
(
    item_id                                 SERIAL PRIMARY KEY,
    item_code                               national character varying(24) NOT NULL,
    item_name                               national character varying(500) NOT NULL,
    barcode                                 national character varying(100),
    item_group_id                           integer NOT NULL REFERENCES inventory.item_groups,
    brand_id                                integer REFERENCES inventory.brands,
    preferred_supplier_id                   integer REFERENCES inventory.suppliers,
    lead_time_in_days                       integer,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    hot_item                                boolean NOT NULL DEFAULT(false),
    cost_price                              public.decimal_strict2,
    selling_price                           public.decimal_strict2,
    reorder_level                           public.integer_strict2 NOT NULL DEFAULT(0),
    reorder_quantity                        public.integer_strict2 NOT NULL DEFAULT(0),
    maintain_inventory                      boolean NOT NULL DEFAULT(true),
    photo                                   public.photo,
    allow_sales                             boolean NOT NULL DEFAULT(true),
    allow_purchase                          boolean NOT NULL DEFAULT(true),
    is_variant_of                           integer REFERENCES inventory.items,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.stores
(
    store_id                                SERIAL PRIMARY KEY,
    store_code                              national character varying(24) NOT NULL,
    store_name                              national character varying(100) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.counters
(
    counter_id                              SERIAL PRIMARY KEY,
    counter_code                            national character varying(12) NOT NULL,
    counter_name                            national character varying(100) NOT NULL,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.checkouts
(
    checkout_id                             BIGSERIAL PRIMARY KEY,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    transaction_date                        date NOT NULL,
    transaction_type                        national character varying(2) NOT NULL
                                            CHECK(transaction_type IN('IN', 'OUT')),
    transaction_book                        national character varying(100) NOT NULL, --SALES, PURCHASE, INVENTORY TRANSFER, DAMAGE
    posted_by                               integer NOT NULL REFERENCES account.users,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    /*LOOKUP FIELDS, ONLY TO SPEED UP THE QUERY */
    office_id                               integer NOT NULL REFERENCES core.offices,
    /*LOOKUP FIELDS */    
    cancelled                               boolean NOT NULL DEFAULT(false),
	cancellation_reason						text,
    amount                                  decimal(24, 4) NOT NULL CHECK(amount > 0),
    discount                                decimal(24, 4) NOT NULL DEFAULT(0),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.checkout_details
(
    checkout_detail_id                      BIGSERIAL PRIMARY KEY,
    checkout_id                             bigint NOT NULL REFERENCES inventory.checkouts,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    rate                                    decimal(24, 3) NOT NULL CHECK(rate > 0),
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    quantity                                public.integer_strict2 NOT NULL
);

CREATE TABLE inventory.inventory_transfer_requests
(
    inventory_transfer_request_id           BIGSERIAL PRIMARY KEY,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    request_date                            date NOT NULL,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(500),
    authorized                              boolean NOT NULL DEFAULT(false),
    authorized_by_user_id                   integer REFERENCES account.users,
    authorized_on                           TIMESTAMP WITH TIME ZONE,
    authorization_reason                    national character varying(500),
    rejected                                boolean NOT NULL DEFAULT(false),
    rejected_by_user_id                     integer REFERENCES account.users,
    rejected_on                             TIMESTAMP WITH TIME ZONE,
    rejection_reason                        national character varying(500),
    received                                boolean NOT NULL DEFAULT(false),
    received_by_user_id                     integer REFERENCES account.users,
    received_on                             TIMESTAMP WITH TIME ZONE,
    receipt_memo                            national character varying(500),
    delivered                               boolean NOT NULL DEFAULT(false),
    delivered_by_user_id                    integer REFERENCES account.users,
    delivered_on                            TIMESTAMP WITH TIME ZONE,
    delivery_memo                           national character varying(500),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.inventory_transfer_request_details
(
    inventory_transfer_request_detail_id    BIGSERIAL PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                public.integer_strict2 NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           public.integer_strict2 NOT NULL
);

CREATE TABLE inventory.inventory_transfer_deliveries
(
    inventory_transfer_delivery_id          BIGSERIAL PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    destination_store_id                    integer NOT NULL REFERENCES inventory.stores,
    delivery_date                           date NOT NULL,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(500),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.inventory_transfer_delivery_details
(
    inventory_transfer_delivery_detail_id   BIGSERIAL PRIMARY KEY,
    inventory_transfer_delivery_id          bigint NOT NULL REFERENCES inventory.inventory_transfer_deliveries,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                public.integer_strict2 NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           public.integer_strict2 NOT NULL
);



-->-->-- C:/Users/nirvan/Desktop/mixerp/frapid/src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/1.x/1.0/src/03.menus/menus.sql --<--<--
DELETE FROM auth.menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'CineSys'
);

DELETE FROM auth.group_menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'CineSys'
);

DELETE FROM core.menus
WHERE app_name = 'CineSys';


SELECT * FROM core.create_app('CineSys', 'Cinema', '1.0', 'MixERP Inc.', 'December 1, 2015', 'teal film', '/dashboard/cinesys/home', NULL::text[]);

SELECT * FROM core.create_menu('CineSys', 'Tasks', '/dashboard/cinesys/home', 'lightning', '');
SELECT * FROM core.create_menu('CineSys', 'Home', '/dashboard/cinesys/home', 'user', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Ticketing', '/dashboard/cinesys/ticketing', 'ticket', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Food Court', '/dashboard/cinesys/foodcourt', 'food', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Counters', '/dashboard/cinesys/counters', 'keyboard', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Cashiers', '/dashboard/cinesys/cashiers', 'users', 'Tasks');

SELECT * FROM core.create_menu('CineSys', 'Cinema', 'square outline', 'configure', '');
SELECT * FROM core.create_menu('CineSys', 'Screens', '/dashboard/cinesys/screens', 'desktop', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Movies', '/dashboard/cinesys/movies', 'film', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Cinemas', '/dashboard/cinesys/cinemas', 'square outline', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Shows', '/dashboard/cinesys/shows', 'clock', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Pricing Types', '/dashboard/cinesys/pricing-types', 'money', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Pricings', '/dashboard/cinesys/pricings', 'money', 'Cinema');

SELECT * FROM core.create_menu('CineSys', 'Setup', '/dashboard/cinesys/setup', 'configure', '');
SELECT * FROM core.create_menu('CineSys', 'Genres', '/dashboard/cinesys/genres', 'lightning', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Film Formats', '/dashboard/cinesys/film-formats', 'film', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Ratings', '/dashboard/cinesys/ratings', 'star', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Categories', '/dashboard/cinesys/categories', 'sitemap', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Distributors', '/dashboard/cinesys/distributors', 'users', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Seat Types', '/dashboard/cinesys/seat-types', 'grid layout', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Arrangement', '/dashboard/cinesys/seating-arrangement', 'grid layout', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Shifts', '/dashboard/cinesys/shifts', 'clock', 'Setup');

SELECT * FROM core.create_menu('CineSys', 'Reports', '/dashboard/cinesys/setup', 'bar chart', '');
SELECT * FROM core.create_menu('CineSys', 'Sales by Cashier', '/dashboard/cinesys/reports/sales-by-cashier', 'money', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'Anusuchi 7', '/dashboard/cinesys/reports/anusuchi-7', 'money', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'Sales book', '/dashboard/cinesys/reports/sales-book', 'grid layout', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'User Audits', '/dashboard/cinesys/reports/user-audit', 'grid layout', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'Cancelled Transactions', '/dashboard/cinesys/reports/cancelled-transactions', 'grid layout', 'Reports');

SELECT * FROM core.create_menu('CineSys', 'Help', '/dashboard/cinesys/help', 'help circle', '');
SELECT * FROM core.create_menu('CineSys', 'User Manual', '/Static/UserManual.pdf', 'star', 'Help');


SELECT * FROM auth.create_app_menu_policy
 (
    'Admin', 
    core.get_office_id_by_office_name('PCP'), 
    'Cinesys',
    '{*}'::text[]
);



-->-->-- C:/Users/nirvan/Desktop/mixerp/frapid/src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/1.x/1.0/src/04.default-values/01.default-values.sql --<--<--


-->-->-- C:/Users/nirvan/Desktop/mixerp/frapid/src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/1.x/1.0/src/05.reports/cinesys.sales_by_cashier_view.sql --<--<--


-->-->-- C:/Users/nirvan/Desktop/mixerp/frapid/src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/1.x/1.0/src/99.ownership.sql --<--<--
DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_tables 
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND tableowner <> 'frapid_db_user'
    LOOP
        EXECUTE 'ALTER TABLE '|| this.schemaname || '.' || this.tablename ||' OWNER TO frapid_db_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;

DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'ALTER '
        || CASE WHEN p.proisagg THEN 'AGGREGATE ' ELSE 'FUNCTION ' END
        || quote_ident(n.nspname) || '.' || quote_ident(p.proname) || '(' 
        || pg_catalog.pg_get_function_identity_arguments(p.oid) || ') OWNER TO frapid_db_user;' AS sql
    FROM   pg_catalog.pg_proc p
    JOIN   pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    WHERE  NOT n.nspname = ANY(ARRAY['pg_catalog', 'information_schema'])
    LOOP        
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_views
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND viewowner <> 'frapid_db_user'
    LOOP
        EXECUTE 'ALTER VIEW '|| this.schemaname || '.' || this.viewname ||' OWNER TO frapid_db_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'ALTER SCHEMA ' || nspname || ' OWNER TO frapid_db_user;' AS sql FROM pg_namespace
    WHERE nspname NOT LIKE 'pg_%'
    AND nspname <> 'information_schema'
    LOOP
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;



DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT      'ALTER TYPE ' || n.nspname || '.' || t.typname || ' OWNER TO frapid_db_user;' AS sql
    FROM        pg_type t 
    LEFT JOIN   pg_catalog.pg_namespace n ON n.oid = t.typnamespace 
    WHERE       (t.typrelid = 0 OR (SELECT c.relkind = 'c' FROM pg_catalog.pg_class c WHERE c.oid = t.typrelid)) 
    AND         NOT EXISTS(SELECT 1 FROM pg_catalog.pg_type el WHERE el.oid = t.typelem AND el.typarray = t.oid)
    AND         typtype NOT IN ('b')
    AND         n.nspname NOT IN ('pg_catalog', 'information_schema')
    LOOP
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_tables 
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND tableowner <> 'report_user'
    LOOP
        EXECUTE 'GRANT SELECT ON TABLE '|| this.schemaname || '.' || this.tablename ||' TO report_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;

DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'GRANT EXECUTE ON '
        || CASE WHEN p.proisagg THEN 'AGGREGATE ' ELSE 'FUNCTION ' END
        || quote_ident(n.nspname) || '.' || quote_ident(p.proname) || '(' 
        || pg_catalog.pg_get_function_identity_arguments(p.oid) || ') TO report_user;' AS sql
    FROM   pg_catalog.pg_proc p
    JOIN   pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    WHERE  NOT n.nspname = ANY(ARRAY['pg_catalog', 'information_schema'])
    LOOP        
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_views
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND viewowner <> 'report_user'
    LOOP
        EXECUTE 'GRANT SELECT ON '|| this.schemaname || '.' || this.viewname ||' TO report_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'GRANT USAGE ON SCHEMA ' || nspname || ' TO report_user;' AS sql FROM pg_namespace
    WHERE nspname NOT LIKE 'pg_%'
    AND nspname <> 'information_schema'
    LOOP
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;
