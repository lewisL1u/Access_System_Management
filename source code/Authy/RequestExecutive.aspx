<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestExecutive.aspx.cs" Inherits="Authy.RequestExecutive" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Panel runat="server" ID="pComment" Visible="false">
        <asp:TextBox runat="server" ID="txtComment" TextMode="MultiLine" Rows="5" Columns="30"></asp:TextBox>
        <asp:Button runat="server" Text="Comment" ID="btnComment" OnClick="btnComment_Click" />
    </asp:Panel>
    </div>
    </form>
</body>
</html>
