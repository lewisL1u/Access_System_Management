<%@ Page Title="Employee Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeReports.aspx.cs" Inherits="SAR_Helper.Pages.EmployeeReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family: 'Century Gothic'">
        Employee Reports
    </div>
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container-fluid">
                <div class="row block-gray">
                    <div class="col-xs-12">
                        <asp:Panel runat="server" ID="Panel_GenerateReport" DefaultButton="BtnGenerate">
                            <div class="row">
                                <div class="col-xs-12" style="text-align: center; font-size: 18px">
                                    Select Report Criteria
                                </div>
                                <br />
                                <div class="form-group">
                                    <div class="col-xs-12">
                                        
                                        <div class="container">
                                            <div class="inner-addon right-addon">
                                                
                                            <i class="glyphicon glyphicon-search" ></i>
                                                
                                                <asp:TextBox runat="server" ID="tb_search" class="form-control" Style="max-width: 100%" placeholder="Search by Fisrtname, Lastname, Member Number, or Person Number"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:Button ID="BtnGenerate" runat="server" CssClass="btn btn-default btn-block" ForeColor="White" BackColor="YellowGreen" BorderStyle="None" Text="Search" OnClick="BtnGenerate_Click" style="display:none" />

                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-12">
                        <asp:ListView ID="ListView_EmployeeReport" runat="server" ItemType="Authy.Models.Authy_Employee" DataKeyNames="EmployeeID" SelectMethod="ListView_EmployeeReport_GetData" OnItemDataBound="ListView_EmployeeReport_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-1">
                                        Sort by:
                                    </div>
                                    <div class="col-xs-12 col-sm-1">
                                        <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeFirstName">
                                                    First Name
                                        </asp:LinkButton>
                                    </div>
                                    <div class="col-xs-12 col-sm-1">
                                        <asp:LinkButton runat="server" CssClass="color-OECUGreen" CommandName="Sort" CommandArgument="EmployeeLastName">
                                                    Last Name
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
                                        <asp:DataPager runat="server" PageSize="5">
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
                                <div class="row block-default" style="margin-bottom: 10px">
                                    <div class="col-xs-12">
                                        <div class="row">
                                            <div class="col-xs-12" style="font-weight: bold; font-size: 18px">
                                                <%#: Eval("EmployeeFirstName") + " " +  Eval("EmployeeMiddleName") + " " + Eval("EmployeeLastName") %>
                                            </div>
                                            <div class="col-xs-12 col-sm-3">
                                                Title: <%#: Eval("EmployeeTitle") %>
                                            </div>
                                            <div class="col-xs-12 col-sm-3">
                                                Branch: <%#: Eval("EmployeeBranch") %>
                                            </div>
                                            <div class="col-xs-12 col-sm-3">
                                                Member Number: <%#: Eval("EmployeeMemberNumber") %>
                                            </div>
                                            <div class="col-xs-12 col-sm-3">
                                                Authy ID: <%#: Eval("EmployeeID") %>
                                            </div>
                                            <div class="col-xs-12 col-sm-3">
                                                Hire Date: <%#: CustomShortDateString((DateTime)Eval("EmployeeHireDate")) %>
                                            </div>
                                            <div class="col-xs-12 col-sm-3">
                                                Termination Date: <%#: CustomShortDateString((DateTime)Eval("EmployeeTerminationDate")) %>
                                            </div>
                                        </div>
                                        <br />
                                        <asp:HiddenField ID="HiddenField_EmployeeID" runat="server" Value='<%#: Eval("EmployeeID") %>' />
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <asp:ListView ID="ListView_EmployeeAuthorizations" runat="server" ItemType="Authy.Models.Authy_Access" GroupItemCount="4">
                                                    <LayoutTemplate>
                                                        <table>
                                                            <tr id="GroupPlaceHolder" runat="server">
                                                            </tr>
                                                        </table>
                                                    </LayoutTemplate>
                                                    <GroupTemplate>
                                                        <tr>
                                                            <td id="ItemPlaceHolder" runat="server"></td>
                                                        </tr>
                                                    </GroupTemplate>
                                                    <ItemTemplate>
                                                        <td style="padding-left: 10px; padding-top: 2px">
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <%#: Container.DisplayIndex+1 + ". " %><a style="font-weight: bold" href='<%#: "RequestDetails.aspx?aid=" + Eval("AccessID")  %>'><%#: GetAuthorizationName((int)Eval("AccessID")) %></a>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </ItemTemplate>
                                                    <GroupSeparatorTemplate>
                                                        <tr runat="server">
                                                            <td></td>
                                                        </tr>
                                                    </GroupSeparatorTemplate>
                                                    <EmptyDataTemplate>
                                                        <div class="row">
                                                            <div class="col-xs-12">
                                                                No authorizations.
                                                            </div>
                                                        </div>
                                                    </EmptyDataTemplate>
                                                </asp:ListView>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <div style="text-align: center">
                                    No employees found.
                                </div>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
