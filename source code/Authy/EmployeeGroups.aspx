<%@ Page Title="Manage Employee Groups" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeGroups.aspx.cs" Inherits="Authy.Pages.EmployeeGroups" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <asp:UpdatePanel runat="server" >
            <ContentTemplate>
                <!-- Page Title -->
                <div class="row">
                    <div class="col-xs-12" style="text-align:center; color:yellowgreen">
                        <h3>Manage Employee Groups</h3>
                    </div>
                </div>
                <br />
                <div class="row block-gray">
                    <div class="col-xs-12" style="text-align: center;">
                        <h4 style="font-weight:bold">Modify Existing Employee Groups</h4>
                    </div>
                    <div class="col-xs-12 col-sm-6">
                        <!-- Group ListView -->
                        <div class="row">
                            <div class="col-xs-12">
                                <asp:ListView ID="ListView_Groups" runat="server" ItemType="Authy.Models.Authy_EmployeeGroup" DataKeyNames="EmployeeGroupID" SelectMethod="ListView_Groups_GetData" UpdateMethod="ListView_Groups_UpdateItem" DeleteMethod="ListView_Groups_DeleteItem" OnSelectedIndexChanged="ListView_Groups_SelectedIndexChanged">
                                    <LayoutTemplate>
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-2">
                                                Sort by:
                                            </div>
                                            <div class="col-xs-12 col-sm-2">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeGroupName">
                                            <div>Name</div>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <div style="margin-bottom: 5px">
                                            <div id="ItemPlaceholder" runat="server"></div>
                                        </div>
                                        <asp:DataPager runat="server" PageSize="10">
                                            <Fields>
                                                <asp:NumericPagerField NumericButtonCssClass="color-OECUGreen" />
                                            </Fields>
                                        </asp:DataPager>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_SelectGroup" runat="server" CssClass="btn btn-default btn-block" CommandName="Select">
                                    <div class="row" style="text-align:center">
                                        <div class="col-xs-12 col-sm-12">
                                            <b><%#: Eval("EmployeeGroupName") %></b>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-7">
                                            Employees:
                                           <%#: GetNumberOfEmployees(Eval("EmployeeGroupID").ToString()) %>
                                        </div>
                                          <div class="col-xs-12 col-sm-2">
                                             ID:
                                             <%#: Eval("EmployeeGroupID") %>
                                        </div>
                                    </div>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="block-default" style="margin-top: 5px; margin-bottom: 5px">
                                            <div class="row" style="text-align: center">
                                                <div class="col-xs-12 col-sm-12">
                                                    <b><%#: Eval("EmployeeGroupName") %></b>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-6 col-sm-offset-2">
                                                    Employees:
                                                <%#: GetNumberOfEmployees(Eval("EmployeeGroupID").ToString()) %>
                                                </div>
                                                <div class="col-xs-12 col-sm-2">
                                                    ID:
                                                <%#: Eval("EmployeeGroupID") %>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-2 col-sm-offset-5">
                                                    <asp:LinkButton ID="LinkButton_Edit_Command" runat="server" CssClass="btn btn-default btn-block" CommandName="Edit" OnCommand="LinkButton_Edit_Command" ToolTip="Edit employee group.">
                                                <i class="glyphicon glyphicon-edit"></i>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EditItemTemplate>
                                        <div style="margin-top: 5px; margin-bottom: 5px">
                                            <asp:Panel ID="Panel_EditItem" CssClass="block-green" runat="server">
                                                <div class="row" style="text-align: center">
                                                    <div class="col-xs-12 col-sm-12">
                                                        <b><%#: Eval("EmployeeGroupName") %></b>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-6 col-sm-offset-2">
                                                        Employees:
                                                        <%#: GetNumberOfEmployees(Eval("EmployeeGroupID").ToString()) %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-2">
                                                        ID:
                                                        <%#: Eval("EmployeeGroupID") %>
                                                    </div>
                                                </div>
                                                <hr />
                                                <!-- Editing Panel -->
                                                <asp:Panel ID="Panel_Edit" runat="server" CssClass="row">
                                                    <div class="col-xs-12 col-sm-2 col-sm-offset-3">
                                                        <asp:LinkButton ID="LinkButton_Save" runat="server" CssClass="btn btn-default btn-block" ForeColor="White" BackColor="YellowGreen" BorderStyle="None" CommandName="Update" OnCommand="LinkButton_Save_Command" ToolTip="Save changes.">
                                                            <i class="glyphicon glyphicon-save"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-2">
                                                        <asp:LinkButton ID="LinkButton_Cancel" runat="server" CssClass="btn btn-default btn-block" CommandName="Cancel" OnCommand="LinkButton_Cancel_Command" ToolTip="Cancel editing.">
                                                            <i class="glyphicon glyphicon-arrow-left"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-2">
                                                        <asp:LinkButton ID="LinkButton_Delete" runat="server" CssClass="btn btn-danger btn-block" OnClick="LinkButton_Delete_Click" ToolTip="Delete employee group.">
                                                            <i class="glyphicon glyphicon-trash"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                </asp:Panel>
                                                <!-- Delete Panel -->
                                                <asp:Panel ID="Panel_Delete" runat="server" CssClass="row" Visible="false">
                                                    <div class="col-xs-12">
                                                        <div class="row">
                                                            <div class="col-xs-12" style="text-align: center">
                                                                Are you sure you want to delete this employee group? This cannot be undone.
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-2 col-sm-offset-4">
                                                                <asp:Button runat="server" CssClass="btn btn-danger btn-block" Text="Yes" CommandName="Delete" />
                                                            </div>
                                                            <div class="col-xs-12 col-sm-2">
                                                                <asp:Button ID="Button_CancelDelete" runat="server" CssClass="btn btn-default btn-block" Text="No" OnClick="Button_CancelDelete_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </asp:Panel>
                                        </div>
                                    </EditItemTemplate>
                                    <EmptyDataTemplate>
                                        No employee groups found.
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </div>
                    <!-- Preset Authorization ListBoxes -->
                    <div class="col-xs-12 col-sm-6">
                        <div class="row">
                            <asp:Panel ID="Panel_EditEmployees" runat="server" CssClass="col-xs-12 block-default">
                                 <div class="row">
                                    <div class="col-xs-12" style="text-align: center">
                                        <asp:Label ID="Label_ViewMode" runat="server"  Text="View-Only Mode" Font-Bold="true"></asp:Label>
                                        <asp:Label ID="Label_EditMode" runat="server" CssClass="color-OECUGreen" Text="Edit Mode" Font-Bold="true" Visible="false"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6" style="text-align: center">
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div>Employees in Selected Group:</div>
                                                <asp:ListBox ID="ListBox_Current" runat="server" CssClass="form-control" Rows="15" OnSelectedIndexChanged="ListBox_Current_SelectedIndexChanged" SelectMethod="ListBox_Current_GetData" DataValueField="EmployeeID" DataTextField="EmployeeLastName" OnDataBound="ListBox_Current_DataBound" AutoPostBack="true"></asp:ListBox>
                                            </div>
                                        </div>
                                        <div class="row" style="margin-top: 5px">
                                            <div class="col-xs-12">
                                                <asp:LinkButton ID="LinkButton_RemoveEmployee" runat="server" CssClass="btn btn-default btn-block" OnClick="LinkButton_RemoveEmployee_Click" Visible="false" ToolTip="Remove from employee group.">
                                                    <i class="glyphicon glyphicon-chevron-right"></i> 
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <asp:Label ID="Label_DuplicateError" runat="server" ForeColor="Red" Text="* Employee is already on the list." Visible="false"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-6" style="text-align: center;">
                                        <div class="row">
                                            <div class="col-xs-12">
                                                Available Employees:
                                                <asp:ListBox ID="ListBox_Available" runat="server" ItemType="Authy.Models.Authy_Employee" DataValueField="EmployeeID" DataTextField="EmployeeLastName" SelectMethod="ListBox_Available_GetData" CssClass="form-control" Rows="15" OnSelectedIndexChanged="ListBox_Available_SelectedIndexChanged" OnDataBound="ListBox_Available_DataBound" AutoPostBack="true"></asp:ListBox>
                                            </div>
                                        </div>
                                        <div class="row" style="margin-top: 5px">
                                            <div class="col-xs-12">
                                                <asp:LinkButton ID="LinkButton_AddEmployee" runat="server" CssClass="btn btn-default btn-block" OnClick="LinkButton_AddEmployee_Click" Visible="false" ToolTip="Add to employee group.">
                                                    <i class="glyphicon glyphicon-chevron-left"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12" style="text-align: center">
                                        <asp:Label ID="Label_UpdateSuccess" runat="server" ForeColor="Green" Text="Group updated successfully!" Visible="false"></asp:Label>
                                        <asp:Label ID="Label_DeleteSuccess" runat="server" ForeColor="Red" Text="Group has been deleted." Visible="false"></asp:Label>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <br />
                <!-- Create Preset Area -->
                <div class="row block-gray">
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12" style="text-align: center;">
                                <h4 style="font-weight:bold">Create New Employee Group</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-3 col-sm-offset-4">
                                Name:
                                <asp:TextBox ID="TextBox_CreateGroup" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-xs-12 col-sm-2">
                                &nbsp
                                <asp:Button ID="Button_CreateGroup" runat="server" CssClass="btn btn-white btn-block" ForeColor="White" BackColor="YellowGreen" BorderStyle="None" Text="Create Group" OnClick="Button_CreateGroup_Click" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12" style="text-align: center">
                                <asp:Label ID="Label_CreateSuccess" runat="server" ForeColor="Green" Text="Group created successfully!" Visible="false"></asp:Label>
                                <asp:Label ID="Label_CreateDuplicateError" runat="server" ForeColor="Red" Text="A group with this name already exists." Visible="false"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
