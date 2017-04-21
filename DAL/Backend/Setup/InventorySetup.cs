using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Frapid.DataAccess;

namespace MixERP.Inventory.DAL.Backend.Setup
{
    public static class InventorySetup
    {
        public static async Task<DTO.InventorySetup> GetAsync(string tenant, int officeId)
        {
            const string sql = "SELECT * FROM inventory.inventory_setup WHERE office_id=@0;";
            var awaiter = await Factory.GetAsync<DTO.InventorySetup>(tenant, sql, officeId).ConfigureAwait(false);

            return awaiter.FirstOrDefault();
        }

        public static async Task<IEnumerable<DTO.InventorySetup>> GetAsync(string tenant)
        {
            const string sql = "SELECT * FROM inventory.inventory_setup;";
            return await Factory.GetAsync<DTO.InventorySetup>(tenant, sql).ConfigureAwait(false);
        }
    }
}