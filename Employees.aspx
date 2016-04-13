<%@ Page Title="Manage Employees" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="Authy.Pages.Employees" MaintainScrollPositionOnPostback="True" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Title -->
    <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family: 'Century Gothic'">
        Manage Employees
    </div>
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container-fluid" style="background-color: #F8F8F8; padding: 20px; border-radius: 10px">
                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        <asp:LinkButton ID="LinkButton_NewEmployee" runat="server" CssClass="btn btn-default btn-block" ForeColor="YellowGreen" Font-Size="16px" ToolTip="Create a new employee." OnClick="LinkButton_NewEmployee_Click">
                            <i class="glyphicon glyphicon-plus"></i> Create New
                        </asp:LinkButton>
                    </div>
                    <div class="col-xs-12 col-sm-2">
                        <asp:LinkButton ID="LinkButton_EditEmployee" runat="server" CssClass="btn btn-default btn-block active" ForeColor="Gray" Font-Size="16px" ToolTip="Modify existing employees." OnClick="LinkButton_EditEmployee_Click">
                            <i class="glyphicon glyphicon-edit"></i> Modify Existing
                        </asp:LinkButton>
                    </div>
                </div>
                <hr />
                <asp:MultiView ID="MultiView_Employees" runat="server" ActiveViewIndex="0">
                    <asp:View runat="server">
                        <div class="row">
                            <div class="col-xs-12">
                                <asp:ListView ID="ListView_Employees" runat="server" ItemType="Authy.Models.Authy_Employee" DataKeyNames="EmployeeID" SelectMethod="ListView_Employees_GetData" DeleteMethod="ListView_Employees_DeleteItem" UpdateMethod="ListView_Employees_UpdateItem" OnSelectedIndexChanged="ListView_Employees_SelectedIndexChanged" OnSorted="ListView_Employees_Sorted" OnDataBound="ListView_Employees_DataBound">
                                    <LayoutTemplate>
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-1">
                                                Sort by:
                                            </div>
                                            <div class="col-xs-12 col-sm-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeFirstName">
                                                    First
                                                </asp:LinkButton>
                                            </div>
                                            <div class="col-xs-12 col-sm-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeLastName">
                                                    Last
                                                </asp:LinkButton>
                                            </div>
                                            <div class="col-xs-12 col-sm-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeTitle">
                                                    Title
                                                </asp:LinkButton>
                                            </div>
                                            <div class="col-xs-12 col-sm-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeBranch">
                                                    Branch
                                                </asp:LinkButton>
                                            </div>
                                            <div class="col-xs-12 col-sm-1">
                                                <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeTerminationDate">
                                                    Terminated
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <div id="ItemPlaceholder" runat="server"></div>
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
                                                <asp:Label ID="Label_EmployeeCount" runat="server" ForeColor="Gray"></asp:Label>
                                            </div>
                                        </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="margin-bottom: 10px">
                                            <asp:LinkButton runat="server" CssClass="row btn btn-default btn-block" CommandName="Select">
                                            <div class="col-xs-12">
                                                <div class="row">
                                                    <div class="col-xs-12" style="text-align:left">
                                                        <b><%#: Eval("EmployeeFirstName") + " " + Eval("EmployeeMiddleName") + " " + Eval("EmployeeLastName") + IsTerminatedText((int)Eval("EmployeeID")) %></b> 
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-2" style="text-align:left">
                                                        ID: <%#: Eval("EmployeeID") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Member Number: <%#: Eval("EmployeeMemberNumber") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Person Number: <%#: Eval("EmployeePersonNumber") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Branch: <%#: Eval("EmployeeBranch") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3" style="text-align:left">
                                                        Title: <%#: Eval("EmployeeTitle") %>
                                                    </div>
                                                </div>
                                            </div>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="row block-default" style="margin-bottom: 10px">
                                            <div class="col-xs-12">
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-11" style="text-align: left">
                                                        <b><%#: Eval("EmployeeFirstName") + " " + Eval("EmployeeMiddleName") + " " + Eval("EmployeeLastName") + IsTerminatedText((int)Eval("EmployeeID")) %></b>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-1">
                                                        <div class="col-xs-12 col-sm-1">
                                                            <asp:LinkButton ID="LinkButton_Unselect" runat="server" ForeColor="YellowGreen" OnClick="LinkButton_Unselect_Click">Unselect</asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-2" style="text-align: left">
                                                        ID: <%#: Eval("EmployeeID") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Member Number: <%#: Eval("EmployeeMemberNumber") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Person Number: <%#: Eval("EmployeePersonNumber") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                        Title: <%#: Eval("EmployeeTitle") %>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-2">
                                                        Branch: <%#: Eval("EmployeeBranch") %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-2" style="text-align: left">
                                                        Hired: <%#:GetHireDate((int)Eval("EmployeeID")) %>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-2" style="text-align: left">
                                                        Terminated: <%#: GetTerminatedDate((int)Eval("EmployeeID")) %>
                                                    </div>

                                                </div>
                                                <hr />
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-2 col-sm-offset-10">
                                                        <asp:LinkButton runat="server" CssClass="btn btn-default btn-block" CommandName="Edit" ToolTip="Edit employee">
                                                            <i class="glyphicon glyphicon-edit"></i> Edit
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EditItemTemplate>
                                        <div class="row block-default" style="margin-bottom: 10px">
                                            <div class="col-xs-12">
                                                <div class="row">
                                                    <div class="col-xs-12" style="text-align: center">
                                                        <b class="color-OECUGreen">Edit Mode</b>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                        First Name:<asp:Label runat="server" class="glyphicon glyphicon-question-sign" ToolTip="Preferred name could be added after fisrtname within &quot;&quot; or (). e.g., Jennica &quot;Jay&quot; or (Jay)" ForeColor="YellowGreen"> </asp:Label>
                                                        <asp:TextBox ID="TextBox_EditFirstName" runat="server" CssClass="form-control" Text='<%#: Eval("EmployeeFirstName") %>' ToolTip="Preferred name could be added after fisrtname within &quot;&quot; or (). e.g., Jennica &quot;Jay&quot; or (Jay)"></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextBox_EditFirstName" ForeColor="Red" Text="* Required field" ValidateGroup="Update"></asp:RequiredFieldValidator>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                        Middle Initial:
                                                        <asp:TextBox ID="TextBox_EditMiddleName" runat="server" CssClass="form-control" Text='<%#: Eval("EmployeeMiddleName") %>'></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                        Last Name:<asp:Label runat="server" class="glyphicon glyphicon-question-sign" ToolTip="Preferred name could be added after lastname within &quot;&quot; or (). e.g., Jennica &quot;Jay&quot; or (Jay)" ForeColor="YellowGreen"> </asp:Label>
                                                        <asp:TextBox ID="TextBox_EditLastName" runat="server" CssClass="form-control" Text='<%#: Eval("EmployeeLastName") %>' ToolTip="Preferred name could be added after lastname within &quot;&quot; or (). e.g., Jennica &quot;Jay&quot; or (Jay)"></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextBox_EditLastName" ForeColor="Red" Text="* Required field" ValidateGroup="Update"></asp:RequiredFieldValidator>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                        ID:
                                                        <asp:TextBox runat="server" CssClass="form-control" Text='<%#: Eval("EmployeeID") %>' ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-3">
                                                        Member Number:
                                                        <asp:TextBox ID="TextBox_EditMemberNumber" runat="server" CssClass="form-control" Text='<%#: Eval("EmployeeMembernumber") %>'></asp:TextBox>
                                                        <div>
                                                            <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="TextBox_EditMemberNumber" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Update"></asp:RequiredFieldValidator>
                                                        </div>
                                                        <div>
                                                            <asp:RegularExpressionValidator runat="server" ControlToValidate="TextBox_EditMemberNumber" ForeColor="Red" ErrorMessage="* Up to 12 numbers allowed" SetFocusOnError="true" ValidationExpression="^[0-9]{1,12}$" ValidationGroup="Update"></asp:RegularExpressionValidator>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Person Number:
                                                        <asp:TextBox runat="server" ID="TextBox_EditPersonNumber" CssClass="form-control" Text='<%#: Eval("EmployeePersonnumber") %>'></asp:TextBox>
                                                        <div>
                                                            <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="TextBox_EditPersonNumber" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Update"></asp:RequiredFieldValidator>
                                                        </div>
                                                        <div>
                                                            <asp:RegularExpressionValidator runat="server" ControlToValidate="TextBox_EditPersonNumber" ForeColor="Red" ErrorMessage="* Up to 6 numbers allowed" SetFocusOnError="true" ValidationExpression="^[0-9]{1,6}$" ValidationGroup="Update"></asp:RegularExpressionValidator>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Title:
                                                         <asp:TextBox ID="TextBox_EditTitle" runat="server" CssClass="form-control" Text='<%#: Eval("EmployeeTitle") %>'></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextBox_EditTitle" ForeColor="Red" Text="* Required field" ValidationGroup="Update"></asp:RequiredFieldValidator>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3">
                                                        Branch:
                                                        <asp:TextBox ID="TextBox_EditBranch" runat="server" CssClass="form-control" Text='<%#: Eval("EmployeeBranch") %>'></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextBox_EditBranch" ForeColor="Red" Text="* Required field" ValidationGroup="Update"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                        Hired:
                                                        <asp:TextBox ID="TextBox_EditHireDate" runat="server" CssClass="form-control" TextMode="Date" Text='<%#:GetHireDate((int)Eval("EmployeeID")) %>'></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextBox_EditHireDate" ForeColor="Red" Text="* Required field" ValidationGroup="Update"></asp:RequiredFieldValidator>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-3" style="text-align: left">
                                                        Terminated: 
                                                        <asp:TextBox ID="TextBox_EditTermDate" runat="server" CssClass="form-control" TextMode="Date" Text='<%#: GetTerminatedDate((int)Eval("EmployeeID")) %>'></asp:TextBox>
                                                    </div>
                                                </div>
                                                <hr />
                                                <asp:Panel ID="Panel_Edit" runat="server" CssClass="row">
                                                    <div class="col-xs-12 col-sm-2 col-sm-offset-6">
                                                        <asp:LinkButton runat="server" CssClass="btn btn-default btn-block" ForeColor="White" BackColor="YellowGreen" BorderColor="YellowGreen" CommandName="Update" ToolTip="Save changes" ValidationGroup="Update">
                                                            <i class="glyphicon glyphicon-save"></i> Save
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-2">
                                                        <asp:LinkButton runat="server" CssClass="btn btn-default btn-block" CommandName="Cancel" ToolTip="Cancel editing">
                                                            <i class="glyphicon glyphicon-arrow-left"></i> Cancel
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-2">
                                                        <asp:LinkButton ID="LinkButton_Delete" runat="server" CssClass="btn btn-danger btn-block" OnClick="LinkButton_Delete_Click" ToolTip="Delete employee">
                                                            <i class="glyphicon glyphicon-trash"></i> Delete
                                                        </asp:LinkButton>
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel_Delete" runat="server" CssClass="row" Visible="false">
                                                    <div class="col-xs-12">
                                                        <div class="row">
                                                            <div class="col-xs-12" style="text-align: center">
                                                                Are you sure you want to delete this employee? This cannot be undone.
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-1 col-sm-offset-5">
                                                                <asp:LinkButton runat="server" CssClass="btn btn-danger btn-block" CommandName="Delete">
                                                                    Yes
                                                                </asp:LinkButton>
                                                            </div>
                                                            <div class="col-xs-12 col-sm-1">
                                                                <asp:LinkButton ID="LinkButton_CancelDelete" runat="server" CssClass="btn btn-default btn-block" OnClick="LinkButton_CancelDelete_Click">
                                                                    No
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                    <EmptyDataTemplate>
                                        <div style="text-align: center">
                                            No employees found.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View runat="server">
                        <!-- Employee Create Area -->
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4">
                                        First Name: <asp:Label runat="server" class="glyphicon glyphicon-question-sign" ToolTip="Preferred name could be added after fisrtname within &quot;&quot; or (). e.g., Jennica &quot;Jay&quot; or (Jay)" ForeColor="YellowGreen"> </asp:Label>
                                         <asp:TextBox ID="TextBox_FirstName" runat="server" CssClass="form-control" ToolTip="Preferred name could be added after fisrtname within &quot;&quot; or (). e.g., Jennica &quot;Jay&quot; or (Jay)"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="Textbox_FirstName" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        Middle Name:
                                         <asp:TextBox ID="TextBox_MiddleName" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        Last Name:<asp:Label runat="server" class="glyphicon glyphicon-question-sign" ToolTip="Preferred name could be added after lastname within &quot;&quot; or (). e.g., Jennica &quot;Jay&quot; or (Jay)" ForeColor="YellowGreen"> </asp:Label>
                                         <asp:TextBox ID="TextBox_LastName" runat="server" CssClass="form-control" ToolTip="Preferred name could be added after lastname within &quot;&quot; or () e.g., Jennica &quot;Jay&quot; or (Jay)"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="Textbox_LastName" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4">
                                        Member Number:
                                <asp:TextBox ID="TextBox_MemberNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div>
                                            <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="TextBox_MemberNumber" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                        </div>
                                        <div>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator" runat="server" ControlToValidate="TextBox_MemberNumber" ForeColor="Red" ErrorMessage="* Up to 12 numbers allowed" SetFocusOnError="true" ValidationExpression="^[0-9]{1,12}$" ValidationGroup="Create"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        Person Number:
                                <asp:TextBox ID="TextBox_PersonNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div>
                                            <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="TextBox_PersonNumber" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                        </div>
                                        <div>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_PersonNumber" ForeColor="Red" ErrorMessage="* Up to 6 numbers allowed" SetFocusOnError="true" ValidationExpression="^[0-9]{1,6}$" ValidationGroup="Create"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        Title:
                                        <asp:TextBox ID="TextBox_Title" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="TextBox_Title" ErrorMessage="* Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4">
                                        Branch:
                                        <asp:TextBox ID="TextBox_Branch" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="TextBox_Branch" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        Hire Date:
                                        <asp:TextBox ID="TextBox_HireDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="TextBox_HireDate" ErrorMessage="*Required Field" SetFocusOnError="true" ValidationGroup="Create"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        Termination Date (Optional):<asp:TextBox ID="TextBox_TerminationDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    </div>


                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-xs-12" style="text-align: center">
                                        <asp:Label ID="Label_CreateMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-3-centered">
                                        <asp:Button ID="Button_Create" runat="server" CssClass="btn btn-default btn-block btn-lg" Width="100%" ForeColor="White" BackColor="YellowGreen" BorderStyle="None" Text="Create Employee" OnClick="Button_Create_Click" ValidationGroup="Create" />
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
