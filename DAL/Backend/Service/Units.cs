using Frapid.Configuration;
using Frapid.Configuration.Db;
using Frapid.DataAccess;
using MixERP.Inventory.DTO;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MixERP.Inventory.DAL.Backend.Service
{
    public static class Items
    {
        public static async Task<List<Item>> GetStockableItemsAsync(string tenant)
        {
            using (var db = DbProvider.Get(FrapidDbServer.GetConnectionString(tenant), tenant).GetDatabase())
            {
                return await db.Query<Item>().Where(x => !x.Deleted && x.MaintainInventory).ToListAsync().ConfigureAwait(false);
            }
        }

        public static async Task<List<Item>> GetNonStockableItemsAsync(string tenant)
        {
            using (var db = DbProvider.Get(FrapidDbServer.GetConnectionString(tenant), tenant).GetDatabase())
            {
                return await db.Query<Item>().Where(x => !x.Deleted && !x.MaintainInventory).ToListAsync().ConfigureAwait(false);
            }
        }
    }
    public static class Units
    {
        public static async Task<List<AssociatedUnit>> GetAssociatedUnitsAsync(string tenant, string itemCode)
        {
            string sql = FrapidDbServer.GetProcedureCommand(tenant, "inventory.get_associated_units_by_item_code",
                new[] { "@0" });

            var result = await Factory.GetAsync<AssociatedUnit>(tenant, sql, itemCode).ConfigureAwait(false);
            return result.ToList();
        }
    }
}