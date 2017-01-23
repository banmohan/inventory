using System.Collections.Generic;
using System.Globalization;
using Frapid.Configuration;
using Frapid.i18n;

namespace MixERP.Inventory
{
	public sealed class Localize : ILocalize
	{
		public Dictionary<string, string> GetResources(CultureInfo culture)
		{
			string resourceDirectory = I18N.ResourceDirectory;
			return I18NResource.GetResources(resourceDirectory, culture);
		}
	}

	public static class I18N
	{
		public static string ResourceDirectory { get; }

		static I18N()
		{
			ResourceDirectory = PathMapper.MapPath("/Areas/MixERP.Inventory/i18n");
		}

		/// <summary>
		///Action
		/// </summary>
		public static string Action => I18NResource.GetString(ResourceDirectory, "Action");

		/// <summary>
		///Actions
		/// </summary>
		public static string Actions => I18NResource.GetString(ResourceDirectory, "Actions");

		/// <summary>
		///Actual
		/// </summary>
		public static string Actual => I18NResource.GetString(ResourceDirectory, "Actual");

		/// <summary>
		///Add New
		/// </summary>
		public static string AddNew => I18NResource.GetString(ResourceDirectory, "AddNew");

		/// <summary>
		///Add New Adjustment
		/// </summary>
		public static string AddNewAdjustment => I18NResource.GetString(ResourceDirectory, "AddNewAdjustment");

		/// <summary>
		///Add a New Opening Inventory
		/// </summary>
		public static string AddNewOpeningInventory => I18NResource.GetString(ResourceDirectory, "AddNewOpeningInventory");

		/// <summary>
		///Amount
		/// </summary>
		public static string Amount => I18NResource.GetString(ResourceDirectory, "Amount");

		/// <summary>
		///Approve
		/// </summary>
		public static string Approve => I18NResource.GetString(ResourceDirectory, "Approve");

		/// <summary>
		///Are you sure?
		/// </summary>
		public static string AreYouSure? => I18NResource.GetString(ResourceDirectory, "AreYouSure?");

		/// <summary>
		///Attributes
		/// </summary>
		public static string Attributes => I18NResource.GetString(ResourceDirectory, "Attributes");

		/// <summary>
		///Back
		/// </summary>
		public static string Back => I18NResource.GetString(ResourceDirectory, "Back");

		/// <summary>
		///Book
		/// </summary>
		public static string Book => I18NResource.GetString(ResourceDirectory, "Book");

		/// <summary>
		///Book Date
		/// </summary>
		public static string BookDate => I18NResource.GetString(ResourceDirectory, "BookDate");

		/// <summary>
		///Brands
		/// </summary>
		public static string Brands => I18NResource.GetString(ResourceDirectory, "Brands");

		/// <summary>
		///CHECKOUT
		/// </summary>
		public static string CHECKOUT => I18NResource.GetString(ResourceDirectory, "CHECKOUT");

		/// <summary>
		///CLS
		/// </summary>
		public static string CLS => I18NResource.GetString(ResourceDirectory, "CLS");

		/// <summary>
		///Cancel
		/// </summary>
		public static string Cancel => I18NResource.GetString(ResourceDirectory, "Cancel");

		/// <summary>
		///Cannot add item because the price is zero.
		/// </summary>
		public static string CannotAddItemBecausePriceZero => I18NResource.GetString(ResourceDirectory, "CannotAddItemBecausePriceZero");

		/// <summary>
		///Checklist
		/// </summary>
		public static string Checklist => I18NResource.GetString(ResourceDirectory, "Checklist");

		/// <summary>
		///ChecklistWindow
		/// </summary>
		public static string ChecklistWindow => I18NResource.GetString(ResourceDirectory, "ChecklistWindow");

		/// <summary>
		///Clear
		/// </summary>
		public static string Clear => I18NResource.GetString(ResourceDirectory, "Clear");

		/// <summary>
		///Compound Units of Measure
		/// </summary>
		public static string CompoundUnitsOfMeasure => I18NResource.GetString(ResourceDirectory, "CompoundUnitsOfMeasure");

		/// <summary>
		///Counters
		/// </summary>
		public static string Counters => I18NResource.GetString(ResourceDirectory, "Counters");

