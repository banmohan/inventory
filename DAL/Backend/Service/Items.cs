using System.Collections.Generic;
using System.Threading.Tasks;
using Frapid.Configuration;
using Frapid.Configuration.Db;
using Frapid.DataAccess;
using MixERP.Inventory.DTO;

namespace MixERP.Inventory.DAL.Backend.Service
{
    public static class Items
    {
        public static async Task<List<Item>> GetStockableItemsAsync(string tenant)
        {
            using (var db = DbProvider.Get(FrapidDbServer.GetConnectionString(tenant), tenant).GetDatabase())
            {
                return
                    await
                        db.Query<Item>()
                            .Where(x => !x.Deleted && x.MaintainInventory)
                            .ToListAsync()
                            .ConfigureAwait(false);
            }
        }

        public static async Task<decimal> CountItemsByItemCodeAsync(string tenant, string itemCode, string unitName, string storeName)
        {
            const string sql = "SELECT inventory.count_item_in_stock(inventory.get_item_id_by_item_code(@0), inventory.get_unit_id_by_unit_name(@1), inventory.get_store_id_by_store_name(@2));";
            return await Factory.ScalarAsync<decimal>(tenant, sql, itemCode, unitName, storeName).ConfigureAwait(false);
        }

        public static async Task<decimal> CountItemsAsync(string tenant, int itemId, int unitId, int storeId)
        {
            const string sql = "SELECT inventory.count_item_in_stock(@0, @1, @2);";
            return await Factory.ScalarAsync<decimal>(tenant, sql, itemId, unitId, storeId).ConfigureAwait(false);
        }

        public static async Task<List<Item>> GetNonStockableItemsAsync(string tenant)
        {
            using (var db = DbProvider.Get(FrapidDbServer.GetConnectionString(tenant), tenant).GetDatabase())
            {
                return
                    await
                        db.Query<Item>()
                            .Where(x => !x.Deleted && !x.MaintainInventory)
                            .ToListAsync()
                            .ConfigureAwait(false);
            }
        }
    }
}