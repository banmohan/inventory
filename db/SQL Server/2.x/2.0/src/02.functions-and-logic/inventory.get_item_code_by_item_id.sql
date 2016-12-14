IF OBJECT_ID('inventory.get_item_code_by_item_id') IS NOT NULL
DROP FUNCTION inventory.get_item_code_by_item_id;

GO

CREATE OR REPLACE FUNCTION inventory.get_item_code_by_item_id(item_id_ integer)
RETURNS character varying AS

BEGIN
    RETURN
    (
	    SELECT item_code
	    FROM inventory.items
	    WHERE inventory.items.item_id = item_id_
	    AND inventory.items.deleted = 0
    );
END



GO
