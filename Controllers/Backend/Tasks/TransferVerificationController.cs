using System.Threading.Tasks;
using System.Web.Mvc;
using Frapid.Dashboard;
using MixERP.Finance.Controllers.Backend.Tasks;
using MixERP.Finance.ViewModels;

namespace MixERP.Inventory.Controllers.Backend.Tasks
{
    public class TransferVerificationController : BaseVerificationController
    {
        [Route("dashboard/inventory/tasks/inventory-transfers/verification/approve")]
        [HttpPost]
        public override async Task<ActionResult> ApproveAsync(Verification model)
        {
            return await base.ApproveAsync(model).ConfigureAwait(true);
        }

        [Route("dashboard/inventory/tasks/inventory-transfers/verification/reject")]
        [HttpPost]
        public override async Task<ActionResult> RejectAsync(Verification model)
        {
            return await base.RejectAsync(model).ConfigureAwait(true);
        }
    }
}