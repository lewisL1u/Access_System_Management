using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Authy.Models;

namespace SAR_Helper.Pages
{
    public partial class RequestDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetRequestDetails();
        }


        //Other Methods

        public void GetRequestDetails()
        {
            using(Authy_DataContext db = new Authy_DataContext())
            {
                if(Request.QueryString["aid"] != null)
                {
                    var accessID = Convert.ToUInt32(Request.QueryString["aid"]);
                    var access = db.Accesses.Where(accessX => accessX.AccessID == accessID).FirstOrDefault();
                    try
                    {
                        int requestID = access.AccessRequest.RequestID;
                        Authy_Request req = db.Requests.Where(requestX => requestX.RequestID == requestID).FirstOrDefault();
                        if (req != null)
                        {
                            Label_RequestType.Text = req.ARequestType.RequestTypeDesc;
                            Label_RequestNumber.Text = req.RequestID.ToString();
                            Label_RequestedBy.Text = req.Requester.Username;
                            Label_RequestDate.Text = req.RequestDate.ToShortDateString();
                            Label_Comments.Text = req.RequestedByComments;
                            Label_Processedby.Text = req.ExecutiveName;
                            Label_ProcessDate.Text = req.ExecutiveProcessDate.ToShortDateString();
                            Label_ProcessorComments.Text = req.ExecutiveProcessDate.ToShortDateString();
                        }

                        else
                        {
                            Panel_RequestDetails.Visible = false;
                            Panel_Error.Visible = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        Panel_RequestDetails.Visible = false;
                        Panel_Error.Visible = true;
                    }
                }
                else
                {
                    Panel_RequestDetails.Visible = false;
                    Panel_Error.Visible = true;
                }
               
            }
        }

        public string GetFullRequestName(string initials)
        {
            if(initials == "SAR")
            {
                return "System Access Request (SAR)";
            }

            else if(initials == "SRR")
            {
                return "System Removal Request (SRR)";
            }
            else if(initials == "ETR")
            {
                return "Employee Termination Request";
            }
            else
            {
                return "Unrecognized/Invalid Request";
            }
        }
    }
}