<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Authy.Pages.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Title -->
    <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family: 'Century Gothic'">
        Manage Users
    </div>
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container-fluid" style="background-color: #F8F8F8; padding: 20px; border-radius: 10px">
                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        <asp:LinkButton ID="LinkButton_NewItem" runat="server" CssClass="btn btn-default btn-block" ForeColor="YellowGreen" Font-Size="16px" ToolTip="Create a new users." OnClick="LinkButton_NewItem_Click">
                            <i class="glyphicon glyphicon-plus"></i> Create New
                        </asp:LinkButton>
                    </div>
                    <div class="col-xs-12 col-sm-2">
                        <asp:LinkButton ID="LinkButton_EditItem" runat="server" CssClass="btn btn-default btn-block active" ForeColor="Gray" Font-Size="16px" ToolTip="Modify existing users." OnClick="LinkButton_EditItem_Click">
                            <i class="glyphicon glyphicon-edit"></i> Modify Existing
                        </asp:LinkButton>
                    </div>
                </div>
                <hr />
                <asp:MultiView ID="MultiView_Users" runat="server" ActiveViewIndex="0">
                    <asp:View runat="server">
                        <!-- User Listview -->
                        <div class="row">
                            <div class="col-xs-12">
                                <asp:ListView ID="ListView_Users" runat="server" SelectMethod="ListView_Users_GetData" UpdateMethod="ListView_Users_UpdateItem" DeleteMethod="ListView_Users_DeleteItem" DataKeyNames="UserID" OnSelectedIndexChanged="ListView_Users_SelectedIndexChanged" OnSorted="ListView_Users_Sorted" OnItemDataBound="ListView_Users_ItemDataBound">
                                    <LayoutTemplate>
                                        <div class="row">
                                            <div class="col-xs-1">
                                                Sort by:&nbsp
                                            </div>
                                            <div class="col-xs-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="UserName">
                                                    Name
                                                </asp:LinkButton>
                                            </div>
                                            <div class="col-xs-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="Role.RoleName">
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
                                            <b><%#: Eval("UserName") %></b>
                                        </div>
                                        <div class="col-xs-12 col-sm-3" style="text-align:left">
                                                Role:&nbsp<%#: GetRoleName((Authy.Models.Authy_Role)Eval("Role")) %>
                                        </div>
                                        <div class="col-xs-12 col-sm-1">
                                            ID:&nbsp<%#: Eval("UserID") %>
                                        </div>
                                        <div class="col-xs-12 col-sm-3" style="text-align:right">
                                            Email:&nbsp<%#: Eval("UserEmail") %>
                                        </div>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="block-default" style="margin-bottom: 5px; text-align: center">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-11" style="text-align: left">
                                                    <b><%#: Eval("UserName") %></b>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ID="LinkButton_Unselect" ForeColor="YellowGreen" OnClick="LinkButton_Unselect_Click">
                                                        Unselect
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                    Role:&nbsp<%#: GetRoleName((Authy.Models.Authy_Role)Eval("Role")) %></div>
                                                <div class="col-xs-12 col-sm-1">
                                                    ID:&nbsp<%#: Eval("UserID") %></div>
                                                <div class="col-xs-12 col-sm-3">
                                                    Email:&nbsp<%#: Eval("UserEmail") %></div>
                                            </div>
                                            <hr />
                                            <asp:Panel ID="Panel_Modify" CssClass="row" runat="server">
                                                <div class="col-xs-12 col-sm-2 col-sm-offset-8">
                                                    <asp:LinkButton ID="LinkButton_Edit" runat="server" CssClass="btn btn-default btn-block" CommandName="Edit">
                                                <i class="glyphicon glyphicon-edit"></i> Edit
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-2">
                                                    <asp:LinkButton ID="LinkButton_Delete" runat="server" CssClass="btn btn-danger btn-block" ToolTip="Delete the selected user." OnClick="LinkButton_Delete_Click">
                                            <i class="glyphicon glyphicon-trash"></i> Delete
                                                    </asp:LinkButton>
                                                </div>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel_Delete" runat="server" CssClass="row" Visible="false">
                                                <div class="col-xs-12" style="text-align: center">
                                                    Are you sure you want to delete this user? This cannot be undone, and they will lose access to Authy.
                                                </div>
                                                <div class="col-xs-12 col-sm-2 col-sm-offset-4">
                                                    <asp:LinkButton ID="LinkButton_ConfirmDelete" runat="server" CssClass="btn btn-danger btn-block" OnClick="LinkButton_ConfirmDelete_Click" ToolTip="Delete the selected user.">
                                                        Delete
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-2">
                                                    <asp:LinkButton ID="LinkButton_CancelDelete" runat="server" CssClass="btn btn-default btn-block" OnClick="LinkButton_CancelDelete_Click" ToolTip="Cancel the deletion.">
                                                         Cancel
                                                    </asp:LinkButton>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        No users found.
                                    </EmptyDataTemplate>
                                    <EditItemTemplate>
                                        <div class="block-green" style="margin-bottom: 5px;">
                                            <div class="color-OECUGreen" style="text-align: center">
                                                <b>Edit Mode</b>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-3">
                                                    <div>
                                                        Username:
                                                    </div>
                                                    <asp:TextBox ID="TextBox_EditUserName" runat="server" CssClass="form-control" Text='<%#: Eval("UserName") %>'></asp:TextBox>
                                                    <asp:TextBox ID="TextBox_EditUserName_Hidden" runat="server" Visible="false" Text='<%#: Eval("UserName") %>'></asp:TextBox>
                                                </div>
                                                <div class="col-xs-3">
                                                    <div>
                                                        Email:
                                                    </div>
                                                    <asp:TextBox ID="TextBox_EditEmail" runat="server" CssClass="form-control" Text='<%#: Eval("UserEmail") %>'></asp:TextBox>
                                                </div>
                                                <div class="col-xs-12 col-sm-3">
                                                    <div>
                                                        Role:
                                                    </div>
                                                    <asp:DropDownList ID="DropDownList_EditRole" runat="server" CssClass="form-control" ItemType="Authy.Models.Authy_Role" DataValueField="RoleID" DataTextField="RoleName" SelectMethod="DropDownList_EditRole_GetData">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-12 col-sm-3">
                                                    ID:
                                                <asp:TextBox runat="server" CssClass="form-control" Text='<%#: Eval("UserID") %>' ReadOnly="true"></asp:TextBox>
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
                                        <asp:Label ID="Label_EditSuccess" runat="server" ForeColor="Green" Text="User updated successfully!" Visible="false"></asp:Label>
                                    </div>
                                </div>
                                <div class="row" style="text-align: center">
                                    <div class="col-xs-12">
                                        <asp:Label ID="Label_DeleteSuccess" runat="server" ForeColor="Red" Text="User has been deleted." Visible="false"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View runat="server">
                        <!-- Create Authorization Area -->
                        <div class="row block-gray">
                            <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4">
                                        Username (firstname.lastname):
                                    <asp:TextBox ID="Textbox_UserName" runat="server" CssClass="form-control" OnTextChanged="Textbox_UserName_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="Textbox_UserName" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                     Role:
                                    <asp:DropDownList ID="DropDownList_CreateRole" runat="server" CssClass="form-control" ItemType="Authy.Models.Authy_Role" DataValueField="RoleID" DataTextField="RoleName" SelectMethod="DropDownList_CreateRole_GetData">
                                    </asp:DropDownList>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        Email:
                                    <asp:TextBox ID="Textbox_Email" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12" style="text-align: center">
                                        <asp:Label ID="Label_CreateMessage" runat="server" ForeColor="Green"></asp:Label>
                                    </div>
                                    <div class="col-xs-12" style="text-align: center">
                                        <asp:Label ID="Label_DuplicateUser" runat="server" ForeColor="Red" Text="This user already exists in the system."></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12" style="padding-left: 37.5%">
                                        <asp:Button ID="Button_Create" runat="server" CssClass="btn btn-default btn-block" ForeColor="White" BackColor="YellowGreen" BorderStyle="None" Text="Create User" OnClick="Button_Create_Click" ValidationGroup="Create" />
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
