using System.Web.Mvc;
using Frapid.Dashboard;

namespace MixERP.Inventory.Controllers.Backend.Setup
{
    public class ItemVariantController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/item-variants")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/ItemVariants.cshtml", this.Tenant));
        }
    }
}