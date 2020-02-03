using CriderDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CriderDashboard.Reports
{
    public partial class Shippingdockboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<Statusdata> GetStatusdata()
        {
            CookDAO ObjDAO1 = new CookDAO();
            return ObjDAO1.GetStatusdata();
        }

        [WebMethod]
        public static List<Arriveddata> GetArriveddata()
        {
            CookDAO ObjDAO1 = new CookDAO();
            return ObjDAO1.GetArriveddata();
        }

        [WebMethod]
        public static List<InDoordata> GetInDoordata()
        {
            CookDAO ObjDAO1 = new CookDAO();
            return ObjDAO1.GetInDoordata();
        }
        [WebMethod]
        public static List<Shippingdockboarddata> GetShippingdockboard(Filters objRequest)
        {
            CookDAO ObjDAO1 = new CookDAO();
            return ObjDAO1.GetShippingdockboard(objRequest);
        }

        [WebMethod]
        public static int InsertShippingdockboard(Shippingdockboarddata objRequest)
        {
            CookDAO ObjDAO1 = new CookDAO();
            return ObjDAO1.InsertShippingdockboard(objRequest);
        }

        [WebMethod]
        public static int DeleteShippingdockboard(Shippingdockboarddata objRequest)
        {
            CookDAO ObjDAO1 = new CookDAO();
            return ObjDAO1.DeleteShippingdockboard(objRequest);
        }
    }
}