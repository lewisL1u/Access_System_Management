<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestDetails.aspx.cs" Inherits="SAR_Helper.Pages.RequestDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Request Detail</title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/custom.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12 col-sm-4 col-sm-offset-4">
                    <asp:Image runat="server" ImageUrl="Images/OECU-logo.png" Width="100%" Height="28%" />
                </div>
            </div>
        </div>
        <asp:Panel ID="Panel_RequestDetails" runat="server" CssClass="container" Width="80%">
            <div class="row">
                <div class="col-xs-12" style="text-align: center; font-size: 24px; font-family: 'Century Gothic'">
                    <asp:Label ID="Label_RequestType" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12" style="text-align: center; font-size: 18px;">
                    <asp:Label ID="Label_RequestNumber" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12" style="text-align: center; font-size: 18px; font-weight: bold">
                    <asp:Label ID="Label_RequestStatus" runat="server"></asp:Label>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-xs-12" style="font-size: 14px;">
                    Requested By:
                    <asp:Label ID="Label_RequestedBy" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12" style="font-size: 14px;">
                    Request Date:
                    <asp:Label ID="Label_RequestDate" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12 col-sm-6">
                    <div class="row">
                        <div class="col-xs-12">
                            Requested Employees:
                            <asp:ListView ID="ListView_Employees" runat="server" SelectMethod=""></asp:ListView>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6">
                    <div class="row">
                        <div class="col-xs-12">
                            Requested Authorizations
                            <asp:ListView ID="ListView_Authorizations" runat="server" SelectMethod=""></asp:ListView>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12">
                    Comments:
                    <asp:Label ID="Label_Comments" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-xs-12">
                    Processed By:
                    <asp:Label ID="Label_Processedby" runat="server" Font-Bold="true"></asp:Label>
                </div>
                <div class="col-xs-12">
                    Process Date:
                    <asp:Label ID="Label_ProcessDate" runat="server" Font-Bold="true"></asp:Label>
                </div>
                <div class="col-xs-12">
                    Processor Comments:
                    <asp:Label ID="Label_ProcessorComments" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="Panel_Error" runat="server" CssClass="container-fluid" Visible="false">
            <br />
            <div class="row">
                <div class="col-xs-12" style="text-align: center; font-weight: bold">
                    Sorry! :(
                </div>
                <div class="col-xs-12" style="text-align: center">
                    This request does not exist, has been deleted, or no request has been selected.
                </div>
            </div>
        </asp:Panel>
    </form>
</body>
</html>
