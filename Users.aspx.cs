using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace Authy.Pages
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckRole();
            Label_DeleteSuccess.Visible = false;
            Label_EditSuccess.Visible = false;
            Label_CreateMessage.Visible = false;
            Label_DuplicateUser.Visible = false;
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
            if (!Textbox_UserName.Text.Contains("."))
            {
                Textbox_UserName.Focus();
                Label_DuplicateUser.Visible = true;
                Label_DuplicateUser.Text = "The format of username should be \"firstname.lastname\".";
                return;
            }
            string newUser = Textbox_UserName.Text;
            if (!IsExistingUser(newUser))
            {
                //Creates a new authorization
                using (Authy_DataContext db = new Authy_DataContext())
                {
                    Authy_User user = new Authy_User();
                    Authy_Role role;
                    int roleID = Convert.ToInt32(DropDownList_CreateRole.SelectedValue);

                    role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();

                    user.Username = Textbox_UserName.Text;
                    user.UserEmail = Textbox_Email.Text;
                    user.Role = role;
                    db.Users.Add(user);
                    ;
                    db.SaveChanges();

                    ListView_Users.DataBind();
                    Label_CreateMessage.Text = "User created successfully!";
                    Label_CreateMessage.Visible = true;

                    Textbox_UserName.Text = "";
                    Textbox_Email.Text = "";
                    DropDownList_CreateRole.SelectedIndex = 0;
                    
                }
            }
            else
            {
                Textbox_UserName.Focus();
                Label_DuplicateUser.Visible = true;
                Label_DuplicateUser.Text = "This user already exists in the system.";
            }
        }

        //DropDownList Methods

        public IQueryable<Authy_Role> DropDownList_EditRole_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();

            return db.Roles;
        }

        protected void DropDownList_EditRole_Load(object sender, EventArgs e)
        {

            if (ListView_Users.EditIndex > -1)
            {
                DropDownList ddl = (DropDownList)sender;

                ddl.SelectedValue = (string)ListView_Users.SelectedValue;
            }
        }

        protected void DropDownList_EditUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;

        }

        public IQueryable<Authy_Role> DropDownList_CreateRole_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();

            return db.Roles;
        }

        //LinkButton Methods

        protected void LinkButton_Delete_Click(object sender, EventArgs e)
        {
            ListViewItem lvItem = ListView_Users.Items[ListView_Users.SelectedIndex];

            Panel panel_modify = (Panel)lvItem.FindControl("Panel_Modify");
            Panel panel_delete = (Panel)lvItem.FindControl("Panel_Delete");

            panel_modify.Visible = false;
            panel_delete.Visible = true;
        }

        protected void LinkButton_CancelDelete_Click(object sender, EventArgs e)
        {
            ListViewItem lvItem = ListView_Users.Items[ListView_Users.SelectedIndex];
            Panel panel_modify = (Panel)lvItem.FindControl("Panel_Modify");
            Panel panel_delete = (Panel)lvItem.FindControl("Panel_Delete");

            panel_modify.Visible = true;
            panel_delete.Visible = false;
        }

        protected void LinkButton_ConfirmDelete_Click(object sender, EventArgs e)
        {
            ListView_Users.DeleteItem(ListView_Users.SelectedIndex);
            Label_DeleteSuccess.Visible = true;

        }


        protected void LinkButton_CancelEdit_Click(object sender, EventArgs e)
        {
            Panel panel_save = (Panel)ListView_Users.FindControl("Panel_Save");
            Panel panel_modify = (Panel)ListView_Users.FindControl("Panel_Modify");

            panel_save.Visible = false;
            panel_modify.Visible = true;

            ListView_Users.EditIndex = -1;
        }

        protected void LinkButton_SaveEdit_Command(object sender, CommandEventArgs e)
        {

            Panel panel_save = (Panel)ListView_Users.FindControl("Panel_Save");
            Panel panel_modify = (Panel)ListView_Users.FindControl("Panel_Modify");

            panel_save.Visible = false;
            panel_modify.Visible = true;
            Label_EditSuccess.Visible = false;

            ListView_Users.EditIndex = -1;
        }

        protected void LinkButton_NewItem_Click(object sender, EventArgs e)
        {
            LinkButton_NewItem.ForeColor = System.Drawing.Color.Gray;
            LinkButton_EditItem.ForeColor = System.Drawing.Color.YellowGreen;

            LinkButton_NewItem.CssClass = "btn btn-default btn-block active";
            LinkButton_EditItem.CssClass = "btn btn-default btn-block";

            MultiView_Users.ActiveViewIndex = 1;
        }

        protected void LinkButton_EditItem_Click(object sender, EventArgs e)
        {
            LinkButton_NewItem.ForeColor = System.Drawing.Color.YellowGreen;
            LinkButton_EditItem.ForeColor = System.Drawing.Color.Gray;

            LinkButton_NewItem.CssClass = "btn btn-default btn-block";
            LinkButton_EditItem.CssClass = "btn btn-default active btn-block";

            MultiView_Users.ActiveViewIndex = 0;
        }


        //ListView Methods

        public IQueryable<Authy_User> ListView_Users_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.Users;

        }

        public void ListView_Users_DeleteItem(int UserID)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_User user = db.Users.Where(userX => userX.UserID == UserID).FirstOrDefault();
                db.Users.Remove(user);

                db.SaveChanges();
                ListView_Users.DataBind();
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListView_Users_UpdateItem(int UserID)
        {
            TextBox tb_UserName = (TextBox)ListView_Users.EditItem.FindControl("TextBox_EditUserName");
            TextBox tb_UserName_Hidden = (TextBox)ListView_Users.EditItem.FindControl("TextBox_EditUserName_Hidden");
            TextBox tb_Email = (TextBox)ListView_Users.EditItem.FindControl("TextBox_EditEmail");
            DropDownList ddl_EditRole = (DropDownList)ListView_Users.EditItem.FindControl("DropDownList_EditRole");

            if (!IsExistingUser(tb_UserName.Text) || tb_UserName.Text.ToLower() == tb_UserName_Hidden.Text.ToLower())
            {
                using (Authy_DataContext db = new Authy_DataContext())
                {
                    int roleID = Convert.ToInt32(ddl_EditRole.SelectedValue);
                    Authy_Role role = db.Roles.Where(roleX => roleX.RoleID == roleID).FirstOrDefault();
                    Authy_User user = db.Users.Where(userX => userX.UserID == UserID).FirstOrDefault();
                    user.Username = tb_UserName.Text;
                    user.UserEmail = tb_Email.Text;
                    user.Role = role;

                    db.SaveChanges();
                    Response.Redirect("Users");
                    Label_EditSuccess.Visible = true;
                }
            }
            else
            {
                tb_UserName.Focus();
                Label_DuplicateUser.Visible = true;
            }

        }


        protected void ListView_Users_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListView_Users.EditIndex = -1;
        }

        protected void ListView_Users_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (ListView_Users.EditIndex >= 0)
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                if (dataItem.DisplayIndex == ListView_Users.EditIndex)
                {
                    DropDownList ddl_EditRole = (DropDownList)dataItem.FindControl("DropDownList_EditRole");
                    Authy_User user;

                    using (Authy_DataContext db = new Authy_DataContext())
                    {
                        user = db.Users.Where(userX => userX.UserID == (int)ListView_Users.SelectedValue).FirstOrDefault();

                        for(int i=0; i<ddl_EditRole.Items.Count; i++)
                        {
                            if(user.Role.RoleID.ToString() == ddl_EditRole.Items[i].Value)
                            {
                                ddl_EditRole.Items[i].Selected = true;
                            }
                        }

                    }
                }
            }

        }

        protected void ListView_Users_Sorted(object sender, EventArgs e)
        {
            ListView_Users.SelectedIndex = -1;
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


        public string GetRoleName(Authy_Role role)
        {
            return role.RoleName;
        }

        protected void LinkButton_Unselect_Click(object sender, EventArgs e)
        {
            ListView_Users.SelectedIndex = -1;
        }

        protected void Textbox_UserName_TextChanged(object sender, EventArgs e)
        {
            this.Textbox_Email.Text = this.Textbox_UserName.Text + "@oecu.org";
        }
    }
}