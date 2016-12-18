using System;
using System.Threading.Tasks;
using Frapid.Configuration.Db;
using Frapid.Mapper.Database;
using MixERP.Inventory.DAL.Backend.Tasks.AdjustmentEntry;
using MixERP.Inventory.ViewModels;

namespace MixERP.Inventory.DAL.Backend.Tasks
{
    public static class InventoryAdjustments
    {
        private static IAdjustmentEntry LocateService(string tenant)
        {
            string providerName = DbProvider.GetProviderName(tenant);
            var type = DbProvider.GetDbType(providerName);

            if (type == DatabaseType.PostgreSQL)
            {
                return new PostgreSQL();
            }

            if (type == DatabaseType.SqlServer)
            {
                return new SqlServer();
            }

            throw new NotImplementedException();
        }

        public static async Task<long> PostAsync(string tenant, InventoryAdjustment model)
        {
            var entry = LocateService(tenant);

            return await entry.AddAsync(tenant, model).ConfigureAwait(false);
        }
    }
}