using Frapid.Dashboard;
using System.Web.Mvc;

namespace MixERP.Inventory.Controllers.Backend.Setup
{
    public class InventoryItemController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/inventory-items")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/InventoryItems.cshtml", this.Tenant));
        }
    }
}