		/// <summary>
		///Customer Types
		/// </summary>
		public static string CustomerTypes => I18NResource.GetString(ResourceDirectory, "CustomerTypes");

		/// <summary>
		///Customers
		/// </summary>
		public static string Customers => I18NResource.GetString(ResourceDirectory, "Customers");

		/// <summary>
		///Difference
		/// </summary>
		public static string Difference => I18NResource.GetString(ResourceDirectory, "Difference");

		/// <summary>
		///Doing something ...
		/// </summary>
		public static string DoingSomething => I18NResource.GetString(ResourceDirectory, "DoingSomething");

		/// <summary>
		///Duplicate Entry
		/// </summary>
		public static string DuplicateEntry => I18NResource.GetString(ResourceDirectory, "DuplicateEntry");

		/// <summary>
		///Export
		/// </summary>
		public static string Export => I18NResource.GetString(ResourceDirectory, "Export");

		/// <summary>
		///Export to Doc
		/// </summary>
		public static string ExportDoc => I18NResource.GetString(ResourceDirectory, "ExportDoc");

		/// <summary>
		///Export This Document
		/// </summary>
		public static string ExportDocument => I18NResource.GetString(ResourceDirectory, "ExportDocument");

		/// <summary>
		///Export to Excel
		/// </summary>
		public static string ExportExcel => I18NResource.GetString(ResourceDirectory, "ExportExcel");

		/// <summary>
		///Export to PDF
		/// </summary>
		public static string ExportPDF => I18NResource.GetString(ResourceDirectory, "ExportPDF");

		/// <summary>
		///From
		/// </summary>
		public static string From => I18NResource.GetString(ResourceDirectory, "From");

		/// <summary>
		///IN
		/// </summary>
		public static string IN => I18NResource.GetString(ResourceDirectory, "IN");

		/// <summary>
		///Inventory
		/// </summary>
		public static string Inventory => I18NResource.GetString(ResourceDirectory, "Inventory");

		/// <summary>
		///Inventory Adjustment
		/// </summary>
		public static string InventoryAdjustment => I18NResource.GetString(ResourceDirectory, "InventoryAdjustment");

		/// <summary>
		///Inventory Adjustment Verification
		/// </summary>
		public static string InventoryAdjustmentVerification => I18NResource.GetString(ResourceDirectory, "InventoryAdjustmentVerification");

		/// <summary>
		///Inventory Adjustments
		/// </summary>
		public static string InventoryAdjustments => I18NResource.GetString(ResourceDirectory, "InventoryAdjustments");

		/// <summary>
		///Inventory Items
		/// </summary>
		public static string InventoryItems => I18NResource.GetString(ResourceDirectory, "InventoryItems");

		/// <summary>
		///Inventory Transfer
		/// </summary>
		public static string InventoryTransfer => I18NResource.GetString(ResourceDirectory, "InventoryTransfer");

		/// <summary>
		///Inventory Transfer Verification
		/// </summary>
		public static string InventoryTransferVerification => I18NResource.GetString(ResourceDirectory, "InventoryTransferVerification");

		/// <summary>
		///Inventory Transfers
		/// </summary>
		public static string InventoryTransfers => I18NResource.GetString(ResourceDirectory, "InventoryTransfers");

		/// <summary>
		///Item Code
		/// </summary>
		public static string ItemCode => I18NResource.GetString(ResourceDirectory, "ItemCode");

		/// <summary>
		///Item Groups
		/// </summary>
		public static string ItemGroups => I18NResource.GetString(ResourceDirectory, "ItemGroups");

		/// <summary>
		///Item Id
		/// </summary>
		public static string ItemId => I18NResource.GetString(ResourceDirectory, "ItemId");

		/// <summary>
		///Item Name
		/// </summary>
		public static string ItemName => I18NResource.GetString(ResourceDirectory, "ItemName");

		/// <summary>
		///Item Types
		/// </summary>
		public static string ItemTypes => I18NResource.GetString(ResourceDirectory, "ItemTypes");

		/// <summary>
		///Item Varients
		/// </summary>
		public static string ItemVarients => I18NResource.GetString(ResourceDirectory, "ItemVarients");

