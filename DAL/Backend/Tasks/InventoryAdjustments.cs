using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Frapid.Configuration;
using Frapid.Framework.Extensions;
using MixERP.Inventory.ViewModels;
using Npgsql;

namespace MixERP.Inventory.DAL.Backend.Tasks
{
    public static class InventoryAdjustments
    {
        public static string GetParametersForDetails(List<AdjustmentType> details)
        {
            if (details == null)
            {
                return "NULL::inventory.transfer_type";
            }

            var items = new Collection<string>();
            for (int i = 0; i < details.Count; i++)
            {
                items.Add(string.Format(CultureInfo.InvariantCulture,
                    "ROW(@TransactionType{0}, @ItemCode{0}, @UnitName{0}, @Quantity{0})::inventory.adjustment_type",
                    i.ToString(CultureInfo.InvariantCulture)));
            }

            return string.Join(",", items);
        }

        public static async Task<long> AddAsync(string tenant, InventoryAdjustment model)
        {
            string connectionString = FrapidDbServer.GetConnectionString(tenant);
            string sql = @"SELECT * FROM inventory.post_adjustment
                          (
                            @OfficeId, @UserId, @LoginId, @StoreId, @ValueDate, @BookDate, 
                            @ReferenceNumber, @StatementReference, 
                            ARRAY[{0}]
                          );";
            sql = string.Format(sql, GetParametersForDetails(model.Details));

            using (var connection = new NpgsqlConnection(connectionString))
            {
                using (var command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@OfficeId", model.OfficeId);
                    command.Parameters.AddWithValue("@UserId", model.UserId);
                    command.Parameters.AddWithValue("@LoginId", model.LoginId);
                    command.Parameters.AddWithValue("@StoreId", model.StoreId);
                    command.Parameters.AddWithValue("@ValueDate", model.ValueDate);
                    command.Parameters.AddWithValue("@BookDate", model.BookDate);
                    command.Parameters.AddWithValue("@ReferenceNumber", model.ReferenceNumber);
                    command.Parameters.AddWithValue("@StatementReference", model.StatementReference);

                    command.Parameters.AddRange(AddParametersForDetails(model.Details).ToArray());

                    connection.Open();
                    var awaiter = await command.ExecuteScalarAsync().ConfigureAwait(false);
                    return awaiter.To<long>();
                }
            }
        }

        public static IEnumerable<NpgsqlParameter> AddParametersForDetails(List<AdjustmentType> details)
        {
            var parameters = new List<NpgsqlParameter>();

            if (details != null)
            {
                for (int i = 0; i < details.Count; i++)
                {
                    parameters.Add(new NpgsqlParameter("@TransactionType" + i, details[i].TransactionType)); //Inventory is decreased
                    parameters.Add(new NpgsqlParameter("@ItemCode" + i, details[i].ItemCode));
                    parameters.Add(new NpgsqlParameter("@UnitName" + i, details[i].UnitName));
                    parameters.Add(new NpgsqlParameter("@Quantity" + i, details[i].Quantity));
                }
            }

            return parameters;
        }
    }
}