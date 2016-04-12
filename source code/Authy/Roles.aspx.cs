using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;
//using Authy.UserControl;

namespace Authy.Pages
{
    public partial class Roles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckRole();
            Label_DeleteSuccess.Visible = false;
            Label_EditSuccess.Visible = false;
            
        }

        //Authentication Method
        protected void CheckRole()
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                string username = HttpContext.Current.User.Identity.Name.Replace("OECU\\","");
                Authy_User user = db.Users.Where(userX => userX.Username == username).FirstOrDefault();

                if (user.Role.ManageUsers == true) { }
                else
                {
                    Response.Redirect("Unauthorized");
                }
            }
        }

        //Button Methods

        protected void Button_Create_Click(object sender, EventArgs e)
        {
           using(Authy_DataContext db = new Authy_DataContext())
            {
                string roleName = Textbox_RoleName.Text;
                if (db.Roles.Where(roleX => roleX.RoleName == roleName).Count() == 0)
                {
                    Authy_Role role = new Authy_Role();
                    role.RoleName = Textbox_RoleName.Text;

                    if (CheckBox_NewSAR.Checked == true)
                    {
                        role.NewSAR = true;
                    }

                    if (CheckBox_NewSRR.Checked == true)
                    {
                        role.NewSRR = true;
                    }

                    if (CheckBox_NewETR.Checked == true)
                    {
                        role.NewETR = true;
                    }

                    if (CheckBox_ViewRequests.Checked == true)
                    {
                        role.ViewRequests = true;
                    }

                    if (CheckBox_ManageRequests_Initial.Checked == true)
                    {
                        role.ManageRequests_Initial = true;
                    }

                    if (CheckBox_ManageRequests_Final.Checked == true)
                    {
                        role.ManageRequests_Final = true;
                    }

                    if (CheckBox_Authorizations.Checked == true)
                    {
                        role.ManageAuthorizations = true;
                    }

                    if (CheckBox_AuthorizationGroups.Checked == true)
                    {
                        role.ManageAuthorizationGroups = true;
                    }

                    if (CheckBox_Employees.Checked == true)
                    {
                        role.ManageEmployees = true;
                    }

                    if (CheckBox_EmployeeGroups.Checked == true)
                    {
                        role.ManageEmployeeGroups = true;
                    }

                    if (CheckBox_Users.Checked == true)
                    {
                        role.ManageUsers = true;
                    }

                    if (CheckBox_Roles.Checked == true)
                    {
                        role.ManageRoles = true;
                    }

                    db.Roles.Add(role);
                    db.SaveChanges();

                    Response.Redirect("Roles");
                }
                else
                {
                    Label_DuplicateRole.Visible = true;
                }
                
            }
        }

        //DropDownList Methods

        protected IQueryable<Authy_Role> DropDownList_EditRole_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();

            return db.Roles;
        }

        protected void DropDownList_EditRole_Load(object sender, EventArgs e)
        {
         

        }

        protected void DropDownList_EditRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;

        }

        //Label Methods

        protected void LVLabel_NewSAR_Load(object sender, EventArgs e)
        {
            using(Authy_DataContext db = new Authy_DataContext()){
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if(role.NewSAR == true){
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_NewSRR_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.NewSRR == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_NewETR_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.NewETR == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_ViewRequests_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ViewRequests == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_ManageRequests_Initial_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageRequests_Initial == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_ManageRequests_Final_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageRequests_Final == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_Reports_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ViewReports == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_Authorizations_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageAuthorizations == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_AuthorizationGroups_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageAuthorizationGroups == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_Employees_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageEmployees == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_EmployeeGroups_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageEmployeeGroups == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }

        protected void LVLabel_Users_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageUsers == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }


        protected void LVLabel_Roles_Load(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Label lb = (Label)sender;
                int roleID = (int)ListView_Roles.SelectedValue;
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.ManageRoles == true)
                {
                    lb.ForeColor = System.Drawing.Color.YellowGreen;
                }
            }
        }    






        //LinkButton Methods

        protected void LinkButton_Delete_Click(object sender, EventArgs e)
        {
            using (var db = new Authy_DataContext())
            {
                ListViewItem lvItem = ListView_Roles.Items[ListView_Roles.SelectedIndex];
                var roleID = (int) ListView_Roles.SelectedValue;
                var role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                if (role.Users != null)
                {
                    var label_roleInUse = (Label)lvItem.FindControl("Label_RoleInUse");
                    label_roleInUse.Visible = true;
                }
                else
                {
                    Panel panel_modify = (Panel)lvItem.FindControl("Panel_Modify");
                    Panel panel_delete = (Panel)lvItem.FindControl("Panel_Delete");

                    panel_modify.Visible = false;
                    panel_delete.Visible = true;
                }

               
            }
            

           
        }

        protected void LinkButton_CancelDelete_Click(object sender, EventArgs e)
        {
            ListViewItem lvItem = ListView_Roles.Items[ListView_Roles.SelectedIndex];
            Panel panel_modify = (Panel)lvItem.FindControl("Panel_Modify");
            Panel panel_delete = (Panel)lvItem.FindControl("Panel_Delete");

            panel_modify.Visible = true;
            panel_delete.Visible = false;
        }

        protected void LinkButton_ConfirmDelete_Click(object sender, EventArgs e)
        {
            using (var db = new Authy_DataContext())
            {
                var roleID = (int)ListView_Roles.SelectedValue;
                var role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                db.Roles.Remove(role);
                db.SaveChanges();
                ListView_Roles.DataBind();
                Label_DeleteSuccess.Visible = true;

            }
          
        }


        protected void LinkButton_CancelEdit_Click(object sender, EventArgs e)
        {
            Panel panel_save = (Panel)ListView_Roles.FindControl("Panel_Save");
            Panel panel_modify = (Panel)ListView_Roles.FindControl("Panel_Modify");

            panel_save.Visible = false;
            panel_modify.Visible = true;

            ListView_Roles.EditIndex = -1;
        }

        protected void LinkButton_SaveEdit_Command(object sender, CommandEventArgs e)
        {

            Panel panel_save = (Panel)ListView_Roles.FindControl("Panel_Save");
            Panel panel_modify = (Panel)ListView_Roles.FindControl("Panel_Modify");

            panel_save.Visible = false;
            panel_modify.Visible = true;
            Label_EditSuccess.Visible = false;

            ListView_Roles.EditIndex = -1;
        }

        protected void LinkButton_NewItem_Click(object sender, EventArgs e)
        {
            LinkButton_NewItem.ForeColor = System.Drawing.Color.Gray;
            LinkButton_EditItem.ForeColor = System.Drawing.Color.YellowGreen;

            LinkButton_NewItem.CssClass = "btn btn-default btn-block active";
            LinkButton_EditItem.CssClass = "btn btn-default btn-block";

            MultiView_Roles.ActiveViewIndex = 1;
        }

        protected void LinkButton_EditItem_Click(object sender, EventArgs e)
        {
            LinkButton_NewItem.ForeColor = System.Drawing.Color.YellowGreen;
            LinkButton_EditItem.ForeColor = System.Drawing.Color.Gray;

            LinkButton_NewItem.CssClass = "btn btn-default btn-block";
            LinkButton_EditItem.CssClass = "btn btn-default active btn-block";

            MultiView_Roles.ActiveViewIndex = 0;
        }

        protected void LinkButton_Unselect_Click(object sender, EventArgs e)
        {
            ListView_Roles.SelectedIndex = -1;
        }

        #region linkbutton checkbox interaction 
        protected void LinkButton_NewSAR_Click(object sender, EventArgs e)
        {
            if(CheckBox_NewSAR.Checked == true)
            {
                CheckBox_NewSAR.Checked = false;
                LinkButton_NewSAR.ForeColor = System.Drawing.Color.Gray;
                i_NewSAR.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_NewSAR.Checked = true;
                LinkButton_NewSAR.ForeColor = System.Drawing.Color.YellowGreen;
                i_NewSAR.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_NewSRR_Click(object sender, EventArgs e)
        {
            if (CheckBox_NewSRR.Checked == true)
            {
                CheckBox_NewSRR.Checked = false;
                LinkButton_NewSRR.ForeColor = System.Drawing.Color.Gray;
                i_NewSRR.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_NewSRR.Checked = true;
                LinkButton_NewSRR.ForeColor = System.Drawing.Color.YellowGreen;
                i_NewSRR.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_ViewRequests_Click(object sender, EventArgs e)
        {
            if (CheckBox_ViewRequests.Checked == true)
            {
                CheckBox_ViewRequests.Checked = false;
                LinkButton_ViewRequests.ForeColor = System.Drawing.Color.Gray;
                i_ViewRequests.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_ViewRequests.Checked = true;
                LinkButton_ViewRequests.ForeColor = System.Drawing.Color.YellowGreen;
                i_ViewRequests.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_NewETR_Click(object sender, EventArgs e)
        {
            if (CheckBox_NewETR.Checked == true)
            {
                CheckBox_NewETR.Checked = false;
                LinkButton_NewETR.ForeColor = System.Drawing.Color.Gray;
                i_NewETR.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_NewETR.Checked = true;
                LinkButton_NewETR.ForeColor = System.Drawing.Color.YellowGreen;
                i_NewETR.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_ManageRequests_Initial_Click(object sender, EventArgs e)
        {
            if (CheckBox_ManageRequests_Initial.Checked == true)
            {
                CheckBox_ManageRequests_Initial.Checked = false;
                LinkButton_ManageRequests_Initial.ForeColor = System.Drawing.Color.Gray;
                i_ManageRequests_Initial.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_ManageRequests_Initial.Checked = true;
                LinkButton_ManageRequests_Initial.ForeColor = System.Drawing.Color.YellowGreen;
                i_ManageRequests_Initial.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_ManageRequests_Final_Click(object sender, EventArgs e)
        {
            if (CheckBox_ManageRequests_Final.Checked == true)
            {
                CheckBox_ManageRequests_Final.Checked = false;
                LinkButton_ManageRequests_Final.ForeColor = System.Drawing.Color.Gray;
                i_ManageRequests_Final.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_ManageRequests_Final.Checked = true;
                LinkButton_ManageRequests_Final.ForeColor = System.Drawing.Color.YellowGreen;
                i_ManageRequests_Final.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_Reports_Click(object sender, EventArgs e)
        {
            if (CheckBox_Reports.Checked == true)
            {
                CheckBox_Reports.Checked = false;
                LinkButton_Reports.ForeColor = System.Drawing.Color.Gray;
                i_Reports.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_Reports.Checked = true;
                LinkButton_Reports.ForeColor = System.Drawing.Color.YellowGreen;
                i_Reports.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_Authorizations_Click(object sender, EventArgs e)
        {
            if (CheckBox_Authorizations.Checked == true)
            {
                CheckBox_Authorizations.Checked = false;
                LinkButton_Authorizations.ForeColor = System.Drawing.Color.Gray;
                i_Authorizations.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_Authorizations.Checked = true;
                LinkButton_Authorizations.ForeColor = System.Drawing.Color.YellowGreen;
                i_Authorizations.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_AuthorizationGroups_Click(object sender, EventArgs e)
        {
            if (CheckBox_AuthorizationGroups.Checked == true)
            {
                CheckBox_AuthorizationGroups.Checked = false;
                LinkButton_AuthorizationGroups.ForeColor = System.Drawing.Color.Gray;
                i_AuthorizationGroups.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_AuthorizationGroups.Checked = true;
                LinkButton_AuthorizationGroups.ForeColor = System.Drawing.Color.YellowGreen;
                i_AuthorizationGroups.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_Employees_Click(object sender, EventArgs e)
        {
            if (CheckBox_Employees.Checked == true)
            {
                CheckBox_Employees.Checked = false;
                LinkButton_Employees.ForeColor = System.Drawing.Color.Gray;
                i_Employees.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_Employees.Checked = true;
                LinkButton_Employees.ForeColor = System.Drawing.Color.YellowGreen;
                i_Employees.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_EmployeeGroups_Click(object sender, EventArgs e)
        {
            if (CheckBox_EmployeeGroups.Checked == true)
            {
                CheckBox_EmployeeGroups.Checked = false;
                LinkButton_EmployeeGroups.ForeColor = System.Drawing.Color.Gray;
                i_EmployeeGroups.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_EmployeeGroups.Checked = true;
                LinkButton_EmployeeGroups.ForeColor = System.Drawing.Color.YellowGreen;
                i_EmployeeGroups.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_Users_Click(object sender, EventArgs e)
        {
            if (CheckBox_Users.Checked == true)
            {
                CheckBox_Users.Checked = false;
                LinkButton_Users.ForeColor = System.Drawing.Color.Gray;
                i_Users.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_Users.Checked = true;
                LinkButton_Users.ForeColor = System.Drawing.Color.YellowGreen;
                i_Users.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }

        protected void LinkButton_Roles_Click(object sender, EventArgs e)
        {
            if (CheckBox_Roles.Checked == true)
            {
                CheckBox_Roles.Checked = false;
                LinkButton_Roles.ForeColor = System.Drawing.Color.Gray;
                i_Roles.Attributes["class"] = "glyphicon glyphicon-remove";
            }
            else
            {
                CheckBox_Roles.Checked = true;
                LinkButton_Roles.ForeColor = System.Drawing.Color.YellowGreen;
                i_Roles.Attributes["class"] = "glyphicon glyphicon-ok";
            }
        }
        #endregion

        //ListView Methods

        public IQueryable<Authy_Role> ListView_Roles_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.Roles;

        }

        public void ListView_Roles_DeleteItem(int RoleID)
        {
            //using (Authy_DataContext db = new Authy_DataContext())
            //{
            
            //}
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListView_Roles_UpdateItem(int RoleID)
        {
          

        }
    


        protected void ListView_Roles_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListView_Roles.EditIndex = -1;
            var t = this.ListView_Roles.FindControl("PermissionsUC");
        }

        protected void ListView_Roles_Sorted(object sender, EventArgs e)
        {
            ListView_Roles.SelectedIndex = -1;
        }

        protected void ListView_Roles_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
          
        }

        //Panel Methods

        protected void Panel_NewSAR_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.NewSAR == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        protected void Panel_NewSRR_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.NewSRR == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        protected void Panel_NewETR_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.NewETR == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        protected void Panel_ViewRequests_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ViewRequests == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }



        protected void Panel_ManageRequests_Initial_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageRequests_Initial == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }



        protected void Panel_ManageRequests_Final_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageRequests_Final == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }



        protected void Panel_Reports_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ViewReports == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }



        protected void Panel_Authorizations_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageAuthorizations == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }



        protected void Panel_AuthorizationGroups_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageAuthorizationGroups == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        protected void Panel_Employees_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageEmployees == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        protected void Panel_EmployeeGroups_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageEmployeeGroups == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        protected void Panel_Users_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageUsers == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        protected void Panel_Roles_Load(object sender, EventArgs e)
        {
            Panel pan = (Panel)sender;
            int roleID = (int)ListView_Roles.SelectedValue;

            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                if (role.ManageRoles == true)
                {
                    pan.CssClass = "glyphicon glyphicon-ok";
                }
            }
        }

        //Other

        public bool IsExistingUser(string newUserName)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                List<Authy_User> userList = db.Users.ToList();
                for (int i = 0; i < userList.Count; i++)
                {
                    if (userList[i].Username.ToLower() == newUserName.ToLower())
                    {
                        return true;
                    }
                }

                return false;
            }
        }

        //returns the amount of users a role has
        public int GetUserCount(int roleID)
        {
            using(Authy_DataContext db = new Authy_DataContext())
            {
                return db.Roles.Where(roleX => roleX.RoleID == roleID).SelectMany(roleX => roleX.Users).Count();
            }
        }

        protected void roleSave_Click(object sender, EventArgs e)
        {

        }

        protected Dictionary<string, bool> getRoleData()
        {
            Dictionary<string, bool> roles = new Dictionary<string, bool>();
            roles.Add("newsar", true);
            roles.Add("newsrr", true);
            return roles;
        }

     
    }
}