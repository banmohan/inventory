using System.Threading.Tasks;
using System.Web.Mvc;

namespace MixERP.Inventory.Controllers.Backend.Services
{
    public class ItemController : InventoryBackendController
    {
        [Route("dashboard/inventory/items/stockable")]
        public async Task<ActionResult> IndexAsync(string itemCode)
        {
            var model = await DAL.Backend.Service.Items.GetStockableItemsAsync(this.Tenant).ConfigureAwait(true);
            return this.Ok(model);
        }
    }
}