		/// <summary>
		///Memo
		/// </summary>
		public static string Memo => I18NResource.GetString(ResourceDirectory, "Memo");

		/// <summary>
		///OUT
		/// </summary>
		public static string OUT => I18NResource.GetString(ResourceDirectory, "OUT");

		/// <summary>
		///Office
		/// </summary>
		public static string Office => I18NResource.GetString(ResourceDirectory, "Office");

		/// <summary>
		///OfficeId
		/// </summary>
		public static string OfficeId => I18NResource.GetString(ResourceDirectory, "OfficeId");

		/// <summary>
		///Okay
		/// </summary>
		public static string Okay => I18NResource.GetString(ResourceDirectory, "Okay");

		/// <summary>
		///Opening Inventories
		/// </summary>
		public static string OpeningInventories => I18NResource.GetString(ResourceDirectory, "OpeningInventories");

		/// <summary>
		///Opening Inventory
		/// </summary>
		public static string OpeningInventory => I18NResource.GetString(ResourceDirectory, "OpeningInventory");

		/// <summary>
		///Opening inventory has already been entered for this office.
		/// </summary>
		public static string OpeningInventoryAlreadyEnteredOffice => I18NResource.GetString(ResourceDirectory, "OpeningInventoryAlreadyEnteredOffice");

		/// <summary>
		///Opening Inventory Verification
		/// </summary>
		public static string OpeningInventoryVerification => I18NResource.GetString(ResourceDirectory, "OpeningInventoryVerification");

		/// <summary>
		///Please select a store!
		/// </summary>
		public static string PleaseSelectStore! => I18NResource.GetString(ResourceDirectory, "PleaseSelectStore!");

		/// <summary>
		///PostedBy
		/// </summary>
		public static string PostedBy => I18NResource.GetString(ResourceDirectory, "PostedBy");

		/// <summary>
		///Print
		/// </summary>
		public static string Print => I18NResource.GetString(ResourceDirectory, "Print");

		/// <summary>
		///Quantity
		/// </summary>
		public static string Quantity => I18NResource.GetString(ResourceDirectory, "Quantity");

		/// <summary>
		///Reason
		/// </summary>
		public static string Reason => I18NResource.GetString(ResourceDirectory, "Reason");

		/// <summary>
		///Reference Number
		/// </summary>
		public static string ReferenceNumber => I18NResource.GetString(ResourceDirectory, "ReferenceNumber");

		/// <summary>
		///Ref #
		/// </summary>
		public static string ReferenceNumberAbbrebiated => I18NResource.GetString(ResourceDirectory, "ReferenceNumberAbbrebiated");

		/// <summary>
		///Reject
		/// </summary>
		public static string Reject => I18NResource.GetString(ResourceDirectory, "Reject");

		/// <summary>
		///Save
		/// </summary>
		public static string Save => I18NResource.GetString(ResourceDirectory, "Save");

		/// <summary>
		///Search ...
		/// </summary>
		public static string Search... => I18NResource.GetString(ResourceDirectory, "Search...");

		/// <summary>
		///Select
		/// </summary>
		public static string Select => I18NResource.GetString(ResourceDirectory, "Select");

		/// <summary>
		///Select Store
		/// </summary>
		public static string SelectStore => I18NResource.GetString(ResourceDirectory, "SelectStore");

		/// <summary>
		///Shippers
		/// </summary>
		public static string Shippers => I18NResource.GetString(ResourceDirectory, "Shippers");

		/// <summary>
		///Show
		/// </summary>
		public static string Show => I18NResource.GetString(ResourceDirectory, "Show");

		/// <summary>
		///Show Items
		/// </summary>
		public static string ShowItems => I18NResource.GetString(ResourceDirectory, "ShowItems");

		/// <summary>
		///Statement Reference
		/// </summary>
		public static string StatementReference => I18NResource.GetString(ResourceDirectory, "StatementReference");

		/// <summary>
		///Status
		/// </summary>
		public static string Status => I18NResource.GetString(ResourceDirectory, "Status");

		/// <summary>
		///Store
		/// </summary>
		public static string Store => I18NResource.GetString(ResourceDirectory, "Store");

