using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace SAR_Helper.Pages
{
    public partial class EmployeeReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }       

        //LISTVIEW METHODS

        //Method retrieves data for ListView_EmployeeReport
        public IQueryable<Authy_Employee> ListView_EmployeeReport_GetData()
        {
            
            Authy_DataContext db = new Authy_DataContext();

            if (tb_search.Text.Trim() != "")
            {
                string searchText = tb_search.Text.Trim().ToLower();
                return db.Employees.Where(empx => empx.EmployeeFirstName.ToLower().Contains(searchText) || empx.EmployeeLastName.ToLower().Contains(searchText) || empx.EmployeeMemberNumber.ToString().Contains(tb_search.Text.Trim()) || empx.EmployeePersonNumber.ToString().Contains(tb_search.Text.Trim()));
            }
            else
            {
                return db.Employees.OrderBy(empX => empX.EmployeeFirstName);
            }
        }

        //Populates the inner-Listview inside ListView_EmployeeReport with employees' authorizations
        protected void ListView_EmployeeReport_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            HiddenField hf = (HiddenField)e.Item.FindControl("HiddenField_EmployeeID");
            ListView lv = (ListView)e.Item.FindControl("ListView_EmployeeAuthorizations");
            int empID = Convert.ToInt32(hf.Value);

            using (Authy_DataContext db = new Authy_DataContext())
            {
                List<Authy_Access> accessList = db.Accesses.Where(accessX => accessX.AccessEmployee.EmployeeID == empID).Where(accessX => accessX.AccessIsActive == true).ToList();
                lv.DataSource = accessList;
                lv.DataBind();

                Label lbl = (Label)ListView_EmployeeReport.FindControl("Label_EmployeeCount");
                if (db.Employees.Count() > 0)
                {
                    lbl.Text = db.Employees.Count().ToString() + " employee(s) total";
                }
            }


        }

        //Gets data for the ListView_EmployeeAuthorization sub-listview inside ListView_EmployeeReport
        public IQueryable<Authy_Access> ListView_EmployeeAuthorizations_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            HiddenField hf = (HiddenField)ListView_EmployeeReport.FindControl("HiddenField_EmployeeID");
            int employeeID = Convert.ToInt32(hf.Value);
            return db.Accesses.Where(accessX => accessX.AccessEmployee.EmployeeID == employeeID).Where(accessX => accessX.AccessIsActive == true);
        }


        //OTHER METHODS

        public string GetAuthorizationName(int accessID)
        {
            using(Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Access access = db.Accesses.Where(accessX => accessX.AccessID == accessID).FirstOrDefault();
                int authID = access.AccessAuthorization.AuthorizationID;
                Authy_Authorization auth = db.Authorizations.Where(authX => authX.AuthorizationID == authID).FirstOrDefault();
         
                return auth.AuthorizationName;
            }
        }

        public string CustomShortDateString(DateTime date)
        {
            if(date == new DateTime(9999, 12, 31))
            {
                return "";
            }
            else
            {
                return date.ToShortDateString();
            }
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<Authy.Models.Authy_Access> ListView_EmployeeAuthorizations_GetData1()
        {
            return null;
        }

        protected void BtnGenerate_Click(object sender, EventArgs e)
        {
            if (tb_search.Text.Trim() != "")
            {
                
                this.ListView_EmployeeReport.SelectMethod = "ListView_EmployeeReport_GetData";
            }
            this.ListView_EmployeeReport.DataBind();
        }
    }
}