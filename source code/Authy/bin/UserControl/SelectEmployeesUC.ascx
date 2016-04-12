<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SelectEmployeesUC.ascx.cs" Inherits="Authy.UserControl.SelectEmployeesUC" %>
<div class="row">
    <div class="col-xs-12 col-sm-4">
        <h4>Select Individual Employee(s)</h4>
        <i style="font-size:11px; color:gray;">Quickly addressing an employee by typing one's initial of first name.</i>
        <asp:ListBox ID="ListBox_Employees" runat="server" CssClass="form-control" ItemType="Authy.Models.Authy_Employee" DataValueField="EmployeeID" DataTextField="EmployeeLastName" SelectMethod="ListBox_Employees_GetData" Rows="10" OnDataBound="ListBox_Employees_DataBound" OnSelectedIndexChanged="ListBox_Employees_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
        <div style="margin-top: 10px">
            <asp:Button ID="Button_SelectEmployee" runat="server" Text="Select Employee" CssClass="btn btn-default btn-block" OnClick="Button_SelectEmployee_Click" BackColor="YellowGreen" ForeColor="White" BorderStyle="None" />
        </div>
        <div>
            <asp:Label ID="Label_SelectEmployee" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>
    </div>
    <div class="col-xs-12 col-sm-8">
        <h4>Employee Information:</h4>
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                First Name:
                                       <asp:Label ID="Label_EmployeeFirstName" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                Middle Name:
                                       <asp:Label ID="Label_EmployeeMiddleName" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                Last Name:
                                        <asp:Label ID="Label_EmployeeLastName" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-4">
                Member Number:
                                        <asp:Label ID="Label_EmployeeMemberNumber" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="col-xs-12 col-sm-4">
                Person Number:
                                        <asp:Label ID="Label_EmployeePersonNumber" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-4">
                Title:
                                        <asp:Label ID="Label_EmployeeTitle" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="col-xs-12 col-sm-4">
                Branch:
                                        <asp:Label ID="Label_EmployeeBranch" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-4">
                Hire Date:
                                        <asp:Label ID="Label_EmployeeHireDate" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="col-xs-12 col-sm-4">
                Termination Date:
                                        <asp:Label ID="Label_EmployeeTerminationDate" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12">
                Authorizations:
                                        <asp:ListView ID="ListView_Accesses" runat="server" ItemType="Authy.Models.Authy_Access" DataKeyNames="AccessID" SelectMethod="ListView_Accesses_GetData">
                                            <LayoutTemplate>
                                                <div id="ItemPlaceholder" runat="server"></div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        &gt <b><%#: GetAccessAuthorizationName((int)Eval("AccessID")) %></b>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
            </div>
        </div>
    </div>
</div>
<hr />
<div class="row">
    <div class="col-xs-12 col-sm-4">
        <div>- or -</div>
        <h4>Select Employee Group</h4>
        <asp:DropDownList ID="DropDownList_EmployeeGroup" runat="server" ItemType="Authy.Models.Authy_EmployeeGroup" DataValueField="EmployeeGroupID" DataTextField="EmployeeGroupName" SelectMethod="DropDownList_EmployeeGroup_GetData" CssClass="form-control" OnSelectedIndexChanged="DropDownList_EmployeeGroup_SelectedIndexChanged" AutoPostBack="true">
        </asp:DropDownList>
        <div style="margin-top: 10px">
            <asp:Button ID="Button_SelectEmployeeGroup" runat="server" Text="Select Group" CssClass="btn btn-default btn-block" BackColor="YellowGreen" ForeColor="White" BorderStyle="None" OnClick="Button_SelectEmployeeGroup_Click" />
        </div>
        <div>
            <asp:Label ID="Label_EmployeeGroup" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>
    </div>
    <div class="col-xs-12 col-sm-8">
        <div>&nbsp</div>
        <h4>Employees in Group:</h4>
        <div class="row">
            <div class="col-xs-12">
                <asp:ListView ID="ListView_EmployeeGroup" runat="server" ItemType="Authy.Models.Authy_Employee" DataKeyNames="EmployeeID" SelectMethod="ListView_EmployeeGroup_GetData">
                    <LayoutTemplate>
                        <div id="ItemPlaceholder" runat="server"></div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        > <b><%#: Eval("EmployeeFirstName") + " " + Eval("EmployeeMiddleName") + " " + Eval("EmployeeLastName")  + IsTerminated((DateTime)Eval("EmployeeTerminationDate")) + " (" + Eval("EmployeeTitle") + ", " + Eval("EmployeeBranch") + ", " + Eval("EmployeeMemberNumber") + ")" %></b>
                    </ItemTemplate>
                    <ItemSeparatorTemplate>
                        <br />
                    </ItemSeparatorTemplate>
                    <EmptyDataTemplate>No employees found in this group.</EmptyDataTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
</div>
<hr />
<div class="row">
    <div class="col-xs-12 col-sm-4">
        <h4>Selected Employee(s)</h4>
        <i style="font-size:11px; color:gray;">Quickly addressing an employee by typing one's initial of first name.</i>
        <div>
            <asp:Label ID="Label_NoEmployees" runat="server" Text="* No employees selected." ForeColor="Red" Visible="false"></asp:Label>
        </div>
        <asp:ListBox ID="ListBox_SelectedEmployees" runat="server" ItemType="Authy.Models.Authy_Employee" DataValueField="EmployeeID" DataTextField="EmployeeLastName" CssClass="form-control" Rows="10" OnSelectedIndexChanged="ListBox_SelectedEmployees_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
        <div>
            <asp:Label ID="Label_Create_SelectedEmployeeCount" runat="server" Font-Italic="true" ForeColor="LightGray"></asp:Label></div>
        <div style="margin-top: 10px">
            <asp:Button ID="Button_DeselectEmployee" runat="server" Text="Unselect Employee" CssClass="btn btn-danger btn-block" OnClick="Button_DeselectEmployee_Click" />
        </div>
    </div>
    <div class="col-xs-12 col-sm-8">
        <h4>Selected Employee Information:</h4>
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                First Name:
                                        <asp:Label ID="Label_SelectedEmployeeFirstName" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                Middle Name:
                                        <asp:Label ID="Label_SelectedEmployeeMiddleName" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                Last Name:
                                        <asp:Label ID="Label_SelectedEmployeeLastName" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-4">
                Member Number:
                                        <asp:Label ID="Label_SelectedEmployeeMemberNumber" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="col-xs-12 col-sm-4">
                Person Number:<asp:Label ID="Label_SelectedEmployeePersonNumber" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-4">
                Title:
                                        <asp:Label ID="Label_SelectedEmployeeTitle" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="col-xs-12 col-sm-4">
                Branch:
                                        <asp:Label ID="Label_SelectedEmployeeBranch" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12 col-sm-4">
                Hire Date:
                                        <asp:Label ID="Label_SelectedEmployeeHireDate" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="col-xs-12 col-sm-4">
                Termination Date:
                                        <asp:Label ID="Label_SelectedEmployeeTerminationDate" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-xs-12">
                Authorizations:
                                        <asp:ListView ID="ListView_EmployeeAccesses" runat="server" ItemType="Authy.Models.Authy_Access" DataKeyNames="AccessID" SelectMethod="ListView_EmployeeAccesses_GetData">
                                            <LayoutTemplate>
                                                <div id="ItemPlaceholder" runat="server"></div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        &gt <b><%#: GetAccessAuthorizationName((int)Eval("AccessID")) %></b>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
            </div>
        </div>
    </div>
</div>
