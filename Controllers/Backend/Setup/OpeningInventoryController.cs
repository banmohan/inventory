using System.Threading.Tasks;
using System.Web.Mvc;
using Frapid.ApplicationState.Cache;
using Frapid.Dashboard;
using MixERP.Inventory.Models;
using MixERP.Inventory.ViewModels;

namespace MixERP.Inventory.Controllers.Backend.Setup
{
    public class OpeningInventoryController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/opening-inventory")]
        [MenuPolicy]
        public async Task<ActionResult> IndexAsync()
        {
            var meta = await AppUsers.GetCurrentAsync().ConfigureAwait(true);
            var model = await OpeningInventories.GetModelAsync(this.Tenant, meta).ConfigureAwait(true);

            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/OpeningInventory/Index.cshtml", this.Tenant), model);
        }

        [Route("dashboard/inventory/setup/opening-inventory/checklist/{tranId}")]
        [MenuPolicy(OverridePath = "/dashboard/inventory/setup/opening-inventory")]
        public ActionResult ChecklistAsync(long tranId)
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/OpeningInventory/Checklist.cshtml", this.Tenant), tranId);
        }

        [Route("dashboard/inventory/setup/opening-inventory/new")]
        [MenuPolicy(OverridePath = "/dashboard/inventory/setup/opening-inventory")]
        public async Task<ActionResult> NewAsync()
        {
            var meta = await AppUsers.GetCurrentAsync().ConfigureAwait(true);
            var model = await OpeningInventories.GetModelAsync(this.Tenant, meta).ConfigureAwait(true);

            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/OpeningInventory/New.cshtml", this.Tenant), model);
        }

        [Route("dashboard/inventory/setup/opening-inventory/new")]
        [HttpPost]
        [MenuPolicy(OverridePath = "/dashboard/inventory/setup/opening-inventory")]
        public async Task<ActionResult> PostAsync(OpeningInventory model)
        {
            if (!this.ModelState.IsValid)
            {
                return this.InvalidModelState(this.ModelState);
            }

            var meta = await AppUsers.GetCurrentAsync().ConfigureAwait(true);

            model.UserId = meta.UserId;
            model.OfficeId = meta.OfficeId;
            model.LoginId = meta.LoginId;

            long tranId = await DAL.Backend.Setup.OpeningInventories.PostAsync(this.Tenant, model).ConfigureAwait(true);
            return this.Ok(tranId);
        }
    }
}