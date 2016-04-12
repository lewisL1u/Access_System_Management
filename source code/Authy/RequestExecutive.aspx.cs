using Authy.Helper;
using Authy.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authy
{
    public partial class RequestExecutive : System.Web.UI.Page
    {
        private int requestId;
        private int stepId;
        private static Authy_DataContext db;// db
        private int status;
        private Authy_Request sar;
        private IQueryable<Authy_Authorization> aus;
        private IQueryable<Authy_Employee> ems;
        private Authy_User user;
        private RequestHandler rh; // rquest handler
        private string name;// handler name

        protected void Page_Load(object sender, EventArgs e)
        {

            name = HttpContext.Current.User.Identity.Name.Replace("OECU\\", "");
            CheckRole();

            requestId = Int32.Parse(Request.QueryString["requestId"]);
            stepId = Int32.Parse(Request.QueryString["step"]);
            status = Int32.Parse(Request.QueryString["status"]);


            rh = new RequestHandler(this.Page.Server);
            #region
            //try
            //{
            //db = new Authy_DataContext();

            //sar = db.Requests.Where(request => request.RequestID == requestId).FirstOrDefault();// get request
            //aus = db.Requests.Where(request => request.RequestID == requestId).SelectMany(sarA => sarA.RequestedAuthorizations);// get request authorization    
            //ems = db.Requests.Where(request => request.RequestID == requestId).SelectMany(sarE => sarE.RequestedEmployees);// get request employees
            //sar.Requester = db.Users.Where(u => u.UserID == user.UserID).FirstOrDefault();

            //if (!checkHandledOrNot(sar))
            //    return;
            // if stepid is 1, set executive infor
            //if (stepId == 1)
            //{
            //    sar.ExecutiveName = name;
            //    sar.ExecutiveStatus = "Approved";
            //    sar.ExecutiveProcessDate = DateTime.Now;
            //}
            //else if (stepId == 2)
            //{
            //    sar.ITName = name;
            //    sar.ITStatus = "Approved";
            //    sar.ITProcessDate = DateTime.Now;
            //}

            // if status is 1, it means approve without comments.
            // if status is 2, it means approve with comments.
            // if status is 3, it means decline with comments.
            //if (status == 1)
            //{
            //    //db.SaveChanges();

            //    sendAndEmail();
            //}
            //else 
            #endregion
            if (status == 2 || status == 3)
            {
                pComment.Visible = true;
                return;
            }
            submit();
            //}
            //catch (Exception ex)
            //{
            //    pComment.Visible = false;
            //    System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert(':( Notification cannot be sent. Please try it later or contact IT Department. Err... '" + ex.Message + ");</SCRIPT>");
            //}

        }

        //Authentication Method
        protected void CheckRole()
        {
            using (Authy_DataContext db = new Authy_DataContext())
            {
                //string username = HttpContext.Current.User.Identity.Name.Replace("OECU\\","");
                user = db.Users.Where(userX => userX.Username == name).FirstOrDefault();

                if (user.Role.ManageRequests_Initial == false && user.Role.ManageRequests_Final == false)
                {
                    Response.Redirect("Unauthorized");
                }

            }
        }

        protected void btnComment_Click(object sender, EventArgs e)
        {
            // approved with comments, else declined with comments
            pComment.Visible = false;
            if (status == 2)
            {
                rh.Comments = txtComment.Text;
                status = 1;
            }
            else if (status == 3)
            {
                // for status 3 comment should not be empty
                if (txtComment.Text == "")
                {
                    System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert(':( Comments cannot be empty for Decline.');</SCRIPT>");
                    pComment.Visible = true;
                    return;
                }
                rh.Comments = txtComment.Text;
                status = 2;
            }
            submit();
        }

        private void submit()
        {
            string message = rh.processRequest(requestId, stepId, status, name);
            if (!message.Contains("Err: "))
                System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert('Notification has been sent.');</SCRIPT>");
            else
                System.Web.HttpContext.Current.Response.Write(string.Format("<SCRIPT LANGUAGE='JavaScript'>alert(':( Notification cannot be sent. Please try it later or contact IT Department. Err: {0}');</SCRIPT>", message));
        }

        #region not used
        //private void sendAndEmail()
        //{

        //    try
        //    {
        //        int step = stepId + 1;
        //        // add access mapping to request, authorization and employees
        //        if (step == 3 && (status == 1 || status == 2))
        //        {
        //            if (sar.ARequestType.RequestTypeName.Equals(RequestTypeEnum.SAR.RequestTypeName) || sar.ARequestType.RequestTypeName.Equals(RequestTypeEnum.NESAR.RequestTypeName))
        //            {

        //                foreach (Authy_Authorization au in aus)
        //                {
        //                    foreach (Authy_Employee ae in ems)
        //                    {
        //                        Authy_Access aa = new Authy_Access();
        //                        aa.AccessIsActive = true;
        //                        aa.AccessRequest = sar;
        //                        aa.AccessAuthorization = au;
        //                        aa.AccessEmployee = ae;
        //                        db.Accesses.Add(aa);
        //                    }
        //                }
        //            }
        //            else if (sar.ARequestType.RequestTypeName.Equals(RequestTypeEnum.SRR.RequestTypeName))
        //            {
        //                if (aus != null && ems != null)
        //                {
        //                    // set access as false in every employee in every authorization
        //                    foreach (Authy_Employee ae in ems)
        //                    {
        //                        foreach (Authy_Authorization au in aus)
        //                        {
        //                            IQueryable<Authy_Access> aas = db.Accesses.Where(accessX => accessX.AccessEmployee.EmployeeID == ae.EmployeeID).Where(accessX => accessX.AccessAuthorization.AuthorizationID == au.AuthorizationID);
        //                            if (aas != null)
        //                            {
        //                                foreach (Authy_Access aa in aas)
        //                                {
        //                                    aa.AccessIsActive = false;
        //                                }
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //            else if (sar.ARequestType.RequestTypeName.Equals(RequestTypeEnum.ETR.RequestTypeName))
        //            {
        //                if (ems != null)
        //                {
        //                    // set terminate date of requested employees
        //                    foreach (Authy_Employee ae in ems)
        //                    {
        //                        ae.EmployeeTerminationDate = DateTime.Now;
        //                        // set access as false in every employee in every authorization
        //                        if (aus.Count() != 0)
        //                        {
        //                            foreach (Authy_Authorization aa in aus)
        //                            {
        //                                IQueryable<Authy_Access> aas = db.Accesses.Where(accessX => accessX.AccessEmployee.EmployeeID == ae.EmployeeID).Where(accessX => accessX.AccessAuthorization.AuthorizationID == aa.AuthorizationID);
        //                                if (aas != null)
        //                                {
        //                                    foreach (Authy_Access ac in aas)
        //                                    {
        //                                        ac.AccessIsActive = false;
        //                                    }
        //                                }
        //                            }
        //                        }
        //                        else
        //                        {
        //                            IQueryable<Authy_Access> aas = db.Accesses.Where(accessX => accessX.AccessEmployee.EmployeeID == ae.EmployeeID);
        //                            foreach (Authy_Access ac in aas)
        //                            {
        //                                ac.AccessIsActive = false;
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //            if (sar.ARequestType.RequestTypeName.Equals(RequestTypeEnum.NESAR.RequestTypeName) || sar.ARequestType.RequestTypeName.Equals(RequestTypeEnum.ETR.RequestTypeName))
        //            {
        //                sar.ExecutiveStatus = status == 1 ? "Approved" : "Declined";
        //                sar.ExecutiveName = "System";
        //                sar.ExecutiveProcessDate = DateTime.Now;
        //            }
        //        }
        //        db.SaveChanges();
        //        if (aus != null)
        //            sar.RequestedAuthorizations = aus.ToList();// add request authorizations
        //        if (ems != null)
        //            sar.RequestedEmployees = ems.ToList(); // add request employees 

        //        string emailSubject = sar.ARequestType.RequestTypeDesc + (stepId == 1 ? " IT" : " Confirmation") + " - SAR Helper";
        //        string displayAtt = step == 3 ? "none" : "display";
        //        string result = EmailNotification.sendNotification(step, emailSubject, this.Page.Server, db, sar, displayAtt);
        //        if (!result.Contains("Err"))
        //            System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert('Notification has been sent.');</SCRIPT>");
        //        else
        //            System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert(':( Notification cannot be sent. Please try it later or contact IT Department.');</SCRIPT>");
        //    }
        //    catch (Exception ex)
        //    {
        //        System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert(':( Notification cannot be sent. Please try it later or contact IT Department. Err... '" + ex.Message + ");</SCRIPT>");
        //    }
        //    finally
        //    {
        //        pComment.Visible = false;
        //        db.Dispose();
        //    }
        //}

        //private bool checkHandledOrNot(Authy_Request saq)
        //{
        //    if (!saq.ExecutiveStatus.Equals("Pending") && stepId == 1)
        //    {
        //        System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert(':( Sorry, you cannot change it because it was " + saq.ExecutiveStatus + " by " + saq.ExecutiveName + " ');</SCRIPT>");
        //        return false;
        //    }
        //    else if (!saq.ITStatus.Equals("Pending") && stepId == 2)
        //    {
        //        System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert(':( Sorry, you cannot change it because it was " + saq.ITStatus + " by " + saq.ITName + " ');</SCRIPT>");
        //        return false;
        //    }
        //    else
        //        return true;
        //}
        #endregion
    }
}