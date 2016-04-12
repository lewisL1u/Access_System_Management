using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authy
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string name = HttpContext.Current.User.Identity.Name;
            //string p = Request.QueryString["a"];
            //string a = "";
            //System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert('Hello " + name + p + "')</SCRIPT>");
        }
    }
}