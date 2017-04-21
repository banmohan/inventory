using Frapid.DataAccess;
using Frapid.Mapper.Decorators;

namespace MixERP.Inventory.DTO
{
    [TableName("inventory.inventory_setup")]
    [PrimaryKey("office_id", AutoIncrement = false)]
    public sealed class InventorySetup : IPoco
    {
        public int OfficeId { get; set; }
        public string InventorySystem { get; set; }
        public string CogsCalculationMethod { get; set; }
        public bool AllowMultipleOpeningInventory { get; set; }
        public int DefaultDiscountAccountId { get; set; }
        public bool UsePosCheckoutScreen { get; set; }
    }
}