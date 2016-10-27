using System.Linq;
using System.Threading.Tasks;
using Frapid.DataAccess;
using MixERP.Inventory.DTO;

namespace MixERP.Inventory.DAL.Backend.Setup
{
    public static class Inventory
    {
        public static async Task<OpeningInventoryStatus> GetOpeningStatusAsync(string tenant, int officeId)
        {
            const string sql = "SELECT * FROM inventory.get_opening_inventory_status(@0);";
            var awaiter = await Factory.GetAsync<OpeningInventoryStatus>(tenant, sql, officeId).ConfigureAwait(false);

            return awaiter.FirstOrDefault();
        }
    }
}