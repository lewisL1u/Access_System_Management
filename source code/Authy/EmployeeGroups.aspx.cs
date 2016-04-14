using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace Authy.Pages
{
    public partial class EmployeeGroups : System.Web.UI.Page
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

                if(user.Role.ManageEmployees == true) { }
                else
                {
                    Response.Redirect("Unauthorized");
                }

            }
        }

        //Button Methods
        protected void Button_CreateGroup_Click(object sender, EventArgs e)
        {
            Label_CreateSuccess.Visible = false;
            Label_CreateDuplicateError.Visible = false;
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_EmployeeGroup group = new Authy_EmployeeGroup();
                group.EmployeeGroupName = TextBox_CreateGroup.Text;

                List<Authy_EmployeeGroup> groupList = db.EmployeeGroups.ToList();

                bool isDuplicateName = false;
                for (int i = 0; i < groupList.Count; i++)
                {
                    if (groupList[i].EmployeeGroupName.ToLower() == TextBox_CreateGroup.Text.ToLower())
                    {
                        isDuplicateName = true;
                        break;
                    }
                }
                if (isDuplicateName)
                {
                    Label_CreateDuplicateError.Visible = true;

                }
                else
                {
                    db.EmployeeGroups.Add(group);
                    db.SaveChanges();

                    ListView_Groups.DataBind();
                    Label_CreateSuccess.Visible = true;
                    Label_DeleteSuccess.Visible = false;
                    TextBox_CreateGroup.Text = "";
                }
            }
        }

        protected void Button_CancelDelete_Click(object sender, EventArgs e)
        {
            Panel panel_Edit = (Panel)ListView_Groups.EditItem.FindControl("Panel_Edit");
            Panel panel_Delete = (Panel)ListView_Groups.EditItem.FindControl("Panel_Delete");
            Panel panel_EditItem = (Panel)ListView_Groups.EditItem.FindControl("Panel_EditItem");

            panel_EditItem.CssClass = "block-gray";
            panel_Edit.Visible = true;
            panel_Delete.Visible = false;
        }


        //LinkButton Methods
        protected void LinkButton_Edit_Command(object sender, CommandEventArgs e)
        {
            Panel_EditEmployees.CssClass = "block-green";
            LinkButton_AddEmployee.Visible = true;
            LinkButton_RemoveEmployee.Visible = true;
            Label_ViewMode.Visible = false;
            Label_EditMode.Visible = true;

        }

        protected void LinkButton_Cancel_Command(object sender, CommandEventArgs e)
        {
            LinkButton_AddEmployee.Visible = false;
            LinkButton_RemoveEmployee.Visible = false;
            Panel_EditEmployees.CssClass = "block-default";
            Label_ViewMode.Visible = true;
            Label_EditMode.Visible = false;
        }

        protected void LinkButton_RemoveEmployee_Click(object sender, EventArgs e)
        {
            if (ListBox_Current.SelectedIndex > -1 && ListView_Groups.EditIndex > -1)
            {
                ListBox_Current.Items.RemoveAt(ListBox_Current.SelectedIndex);
            }
        }

        protected void LinkButton_AddEmployee_Click(object sender, EventArgs e)
        {
            if (ListBox_Available.SelectedIndex > -1 && ListView_Groups.EditIndex > -1)
            {
                if (!ListBox_Current.Items.Contains(ListBox_Available.SelectedItem))
                {
                    ListBox_Current.Items.Add(ListBox_Available.SelectedItem);
                    ListBox_Available.SelectedIndex = -1;
                }
                else
                {
                    Label_DuplicateError.Visible = true;
                }

            }
        }

        protected void LinkButton_Save_Command(object sender, CommandEventArgs e)
        {
            Panel panel_EditItem = (Panel)ListView_Groups.EditItem.FindControl("Panel_EditItem");

            panel_EditItem.CssClass = "block-gray";
            Panel_EditEmployees.CssClass = "block-default";

            Label_ViewMode.Visible = true;
            Label_EditMode.Visible = false;
        }

        protected void LinkButton_Delete_Click(object sender, EventArgs e)
        {
            Panel panel_Edit = (Panel)ListView_Groups.EditItem.FindControl("Panel_Edit");
            Panel panel_Delete = (Panel)ListView_Groups.EditItem.FindControl("Panel_Delete");

            panel_Edit.Visible = false;
            panel_Delete.Visible = true;
        }

        //ListBox Methods

        public IQueryable<Authy_Employee> ListBox_Available_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            IQueryable<Authy_Employee> ems = db.Employees.Where(emp => emp.EmployeeTerminationDate.Equals(new DateTime(9999,12,31))).OrderBy(empX => empX.EmployeeLastName);
            return ems;
        }

        public IQueryable<Authy_Employee> ListBox_Current_GetData()
        {
            if (ListView_Groups.SelectedIndex > -1)
            {
                Authy_DataContext db = new Authy_DataContext();
                int groupID = (int)ListView_Groups.SelectedValue;
                return db.EmployeeGroups.Where(groupX => groupX.EmployeeGroupID == groupID).SelectMany(groupX => groupX.GroupEmployees).OrderBy(empX => empX.EmployeeLastName);
            }
            else{
                return null;
            }
        }

        protected void ListBox_Available_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ListView_Groups.SelectedIndex > -1)
            {
                Label_DuplicateError.Visible = false;
                Label_UpdateSuccess.Visible = false;
                Label_CreateSuccess.Visible = false;
                Label_CreateDuplicateError.Visible = false;
                Label_DeleteSuccess.Visible = false;
                this.ListBox_Available.Focus();

            }

        }

        protected void ListBox_Current_SelectedIndexChanged(object sender, EventArgs e)
        {
             if (ListView_Groups.SelectedIndex > -1)
            {
                Label_DuplicateError.Visible = false;
                Label_UpdateSuccess.Visible = false;
                Label_CreateSuccess.Visible = false;
                Label_CreateDuplicateError.Visible = false;
                Label_DeleteSuccess.Visible = false;
                this.ListBox_Current.Focus();
            }
            
            
        }

        protected void ListBox_Current_DataBound(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp;
                for (int i = 0; i < ListBox_Current.Items.Count; i++)
                {
                    int empID = Convert.ToInt32(ListBox_Current.Items[i].Value);
                    emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();

                    if (emp.EmployeeTerminationDate.ToShortDateString() == "12/31/9999")
                    {
                        ListBox_Current.Items[i].Text = emp.EmployeeFirstName + " " + emp.EmployeeLastName + " (" + emp.EmployeeMemberNumber + ")";
                    }
                }
            }
        }

        protected void ListBox_Available_DataBound(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp;
                for (int i = 0; i < ListBox_Available.Items.Count; i++)
                {
                    int empID = Convert.ToInt32(ListBox_Available.Items[i].Value);
                    emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();

                    if (emp.EmployeeTerminationDate.ToShortDateString() == "12/31/9999")
                    {
                        ListBox_Available.Items[i].Text = emp.EmployeeFirstName + " " + emp.EmployeeLastName + " (" + emp.EmployeeMemberNumber + ")";
                    }
                }
            }
        }


        //ListView Methods
        public IQueryable<Authy.Models.Authy_EmployeeGroup> ListView_Groups_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.EmployeeGroups;
        }

        protected void ListView_Groups_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListView_Groups.EditIndex = -1;
            ListBox_Current.Items.Clear();
            Label_DuplicateError.Visible = false;
            Label_UpdateSuccess.Visible = false;
            Panel_EditEmployees.CssClass = "block-default";

            ListBox_Current.DataBind();

        }

        public void ListView_Groups_UpdateItem(int EmployeeGroupID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy.Models.Authy_EmployeeGroup item = null;
                item = db.EmployeeGroups.Where(groupX => groupX.EmployeeGroupID == EmployeeGroupID).FirstOrDefault();
                if (item == null)
                {
                    // The item wasn't found
                    ModelState.AddModelError("", String.Format("Item with id {0} was not found", EmployeeGroupID));
                    return;
                }
                db.Entry(item).Collection(groupx => groupx.GroupEmployees).Load();
                TryUpdateModel(item);
                if (ModelState.IsValid)
                {
                    List<Authy_Employee> empList = db.EmployeeGroups.Where(groupX => groupX.EmployeeGroupID == EmployeeGroupID).SelectMany(groupX => groupX.GroupEmployees).ToList();
                    //Checks for new employees
                    for (int i = 0; i < ListBox_Current.Items.Count; i++)
                    {
                        int employeeID = Convert.ToInt32(ListBox_Current.Items[i].Value);
                        Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == employeeID).FirstOrDefault();
                        
                        if (!empList.Contains(emp))
                        {
                            item.GroupEmployees.Add(emp);
                        }

                    }

                    //Checks for removed employees
                    for (int i = 0; i < empList.Count; i++)
                    {
                        ListItem listItem = new ListItem();
                        listItem.Value = empList[i].EmployeeID.ToString();
                        listItem.Text = empList[i].EmployeeFirstName + " " + empList[i].EmployeeLastName;
                        int empId = empList[i].EmployeeID;
                        Authy_Employee emp = db.Employees.Where(em => em.EmployeeID == empId).FirstOrDefault();

                        if (!ListBox_Current.Items.Contains(listItem))
                        {
                            item.GroupEmployees.Remove(emp);
                        }
                    }
                    // Save changes here, e.g. MyDataLayer.SaveChanges();
                    db.SaveChanges();
                }
            }
            Label_UpdateSuccess.Visible = true;
        }

        public void ListView_Groups_DeleteItem(int EmployeeGroupID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_EmployeeGroup group = db.EmployeeGroups.Where(groupX => groupX.EmployeeGroupID == EmployeeGroupID).FirstOrDefault();
                db.EmployeeGroups.Remove(group);
                db.SaveChanges();
            }

            Label_DeleteSuccess.Visible = true;
            Panel_EditEmployees.CssClass = "block-gray";
        }

        //Other Methods
        public int GetNumberOfEmployees(string groupID)
        {
            int id = Convert.ToInt32(groupID);
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_EmployeeGroup group = db.EmployeeGroups.Where(groupX => groupX.EmployeeGroupID == id).FirstOrDefault();
                if (group.GroupEmployees != null)
                {
                    return db.EmployeeGroups.Where(groupX => groupX.EmployeeGroupID == id).SelectMany(groupX => groupX.GroupEmployees).Count();
                }
                else
                {
                    return 0;
                }
            }
        }
      
    }
}