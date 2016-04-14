using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace Authy.Pages
{
    public partial class Employees : System.Web.UI.Page
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
                string username = HttpContext.Current.User.Identity.Name.Replace("OECU\\","");
                Authy_User user = db.Users.Where(userX => userX.Username == username).FirstOrDefault();

                if (user.Role.ManageEmployees == true) { }
                else
                {
                    Response.Redirect("/Unauthorized");
                }

            }
        }

        //Button Methods


        protected void Button_Create_Click(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee newEmp = new Authy_Employee();
                newEmp.EmployeeFirstName = TextBox_FirstName.Text;
                newEmp.EmployeeMiddleName = TextBox_MiddleName.Text;
                newEmp.EmployeeLastName = TextBox_LastName.Text;
                newEmp.EmployeeMemberNumber = Convert.ToInt64(TextBox_MemberNumber.Text);
                newEmp.EmployeePersonNumber = Convert.ToInt32(TextBox_PersonNumber.Text);
                newEmp.EmployeeTitle = TextBox_Title.Text;
                newEmp.EmployeeBranch = TextBox_Branch.Text;
                newEmp.EmployeeHireDate = Convert.ToDateTime(TextBox_HireDate.Text);

                if (TextBox_TerminationDate.Text != "")
                {
                    newEmp.EmployeeTerminationDate = Convert.ToDateTime(TextBox_TerminationDate.Text);
                }
                else
                {
                    newEmp.EmployeeTerminationDate = new DateTime(9999, 12, 31);
                }

                db.Employees.Add(newEmp);
                db.SaveChanges();

                ListView_Employees.DataBind();

                TextBox_FirstName.Text = "";
                TextBox_MiddleName.Text = "";
                TextBox_LastName.Text = "";
                TextBox_MemberNumber.Text = "";
                TextBox_Title.Text = "";
                TextBox_Branch.Text = "";
                TextBox_HireDate.Text = "";
                TextBox_TerminationDate.Text = "";
            }

            Label_CreateMessage.Text = "Employee created successfully!";
            Label_CreateMessage.Visible = true;
        }

        //LinkButton Method

        protected void LinkButton_Delete_Click(object sender, EventArgs e)
        {
            Panel panel_Edit = (Panel)ListView_Employees.EditItem.FindControl("Panel_Edit");
            Panel panel_Delete = (Panel)ListView_Employees.EditItem.FindControl("Panel_Delete");

            panel_Edit.Visible = false;
            panel_Delete.Visible = true;
        }

        protected void LinkButton_CancelDelete_Click(object sender, EventArgs e)
        {
            Panel panel_Edit = (Panel)ListView_Employees.EditItem.FindControl("Panel_Edit");
            Panel panel_Delete = (Panel)ListView_Employees.EditItem.FindControl("Panel_Delete");

            panel_Edit.Visible = true;
            panel_Delete.Visible = false;
        }

        protected void LinkButton_NewEmployee_Click(object sender, EventArgs e)
        {
            LinkButton_NewEmployee.ForeColor = System.Drawing.Color.Gray;
            LinkButton_EditEmployee.ForeColor = System.Drawing.Color.YellowGreen;

            LinkButton_NewEmployee.CssClass = "btn btn-default btn-block active";
            LinkButton_EditEmployee.CssClass = "btn btn-default btn-block";

            MultiView_Employees.ActiveViewIndex = 1;
        }

        protected void LinkButton_EditEmployee_Click(object sender, EventArgs e)
        {
            LinkButton_NewEmployee.ForeColor = System.Drawing.Color.YellowGreen;
            LinkButton_EditEmployee.ForeColor = System.Drawing.Color.Gray;

            LinkButton_NewEmployee.CssClass = "btn btn-default btn-block";
            LinkButton_EditEmployee.CssClass = "btn btn-default btn-block active";

            MultiView_Employees.ActiveViewIndex = 0;
        }

        protected void LinkButton_Unselect_Click(object sender, EventArgs e)
        {
            ListView_Employees.SelectedIndex = -1;
        }


        //ListView Methods

        public IQueryable<Authy.Models.Authy_Employee> ListView_Employees_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();

            return db.Employees;
        }

        protected void ListView_Employees_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListView_Employees.EditIndex = -1;
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListView_Employees_DeleteItem(int EmployeeID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp = new Authy_Employee();

                emp = db.Employees.Where(empX => empX.EmployeeID == EmployeeID).FirstOrDefault();
                emp.EmployeeTerminationDate = DateTime.Now;

                db.SaveChanges();
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListView_Employees_UpdateItem(int EmployeeID)
        {
            Authy.Models.Authy_Employee item = null;
            Authy_DataContext db = new Authy_DataContext();
            item = db.Employees.Where(empX => empX.EmployeeID == EmployeeID).FirstOrDefault();
            // Load the item here, e.g. item = MyDataLayer.Find(id);
            if (item == null)
            {
                // The item wasn't found
                ModelState.AddModelError("", String.Format("Item with id {0} was not found", EmployeeID));
                return;
            }
            TryUpdateModel(item);
            if (ModelState.IsValid)
            {
                TextBox tb_EditFirstName = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditFirstName");
                TextBox tb_EditMiddleName = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditMiddleName");
                TextBox tb_EditLastName = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditLastName");
                TextBox tb_EditTitle = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditTitle");
                TextBox tb_EditBranch = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditBranch");
                TextBox tb_EditHireDate = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditHireDate");
                TextBox tb_EditTermDate = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditTermDate");
                TextBox tb_EditMemberNumber = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditMemberNumber");
                TextBox tb_EditPersonNumber = (TextBox)ListView_Employees.EditItem.FindControl("TextBox_EditPersonNumber");

                item.EmployeeFirstName = tb_EditFirstName.Text;
                item.EmployeeMiddleName = tb_EditMiddleName.Text;
                item.EmployeeLastName = tb_EditLastName.Text;
                item.EmployeeTitle = tb_EditTitle.Text;
                item.EmployeeBranch = tb_EditBranch.Text;
                item.EmployeeHireDate = Convert.ToDateTime(tb_EditHireDate.Text);
                item.EmployeeMemberNumber = Convert.ToInt64(tb_EditMemberNumber.Text);
                item.EmployeePersonNumber = Convert.ToInt32(tb_EditPersonNumber.Text);
                DateTime dt;
                if (tb_EditTermDate.Text != null && DateTime.TryParse(tb_EditTermDate.Text, out dt))
                {
                    item.EmployeeTerminationDate = dt;
                }
                else
                {
                    item.EmployeeTerminationDate = new DateTime(9999, 12, 31);
                }

                // Save changes here, e.g. MyDataLayer.SaveChanges();
                db.SaveChanges();

            }
        }

        protected void ListView_Employees_Sorted(object sender, EventArgs e)
        {
            ListView_Employees.SelectedIndex = -1;
        }

        protected void ListView_Employees_DataBound(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lbl = (Label)ListView_Employees.FindControl("Label_EmployeeCount");
                if (db.Employees.Count() > 0)
                {
                    lbl.Text = db.Employees.Count().ToString() + " employee(s) total";
                }
            }
        }

        //Other Methods

        public string GetHireDate(int employeeID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == employeeID).FirstOrDefault();

                if (emp.EmployeeHireDate != new DateTime(9999, 12, 31))
                {
                    return emp.EmployeeHireDate.ToString("yyyy-MM-dd");
                }
                else
                {
                    return "N/A";
                }
            }
        }

        public string GetTerminatedDate(int employeeID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == employeeID).FirstOrDefault();

                if (emp.EmployeeTerminationDate != new DateTime(9999, 12, 31))
                {
                    return emp.EmployeeTerminationDate.ToString("yyyy-MM-dd");
                }
                else
                {
                    return "N/A";
                }
            }
        }

        public string IsTerminatedText(int employeeID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == employeeID).FirstOrDefault();

                if (emp.EmployeeTerminationDate != new DateTime(9999, 12, 31))
                {
                    return " (Terminated)";
                }
                else
                {
                    return "";
                }
            }
        }

       

     

    }
}