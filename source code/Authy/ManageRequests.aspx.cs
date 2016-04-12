using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;
using Authy.Helper;
using Authy.UserControl;

namespace Authy.Pages
{
    public partial class ManageRequests : System.Web.UI.Page
    {
        private Authy_User loginUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckRole();
            
        }

        //Authentication Method
        protected void CheckRole()
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                string loginName = HttpContext.Current.User.Identity.Name;
                string username = loginName.Replace("OECU\\", "");
                loginUser = db.Users.Where(userX => userX.Username == username).FirstOrDefault();

                if (loginUser.Role.ManageRequests_Initial == false && loginUser.Role.ManageRequests_Final == false)
                {
                    Response.Redirect("ViewRequests");
                }

            }
        }

        //Label Methods
        protected void Label_ItemCount_PreRender(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lbl = (Label)sender;
                string userName = HttpContext.Current.User.Identity.Name;

                Authy_User user = db.Users.Where(userX => userX.Username == userName).FirstOrDefault();

                if (db.Requests.Where(requestX => requestX.ITStatus == "Pending") != null)
                {
                    lbl.Text = db.Requests.Where(requestX => requestX.ITStatus == "Pending").Count().ToString() + " pending Request(s) total.";
                }
           
            }
        }

        //ListView Methods

        public IQueryable<Authy.Models.Authy_Request> ListView_PendingRequests_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
                List<Authy_Request> requests = db.Requests.Where(requestX => requestX.ITStatus == "Pending").ToList();
                foreach (Authy_Request ar in requests)
                {
                    if (loginUser.Role.RoleName.Equals("Executive"))
                    {
                        if (!ar.ExecutiveStatus.Equals("Pending"))
                        {
                            requests.Remove(ar);
                        }
                    }
                }
                
                return requests.AsQueryable();
     
        }

        protected void ListView_PendingRequests_DataBound(object sender, EventArgs e)
        {


        }

        

        public int GetRequestEmployeeCount(int RequestID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                return db.Requests.Where(requestX => requestX.RequestID == RequestID).SelectMany(requestX => requestX.RequestedEmployees).Count();
            }
        }

        public int GetRequestAuthorizationCount(int RequestID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                return db.Requests.Where(requestX => requestX.RequestID == RequestID).SelectMany(requestX => requestX.RequestedAuthorizations).Count();
            }
        }

        protected void RequestInforUC_AproveClick(object sender, EventArgs e)
        {
            ListView_PendingRequests.SelectedIndex = -1;
            ListView_PendingRequests.DataBind();
        }

        protected void RequestInforUC_DeclineClick(object sender, EventArgs e)
        {
            ListView_PendingRequests.SelectedIndex = -1;
            ListView_PendingRequests.DataBind();
        }
    }
}