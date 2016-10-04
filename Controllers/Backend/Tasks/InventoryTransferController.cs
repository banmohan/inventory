using Frapid.Dashboard;
using System.Web.Mvc;

namespace MixERP.Inventory.Controllers.Backend.Tasks
{
    public class InventoryTransferController:InventoryBackendController
    {
        [Route("dashboard/inventory/tasks/inventory-transfer")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Tasks/InventoryTrasnfer/Index.cshtml", this.Tenant));
        }

        [Route("dashboard/inventory/tasks/inventory-transfer/new")]
        [MenuPolicy(OverridePath = "/dashboard/inventory/tasks/inventory-transfer")]
        public ActionResult New()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Tasks/InventoryTrasnfer/New.cshtml", this.Tenant));
        }
    }
}