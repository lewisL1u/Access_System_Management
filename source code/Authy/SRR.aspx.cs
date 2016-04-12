using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;
using Authy.Helper;

namespace Authy.Pages
{
    public partial class SRR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
       
        }

        //BulletedList Methods

        protected void BulletedList_SelectedEmployees_Load(object sender, EventArgs e)
        {
            BulletedList_SelectedEmployees.Items.Clear();
            for (int i = 0; i < this.SelectEmployees.ListBoxSelectedEmployees.Items.Count; i++)
            {
                BulletedList_SelectedEmployees.Items.Add(this.SelectEmployees.ListBoxSelectedEmployees.Items[i]);
            }
        }

        protected void BulletedList_SelectedAuthorizations_Load(object sender, EventArgs e)
        {
            BulletedList_SelectedAuthorizations.Items.Clear();
            for (int i = 0; i < this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items.Count; i++)
            {
                BulletedList_SelectedAuthorizations.Items.Add(this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items[i]);
            }
        }

        //Label Methods

        protected void Label_SelectedEmployeeCount_Load(object sender, EventArgs e)
        {
            Label_SelectedEmployeeCount.Text = this.SelectEmployees.ListBoxSelectedEmployees.Items.Count.ToString() + " selected employee(s).";
        }

        protected void Label_SelectedAuthorizationCount_Load(object sender, EventArgs e)
        {
            Label_SelectedAuthorizationCount.Text = this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items.Count.ToString() + " selected authorization(s).";
        }

        protected void Label_Comments_Load(object sender, EventArgs e)
        {
            Label_Comments.Text = TextBox_Comments.Text;
        }

        protected void Label_Username_Load(object sender, EventArgs e)
        {
            Label_Username.Text = HttpContext.Current.User.Identity.Name;
        }

        //LinkButton Methods
        protected void LinkButton_Review_Click(object sender, EventArgs e)
        {
            if (this.SelectEmployees.ListBoxSelectedEmployees.Items.Count == 0)
            {
                this.SelectEmployees.LabelNoEmployees.Visible = true;
                this.SelectEmployees.ListBoxSelectedEmployees.Focus();
            }
            else if(this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items.Count == 0)
            {
                SelectAuthorizations.LabelNoAuthorizations.Visible = true;
                this.SelectAuthorizations.ListBoxSelectedAuthorizations.Focus();
            }
            else
            {
                this.SelectEmployees.HideMessageLabels();
                this.SelectAuthorizations.HideMessageLabels();
                MultiView_SRRForm.ActiveViewIndex = 1;
            }
        }

        protected void LinkButton_Submit_Command(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Request request = new Authy_Request();
                DateTime dt = DateTime.Now;
                DateTime exDate = new DateTime();
                DateTime itDate = new DateTime();

                //Sets the type of request
                request.ARequestType =db.Authy_RequestType.Where(rt => rt.RequestTypeId == RequestTypeEnum.SRR.RequestTypeId).FirstOrDefault();

                request.Requester = db.Users.Where(u => u.Username == Label_Username.Text.Replace("OECU\\", "")).FirstOrDefault(); 
                request.RequestedByComments = TextBox_Comments.Text;

                request.ExecutiveStatus = "Pending";
                request.ITStatus = "Pending";

                //DateTime.TryParse(Label_SubmitDate.Text, out dt);
                request.RequestDate = dt;

                //Sets dates to max date, since null is not allowed
                DateTime.TryParse("12/31/9999", out exDate);
                request.ExecutiveProcessDate = exDate;

                //Sets dates to max date, since null is not allowed
                DateTime.TryParse("12/31/9999", out itDate);
                request.ITProcessDate = itDate;

                for (int i = 0; i < this.SelectEmployees.ListBoxSelectedEmployees.Items.Count; i++)
                {
                    int empID = Convert.ToInt32(this.SelectEmployees.ListBoxSelectedEmployees.Items[i].Value);
                    Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();
                    request.RequestedEmployees.Add(emp);

                }

                for (int i = 0; i < this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items.Count; i++ )
                {
                    int authID = Convert.ToInt32(this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items[i].Value);
                    Authy_Authorization auth = db.Authorizations.Where(authX => authX.AuthorizationID == authID).FirstOrDefault();
                    request.RequestedAuthorizations.Add(auth);
                }

                db.Requests.Add(request);
                try
                {
                    db.SaveChanges();
                    string result = EmailNotification.sendNotification(1, request.ARequestType.RequestTypeDesc + " - SAR Helper", this.Page.Server, db, request, "block");
                    if (!result.Contains("Err"))
                    {
                        sucessfulPannel.Visible = true;
                        failurePannel.Visible = false;
                    }
                    else
                    {
                        sucessfulPannel.Visible = false;
                        failurePannel.Visible = true;
                        errMessage.Text = result;
                    }
                }
                catch (Exception ex)
                {
                    sucessfulPannel.Visible = false;
                    failurePannel.Visible = true;
                    errMessage.Text = ex.Message;
                }
                
            }
        }

        protected void Label_SubmitDate_Load(object sender, EventArgs e)
        {
            Label_SubmitDate.Text = DateTime.Today.ToShortDateString();
        }

        protected void CheckBox_Sign_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox_Sign.Checked == true)
            {
                LinkButton_Submit.CssClass = "btn btn-default btn-block btn-lg";
            }
            else
            {
                LinkButton_Submit.CssClass = "btn btn-default btn-block btn-lg disabled";
            }
        }

       


    }
}