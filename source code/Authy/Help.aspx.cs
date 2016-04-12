using Authy.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authy
{
    public partial class Help : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                string username = HttpContext.Current.User.Identity.Name;
                Authy_User user = db.Users.Where(userX => userX.Username == username).FirstOrDefault();

                //sar.Visible = user.Role.NewSAR;
                ////etr.Visible = user.Role.NewETR;
                //viewRequest.Visible = user.Role.ViewRequests;
                //manageRequest.Visible = (user.Role.ManageRequests_Initial || user.Role.ManageRequests_Final);
                //authorReports.Visible = emlReports.Visible = user.Role.ViewReports;
                //manageAuth.Visible = user.Role.ManageAuthorizations;
                //manageAuthGroup.Visible = user.Role.ManageAuthorizationGroups;
                //manageEmp.Visible = user.Role.ManageEmployees;
                //manageEmpGroup.Visible = user.Role.ManageEmployeeGroups;
                //manageUser.Visible = user.Role.ManageUsers;
                //manageRoles.Visible = user.Role.ManageRoles;
            }
        }
    }
}