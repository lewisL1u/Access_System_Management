using Authy.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authy.UserControl
{
    public partial class SelectAuthorizationsUC : System.Web.UI.UserControl
    {
        public event EventHandler SelectGroupClick; 
        public ListBox ListBoxSelectedAuthorizations;
        public DropDownList DropDownListAuthorizationGroup;
        public Label LabelNoAuthorizations;
        public event EventHandler SelectAuthorizationClick;

        protected void Page_Load(object sender, EventArgs e)
        {
            ListBoxSelectedAuthorizations = this.ListBox_SelectedAuthorizations;
            LabelNoAuthorizations = this.Label_NoAuthorizations;
            DropDownListAuthorizationGroup = this.DropDownList_AuthorizationGroup;
        }

        public IQueryable<Authy.Models.Authy_Authorization> ListView_IndividualAuthorizations_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();

            return db.Authorizations.Where(authX => authX.AuthorizationIsActive == true).OrderBy(authX => authX.AuthorizationName);
        }

        protected void ListBox_IndividualAuthorizations_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                int authID = Convert.ToInt32(ListBox_IndividualAuthorizations.SelectedValue);
                Authy_Authorization auth = db.Authorizations.Where(authX => authX.AuthorizationID == authID).FirstOrDefault();

                Label_AuthorizationName.Text = auth.AuthorizationName;
                Label_AuthorizationID.Text = auth.AuthorizationID.ToString();
                Label_AuthorizationContact.Text = auth.AuthorizationContact;
                Label_AuthorizationDescription.Text = auth.AuthorizationDescription;

            }
            this.ListBox_IndividualAuthorizations.Focus();
        }

        protected void Button_SelectAuthorization_Click(object sender, EventArgs e)
        {
            if (!ListBox_SelectedAuthorizations.Items.Contains(ListBox_IndividualAuthorizations.SelectedItem) && ListBox_IndividualAuthorizations.SelectedIndex > -1)
            {
                ListBox_SelectedAuthorizations.Items.Add(ListBox_IndividualAuthorizations.SelectedItem);
                if (this.SelectAuthorizationClick != null)
                {
                    this.SelectAuthorizationClick(this, e);
                }
                ListBox_SelectedAuthorizations.SelectedIndex = -1;
                ListBox_SelectedAuthorizations.Focus();
                HideMessageLabels();
                Label_Create_SelectedAuthorizationsCount.Text = ListBox_SelectedAuthorizations.Items.Count.ToString() + " selected authorization(s).";                
            }
            else if (ListBox_SelectedAuthorizations.Items.Contains(ListBox_IndividualAuthorizations.SelectedItem))
            {
                setMessageOnLBSelectAuthorizaiton("* This authorization is already selected.");
            }
            else
            {
                setMessageOnLBSelectAuthorizaiton("* Please select an authorization.");
            }            
        }

        public void HideMessageLabels()
        {
            // Label_SelectEmployee.Visible = false;
            Label_SelectAuthorization.Visible = false;
            //Label_NoEmployees.Visible = false;
            Label_NoAuthorizations.Visible = false;
        }

        public IQueryable<Authy_AuthorizationGroup> DropDownList_AuthorizationGroup_GetData()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.AuthorizationGroups.OrderBy(authgroupX => authgroupX.AuthorizationGroupName);
        }


        public void setMessageOnLBSelectAuthorizaiton(string message)
        {
            Label_SelectAuthorization.Text = message;
            Label_SelectAuthorization.Visible = true;
        }


        protected void DropDownList_AuthorizationGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListView_AuthorizationGroupAuthorizations.DataBind();
        }

        protected void Button_SelectAuthorizationGroup_Click(object sender, EventArgs e)
        {
            if (DropDownList_AuthorizationGroup.SelectedIndex > -1)
            {
                using (Authy_DataContext db = new Authy_DataContext())
                {
                    int authGroupID = Convert.ToInt32(DropDownList_AuthorizationGroup.SelectedValue);
                    List<Authy_Authorization> authList = db.AuthorizationGroups.Where(authGroupX => authGroupX.AuthorizationGroupID == authGroupID).SelectMany(authGroupX => authGroupX.Authorizations).Where(authX => authX.AuthorizationIsActive == true).OrderBy(authX => authX.AuthorizationName).ToList();

                    for (int i = 0; i < authList.Count; i++)
                    {
                        ListItem listItem = ListBox_IndividualAuthorizations.Items.FindByValue(authList[i].AuthorizationID.ToString());

                        if (!ListBox_SelectedAuthorizations.Items.Contains(listItem))
                        {
                            ListBox_SelectedAuthorizations.Items.Add(listItem);
                            ListBox_SelectedAuthorizations.Focus();
                            HideMessageLabels();
                        }
                        else
                        {
                            Label_AuthorizationGroup.Text = "* This authorization " + authList[i].AuthorizationName + " is already selected.";
                            Label_AuthorizationGroup.Visible = true;
                        }
                    }
                    Label_Create_SelectedAuthorizationsCount.Text = ListBox_SelectedAuthorizations.Items.Count.ToString() + " selected authorization(s).";
                }

                if (SelectGroupClick != null)
                {
                    this.SelectGroupClick(this, e);
                }
            }
            else
            {
                Label_AuthorizationGroup.Text = "* Please select an Authorization group.";
                Label_AuthorizationGroup.Visible = true;
            }
        }

        protected void Button_UnselectAuthorization_Click(object sender, EventArgs e)
        {
            if (ListBox_SelectedAuthorizations.SelectedIndex > -1)
            {
                ListBox_SelectedAuthorizations.Items.Remove(ListBox_SelectedAuthorizations.SelectedItem);
                ListBox_SelectedAuthorizations.SelectedIndex = -1;
                Label_SelectedAuthorizationName.Text = "";
                Label_SelectedAuthorizationID.Text = "";
                Label_SelectedAuthorizationContact.Text = "";
                Label_SelectedAuthorizationDescription.Text = "";
                Label_Create_SelectedAuthorizationsCount.Text = ListBox_SelectedAuthorizations.Items.Count.ToString() + " selected authorization(s).";
            }
        }

        protected void ListBox_SelectedAuthorizations_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                int authID = Convert.ToInt32(ListBox_SelectedAuthorizations.SelectedValue);
                Authy_Authorization auth = db.Authorizations.Where(authX => authX.AuthorizationID == authID).FirstOrDefault();

                Label_SelectedAuthorizationName.Text = auth.AuthorizationName;
                Label_SelectedAuthorizationID.Text = auth.AuthorizationID.ToString();
                Label_SelectedAuthorizationContact.Text = auth.AuthorizationContact;
                Label_SelectedAuthorizationDescription.Text = auth.AuthorizationDescription;                
            }
            ListBox_SelectedAuthorizations.Focus();
        }

        public IQueryable<Authy_Authorization> ListView_AuthorizationGroupAuthorizations_GetData()
        {
            if (DropDownList_AuthorizationGroup.SelectedIndex > -1)
            {
                Authy_DataContext db = new Authy_DataContext();

                int authGroupID = Convert.ToInt32(DropDownList_AuthorizationGroup.SelectedValue);

                IQueryable<Authy_AuthorizationGroup> authGroupQuery = db.AuthorizationGroups.Where(authGroupX => authGroupX.AuthorizationGroupID == authGroupID);

                IQueryable<Authy_Authorization> authQuery = authGroupQuery.SelectMany(authGroupX => authGroupX.Authorizations).Where(authX => authX.AuthorizationIsActive == true);

                return authQuery.OrderBy(authX => authX.AuthorizationName);
            }
            else
            {
                return null;
            }

        }
    }
}