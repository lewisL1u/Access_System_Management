using Authy.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authy
{
    public partial class ResultPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckRole();
        }

        //Authentication Method
        protected void CheckRole()
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                string username = HttpContext.Current.User.Identity.Name;
                Authy_User user = db.Users.Where(userX => userX.Username == username).FirstOrDefault();

                if (user.Role.ManageRequests_Initial == false && user.Role.ManageRequests_Final == false)
                {
                    Response.Redirect("Unauthorized");
                }
                else
                {
                    resultLabel.Text = Request.QueryString["resultMessages"];
                }

            }
        }
    }
}