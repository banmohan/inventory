using System.ComponentModel.DataAnnotations;

namespace MixERP.Inventory.ViewModels
{
    public sealed class AdjustmentType
    {
        public string TransactionType => "Cr";
        [Required]
        public string ItemCode { get; set; }
        [Required]
        public string UnitName { get; set; }
        [Required]
        public decimal Quantity { get; set; }
    }
}