		/// <summary>
		///Store Types
		/// </summary>
		public static string StoreTypes => I18NResource.GetString(ResourceDirectory, "StoreTypes");

		/// <summary>
		///Stores & Warehouses
		/// </summary>
		public static string StoresAndWarehouses => I18NResource.GetString(ResourceDirectory, "StoresAndWarehouses");

		/// <summary>
		///Supplier Types
		/// </summary>
		public static string SupplierTypes => I18NResource.GetString(ResourceDirectory, "SupplierTypes");

		/// <summary>
		///Suppliers
		/// </summary>
		public static string Suppliers => I18NResource.GetString(ResourceDirectory, "Suppliers");

		/// <summary>
		///To
		/// </summary>
		public static string To => I18NResource.GetString(ResourceDirectory, "To");

		/// <summary>
		///TranCode
		/// </summary>
		public static string TranCode => I18NResource.GetString(ResourceDirectory, "TranCode");

		/// <summary>
		///TranId
		/// </summary>
		public static string TranId => I18NResource.GetString(ResourceDirectory, "TranId");

		/// <summary>
		///The transaction was posted successfully.
		/// </summary>
		public static string TransactionPostedSuccessfully => I18NResource.GetString(ResourceDirectory, "TransactionPostedSuccessfully");

		/// <summary>
		///Type
		/// </summary>
		public static string Type => I18NResource.GetString(ResourceDirectory, "Type");

		/// <summary>
		///Unit
		/// </summary>
		public static string Unit => I18NResource.GetString(ResourceDirectory, "Unit");

		/// <summary>
		///Unit Id
		/// </summary>
		public static string UnitId => I18NResource.GetString(ResourceDirectory, "UnitId");

		/// <summary>
		///Unit Name
		/// </summary>
		public static string UnitName => I18NResource.GetString(ResourceDirectory, "UnitName");

		/// <summary>
		///Units of Measure
		/// </summary>
		public static string UnitsOfMeasure => I18NResource.GetString(ResourceDirectory, "UnitsOfMeasure");

		/// <summary>
		///UserId
		/// </summary>
		public static string UserId => I18NResource.GetString(ResourceDirectory, "UserId");

		/// <summary>
		///Value Date
		/// </summary>
		public static string ValueDate => I18NResource.GetString(ResourceDirectory, "ValueDate");

		/// <summary>
		///Variants
		/// </summary>
		public static string Variants => I18NResource.GetString(ResourceDirectory, "Variants");

		/// <summary>
		///Verification Reason
		/// </summary>
		public static string VerificationReason => I18NResource.GetString(ResourceDirectory, "VerificationReason");

		/// <summary>
		///Verified By
		/// </summary>
		public static string VerifiedBy => I18NResource.GetString(ResourceDirectory, "VerifiedBy");

		/// <summary>
		///Verified On
		/// </summary>
		public static string VerifiedOn => I18NResource.GetString(ResourceDirectory, "VerifiedOn");

		/// <summary>
		///Verify
		/// </summary>
		public static string Verify => I18NResource.GetString(ResourceDirectory, "Verify");

		/// <summary>
		///View Adjustments
		/// </summary>
		public static string ViewAdjustments => I18NResource.GetString(ResourceDirectory, "ViewAdjustments");

		/// <summary>
		///View Opening Inventories
		/// </summary>
		public static string ViewOpeningInventories => I18NResource.GetString(ResourceDirectory, "ViewOpeningInventories");

		/// <summary>
		///View Opening Inventory Advice
		/// </summary>
		public static string ViewOpeningInventoryAdvice => I18NResource.GetString(ResourceDirectory, "ViewOpeningInventoryAdvice");

		/// <summary>
		///View Transfer
		/// </summary>
		public static string ViewTransfer => I18NResource.GetString(ResourceDirectory, "ViewTransfer");

		/// <summary>
		///View Transfers
		/// </summary>
		public static string ViewTransfers => I18NResource.GetString(ResourceDirectory, "ViewTransfers");

		/// <summary>
		///We only have {0} {1} in inventory
		/// </summary>
		public static string WeOnlyHaveInInventory => I18NResource.GetString(ResourceDirectory, "WeOnlyHaveInInventory");

	}
}
