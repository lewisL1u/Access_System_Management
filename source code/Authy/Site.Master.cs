using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace Authy
{
    public partial class SiteMaster : MasterPage
    {
        //Method #01 - Page_Load - Runs when page is loaded
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckRole();
            Label_Role.Text = GetRole();
        }

        //Method #02 - CheckRole - Shows navigation elements based on the user's roles
        protected void CheckRole()
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                string username = HttpContext.Current.User.Identity.Name.Replace("OECU\\","");
                Authy_User user = db.Users.Where(userX => userX.Username == username).SingleOrDefault();

                if (user != null)
                {
                    Authy_Role role = user.Role;

                    //Checks if the user has any role, else sends them to the unauthorized page
                    if (role != null)
                    {
                        //Checks if the user can submit any request
                        if (role.NewSAR == true || role.NewSRR == true || role.NewETR == true)
                        {
                            //Shows the main 'New Request' navigation link
                            Panel_NewRequest.Visible = true;

                            //Checks if the user can submit a new System Access Requests (SAR). If true, shows the navigation sublink.
                            if (role.NewSAR == true)
                            {
                                Panel_SAR.Visible = true;
                            }

                            //Checks if the user can submit a new System Removal Request (SRR). If true, shows the navigation sublink.
                            if (role.NewSRR == true)
                            {
                                Panel_SRR.Visible = true;
                            }

                            //Checks if the user can submit a new Employee Termination Request (ETR). If true, shows the navigation sublink.
                            if (role.NewETR == true)
                            {
                                Panel_ETR.Visible = true;
                            }
                        }

                        //Checks if the user can interact at all with any existing requests
                        if (role.ViewRequests == true || role.ManageRequests_Initial == true)
                        {
                            //Shows the main 'Existing Request' navigation link 
                            Panel_ExistingRequests.Visible = true;

                            //Checks if the user can view existing requests. If true, shows the "View Requests" navigation sublink
                            if (role.ViewRequests == true)
                            {
                                link_ViewRequests.Visible = true;
                            }

                            //Checks if the user can manage existing requests. If true, shows the "Manage Requests" navigation sublink
                            if (role.ManageRequests_Initial == true || role.ManageRequests_Final == true)
                            {
                                link_ManageRequests.Visible = true;
                            }
                        }

                        //Checks if the user can view reports. If true, shows the "Reports" navigation link
                        if (role.ViewReports == true)
                        {
                            Panel_Reports.Visible = true;
                        }

                        //Checks if the user can manage authorizations or authorization groups. If true, shows the "Authorizations" navigation link
                        if (role.ManageAuthorizations == true || role.ManageAuthorizationGroups == true)
                        {
                            //Shows the authorization navigation link
                            Panel_Authorizations.Visible = true;

                            //Checks if the user can manage authorizations. If true, shows the "Manage Authorizations" navigation sublink.
                            if (role.ManageAuthorizations == true)
                            {
                                link_ManageAuthorizations.Visible = true;
                            }

                            //Checks if the user can manage authorization groups. If true, shows the "Manage Authorization Groups" navigation sublink.
                            if (role.ManageAuthorizationGroups == true)
                            {
                                link_ManageAuthorizationGroups.Visible = true;
                            }

                        }

                        //Checks if the user can manage employees or employee groups. If true, shows the "Employees" navigation link.
                        if (role.ManageEmployees == true || role.ManageEmployeeGroups == true)
                        {
                            Panel_Employees.Visible = true;

                            //Checks if the user can manage employees. If true, shows the "Manage Employees" navigation sublink.
                            if (role.ManageEmployees == true)
                            {
                                link_ManageEmployees.Visible = true;
                            }

                            //Checks if the user can manage employee groups. If true, shows the "Manage Employee Groups" navigation sublink.
                            if (role.ManageEmployeeGroups == true)
                            {
                                link_ManageEmployeeGroups.Visible = true;
                            }
                        }

                        //Checks if the user can manage Authy Users or Authy Roles. If true, shows the "Users/Roles" navigation link.
                        if (role.ManageUsers == true || role.ManageRoles == true)
                        {
                            //Shows the "Users/Roles" navigation link
                            Panel_AuthyUsers.Visible = true;

                            //Checks if the user can manage Authy Users. If true, shows the "Manage Users" navigation sublink.
                            if (role.ManageUsers == true)
                            {
                                link_ManageUsers.Visible = true;
                            }

                            //Checks if the user can manage Authy Roles. If true, shows the "Manage Roles" navigation sublink.
                            if (role.ManageRoles == true)
                            {
                                link_ManageRoles.Visible = true;
                            }
                        }

                    }
                }
                
                else
                {
                    Response.Redirect("Unauthorized");
                }
             
            }
        }

        //Method #03 - GetRole - Gets the user's role by searching the database with the user's username
        protected string GetRole()
        {
            using(Authy_DataContext db = new Authy_DataContext())
            {
                string username = HttpContext.Current.User.Identity.Name.Replace("OECU\\","");
                Authy_User user = db.Users.Where(userX => userX.Username == username).FirstOrDefault();

                if(user != null)
                {
                    return user.Role.RoleName;
                }
                else
                {
                    return "Unauthorized";
                }
            }
        }

        //Method #04 - GetAuthorizations - Returns all authorizations in the database as an IQueryable<Authy_Authorization>
        protected IQueryable<Authy_Authorization> GetAuthorizations()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.Authorizations;

        }

        //Method #05 - GetEmployees - Returns all employees in the database as an IQueryable<Authy_Employee>
        protected IQueryable<Authy_Employee> GetEmployees()
        {
            Authy_DataContext db = new Authy_DataContext();
            return db.Employees;

        }
    }
}