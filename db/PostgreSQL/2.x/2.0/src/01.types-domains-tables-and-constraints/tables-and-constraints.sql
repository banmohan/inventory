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


CREATE TABLE inventory.customer_types
(
    customer_type_id                        SERIAL PRIMARY KEY,
    customer_type_code                      national character varying(24) NOT NULL,
    customer_type_name                      national character varying(500) NOT NULL,
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

