using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;
using System.Configuration;
using System.IO;
using System.Text;
using Authy.Helper;

namespace Authy.Pages
{
    public partial class SAR : System.Web.UI.Page
    {
        private string comments;

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

        

        protected void Label_Username_Load(object sender, EventArgs e)
        {
            Label_Username.Text = HttpContext.Current.User.Identity.Name.Replace("OECU\\","");
        }

        //LinkButton Methods
        protected void LinkButton_Review_Click(object sender, EventArgs e)
        {
            if (this.SelectEmployees.ListBoxSelectedEmployees.Items.Count == 0)
            {
                this.SelectEmployees.LabelNoEmployees.Visible = true;
                this.SelectEmployees.ListBoxSelectedEmployees.Focus();
            }
            else if (this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items.Count == 0)
            {
                this.SelectAuthorizations.LabelNoAuthorizations.Visible = true;
                this.SelectAuthorizations.ListBoxSelectedAuthorizations.Focus();
            }
            else
            {
                //HideMessageLabels();
                this.SelectEmployees.HideMessageLabels();
                this.SelectAuthorizations.HideMessageLabels();
                checkDuplication();
                MultiView_SARForm.ActiveViewIndex = 1;
            }
        }

        private void checkDuplication()
        {
            var employees = this.SelectEmployees.ListBoxSelectedEmployees.Items;
            var authorizations = this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items;
            comments = TextBox_Comments.Text;
            using (Authy_DataContext db = new Authy_DataContext())
            {
                foreach (ListItem em in employees)
                {
                    foreach (ListItem au in authorizations)
                    {
                        int empId = Convert.ToInt32(em.Value);
                        int authId = Convert.ToInt32(au.Value);
                        // get the num of accessActive, exist employee, and exits auth
                        int num = db.Accesses.Where(ac => ac.AccessIsActive == true && ac.AccessEmployee.EmployeeID == empId && ac.AccessAuthorization.AuthorizationID == authId).Count();
                        // check duplication
                        if (num > 0)
                        {
                            comments += string.Format("<br/><I>[{0}]<I/> has <I>[{1}]</i> in system;", em.Text,au.Text);
                        }
                    }
                }
                Label_Comments.Text = comments;
            }
        }

        protected void LinkButton_Submit_Command(object sender, EventArgs e)
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                Authy_Request sar = new Authy_Request();
                DateTime dt = DateTime.Now;
                DateTime exDate = new DateTime();
                DateTime itDate = new DateTime();

                //Sets the type of request
                if (cb_isNewEmployeeRequest.Checked)
                {
                    sar.ARequestType = db.Authy_RequestType.Where(rt => rt.RequestTypeId == RequestTypeEnum.NESAR.RequestTypeId).FirstOrDefault();
                    sar.ExecutiveName = "System";
                    sar.ExecutiveStatus = "Approved";
                    sar.ExecutiveProcessDate = DateTime.Now;
                }
                else
                {
                    sar.ARequestType = db.Authy_RequestType.Where(rt => rt.RequestTypeId == RequestTypeEnum.SAR.RequestTypeId).FirstOrDefault();
                    //Sets dates to max date, since null is not allowed
                    DateTime.TryParse("12/31/9999", out exDate);
                    sar.ExecutiveProcessDate = exDate;
                    sar.ExecutiveStatus = "Pending";
                }

                sar.Requester = db.Users.Where(u => u.Username == Label_Username.Text).FirstOrDefault();
                sar.RequestedByComments = Label_Comments.Text;                
                sar.ITStatus = "Pending";
                //DateTime.TryParse(Label_SubmitDate.Text, out dt);
                sar.RequestDate = dt;                

                //Sets dates to max date, since null is not allowed
                DateTime.TryParse("12/31/9999", out itDate);
                sar.ITProcessDate = itDate;

                for (int i = 0; i < this.SelectEmployees.ListBoxSelectedEmployees.Items.Count; i++)
                {
                    int empID = Convert.ToInt32(this.SelectEmployees.ListBoxSelectedEmployees.Items[i].Value);
                    Authy_Employee emp = db.Employees.Where(empX => empX.EmployeeID == empID).FirstOrDefault();
                    sar.RequestedEmployees.Add(emp);

                }

                for (int i = 0; i < this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items.Count; i++)
                {
                    int authID = Convert.ToInt32(this.SelectAuthorizations.ListBoxSelectedAuthorizations.Items[i].Value);
                    Authy_Authorization auth = db.Authorizations.Where(authX => authX.AuthorizationID == authID).FirstOrDefault();
                    sar.RequestedAuthorizations.Add(auth);
                }
                
                db.Requests.Add(sar);
                try
                {
                    db.SaveChanges();
                    string result = "";
                    if(cb_isNewEmployeeRequest.Checked)
                        result = EmailNotification.sendNotification(2, sar.ARequestType.RequestTypeDesc + " - SAR Helper", this.Page.Server, db, sar, "block");
                    else
                        result = EmailNotification.sendNotification(1, sar.ARequestType.RequestTypeDesc + " - SAR Helper", this.Page.Server, db, sar,"block");
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

        //Other Methods

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

        protected void lb_isNewEmployeeRequest_Click(object sender, EventArgs e)
        {
            if (cb_isNewEmployeeRequest.Checked )
            {
                oldEmployeeRequest();
            }
            else
            {
                newEmployeeRequest();
            }
        }

        private void newEmployeeRequest()
        {
            cb_isNewEmployeeRequest.Checked = true;
            lb_isNewEmployeeRequest.ForeColor = System.Drawing.Color.YellowGreen;
            i_isNewEmployeeRequest.Attributes["class"] = "glyphicon glyphicon-ok";
            i_isNewEmployeeRequest.InnerText = "  Yes";
        }

        private void oldEmployeeRequest()
        {
            cb_isNewEmployeeRequest.Checked = false;
            lb_isNewEmployeeRequest.ForeColor = System.Drawing.Color.Gray;
            i_isNewEmployeeRequest.Attributes["class"] = "glyphicon glyphicon-remove";
            i_isNewEmployeeRequest.InnerText = "  No";
        }

        protected void SelectAuthorizations_SelectGroupClick(object sender, EventArgs e)
        {
            var authUC = (sender as Authy.UserControl.SelectAuthorizationsUC);
            var ddl = authUC.DropDownListAuthorizationGroup;
            if (ddl.SelectedItem.Text.ToLower().Contains("new"))
            {
                newEmployeeRequest();
            }
            else
            {
                oldEmployeeRequest();
            }
        }

        protected void label_newRequest_Load(object sender, EventArgs e)
        {
            label_newRequest.Text = cb_isNewEmployeeRequest.Checked.ToString();
        }
    }
}