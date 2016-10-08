using System.Web.Mvc;
using Frapid.Dashboard;

namespace MixERP.Inventory.Controllers.Backend.Tasks
{
    public class InventoryAdjustmentController : InventoryBackendController
    {
        [Route("dashboard/inventory/tasks/inventory-adjustments")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Tasks/InventoryAdjustment/Index.cshtml", this.Tenant));
        }
    }
}