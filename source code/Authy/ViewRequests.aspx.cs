using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace Authy.Pages
{
    public partial class ViewSARs : System.Web.UI.Page
    {
        private Authy_Role role;
        private string username;
        protected void Page_Load(object sender, EventArgs e)
        {
            string loginName = HttpContext.Current.User.Identity.Name;
            username = loginName.Replace(@"OECU\", "");

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_User user = db.Users.Where(u => u.Username.Equals(username)).FirstOrDefault();
                if (user != null)
                {
                    role = user.Role;
                }
            }
        }


        //DropDownList Methods

        protected void DropDownList_Requests_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList_Requests.SelectedIndex == 0)
            {
                MultiView_ViewSARs.ActiveViewIndex = 0;
            }
            else if (DropDownList_Requests.SelectedIndex == 1)
            {
                MultiView_ViewSARs.ActiveViewIndex = 1;
            }
            else
            {
                MultiView_ViewSARs.ActiveViewIndex = 2;
            }
        }

        //LinkButton Methods

        protected void LinkButton_Unselect_Click(object sender, EventArgs e)
        {
            ListView_PendingRequests.SelectedIndex = -1;
        }

        protected void LinkButton_UnselectProcessed_Click(object sender, EventArgs e)
        {
            ListView_ProcessedRequests.SelectedIndex = -1;
        }


        protected void LinkButton_UnselectMy_Click(object sender, EventArgs e)
        {
            ListView_MyRequests.SelectedIndex = -1;
        }


        //ListView Methods

        public IQueryable<Authy.Models.Authy_Request> ListView_PendingRequests_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            List<Authy_Request> requests = null;
            if (role.RoleName.Equals("Supervisor"))
                requests = db.Requests.Where(requestX => requestX.ITStatus == "Pending" && requestX.Requester.Username == username).OrderByDescending(req => req.RequestDate).ToList();
            else
                requests = db.Requests.Where(requestX => requestX.ITStatus == "Pending").OrderByDescending(req => req.RequestDate).ToList();
            foreach (Authy_Request ar in requests)
            {
                if (role.RoleName.Equals("Supervisor"))
                {
                    if (!ar.Requester.Username.Equals(username))
                        requests.Remove(ar);
                }
                else if (role.RoleName.Equals("Executive"))
                {
                    if (!ar.ExecutiveStatus.Equals("Pending"))
                        requests.Remove(ar);
                }
                //else if(role.RoleName.Equals("IT")){

                //}
            }
            Label lbl = (Label)ListView_PendingRequests.FindControl("Label_ItemCount");

            if (requests.Count() > 0)
            {
                lbl.Text = requests.Count().ToString() + " pending request(s) total";
            }

            return requests.AsQueryable();

        }

        public IQueryable<Authy.Models.Authy_Request> ListView_ProccessedRequests_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            List<Authy_Request> requests = null;
            if (role.RoleName.Equals("Supervisor"))
                requests = db.Requests.Where(sarX => sarX.ITStatus != "Pending" && sarX.Requester.Username == username).OrderByDescending(req => req.RequestDate).ToList();
            else
                requests = db.Requests.Where(sarX => sarX.ITStatus != "Pending").OrderByDescending(req => req.RequestDate).ToList();
            foreach (Authy_Request ar in requests)
            {
                if (role.RoleName.Equals("Supervisor"))
                {
                    if (!ar.Requester.Username.Equals(username))
                    {
                        requests.Remove(ar);
                    }
                }
                else if (role.RoleName.Equals("Executive"))
                {
                    if (ar.ExecutiveStatus.Equals("Pending"))
                    {
                        requests.Remove(ar);
                    }
                }
            }
            Label lbl = (Label)ListView_ProcessedRequests.FindControl("Label_ItemCount");
            if (requests.Count > 0)
            {
                lbl.Text = requests.Count().ToString() + " requests total";
            }
            return requests.AsQueryable();
        }

        protected void ListView_ProcessedRequests_DataBound(object sender, EventArgs e)
        {
            //using (Authy_DataContext db = new Authy_DataContext())
            //{
            //    Label lbl = (Label)ListView_ProcessedRequests.FindControl("Label_ItemCount");
            //    if (db.Requests.Where(sarX => sarX.ITStatus != "Pending").Count() > 0)
            //    {
            //        lbl.Text = db.Requests.Where(requestX => requestX.ITStatus != "Pending").Count().ToString() + " request(s) total";
            //    }

            //}
        }

        public IQueryable<Authy.Models.Authy_Request> ListView_MyRequests_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            //string username = HttpContext.Current.User.Identity.Name.Replace(@"OECU\", "");

            IQueryable<Authy.Models.Authy_Request> rqs = db.Requests.Where(requestX => requestX.Requester.Username == username).OrderByDescending(req => req.RequestDate);
            return rqs;
        }

        protected void ListView_MyRequests_DataBound(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                //string username = HttpContext.Current.User.Identity.Name.Replace(@"OECU\", "");
                Label lbl = (Label)ListView_MyRequests.FindControl("Label_ItemCount");
                if (db.Requests.Where(requestX => requestX.Requester.Username == username).Count() > 0)
                {
                    lbl.Text = db.Requests.Where(requestX => requestX.Requester.Username == username).Count().ToString() + " request(s) total";
                }
            }
        }

        // Other Methods

        public int GetRequestEmployeeCount(int requestID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                return db.Requests.Where(requestX => requestX.RequestID == requestID).SelectMany(sarX => sarX.RequestedEmployees).Count();
            }
        }

        public string GetRequestAuthorizationCount(int requestID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Request request = db.Requests.Where(requestX => requestX.RequestID == requestID).FirstOrDefault();
                if (request.ARequestType.RequestTypeName.Contains(RequestTypeEnum.SAR.RequestTypeName) || request.ARequestType.RequestTypeName == RequestTypeEnum.SRR.RequestTypeName)
                {
                    return db.Requests.Where(sarX => sarX.RequestID == requestID).SelectMany(sarX => sarX.RequestedAuthorizations).Count().ToString();
                }
                else
                {
                    return "N/A";
                }

            }
        }

        public string getTerminatedStatus(int empID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();

                if (emp.EmployeeTerminationDate != new DateTime(9999, 12, 31))
                {
                    return "(Terminated)";
                }
                else
                {
                    return null;
                }
            }
        }

        public string GetTerminationDate(DateTime dt)
        {
            if (dt == new DateTime(9999, 12, 31))
            {
                return null;
            }
            else
            {
                return dt.ToShortDateString();
            }
        }





    }
}