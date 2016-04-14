using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace SAR_Helper.Pages
{
    public partial class AuthorizationReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadGroups();
        }

        //Method retrieves data for ListView_AuthorizationReport
        public IQueryable<Authy_Authorization> ListView_AuthorizationReport_GetData()
        {

            Authy_DataContext db = new Authy_DataContext();

            //Return all authorizations in the database
            /*
            if (DropDownList_ShowAll.SelectedValue == "YES" && DropDownList_Active.SelectedValue == "ALL")
            {       
                return db.Authorizations.OrderBy(autX => autX.AuthorizationName);
            }
            //Return all active authorizations in the database
            else if (DropDownList_ShowAll.SelectedValue == "YES" && DropDownList_Active.SelectedValue == "YES")
            {
                return db.Authorizations.Where(autX => autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
            }
            //Returns all inactive autorizations in the database
            else if (DropDownList_ShowAll.SelectedValue == "YES" && DropDownList_Active.SelectedValue == "NO")
            {
                return db.Authorizations.Where(autX => !autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
            }
            return null;
            */

            if(DropDownList_ShowAll.SelectedValue == "YES")
            {
                switch (DropDownList_Active.SelectedValue)
                {
                    case "All":
                        return db.Authorizations.OrderBy(autX => autX.AuthorizationName);
                    case "YES":
                        return db.Authorizations.Where(autX => autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
                    case "NO":
                        return db.Authorizations.Where(autX => !autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
                    default:
                        return null;
                }
            }
            else
            {
                string groupName = "";

                switch (DropDownList_Active.SelectedValue)
                {
                    case "All":
                        return db.Authorizations.OrderBy(autX => autX.AuthorizationName);
                    case "YES":
                        return db.Authorizations.Where(autX => autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
                    case "NO":
                        return db.Authorizations.Where(autX => !autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
                    default:
                        return null;
                }


        }
        //Method for change on showall list
        protected void DropDownList_ShowAll_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList_ShowAll.SelectedValue == "YES")
            {
                DropDownList_Group.Enabled = false;
            }
            else
            {
                DropDownList_Group.Enabled = true;
            }
        }



        //load group
        public void loadGroups()
        {
            Authy_DataContext db = new Authy_DataContext();
            //ListItemCollection items = new ListItemCollection { };
            
            List<string> grouplist = db.AuthorizationGroups.Select(autX => autX.AuthorizationGroupName).ToList();

            DropDownList_Group.Items.Clear();
            foreach (string item in grouplist)
            {
                DropDownList_Group.Items.Add(item);
            }

            //DropDownList_Group.Items.Add
        }

        /*
        protected void DropDownList_Active_SelectedIndexChanged(object sender, EventArgs e)
        {
            Authy_DataContext db = new Authy_DataContext();
            if (DropDownList_ShowAll.SelectedValue == "YES")
            {
                switch (DropDownList_Active.SelectedValue)
                {
                    case "ALL":
                        ListView_AuthorizationReport.DataSource = db.Authorizations.OrderBy(autX => autX.AuthorizationName);
                        break;
                    case "YES":
                        ListView_AuthorizationReport.DataSource = db.Authorizations.Where(autX => autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
                        break;
                    case "NO":
                        ListView_AuthorizationReport.DataSource = db.Authorizations.Where(autX => !autX.AuthorizationIsActive).OrderBy(autX => autX.AuthorizationName);
                        break;
                }
                //ListView_AuthorizationReport.DataBind();
            }
        }*/



    }
}