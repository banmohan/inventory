-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/01.types-domains-tables-and-constraints/tables-and-constraints.sql --<--<--
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


CREATE TABLE inventory.supplier_types
(
    supplier_type_id                        SERIAL PRIMARY KEY,
    supplier_type_code                      national character varying(24) NOT NULL,
    supplier_type_name                      national character varying(500) NOT NULL,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.suppliers
(
    supplier_id                             SERIAL PRIMARY KEY,
    supplier_code                           national character varying(24) NOT NULL,
    supplier_name                           national character varying(500) NOT NULL,
	supplier_type_id						integer NOT NULL REFERENCES inventory.supplier_types,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128) NULL,   
    company_address_line_2                  national character varying(128) NULL,
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
    contact_address_line_1                  national character varying(128) NULL,   
    contact_address_line_2                  national character varying(128) NULL,
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


CREATE TABLE inventory.customer_types
(
    customer_type_id                        SERIAL PRIMARY KEY,
    customer_type_code                      national character varying(24) NOT NULL,
    customer_type_name                      national character varying(500) NOT NULL,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.customers
(
    customer_id                             SERIAL PRIMARY KEY,
    customer_code                           national character varying(24) NOT NULL,
    customer_name                           national character varying(500) NOT NULL,
    customer_type_id                        integer NOT NULL REFERENCES inventory.customer_types,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128) NULL,   
    company_address_line_2                  national character varying(128) NULL,
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
    contact_address_line_1                  national character varying(128) NULL,   
    contact_address_line_2                  national character varying(128) NULL,
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
    sales_account_id                        bigint NOT NULL REFERENCES finance.accounts,
    sales_discount_account_id               bigint NOT NULL REFERENCES finance.accounts,
    sales_return_account_id                 bigint NOT NULL REFERENCES finance.accounts,
    purchase_account_id                     bigint NOT NULL REFERENCES finance.accounts,
    purchase_discount_account_id            bigint NOT NULL REFERENCES finance.accounts,
    inventory_account_id                    bigint NOT NULL REFERENCES finance.accounts,
    cost_of_goods_sold_account_id           bigint NOT NULL REFERENCES finance.accounts,    
    parent_item_group_id                    integer NULL REFERENCES inventory.item_groups(item_group_id),
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

CREATE TABLE inventory.item_types
(
    item_type_id                            SERIAL PRIMARY KEY,
    item_type_code                          national character varying(12) NOT NULL,
    item_type_name                          national character varying(50) NOT NULL,
	is_component							boolean NOT NULL DEFAULT(false),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE UNIQUE INDEX item_type_item_type_code_uix
ON inventory.item_types(UPPER(item_type_code));


CREATE UNIQUE INDEX item_type_item_type_name_uix
ON inventory.item_types(UPPER(item_type_name));


CREATE TABLE inventory.items
(
    item_id                                 SERIAL PRIMARY KEY,
    item_code                               national character varying(24) NOT NULL,
    item_name                               national character varying(500) NOT NULL,
    barcode                                 national character varying(100), --UNIQUE
    item_group_id                           integer NOT NULL REFERENCES inventory.item_groups,
	item_type_id							integer NOT NULL REFERENCES inventory.item_types,
    brand_id                                integer REFERENCES inventory.brands,
    preferred_supplier_id                   integer REFERENCES inventory.suppliers,
    lead_time_in_days                       integer,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    hot_item                                boolean NOT NULL DEFAULT(false),
    cost_price                              public.decimal_strict2,
    selling_price                           public.decimal_strict2,
    reorder_level                           public.integer_strict2 NOT NULL DEFAULT(0),
    reorder_quantity                        public.integer_strict2 NOT NULL DEFAULT(0),
	reorder_unit_id                         integer NOT NULL REFERENCES inventory.units,
    maintain_inventory                      boolean NOT NULL DEFAULT(true),
    photo                                   public.photo,
    allow_sales                             boolean NOT NULL DEFAULT(true),
    allow_purchase                          boolean NOT NULL DEFAULT(true),
    is_variant_of                           integer REFERENCES inventory.items,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.store_types
(
    store_type_id                           SERIAL PRIMARY KEY,
    store_type_code                         national character varying(12) NOT NULL,
    store_type_name                         national character varying(50) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.stores
(
    store_id                                SERIAL PRIMARY KEY,
    store_code                              national character varying(24) NOT NULL,
    store_name                              national character varying(100) NOT NULL,
    store_type_id                           integer NOT NULL REFERENCES inventory.store_types,
	office_id								integer NOT NULL REFERENCES core.offices,
    address_line_1                          national character varying(128) NULL,   
    address_line_2                          national character varying(128) NULL,
    street                                  national character varying(50) NULL,
    city                                    national character varying(50) NULL,
    state                                   national character varying(50) NULL,
    country                                 national character varying(50) NULL,
    phone                                   national character varying(50) NULL,
    fax                                     national character varying(50) NULL,
    cell                                    national character varying(50) NULL,
    allow_sales                             boolean NOT NULL DEFAULT(true),	
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

CREATE TABLE inventory.shippers
(
    shipper_id                              SERIAL PRIMARY KEY,
    shipper_code                            national character varying(24) NULL,
    company_name                            national character varying(128) NOT NULL,
    shipper_name                            national character varying(150) NULL,
    po_box                                  national character varying(128) NULL,
    address_line_1                          national character varying(128) NULL,   
    address_line_2                          national character varying(128) NULL,
    street                                  national character varying(50) NULL,
    city                                    national character varying(50) NULL,
    state                                   national character varying(50) NULL,
    country                                 national character varying(50) NULL,
    phone                                   national character varying(50) NULL,
    fax                                     national character varying(50) NULL,
    cell                                    national character varying(50) NULL,
    email                                   national character varying(128) NULL,
    url                                     national character varying(50) NULL,
    contact_person                          national character varying(50) NULL,
    contact_po_box                          national character varying(128) NULL,
    contact_address_line_1                  national character varying(128) NULL,   
    contact_address_line_2                  national character varying(128) NULL,
    contact_street                          national character varying(50) NULL,
    contact_city                            national character varying(50) NULL,
    contact_state                           national character varying(50) NULL,
    contact_country                         national character varying(50) NULL,
    contact_email                           national character varying(128) NULL,
    contact_phone                           national character varying(50) NULL,
    contact_cell                            national character varying(50) NULL,
    factory_address                         national character varying(250) NULL,
    pan_number                              national character varying(50) NULL,
    sst_number                              national character varying(50) NULL,
    cst_number                              national character varying(50) NULL,
    account_id                              bigint NOT NULL REFERENCES finance.accounts(account_id),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.checkouts
(
    checkout_id                             BIGSERIAL PRIMARY KEY,
	value_date								date NOT NULL,
	book_date								date NOT NULL,
	transaction_master_id					bigint NOT NULL REFERENCES finance.transaction_master,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    transaction_book                        national character varying(100) NOT NULL, --SALES, PURCHASE, INVENTORY TRANSFER, DAMAGE
    posted_by                               integer NOT NULL REFERENCES account.users,
    /*LOOKUP FIELDS, ONLY TO SPEED UP THE QUERY */
    office_id                               integer NOT NULL REFERENCES core.offices,
    /*LOOKUP FIELDS */    
    cancelled                               boolean NOT NULL DEFAULT(false),
	cancellation_reason						text,
	shipper_id								integer REFERENCES inventory.shippers,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.checkout_details
(
    checkout_detail_id                      BIGSERIAL PRIMARY KEY,
    checkout_id                             bigint NOT NULL REFERENCES inventory.checkouts,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
	value_date								date NOT NULL,
	book_date								date NOT NULL,
    transaction_type                        national character varying(2) NOT NULL
                                            CHECK(transaction_type IN('Dr', 'Cr')),
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    price                                   public.money_strict NOT NULL,
    discount                                public.money_strict2 NOT NULL DEFAULT(0),    
    cost_of_goods_sold                      public.money_strict2 NOT NULL DEFAULT(0),
    shipping_charge                         public.money_strict2 NOT NULL DEFAULT(0),    
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    quantity                                public.integer_strict2 NOT NULL,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           numeric NOT NULL
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


CREATE TABLE inventory.attributes
(
	attribute_id                            SERIAL NOT NULL PRIMARY KEY,
	attribute_code                          national character varying(12) NOT NULL UNIQUE,
	attribute_name                          national character varying(100) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.variants
(
	variant_id                              SERIAL NOT NULL PRIMARY KEY,
	variant_code                            national character varying(12) NOT NULL UNIQUE,
	variant_name                            national character varying(100) NOT NULL,
	attribute_id                            integer NOT NULL REFERENCES inventory.attributes,
	attribute_value                         national character varying(200) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.item_variants
(
	item_variant_id                         SERIAL NOT NULL PRIMARY KEY,
	item_id                                 integer NOT NULL REFERENCES inventory.items,
	variant_id                              integer NOT NULL REFERENCES inventory.variants,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE NULL DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.inventory_setup
(
	office_id								integer NOT NULL PRIMARY KEY REFERENCES core.offices,
	inventory_system						national character varying(50) NOT NULL
											CHECK(inventory_system IN('Periodic', 'Perpetual')),
	cogs_calculation_method					national character varying(50) NOT NULL
											CHECK(cogs_calculation_method IN('FIFO', 'LIFO', 'MAVCO'))
);


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.convert_unit.sql --<--<--
DROP FUNCTION IF EXISTS inventory.convert_unit(from_unit integer, to_unit integer);

CREATE FUNCTION inventory.convert_unit(from_unit integer, to_unit integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _factor decimal;
BEGIN
    IF(inventory.get_root_unit_id($1) != inventory.get_root_unit_id($2)) THEN
        RETURN 0;
    END IF;

    IF($1 = $2) THEN
        RETURN 1.00;
    END IF;
    
    IF(inventory.is_parent_unit($1, $2)) THEN
            WITH RECURSIVE unit_cte(unit_id, value) AS 
            (
                SELECT tn.compare_unit_id, tn.value
                FROM inventory.compound_units AS tn WHERE tn.base_unit_id = $1

                UNION ALL

                SELECT 
                c.compare_unit_id, c.value * p.value
                FROM unit_cte AS p, 
                inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )
        SELECT 1.00/value INTO _factor
        FROM unit_cte
        WHERE unit_id=$2;
    ELSE
            WITH RECURSIVE unit_cte(unit_id, value) AS 
            (
             SELECT tn.compare_unit_id, tn.value
                FROM inventory.compound_units AS tn WHERE tn.base_unit_id = $2
            UNION ALL
             SELECT 
                c.compare_unit_id, c.value * p.value
                FROM unit_cte AS p, 
              inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )

        SELECT value INTO _factor
        FROM unit_cte
        WHERE unit_id=$1;
    END IF;

    RETURN _factor;
END
$$
LANGUAGE plpgsql;




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.count_item_in_stock.sql --<--<--
DROP FUNCTION IF EXISTS inventory.count_item_in_stock(_item_id integer, _unit_id integer, _store_id integer);

CREATE FUNCTION inventory.count_item_in_stock(_item_id integer, _unit_id integer, _store_id integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _debit decimal;
    DECLARE _credit decimal;
    DECLARE _balance decimal;
BEGIN

    _debit := inventory.count_purchases($1, $2, $3);
    _credit := inventory.count_sales($1, $2, $3);

    _balance:= _debit - _credit;    
    return _balance;  
END
$$
LANGUAGE plpgsql;


SELECT * FROM inventory.count_item_in_stock(1, 1, 1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.count_purchases.sql --<--<--
DROP FUNCTION IF EXISTS inventory.count_purchases(_item_id integer, _unit_id integer, _store_id integer);

CREATE FUNCTION inventory.count_purchases(_item_id integer, _unit_id integer, _store_id integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _base_unit_id integer;
    DECLARE _debit decimal;
    DECLARE _factor decimal;
BEGIN
    --Get the base item unit
    SELECT 
        inventory.get_root_unit_id(inventory.items.unit_id) 
    INTO _base_unit_id
    FROM inventory.items
    WHERE inventory.items.item_id=$1;

    SELECT
        COALESCE(SUM(base_quantity), 0)
    INTO _debit
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND inventory.checkout_details.item_id=$1
    AND inventory.checkout_details.store_id=$3
    AND inventory.checkout_details.tran_type='Dr';

    _factor = inventory.convert_unit(_base_unit_id, $2);    
    RETURN _debit * _factor;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.count_sales.sql --<--<--
DROP FUNCTION IF EXISTS inventory.count_sales(_item_id integer, _unit_id integer, _store_id integer);
CREATE FUNCTION inventory.count_sales(_item_id integer, _unit_id integer, _store_id integer)
RETURNS decimal
STABLE
AS
$$
        DECLARE _base_unit_id integer;
        DECLARE _credit decimal;
        DECLARE _factor decimal;
BEGIN
    --Get the base item unit
    SELECT 
        inventory.get_root_unit_id(inventory.items.unit_id) 
    INTO _base_unit_id
    FROM inventory.items
    WHERE inventory.items.item_id=$1;

    SELECT 
        COALESCE(SUM(base_quantity), 0)
    INTO _credit
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND inventory.checkout_details.item_id=$1
    AND inventory.checkout_details.store_id=$3
    AND inventory.checkout_details.tran_type='Cr';

    _factor = inventory.convert_unit(_base_unit_id, $2);
    RETURN _credit * _factor;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_account_id_by_supplier_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_account_id_by_supplier_id(_supplier_id integer);

CREATE FUNCTION inventory.get_account_id_by_supplier_id(_supplier_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        inventory.suppliers.account_id
    FROM inventory.suppliers
    WHERE inventory.suppliers.supplier_id = _supplier_id
    AND NOT inventory.suppliers.deleted;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_unit_list.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_associated_unit_list(_any_unit_id integer);

CREATE FUNCTION inventory.get_associated_unit_list(_any_unit_id integer)
RETURNS integer[]
VOLATILE
AS
$$
    DECLARE root_unit_id integer;
BEGIN
    DROP TABLE IF EXISTS temp_unit;
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_unit(unit_id integer) ON COMMIT DROP; 
    
    SELECT inventory.get_root_unit_id(_any_unit_id) INTO root_unit_id;
    
    INSERT INTO temp_unit(unit_id) 
    SELECT root_unit_id
    WHERE NOT EXISTS
    (
        SELECT * FROM temp_unit
        WHERE temp_unit.unit_id=root_unit_id
    );
    
    WITH RECURSIVE cte(unit_id)
    AS
    (
         SELECT 
            compare_unit_id
         FROM 
            inventory.compound_units
         WHERE 
            base_unit_id = root_unit_id

        UNION ALL

         SELECT
            units.compare_unit_id
         FROM 
            inventory.compound_units units
         INNER JOIN cte 
         ON cte.unit_id = units.base_unit_id
    )
    
    INSERT INTO temp_unit(unit_id)
    SELECT cte.unit_id FROM cte;
    
    DELETE FROM temp_unit
    WHERE temp_unit.unit_id IS NULL;
    
    RETURN ARRAY(SELECT temp_unit.unit_id FROM temp_unit);
END
$$
LANGUAGE plpgsql;

--SELECT * FROM inventory.get_associated_unit_list(1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_units.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_associated_units(_any_unit_id integer);

CREATE FUNCTION inventory.get_associated_units(_any_unit_id integer)
RETURNS TABLE
(
    unit_id integer, 
    unit_code text, 
    unit_name text
)
VOLATILE
AS
$$
    DECLARE root_unit_id integer;
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_unit(unit_id integer) ON COMMIT DROP; 
    
    SELECT inventory.get_root_unit_id(_any_unit_id) INTO root_unit_id;
    
    INSERT INTO temp_unit(unit_id) 
    SELECT root_unit_id
    WHERE NOT EXISTS
    (
        SELECT * FROM temp_unit
        WHERE temp_unit.unit_id=root_unit_id
    );
    
    WITH RECURSIVE cte(unit_id)
    AS
    (
         SELECT 
            compare_unit_id
         FROM 
            inventory.compound_units
         WHERE 
            base_unit_id = root_unit_id

        UNION ALL

         SELECT
            units.compare_unit_id
         FROM 
            inventory.compound_units units
         INNER JOIN cte 
         ON cte.unit_id = units.base_unit_id
    )
    
    INSERT INTO temp_unit(unit_id)
    SELECT cte.unit_id FROM cte;
    
    DELETE FROM temp_unit
    WHERE temp_unit.unit_id IS NULL;
    
    RETURN QUERY 
    SELECT 
        inventory.units.unit_id,
        inventory.units.unit_code::text,
        inventory.units.unit_name::text
    FROM
        inventory.units
    WHERE
        inventory.units.unit_id 
    IN
    (
        SELECT temp_unit.unit_id FROM temp_unit
    );
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_units_by_item_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_associated_units_by_item_id(_item_id integer);

CREATE FUNCTION inventory.get_associated_units_by_item_id(_item_id integer)
RETURNS TABLE
(
    unit_id integer, 
    unit_code text, 
    unit_name text
)
AS
$$
    DECLARE _unit_id integer;
BEGIN
    SELECT inventory.items.unit_id INTO _unit_id
    FROM inventory.items
    WHERE item_id = _item_id;

    RETURN QUERY
    SELECT * FROM inventory.get_associated_units(_unit_id);
END
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS inventory.get_associated_units_by_item_code(_item_code text);

CREATE FUNCTION inventory.get_associated_units_by_item_code(_item_code text)
RETURNS TABLE
(
    unit_id integer, 
    unit_code text, 
    unit_name text
)
AS
$$
    DECLARE _unit_id integer;
BEGIN
    SELECT inventory.items.unit_id INTO _unit_id
    FROM inventory.items
    WHERE LOWER(item_code) = LOWER(_item_code);

    RETURN QUERY
    SELECT * FROM inventory.get_associated_units(_unit_id);
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_base_quantity_by_unit_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_base_quantity_by_unit_name(text, integer);

CREATE FUNCTION inventory.get_base_quantity_by_unit_name(text, integer)
RETURNS decimal
STABLE
AS
$$
	DECLARE _unit_id integer;
	DECLARE _root_unit_id integer;
	DECLARE _factor decimal;
BEGIN
    _unit_id := inventory.get_unit_id_by_unit_name($1);
    _root_unit_id = inventory.get_root_unit_id(_unit_id);
    _factor = inventory.convert_unit(_unit_id, _root_unit_id);

    RETURN _factor * $2;
END
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS inventory.get_base_quantity_by_unit_id(integer, integer);

CREATE FUNCTION inventory.get_base_quantity_by_unit_id(integer, integer)
RETURNS decimal
STABLE
AS
$$
	DECLARE _root_unit_id integer;
	DECLARE _factor decimal;
BEGIN
    _root_unit_id = inventory.get_root_unit_id($1);
    _factor = inventory.convert_unit($1, _root_unit_id);

    RETURN _factor * $2;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_base_unit_id_by_unit_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_base_unit_id_by_unit_name(text);

CREATE FUNCTION inventory.get_base_unit_id_by_unit_name(text)
RETURNS integer
STABLE
AS
$$
DECLARE _unit_id integer;
BEGIN
    _unit_id := inventory.get_unit_id_by_unit_name($1);

    RETURN inventory.get_root_unit_id(_unit_id);
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_brand_id_by_brand_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_brand_id_by_brand_code(text);

CREATE FUNCTION inventory.get_brand_id_by_brand_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN brand_id
        FROM inventory.brands
        WHERE brand_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_id_by_customer_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_customer_id_by_customer_code(text);

CREATE FUNCTION inventory.get_customer_id_by_customer_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN customer_id
        FROM inventory.customers
        WHERE customer_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_type_id_by_customer_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_customer_type_id_by_customer_type_code(text);

CREATE FUNCTION inventory.get_customer_type_id_by_customer_type_code(text)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN customer_type_id
    FROM inventory.customer_types
    WHERE customer_type_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_inventory_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_inventory_account_id(_item_id integer);

CREATE FUNCTION inventory.get_inventory_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        inventory_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = $1;    
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_group_id_by_item_group_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_group_id_by_item_group_code(text);

CREATE FUNCTION inventory.get_item_group_id_by_item_group_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN item_group_id
        FROM inventory.item_groups
        WHERE item_group_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_id_by_item_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_id_by_item_code(_item_code text);

CREATE FUNCTION inventory.get_item_id_by_item_code(_item_code text)
RETURNS integer
AS
$$
BEGIN
    RETURN item_id
    FROM inventory.items
    WHERE item_code = _item_code;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_type_id_by_item_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_type_id_by_item_type_code(text);

CREATE FUNCTION inventory.get_item_type_id_by_item_type_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN item_type_id
        FROM inventory.item_types
        WHERE item_type_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_purchase_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_purchase_account_id(_item_id integer);

CREATE FUNCTION inventory.get_purchase_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        purchase_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = $1;    
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_purchase_discount_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_purchase_discount_account_id(_item_id integer);

CREATE FUNCTION inventory.get_purchase_discount_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        purchase_discount_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = $1;    
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_root_unit_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_root_unit_id(_any_unit_id integer);

CREATE FUNCTION inventory.get_root_unit_id(_any_unit_id integer)
RETURNS integer
AS
$$
    DECLARE root_unit_id integer;
BEGIN
    SELECT base_unit_id INTO root_unit_id
    FROM inventory.compound_units
    WHERE compare_unit_id=_any_unit_id;

    IF(root_unit_id IS NULL) THEN
        RETURN _any_unit_id;
    ELSE
        RETURN inventory.get_root_unit_id(root_unit_id);
    END IF; 
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_store_type_id_by_store_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_store_type_id_by_store_type_code(text);

CREATE FUNCTION inventory.get_store_type_id_by_store_type_code(text)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN store_type_id
    FROM inventory.store_types
    WHERE store_type_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_supplier_id_by_supplier_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_supplier_id_by_supplier_code(text);

CREATE FUNCTION inventory.get_supplier_id_by_supplier_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN supplier_id
        FROM inventory.suppliers
        WHERE supplier_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_supplier_type_id_by_supplier_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_supplier_type_id_by_supplier_type_code(text);

CREATE FUNCTION inventory.get_supplier_type_id_by_supplier_type_code(text)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN supplier_type_id
    FROM inventory.supplier_types
    WHERE supplier_type_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_id_by_unit_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_unit_id_by_unit_code(text);

CREATE FUNCTION inventory.get_unit_id_by_unit_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN unit_id
        FROM inventory.units
        WHERE unit_code=$1;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_id_by_unit_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_unit_id_by_unit_name(_unit_name text);

CREATE FUNCTION inventory.get_unit_id_by_unit_name(_unit_name text)
RETURNS integer
AS
$$
BEGIN
    RETURN unit_id
    FROM inventory.units
    WHERE unit_name = _unit_name;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.is_parent_unit.sql --<--<--
DROP FUNCTION IF EXISTS inventory.is_parent_unit(parent integer, child integer);

CREATE FUNCTION inventory.is_parent_unit(parent integer, child integer)
RETURNS boolean
AS
$$      
BEGIN
    IF $1!=$2 THEN
        IF EXISTS
        (
            WITH RECURSIVE unit_cte(unit_id) AS 
            (
             SELECT tn.compare_unit_id
                FROM inventory.compound_units AS tn WHERE tn.base_unit_id = $1
            UNION ALL
             SELECT
                c.compare_unit_id
                FROM unit_cte AS p, 
              inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )

            SELECT * FROM unit_cte
            WHERE unit_id=$2
        ) THEN
            RETURN TRUE;
        END IF;
    END IF;
    RETURN false;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.is_periodic_inventory.sql --<--<--
DROP FUNCTION IF EXISTS inventory.is_periodic_inventory(_office_id integer);

CREATE FUNCTION inventory.is_periodic_inventory(_office_id integer)
RETURNS boolean
AS
$$
BEGIN
    IF EXISTS(SELECT * FROM inventory.inventory_setup WHERE inventory_system = 'Periodic' AND office_id = _office_id) THEN
        RETURN true;
    END IF;

    RETURN false;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.is_valid_unit_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.is_valid_unit_id(_unit_id integer, _item_id integer);

CREATE FUNCTION inventory.is_valid_unit_id(_unit_id integer, _item_id integer)
RETURNS boolean
AS
$$
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inventory.items
        WHERE item_id = $2
        AND inventory.get_root_unit_id($1) = inventory.get_root_unit_id(unit_id)
    ) THEN
        RETURN true;
    END IF;

    RETURN false;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/03.menus/menus.sql --<--<--
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
    core.get_office_id_by_office_name('Default'), 
    'Inventory',
    '{*}'::text[]
);



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/04.default-values/01.default-values.sql --<--<--
INSERT INTO inventory.inventory_setup(office_id, inventory_system, cogs_calculation_method)
SELECT office_id, 'Perpetual', 'FIFO'
FROM core.offices;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.reports/cinesys.sales_by_cashier_view.sql --<--<--


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.scrud-views/inventory.item_scrud_view.sql --<--<--
DROP VIEW IF EXISTS inventory.item_scrud_view;

CREATE VIEW inventory.item_scrud_view
AS
SELECT
    inventory.items.item_id,
    inventory.items.item_code,
    inventory.items.item_name,
    inventory.items.barcode,
    inventory.items.item_group_id,
    inventory.item_groups.item_group_name,
    inventory.item_types.item_type_id,
    inventory.item_types.item_type_name,
    inventory.items.brand_id,
    inventory.brands.brand_name,
    inventory.items.preferred_supplier_id,
    inventory.items.unit_id,
    inventory.units.unit_code,
    inventory.units.unit_name,
    inventory.items.hot_item,
    inventory.items.cost_price,
    inventory.items.selling_price,
    inventory.items.maintain_inventory,
    inventory.items.allow_sales,
    inventory.items.allow_purchase,
    inventory.items.photo
FROM inventory.items
INNER JOIN inventory.item_groups
ON inventory.item_groups.item_group_id = inventory.items.item_group_id
INNER JOIN inventory.item_types
ON inventory.item_types.item_type_id = inventory.items.item_type_id
INNER JOIN inventory.brands
ON inventory.brands.brand_id = inventory.items.brand_id
INNER JOIN inventory.units
ON inventory.units.unit_id = inventory.items.unit_id
WHERE NOT inventory.items.deleted
AND inventory.items.allow_purchase
AND inventory.items.maintain_inventory;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/99.ownership.sql --<--<--
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
