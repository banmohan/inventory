using Frapid.Dashboard;
using System.Web.Mvc;

namespace MixERP.Inventory.Controllers.Backend.Setup
{
    public class InventoryItemController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/inventory-items")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/InventoryItems.cshtml", this.Tenant));
        }
    }
    public class ItemGroupController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/item-groups")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/ItemGroups.cshtml", this.Tenant));
        }
    }
    public class ItemTypeController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/item-types")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/ItemTypes.cshtml", this.Tenant));
        }
    }
    public class StoreTypeController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/store-types")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/StoreTypes.cshtml", this.Tenant));
        }
    }
    public class StoreController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/stores")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Stores.cshtml", this.Tenant));
        }
    }
    public class CounterController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/counters")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Counters.cshtml", this.Tenant));
        }
    }
    public class CustomerTypeController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/customer-types")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/CustomerTypes.cshtml", this.Tenant));
        }
    }
    public class SupplierTypeController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/supplier-types")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/SupplierTypes.cshtml", this.Tenant));
        }
    }
    public class CustomerController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/customers")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Customers.cshtml", this.Tenant));
        }
    }
    public class SupplierController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/suppliers")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Suppliers.cshtml", this.Tenant));
        }
    }
    public class BrandController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/brands")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Brands.cshtml", this.Tenant));
        }
    }
    public class UnitsOfMeasureController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/units-of-measure")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/UnitsOfMeasure.cshtml", this.Tenant));
        }
    }
    public class CompoundUnitsOfMeasureController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/compound-units-of-measure")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/CompoundUnitsOfMeasure.cshtml", this.Tenant));
        }
    }
    public class ShipperController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/shippers")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Shippers.cshtml", this.Tenant));
        }
    }
    public class AttributeController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/attributes")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Attributes.cshtml", this.Tenant));
        }
    }
    public class VariantController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/variants")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/Variants.cshtml", this.Tenant));
        }
    }
    public class ItemVariantController : InventoryBackendController
    {
        [Route("dashboard/inventory/setup/item-variants")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Setup/ItemVariants.cshtml", this.Tenant));
        }
    }
}