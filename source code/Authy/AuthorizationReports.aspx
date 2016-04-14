<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AuthorizationReports.aspx.cs" Inherits="SAR_Helper.Pages.AuthorizationReports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family: 'Century Gothic'">
            Authorization Reports
         <div style="font-size:18px">
            <table class="table">

            <tr>
            <td>Show All</td>
            <td>Group</td>
            <td>Active</td>
            </tr>
            
            <tr>
             <td>
                <asp:DropDownList ID="DropDownList_ShowAll" runat="server"  Width="100px" OnSelectedIndexChanged="DropDownList_ShowAll_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Selected="True">YES</asp:ListItem>
                <asp:ListItem>NO</asp:ListItem>
            </asp:DropDownList>
             </td> 
            <td>
             <asp:DropDownList ID="DropDownList_Group" runat="server" Width="100px" Enabled="False">
             </asp:DropDownList>
            </td>
                <td>
                <asp:DropDownList ID="DropDownList_Active" runat="server"  Width="100px">
                <asp:ListItem Selected="True">ALL</asp:ListItem>
                <asp:ListItem>YES</asp:ListItem>
                <asp:ListItem>NO</asp:ListItem>
                    
            </asp:DropDownList>
                    <asp:Button ID="SelectButton" Text="Generate Report" runat="server" CommandName="Select" /><br />
                </td>
             </tr>
            
            

            </table>
</div>
            <br />
            <br />
         

         <div>
         <br />
         <asp:ListView ID="ListView_AuthorizationReport" runat="server" DataKeyNames="AuthorizationID" ItemType="Authy.Models.Authy_Authorization" SelectMethod="ListView_AuthorizationReport_GetData">
             <LayoutTemplate>
                <table class ="table table-striped"  runat="server">
                    <tr>
                        <th >
                            Name
                        </th>
                        <th>
                            Contact
                        </th>
                        <th>
                            Descriptian
                        </th>
                    </tr>
                    <tr id="itemplaceholder" runat="server">
                    </tr>
            </table>
                
            </LayoutTemplate>

             <ItemTemplate>  
                 <div></div>
                        <tr>
                            <td><%#: Eval("AuthorizationName") %></td>
                            <td><%#: Eval("AuthorizationContact") %></td>
                            <td><%#: Eval("AuthorizationDescription") %></td>
                        </tr>     
            </ItemTemplate> 
         </asp:ListView>
         <br />
    </div>
    <%--<img src="Images/Page_Under_Construction.jpg" />--%>
    <br />
     </div>
</asp:Content>
