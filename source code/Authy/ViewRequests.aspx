<%@ Page Title="Pending Requests" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewRequests.aspx.cs" Inherits="Authy.Pages.ViewSARs" %>

<%@ Register Src="~/UserControl/RequestInforUC.ascx" TagPrefix="uc1" TagName="RequestInforUC" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family: 'Century Gothic'">
        View Requests
    </div>
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container-fluid" style="background-color: #F8F8F8; padding: 20px; border-radius: 10px">
                <div class="row">
                    <div class="col-xs-12">
                        <asp:DropDownList ID="DropDownList_Requests" runat="server" CssClass="form-control" OnSelectedIndexChanged="DropDownList_Requests_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Text="My Requests" Value="My"></asp:ListItem>
                            <asp:ListItem Text="All Pending Requests" Value="Pending"></asp:ListItem>
                            <asp:ListItem Text="All Processed Requests" Value="Processed"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-xs-12">
                        <asp:MultiView ID="MultiView_ViewSARs" runat="server" ActiveViewIndex="0">
                            <!-- Only shows the user's requests -->
                            <asp:View runat="server">
                                <asp:ListView ID="ListView_MyRequests" runat="server" ItemType="Authy.Models.Authy_Request" DataKeyNames="RequestID" SelectMethod="ListView_MyRequests_GetData" OnDataBound="ListView_MyRequests_DataBound">
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
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestType">
                                                    Reqeust Type
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="ITStatus">
                                                    Status
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
                                                           Request #: <b><%#:  Eval("RequestID") %></b>
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
                                        
                                        <uc1:RequestInforUC runat="server" ID="RequestInforUC" RequestID="<%# this.ListView_MyRequests.SelectedValue  %>" IsShownProcessingBtn="false"/>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <div style="text-align: center">
                                            There are no pending requests at the moment.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </asp:View>
                            <!-- Pending Requests -->
                            <asp:View runat="server">
                                <asp:ListView ID="ListView_PendingRequests" runat="server" ItemType="Authy.Models.Authy_Request" DataKeyNames="RequestID" SelectMethod="ListView_PendingRequests_GetData">
                                    <LayoutTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-1">
                                                    Sort by:
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestID">
                                                    Request Number
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestType">
                                                    Type
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestedBy">
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
                                        
                                        <uc1:RequestInforUC runat="server" ID="RequestInforUC" RequestID="<%# this.ListView_PendingRequests.SelectedValue  %>" IsShownProcessingBtn="false"/>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <div style="text-align: center">
                                            There are no pending requests at the moment.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </asp:View>
                            <!-- Processed Requests -->
                            <asp:View runat="server">

                                <asp:ListView ID="ListView_ProcessedRequests" runat="server" ItemType="Authy.Models.Authy_Request" DataKeyNames="RequestID" SelectMethod="ListView_ProccessedRequests_GetData" OnDataBound="ListView_ProcessedRequests_DataBound">
                                    <LayoutTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-1">
                                                    Sort by:
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestID">
                                                    Request Number
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="RequestType">
                                                    Type
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="col-xs-12 col-sm-1">
                                                    <asp:LinkButton runat="server" ForeColor="YellowGreen" CommandName="Sort" CommandArgument="Status">
                                                    Status
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div id="ItemPlaceholder" runat="server"></div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-9">
                                                    <asp:DataPager runat="server" PageSize="10">
                                                        <Fields>
                                                            <asp:NextPreviousPagerField ButtonCssClass="color-OECUGreen" PreviousPageText="<" ShowNextPageButton="false" />
                                                            <asp:NumericPagerField NumericButtonCssClass="color-OECUGreen" />
                                                            <asp:NextPreviousPagerField ButtonCssClass="color-OECUGreen" NextPageText=">" ShowPreviousPageButton="false" />
                                                        </Fields>
                                                    </asp:DataPager>
                                                </div>
                                                <div class="col-xs-12 col-sm-3" style="text-align: right">
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
                                        
                                        <uc1:RequestInforUC runat="server" ID="RequestInforUC" RequestID="<%# this.ListView_ProcessedRequests.SelectedValue  %>" IsShownProcessingBtn="false"/>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <div style="text-align: center">
                                            There are no processsed requests at the moment.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </asp:View>
                        </asp:MultiView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
