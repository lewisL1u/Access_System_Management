<%@ Page Title="Manage Roles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="Authy.Pages.Roles" %>

<%@ Register Src="~/UserControl/PermissionsUC.ascx" TagPrefix="uc1" TagName="PermissionsUC" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Title -->
    <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family: 'Century Gothic'">
        Manage Roles
    </div>
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container-fluid" style="background-color: #F8F8F8; padding: 20px; border-radius: 10px">
                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        <asp:LinkButton ID="LinkButton_NewItem" runat="server" CssClass="btn btn-default btn-block" ForeColor="YellowGreen" Font-Size="16px" ToolTip="Create a new role." OnClick="LinkButton_NewItem_Click">
                            <i class="glyphicon glyphicon-plus"></i> Create New
                        </asp:LinkButton>
                    </div>
                    <div class="col-xs-12 col-sm-2">
                        <asp:LinkButton ID="LinkButton_EditItem" runat="server" CssClass="btn btn-default btn-block active" ForeColor="Gray" Font-Size="16px" ToolTip="Modify existing roles." OnClick="LinkButton_EditItem_Click">
                            <i class="glyphicon glyphicon-edit"></i> Modify Existing
                        </asp:LinkButton>
                    </div>
                </div>
                <hr />
                <asp:MultiView ID="MultiView_Roles" runat="server" ActiveViewIndex="0">
                    <asp:View runat="server">
                        <!-- Role Listview -->
                        <div class="row">
                            <div class="col-xs-12 col-sm-12">
                                <asp:ListView ID="ListView_Roles" runat="server" SelectMethod="ListView_Roles_GetData" UpdateMethod="ListView_Roles_UpdateItem" DeleteMethod="ListView_Roles_DeleteItem" DataKeyNames="RoleID" OnSelectedIndexChanged="ListView_Roles_SelectedIndexChanged" OnSorted="ListView_Roles_Sorted" OnItemDataBound="ListView_Roles_ItemDataBound">
                                    <LayoutTemplate>
                                        <div class="row">
                                            <div class="col-xs-1">
                                                Sort by:&nbsp
                                            </div>
                                            <div class="col-xs-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="RoleName">
                                                    Name
                                                </asp:LinkButton>
                                            </div>
                                            <div class="col-xs-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="Role">
                                                    Role
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div id="ItemPlaceholder" runat="server"></div>
                                            </div>
                                        </div>
                                       <div class="row">
                                           <div class="col-xs-12 col-sm-10">
                                               <asp:DataPager runat="server" PageSize="10">
                                                   <Fields>
                                                       <asp:NextPreviousPagerField ButtonCssClass="color-OECUGreen" PreviousPageText="<" ShowNextPageButton="false" />
                                                       <asp:NumericPagerField NumericButtonCssClass="color-OECUGreen" />
                                                       <asp:NextPreviousPagerField ButtonCssClass="color-OECUGreen" NextPageText=">" ShowPreviousPageButton="false" />
                                                   </Fields>
                                               </asp:DataPager>
                                           </div>
                                           <div class="col-xs-12 col-sm-2">
                                               <asp:Label ID="Label_ItemCount" runat="server" ForeColor="Gray"></asp:Label>
                                           </div>
                                       </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="margin-bottom: 5px" class="container">
                                            <asp:LinkButton runat="server" CssClass="btn btn-default btn-block row" CommandName="Select">
                                                <div class="col-xs-12" style="text-align:left">
                                                    <b><%#: Eval("RoleName") %></b>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    ID:&nbsp<%#: Eval("RoleID") %></div>
                                                 <div class="col-xs-12 col-sm-3">
                                                    Users:&nbsp<%#: GetUserCount((int)Eval("RoleID")) %></div>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="block-default" style="margin-bottom: 5px;">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-11" style="text-align: left">
                                                    <b><%#: Eval("RoleName") %></b>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ID="LinkButton_Unselect" ForeColor="YellowGreen" OnClick="LinkButton_Unselect_Click">
                                                        Unselect
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    ID:&nbsp<%#: Eval("RoleID") %></div>
                                                 <div class="col-xs-12 col-sm-3">
                                                    Users:&nbsp<%#: GetUserCount((int)Eval("RoleID")) %></div>
                                            </div>
                                             <hr />
                                                <div class="row">
                                                    <div class="col-xs-12" style="font-style:italic">
                                                        Permissions:
                                                    </div>
                                                </div>
                                                <br />
                                                <%--<div class="row">
                                                    <div class="col-xs-12">
                                                        New Requests:
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        <asp:Label ID="LVLabel_NewSAR" runat="server" ForeColor="gray" ToolTip="Allows the user to create new SAR forms." OnLoad="LVLabel_NewSAR_Load"><asp:Panel ID="Panel_NewSAR" runat="server" CssClass="glyphicon glyphicon-remove" OnLoad="Panel_NewSAR_Load"></asp:Panel>Create New SAR</asp:Label>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        <asp:Label ID="LVLabel_NewSRR" runat="server" ForeColor="gray" ToolTip="Allows the user to create new SRR forms." OnLoad="LVLabel_NewSRR_Load"><asp:Panel ID="Panel_NewSRR" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_NewSRR_Load"></asp:Panel>Create New SRR</asp:Label>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        <asp:Label ID="LVLabel_ETR" runat="server" ForeColor="gray" OnClick="LinkButton_NewETR_Click" ToolTip="Allows the user to create new ETR forms." OnLoad="LVLabel_NewETR_Load"><asp:Panel ID="Label_ETR" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_NewETR_Load"></asp:Panel>Create New ETR</asp:Label>
                                                    </div>
                                                </div>
                                                <hr />
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        Existing Requests:
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                      <asp:Label ID=LVLabel_ViewRequests runat="server" ForeColor="gray" OnLoad="LVLabel_ViewRequests_Load" ToolTip="Allows the user to view existing requests."><asp:Panel ID="Panel_ViewRequests" runat="server" CssClass="glyphicon glyphicon-remove" OnLoad="Panel_ViewRequests_Load"></asp:Panel> View Requests</asp:Label>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                      <asp:Label ID="LVLabel_ManageRequests_Initial" runat="server" ForeColor="gray" ToolTip="Allows the user to manage existing requests with initial authority (i.e. Executives)." OnLoad="LVLabel_ManageRequests_Initial_Load"><asp:Panel ID="Panel_ManageRequests" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_ManageRequests_Initial_Load"></asp:Panel> Manage Requests (Executive)</asp:Label>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                      <asp:Label ID="LVLabel_ManageRequests_Final" runat="server" ForeColor="gray" ToolTip="Allows the user to manage existing requests with final authority (i.e. IT)." OnLoad="LVLabel_ManageRequests_Final_Load"><asp:Panel ID="Panel_ManageRequests_Final" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_ManageRequests_Final_Load"></asp:Panel> Manage Requests (IT)</asp:Label>
                                                    </div>
                                                </div>
                                                <hr />
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        Reports:
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                       <asp:Label ID="LVLabel_Reports" runat="server" ForeColor="gray" ToolTip="Allows the user to view reports." OnLoad="LVLabel_Reports_Load"><asp:Panel ID="Panel_Reports" runat="server" CssClass="glyphicon glyphicon-remove" OnLoad="Panel_Reports_Load"></asp:Panel> View Reports</asp:Label>
                                                    </div>
                                                </div>
                                                <hr />
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        Authorizations:
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                       <asp:Label ID="LVLabel_Authorizations" runat="server" ForeColor="gray" ToolTip="Allows the user to add, delete, or modify authorizations in the database." OnLoad="LVLabel_Authorizations_Load"><asp:Panel ID="Panel_Authorizations" runat="server" CssClass="glyphicon glyphicon-remove" OnLoad="Panel_Authorizations_Load"></asp:Panel> Manage Authorizations</asp:Label>
                                                    </div>
                                                     <div class="col-xs-12 col-sm-3">
                                                       <asp:Label ID="LVLabel_AuthorizationGroups" runat="server" ForeColor="gray" ToolTip="Allows the user to add, delete, or modify authorization groups in the database." OnLoad="LVLabel_AuthorizationGroups_Load"><asp:Panel ID="Panel_AuthorizationGroups" runat="server" class="glyphicon glyphicon-remove" ToolTip="Allows the user to add, delete, or modify authorization groups in the database." OnLoad="Panel_AuthorizationGroups_Load"></asp:Panel> Manage Authorization Groups</asp:Label>
                                                    </div>
                                                </div>
                                                <hr />
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        Employees:
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                      <asp:Label ID="LVLabel_Employees" runat="server" ForeColor="gray" ToolTip="Allows the user to add, delete, or modify employees in the database." OnLoad="LVLabel_Employees_Load"><asp:Panel ID="Panel_Employees" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_Employees_Load"></asp:Panel> Manage Employees</asp:Label>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                       <asp:Label ID="LVLabel_EmployeeGroups" runat="server" ForeColor="gray" ToolTip="Allows the user to add, delete, or modify employee groups in the database." OnLoad="LVLabel_EmployeeGroups_Load"><asp:Panel ID="Panel_EmployeeGroups" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_EmployeeGroups_Load"></asp:Panel> Manage Employee Groups</asp:Label>
                                                    </div>
                                                </div>
                                                 <hr />
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        Authy Users:
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        <asp:Label ID="LVLabel_Users" runat="server" ForeColor="gray" ToolTip="Allows the user to add, delete, or modify users in the database." OnLoad="LVLabel_Users_Load"><asp:Panel ID="Panel_Users" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_Users_Load"></asp:Panel> Manage Users</asp:Label>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                       <asp:Label ID="LVLabel_Roles" runat="server" ForeColor="gray"  ToolTip="Allows the user to add, delete, or modify roles in the database." OnLoad="LVLabel_Roles_Load"><asp:Panel id="Panel_Roles" runat="server" class="glyphicon glyphicon-remove" OnLoad="Panel_Roles_Load"></asp:Panel> Manage Roles</asp:Label>
                                                    </div>
                                                </div>--%>
                                            <uc1:PermissionsUC runat="server" id="PermissionsUC"/>
                                            <hr />
                                            <asp:Panel ID="Panel_Modify" CssClass="row" runat="server">
                                                <div class="col-xs-12 col-sm-2 col-sm-offset-8">
                                                    <asp:LinkButton runat="server" CssClass="btn btn-default btn-block" ForeColor="White" BackColor="YellowGreen" BorderColor="YellowGreen" ID="roleSave" OnClick="roleSave_Click" ToolTip="Save changes">
                                                            <i class="glyphicon glyphicon-save"></i> Save
                                                        </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-2">
                                                    <asp:LinkButton ID="LinkButton_Delete" runat="server" CssClass="btn btn-danger btn-block" ToolTip="Delete the selected Role." OnClick="LinkButton_Delete_Click">
                                                        <i class="glyphicon glyphicon-trash"></i> Delete
                                                    </asp:LinkButton>
                                                    <asp:Label ID="Label_RoleInUse" runat="server" Visible="false" Text="* Role is assigned to one or more users. The role cannot be deleted. " ForeColor="Red"></asp:Label>
                                                </div>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel_Delete" runat="server" CssClass="row" Visible="false">
                                                <div class="col-xs-12" style="text-align: center">
                                                    Are you sure you want to delete this Role? This cannot be undone.
                                                </div>
                                                <div class="col-xs-12 col-sm-2 col-sm-offset-4">
                                                    <asp:LinkButton ID="LinkButton_ConfirmDelete" runat="server" CssClass="btn btn-danger btn-block" OnClick="LinkButton_ConfirmDelete_Click" ToolTip="Delete the selected Role.">
                                                        Delete
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-2">
                                                    <asp:LinkButton ID="LinkButton_CancelDelete" runat="server" CssClass="btn btn-default btn-block" OnClick="LinkButton_CancelDelete_Click" ToolTip="Cancel the deletion.">
                                                         Cancel
                                                    </asp:LinkButton>
                                                </div>
                                            </asp:Panel>
                                            <%--<br />
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-12" style="text-align:center;color:gray">
                                                     * Role editing is not available at this time. To edit a role, you must create a new role with the desired permissions.
                                                </div>
                                            </div>--%>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        No roles found.
                                    </EmptyDataTemplate>
                                    <EditItemTemplate>
                                        <div class="block-green" style="margin-bottom: 5px;">
                                            <div class="color-OECUGreen" style="text-align: center">
                                                <b>Edit Mode</b>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-3">
                                                    <div>
                                                        Role Name:
                                                    </div>
                                                    <asp:TextBox ID="TextBox_EditRoleName" runat="server" CssClass="form-control" Text='<%#: Eval("RoleName") %>'></asp:TextBox>
                                                    <asp:TextBox ID="TextBox_EditRoleName_Hidden" runat="server" Visible="false" Text='<%#: Eval("RoleName") %>'></asp:TextBox>
                                                </div>
                                                <div class="col-xs-12 col-sm-3">
                                                    ID:
                                                <asp:TextBox runat="server" CssClass="form-control" Text='<%#: Eval("RoleID") %>' ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-2 col-sm-offset-8">
                                                    <asp:LinkButton ID="LinkButton_SaveEdit" runat="server" CssClass="btn btn-success btn-block" ToolTip="Save changes." CommandName="Update">
                                                        <i class="glyphicon glyphicon-save"></i> Save
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-2">
                                                    <asp:LinkButton ID="LinkButton_CancelEdit" runat="server" CssClass="btn btn-default btn-block" CommandName="Cancel" ToolTip="Cancel editing.">
                                                         Cancel
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:ListView>
                            </div>
                            <div class="col-xs-12">
                                <div class="row" style="text-align: center">
                                    <div class="col-xs-12">
                                        <asp:Label ID="Label_EditSuccess" runat="server" ForeColor="Green" Text="Role updated successfully!" Visible="false"></asp:Label>
                                    </div>
                                </div>
                                <div class="row" style="text-align: center">
                                    <div class="col-xs-12">
                                        <asp:Label ID="Label_DeleteSuccess" runat="server" ForeColor="Red" Text="Role has been deleted." Visible="false"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View runat="server">
                        <!-- Create New Role Area -->
                        <div class="row block-gray">
                            <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4" style="font-weight:bold">
                                        Role Name:
                                        <asp:TextBox ID="Textbox_RoleName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="Textbox_RoleName" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12" style="font-weight:bold">
                                        Permissions: (click to select)
                                    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-xs-12">
                                        New Requests:
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_NewSAR" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_NewSAR" runat="server" ForeColor="gray" OnClick="LinkButton_NewSAR_Click" ToolTip="Allows the user to create new SAR forms."><i id="i_NewSAR" runat="server" class="glyphicon glyphicon-remove"></i> Create New SAR</asp:LinkButton>
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                         <asp:CheckBox ID="CheckBox_NewSRR" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_NewSRR" runat="server" ForeColor="gray" OnClick="LinkButton_NewSRR_Click" ToolTip="Allows the user to create new SRR forms."><i id="i_NewSRR" runat="server" class="glyphicon glyphicon-remove"></i> Create New SRR</asp:LinkButton>
                                    </div>
                                      <div class="col-xs-12 col-sm-3">
                                         <asp:CheckBox ID="CheckBox_NewETR" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_NewETR" runat="server" ForeColor="gray" OnClick="LinkButton_NewETR_Click" ToolTip="Allows the user to create new ETR forms."><i id="i_NewETR" runat="server" class="glyphicon glyphicon-remove"></i> Create New ETR</asp:LinkButton>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12">
                                        Existing Requests:
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_ViewRequests" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_ViewRequests" runat="server" ForeColor="gray" OnClick="LinkButton_ViewRequests_Click" ToolTip="Allows the user to view existing requests."><i id="i_ViewRequests" runat="server" class="glyphicon glyphicon-remove"></i> View Requests</asp:LinkButton>
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_ManageRequests_Initial" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_ManageRequests_Initial" runat="server" ForeColor="gray" OnClick="LinkButton_ManageRequests_Initial_Click" ToolTip="Allows the user to manage requests with initial authority (i.e. executives)."><i id="i_ManageRequests_Initial" runat="server" class="glyphicon glyphicon-remove"></i> Manage Requests - Initial</asp:LinkButton>
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_ManageRequests_Final" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_ManageRequests_Final" runat="server" ForeColor="gray" OnClick="LinkButton_ManageRequests_Final_Click" ToolTip="Allows the user to manage existing requests with final authority (i.e. IT)"><i id="i_ManageRequests_Final" runat="server" class="glyphicon glyphicon-remove"></i> Manage Requests - Final</asp:LinkButton>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12">
                                        Reports:
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_Reports" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_Reports" runat="server" ForeColor="gray" OnClick="LinkButton_Reports_Click" ToolTip="Allows the user to view reports."><i id="i_Reports" runat="server" class="glyphicon glyphicon-remove"></i> View Reports</asp:LinkButton>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12">
                                        Authorizations:
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_Authorizations" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_Authorizations" runat="server" ForeColor="gray" OnClick="LinkButton_Authorizations_Click" ToolTip="Allows the user to add, delete, or modify authorizations in the database."><i id="i_Authorizations" runat="server" class="glyphicon glyphicon-remove"></i> Manage Authorizations</asp:LinkButton>
                                    </div>
                                     <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_AuthorizationGroups" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_AuthorizationGroups" runat="server" ForeColor="gray" OnClick="LinkButton_AuthorizationGroups_Click" ToolTip="Allows the user to add, delete, or modify authorization groups in the database."><i id="i_AuthorizationGroups" runat="server" class="glyphicon glyphicon-remove" ToolTip="Allows the user to add, delete, or modify authorization groups in the database."></i> Manage Authorization Groups</asp:LinkButton>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12">
                                        Employees:
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_Employees" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_Employees" runat="server" ForeColor="gray" OnClick="LinkButton_Employees_Click" ToolTip="Allows the user to add, delete, or modify employees in the database."><i id="i_Employees" runat="server" class="glyphicon glyphicon-remove"></i> Manage Employees</asp:LinkButton>
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_EmployeeGroups" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_EmployeeGroups" runat="server" ForeColor="gray" OnClick="LinkButton_EmployeeGroups_Click" ToolTip="Allows the user to add, delete, or modify employee groups in the database."><i id="i_EmployeeGroups" runat="server" class="glyphicon glyphicon-remove"></i> Manage Employee Groups</asp:LinkButton>
                                    </div>
                                </div>
                                 <hr />
                                <div class="row">
                                    <div class="col-xs-12">
                                        Authy Users:
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                        <asp:CheckBox ID="CheckBox_Users" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_Users" runat="server" ForeColor="gray" OnClick="LinkButton_Users_Click" ToolTip="Allows the user to add, delete, or modify users in the database."><i id="i_Users" runat="server" class="glyphicon glyphicon-remove"></i> Manage Users</asp:LinkButton>
                                    </div>
                                    <div class="col-xs-12 col-sm-3">
                                       <asp:CheckBox ID="CheckBox_Roles" runat="server" Visible="false" />&nbsp <asp:LinkButton ID="LinkButton_Roles" runat="server" ForeColor="gray" OnClick="LinkButton_Roles_Click" ToolTip="Allows the user to add, delete, or modify roles in the database."><i id="i_Roles" runat="server" class="glyphicon glyphicon-remove"></i> Manage Roles</asp:LinkButton>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12" style="padding-left: 37.5%">
                                        <asp:Button ID="Button_Create" runat="server" CssClass="btn btn-default btn-block" ForeColor="White" BackColor="YellowGreen" BorderStyle="None" Text="Create Role" OnClick="Button_Create_Click" ValidationGroup="Create" />
                                    </div>
                                     <div class="col-xs-12" style="padding-left: 37.5%;">
                                        <asp:Label runat="server" ID="Label_DuplicateRole" ForeColor="Red" Text="* A role with this name already exists." Visible="false"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
