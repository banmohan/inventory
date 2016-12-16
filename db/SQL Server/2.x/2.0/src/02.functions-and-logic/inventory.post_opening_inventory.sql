IF OBJECT_ID('inventory.post_opening_inventory') IS NOT NULL
DROP PROCEDURE inventory.post_opening_inventory;

GO

CREATE PROCEDURE inventory.post_opening_inventory
(
    @office_id                              integer,
    @user_id                                integer,
    @login_id                               bigint,
    @value_date                             date,
    @book_date                              date,
    @reference_number                       national character varying(24),
    @statement_reference                    national character varying(2000),
    @details                                inventory.opening_stock_type READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @book_name                      national character varying(1000) = 'Opening Inventory';
    DECLARE @transaction_master_id          bigint;
    DECLARE @checkout_id                bigint;
    DECLARE @tran_counter                   integer;
    DECLARE @transaction_code national character varying(50);

    DECLARE @can_post_transaction           bit;
    DECLARE @error_message                  national character varying(MAX);

    SELECT
        @can_post_transaction   = can_post_transaction,
        @error_message          = error_message
    FROM finance.can_post_transaction(@login_id, @user_id, @office_id, @book_name, @value_date);

    IF(@can_post_transaction = 0)
    BEGIN
        RAISERROR(@error_message, 10, 1);
        RETURN;
    END;
    
    DECLARE @temp_stock_details TABLE
    (
        id                              integer IDENTITY PRIMARY KEY,
        tran_type                       national character varying(2),
        store_id                        integer,
        item_id                         integer, 
        quantity                        decimal(30, 6),
        unit_id                         integer,
        base_quantity                   decimal(30, 6),
        base_unit_id                    integer,                
        price                           decimal(30, 6)
    ) ;

    INSERT INTO @temp_stock_details(store_id, item_id, quantity, unit_id, price)
    SELECT store_id, item_id, quantity, unit_id, price
    FROM @details;

    UPDATE @temp_stock_details 
    SET
        tran_type                       = 'Dr',
        base_quantity                   = inventory.get_base_quantity_by_unit_id(unit_id, quantity),
        base_unit_id                    = inventory.get_root_unit_id(unit_id);

    IF EXISTS
    (
        SELECT * FROM @temp_stock_details
        WHERE store_id IS NULL
        OR item_id IS NULL
        OR unit_id IS NULL
    )
    BEGIN
        RAISERROR('Access is denied. Invalid values supplied.', 10, 1);
    END;

    IF EXISTS
    (
        SELECT TOP 1 0 FROM @temp_stock_details AS details
        WHERE inventory.is_valid_unit_id(details.unit_id, details.item_id) = 0
    )
    BEGIN
        RAISERROR('Item/unit mismatch.', 10, 1);
    END;

    
    SET @tran_counter           = finance.get_new_transaction_counter(@value_date);
    SET @transaction_code       = finance.get_transaction_code(@value_date, @office_id, @user_id, @login_id);


    INSERT INTO finance.transaction_master(transaction_counter, transaction_code, book, value_date, book_date, user_id, login_id, office_id, reference_number, statement_reference) 
    SELECT @tran_counter, @transaction_code, @book_name, @value_date, @book_date, @user_id, @login_id, @office_id, @reference_number, @statement_reference;
    SET @transaction_master_id = SCOPE_IDENTITY();


    INSERT INTO inventory.checkouts(transaction_book, value_date, book_date, checkout_id, transaction_master_id, posted_by, office_id)
    SELECT @book_name, @value_date, @book_date, @checkout_id, @transaction_master_id, @user_id, @office_id;
    SET @transaction_master_id = SCOPE_IDENTITY();


    INSERT INTO inventory.checkout_details(value_date, book_date, checkout_id, transaction_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price)
    SELECT @value_date, @book_date, @checkout_id, tran_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price
    FROM @temp_stock_details;
    
    EXECUTE finance.auto_verify @transaction_master_id, @office_id;    
    SELECT @transaction_master_id;
END;



-- 
-- SELECT * FROM inventory.post_opening_inventory
-- (
--     2,
--     2,
--     5,
--     '1-1-2020',
--     '1-1-2020',
--     '3424',
--     'ASDF',
--     ARRAY[
--          ROW(1, 1, 1, 1,180000),
--          ROW(1, 2, 1, 1,130000),
--          ROW(1, 3, 1, 1,110000)]);
-- 


GO
