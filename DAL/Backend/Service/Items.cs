using System.Collections.Generic;
using System.Threading.Tasks;
using Frapid.Configuration;
using Frapid.Configuration.Db;
using MixERP.Inventory.DTO;

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
}