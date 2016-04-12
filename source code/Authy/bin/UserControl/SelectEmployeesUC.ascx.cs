using Authy.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authy.UserControl
{
    public partial class SelectEmployeesUC : System.Web.UI.UserControl
    {
        public ListBox ListBoxSelectedEmployees;
        public Label LabelNoEmployees;
        protected void Page_Load(object sender, EventArgs e)
        {
            ListBoxSelectedEmployees = this.ListBox_SelectedEmployees;
            LabelNoEmployees = this.Label_NoEmployees;
        }

        //ListBox Methods

        public IQueryable<Authy_Employee> ListBox_Employees_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.Employees.Where(emp => emp.EmployeeTerminationDate.Equals(new DateTime(9999, 12, 31))).OrderBy(empX => empX.EmployeeFirstName);
        }

        protected void ListBox_Employees_DataBound(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Employee emp;
                for (int i = 0; i < ListBox_Employees.Items.Count; i++)
                {
                    int empID = Convert.ToInt32(ListBox_Employees.Items[i].Value);
                    emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();

                    if (emp.EmployeeTerminationDate.ToShortDateString() != "12/31/9999")
                    {
                        ListBox_Employees.Items[i].Text = emp.EmployeeFirstName + " " + emp.EmployeeLastName + " (Terminated, " + emp.EmployeeMemberNumber + ")";
                    }
                    else
                    {
                        ListBox_Employees.Items[i].Text = emp.EmployeeFirstName + " " + emp.EmployeeLastName + " (" + emp.EmployeeMemberNumber + ")";
                    }
                }
            }

        }

        protected void ListBox_Employees_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                int empID = Convert.ToInt32(ListBox_Employees.SelectedValue);
                Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();

                Label_EmployeeFirstName.Text = emp.EmployeeFirstName;
                Label_EmployeeMiddleName.Text = emp.EmployeeMiddleName;
                Label_EmployeeLastName.Text = emp.EmployeeLastName;
                Label_EmployeeMemberNumber.Text = emp.EmployeeMemberNumber.ToString();
                Label_EmployeePersonNumber.Text = emp.EmployeePersonNumber.ToString();
                Label_EmployeeTitle.Text = emp.EmployeeTitle;
                Label_EmployeeBranch.Text = emp.EmployeeBranch;
                Label_EmployeeHireDate.Text = emp.EmployeeHireDate.ToShortDateString();


                if (emp.EmployeeTerminationDate.ToShortDateString() == "12/31/9999")
                {
                    Label_EmployeeTerminationDate.Text = "N/A";
                }
                else
                {
                    Label_EmployeeTerminationDate.Text = emp.EmployeeTerminationDate.ToShortDateString();
                }
            }
            HideMessageLabels();
            ListView_Accesses.DataBind();
            ListBox_Employees.Focus();
        }

        //Button

        protected void Button_SelectEmployee_Click(object sender, EventArgs e)
        {
            if (!ListBox_SelectedEmployees.Items.Contains(ListBox_Employees.SelectedItem) && ListBox_Employees.SelectedIndex > -1)
            {
                ListBox_SelectedEmployees.Items.Add(ListBox_Employees.SelectedItem);
                ListBox_Employees.SelectedIndex = -1;
                ListBox_SelectedEmployees.Focus();
                HideMessageLabels();
                Label_Create_SelectedEmployeeCount.Text = ListBox_SelectedEmployees.Items.Count.ToString() + " selected employee(s).";

            }
            else if (ListBox_SelectedEmployees.Items.Contains(ListBox_Employees.SelectedItem))
            {
                Label_SelectEmployee.Text = "* This employee is already selected.";
                Label_SelectEmployee.Visible = true;
            }
            else
            {
                Label_SelectEmployee.Text = "* Please select an employee.";
                Label_SelectEmployee.Visible = true;
            }
        }

        public void HideMessageLabels()
        {
            Label_SelectEmployee.Visible = false;
            //Label_SelectAuthorization.Visible = false;
            Label_NoEmployees.Visible = false;
            //Label_NoAuthorizations.Visible = false;
        }

        //DropDownList Methods

        public IQueryable<Authy_EmployeeGroup> DropDownList_EmployeeGroup_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.EmployeeGroups.OrderBy(empGroupX => empGroupX.EmployeeGroupName);
        }

        protected void DropDownList_EmployeeGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListView_EmployeeGroup.DataBind();
        }

        protected void Button_SelectEmployeeGroup_Click(object sender, EventArgs e)
        {
            if (DropDownList_EmployeeGroup.SelectedIndex > -1)
            {
                using (Authy_DataContext db = new Authy_DataContext())
                {
                    int empGroupID = Convert.ToInt32(DropDownList_EmployeeGroup.SelectedValue);
                    List<Authy_Employee> empList = db.EmployeeGroups.Where(empGroupX => empGroupX.EmployeeGroupID == empGroupID).SelectMany(empGroupX => empGroupX.GroupEmployees).OrderBy(empX => empX.EmployeeLastName).ToList();

                    for (int i = 0; i < empList.Count; i++)
                    {
                        ListItem listItem = ListBox_Employees.Items.FindByValue(empList[i].EmployeeID.ToString());

                        if (!ListBox_SelectedEmployees.Items.Contains(listItem))
                        {
                            ListBox_SelectedEmployees.Items.Add(listItem);
                            ListBox_SelectedEmployees.Focus();
                            HideMessageLabels();
                        }
                        else
                        {
                            Label_EmployeeGroup.Text = "* This employee " + empList[i].EmployeeLastName + ", " + empList[i].EmployeeFirstName + " is already selected.";
                            Label_EmployeeGroup.Visible = true;
                        }
                    }
                    Label_Create_SelectedEmployeeCount.Text = ListBox_SelectedEmployees.Items.Count.ToString() + " selected employee(s).";

                }
            }
            else
            {
                Label_EmployeeGroup.Text = "* Please select an employee group.";
                Label_EmployeeGroup.Visible = true;
            }
        }

        protected void ListBox_SelectedEmployees_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                int empID = Convert.ToInt32(ListBox_SelectedEmployees.SelectedValue);
                Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();

                Label_SelectedEmployeeFirstName.Text = emp.EmployeeFirstName;
                Label_SelectedEmployeeMiddleName.Text = emp.EmployeeMiddleName;
                Label_SelectedEmployeeLastName.Text = emp.EmployeeLastName;
                Label_SelectedEmployeeMemberNumber.Text = emp.EmployeeMemberNumber.ToString();
                Label_SelectedEmployeePersonNumber.Text = emp.EmployeePersonNumber.ToString();
                Label_SelectedEmployeeTitle.Text = emp.EmployeeTitle;
                Label_SelectedEmployeeBranch.Text = emp.EmployeeBranch;
                Label_SelectedEmployeeHireDate.Text = emp.EmployeeHireDate.ToShortDateString();


                if (emp.EmployeeTerminationDate.ToShortDateString() == "12/31/9999")
                {
                    Label_SelectedEmployeeTerminationDate.Text = "N/A";
                }
                else
                {
                    Label_SelectedEmployeeTerminationDate.Text = emp.EmployeeTerminationDate.ToShortDateString();
                }
            }
            HideMessageLabels();
            ListView_EmployeeAccesses.DataBind();
            ListBox_SelectedEmployees.Focus();
        }

        protected void Button_DeselectEmployee_Click(object sender, EventArgs e)
        {
            if (ListBox_SelectedEmployees.SelectedIndex > -1)
            {
                ListBox_SelectedEmployees.Items.Remove(ListBox_SelectedEmployees.SelectedItem);
                Label_SelectedEmployeeFirstName.Text = "";
                Label_SelectedEmployeeMiddleName.Text = "";
                Label_SelectedEmployeeLastName.Text = "";
                Label_SelectedEmployeeMemberNumber.Text = "";
                Label_SelectedEmployeePersonNumber.Text = "";
                Label_SelectedEmployeeTitle.Text = "";
                Label_SelectedEmployeeBranch.Text = "";
                Label_SelectedEmployeeHireDate.Text = "";
                Label_Create_SelectedEmployeeCount.Text = ListBox_SelectedEmployees.Items.Count.ToString() + " selected employee(s).";
            }

        }

        public IQueryable<Authy_Access> ListView_Accesses_GetData()
        {
            if (ListBox_Employees.SelectedIndex > -1)
            {
                Authy_DataContext db = new Authy_DataContext();

                int empID = Convert.ToInt32(ListBox_Employees.SelectedValue);

                IQueryable<Authy_Access> query = db.Accesses.Where(accessX => accessX.AccessEmployee.EmployeeID == empID);

                IQueryable<Authy_Access> queryActive = query.Where(accessX => accessX.AccessIsActive == true);

                return queryActive.OrderBy(accessX => accessX.AccessAuthorization.AuthorizationName);
            }
            else
            {
                return null;
            }

        }

        public IQueryable<Authy.Models.Authy_Employee> ListView_EmployeeGroup_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            if (DropDownList_EmployeeGroup.SelectedIndex != -1)
            {
                int empGroupID = Convert.ToInt32(DropDownList_EmployeeGroup.SelectedValue);
                List<Authy_Employee> emps = db.EmployeeGroups.Where(empGroupX => empGroupX.EmployeeGroupID == empGroupID).SelectMany(empGroupX => empGroupX.GroupEmployees).Where(emp => emp.EmployeeTerminationDate == new DateTime(9999, 12, 31)).ToList();

                return emps.AsQueryable();
            }

            else
            {
                return null;
            }
        }

        public IQueryable<Authy.Models.Authy_Access> ListView_EmployeeAccesses_GetData()
        {
            if (ListBox_SelectedEmployees.SelectedIndex > -1)
            {
                Authy_DataContext db = new Authy_DataContext();

                int empID = Convert.ToInt32(ListBox_SelectedEmployees.SelectedValue);

                IQueryable<Authy_Access> query = db.Accesses.Where(accessX => accessX.AccessEmployee.EmployeeID == empID);

                IQueryable<Authy_Access> queryActive = query.Where(accessX => accessX.AccessIsActive == true);

                return queryActive.OrderBy(accessX => accessX.AccessAuthorization.AuthorizationName);
            }
            else
            {
                return null;
            }
        }

        
        //Other Methods

        public string IsTerminated(DateTime dt)
        {
            if (dt != new DateTime(9999, 12, 31))
            {
                return " (Terminated)";
            }
            else
            {
                return null;
            }
        }


        public string GetAccessAuthorizationName(int accID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Access acc = db.Accesses.Where(accX => accX.AccessID == accID).FirstOrDefault();
                return acc.AccessAuthorization.AuthorizationName;
            }
        }


    }
}