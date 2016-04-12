<%@ Page Title="Manage Requests" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageRequests.aspx.cs" Inherits="Authy.Pages.ManageRequests" %>

<%@ Register Src="~/UserControl/RequestInforUC.ascx" TagPrefix="uc1" TagName="RequestInforUC" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family: 'Century Gothic'">
        Manage Requests
    </div>
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container-fluid" style="background-color: #F8F8F8; padding: 20px; border-radius: 10px">
                <div>
                    <asp:ListView ID="ListView_PendingRequests" runat="server" ItemType="Authy.Models.Authy_Request" DataKeyNames="RequestID" SelectMethod="ListView_PendingRequests_GetData" OnDataBound="ListView_PendingRequests_DataBound">
                        <LayoutTemplate>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-1">
                                        Sort by:
                                    </div>
                                    <div class="col-xs-12 col-sm-1">
                                        <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestDate">
                                            Request Date
                                        </asp:LinkButton>
                                    </div>
                                    <div class="col-xs-12 col-sm-1">
                                        <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestBy">
                                        Requester
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
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-xs-12" style="margin-bottom: 5px">
                                    <asp:LinkButton runat="server" CssClass="btn btn-default btn-block" CommandName="Select">
                                        <div class="row" style="padding-left:20px; text-align:left">
                                            <div class="col-xs-12" style="font-size:16px; font-weight:bold">
                                                <%#: Eval("ARequestType.RequestTypeDesc") %>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-left:20px">
                                            <div class="col-xs-12 col-sm-2" style="text-align:left">
                                                Request #: <b><%#: Eval("RequestID") %></b>
                                            </div>
                                            <div class="col-xs-12 col-sm-4" style="text-align:left">
                                                Requested By:&nbsp<b><%#: Item.Requester.Username %></b>
                                            </div>
                                            <div class="col-xs-12 col-sm-2" style="text-align:left">
                                                Submitted:&nbsp<b><%#: Authy.Helper.Helper.ToShortDateString((DateTime)Eval("RequestDate")) %></b>
                                            </div>
                                            <div class="col-xs-12 col-sm-2">
                                                Exec. Status:&nbsp<b><%# Eval("ExecutiveStatus") %></b>
                                            </div>
                                            <div class="col-xs-12 col-sm-2">
                                                IT Status:&nbsp<b><%# Eval("ITStatus") %></b>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-left:20px">
                                            <div class="col-xs-12 col-sm-2" style="text-align:left">
                                                Employee(s):&nbsp<b><%# GetRequestEmployeeCount((int)Eval("RequestID")) %></b>
                                            </div>
                                            <div class="col-xs-12 col-sm-2" style="text-align:left">
                                                Authorization(s):&nbsp<b><%# GetRequestAuthorizationCount((int)Eval("RequestID")) %></b>
                                            </div>
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                        <SelectedItemTemplate>
                            <uc1:RequestInforUC runat="server" id="RequestInforUC" OnAproveClick="RequestInforUC_AproveClick" RequestID="<%# this.ListView_PendingRequests.SelectedValue  %>" IsShownProcessingBtn="true" OnDeclineClick="RequestInforUC_DeclineClick" />
                        </SelectedItemTemplate>
                        <EmptyDataTemplate>
                            <div style="text-align:center">
                                You have no Requests needing your attention right now.
                            </div>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
