using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Frapid.Configuration;
using Frapid.DataAccess.Extensions;
using Frapid.Framework.Extensions;
using MixERP.Inventory.ViewModels;

namespace MixERP.Inventory.DAL.Backend.Tasks.TransferEntry
{
    public sealed class SqlServer : ITransferEntry
    {
        public async Task<long> AddAsync(string tenant, InventoryTransfer model)
        {
            string connectionString = FrapidDbServer.GetConnectionString(tenant);
            string sql = @"EXECUTE inventory.post_transfer
                            @OfficeId, @UserId, @LoginId, @ValueDate, @BookDate, 
                            @ReferenceNumber, @StatementReference, 
                            @Details
                          ;";

            using (var connection = new SqlConnection(connectionString))
            {
                using (var command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithNullableValue("@OfficeId", model.OfficeId);
                    command.Parameters.AddWithNullableValue("@UserId", model.UserId);
                    command.Parameters.AddWithNullableValue("@LoginId", model.LoginId);
                    command.Parameters.AddWithNullableValue("@ValueDate", model.ValueDate);
                    command.Parameters.AddWithNullableValue("@BookDate", model.BookDate);
                    command.Parameters.AddWithNullableValue("@ReferenceNumber", model.ReferenceNumber);
                    command.Parameters.AddWithNullableValue("@StatementReference", model.StatementReference);

                    using (var details = this.GetDetails(model.Details))
                    {
                        command.Parameters.AddWithNullableValue("@Details", details, "inventory.transfer_type");
                    }

                    connection.Open();
                    var awaiter = await command.ExecuteScalarAsync().ConfigureAwait(false);
                    return awaiter.To<long>();
                }
            }
        }

        public DataTable GetDetails(IEnumerable<TransferType> details)
        {
            var table = new DataTable();
            table.Columns.Add("ItemCode", typeof(string));
            table.Columns.Add("ItemName", typeof(string));
            table.Columns.Add("Quantity", typeof(decimal));
            table.Columns.Add("StoreName", typeof(string));
            table.Columns.Add("TransactionType", typeof(string));
            table.Columns.Add("UnitName", typeof(string));

            foreach (var detail in details)
            {
                var row = table.NewRow();

                row["ItemCode"] = detail.ItemCode;
                row["ItemName"] = detail.ItemName;
                row["Quantity"] = detail.Quantity;
                row["StoreName"] = detail.StoreName;
                row["TransactionType"] = detail.TransferTypeEnum.ToString();
                row["UnitName"] = detail.UnitName;

                table.Rows.Add(row);
            }

            return table;
        }
    }
}