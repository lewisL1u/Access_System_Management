<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Unauthorized.aspx.cs" Inherits="Authy.Pages.Unauthorized" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12" style="text-align:center">
                    <asp:Image runat="server" ImageUrl="/Images/OECU-logo.png" Width="25%" Height="7%" />
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12" style="text-align:center">
                        <div>
                        <h1>Sorry! :(</h1>
                        </div>
                        <div>It looks like you don't have permission to view this page. Please contact IT if you believe this is a mistake.</div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
