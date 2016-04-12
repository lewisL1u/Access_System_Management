<%@ Page Title="New ETR" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ETR.aspx.cs" Inherits="Authy.Pages.ETR" MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="~/UserControl/SelectEmployeesUC.ascx" TagPrefix="uc1" TagName="SelectEmployees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align: center; color: #1a1a4c; font-size: 24px; font-family:'Century Gothic'">
        Employee Termination Request (ETR)
    </div>
    <br />
    <asp:UpdatePanel runat="server" ID="updatePanel">
        <ContentTemplate>
            <asp:MultiView ID="MultiView_SARForm" runat="server" ActiveViewIndex="0">
                <asp:View ID="View_Create" runat="server">
                    <div class="container-fluid block-gray">
                        <div class="row">
                            <div class="col-xs-12" style="text-align: center">
                                <div>
                                    <i class="glyphicon glyphicon-user" style="font-size: 48px"></i>
                                </div>
                                <h4 style="font-weight: bold">Step 1 of 3: Select Employee(s)</h4>
                            </div>
                        </div>
                        <hr />
                        <uc1:SelectEmployees runat="server" ID="SelectEmployees" />
                    </div>
                    <br />
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12" style="text-align: center">
                                <i class="glyphicon glyphicon-arrow-down" style="color: lightgray; font-size: 48px"></i>
                            </div>
                        </div>
                    </div>
                     <div class="container-fluid block-gray">
                         <div class="row">
                            <div class="col-xs-12" style="text-align: center">
                                <div>
                                    <i class="glyphicon glyphicon-pencil" style="font-size: 48px"></i>
                                </div>
                                <h4 style="font-weight: bold">Step 2 of 3: Comments (optional)</h4>
                            </div>
                        </div>
                         <hr />
                         <div class="row">
                             <div class="col-xs-12 col-sm-3-centered">
                                 <asp:TextBox ID="TextBox_Comments" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                             </div>
                         </div>
                    </div>
                    <br />
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-sm-offset-4">
                                <asp:LinkButton ID="LinkButton_Review" runat="server" CssClass="btn btn-default btn-block btn-lg" ForeColor="White" BackColor="YellowGreen" OnClick="LinkButton_Review_Click">
                                    <i class="glyphicon glyphicon-thumbs-up"></i>&nbsp Review and Submit
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </asp:View>
                <!-- Review -->
                <asp:View ID="View_Review" runat="server">
                    <div class="container-fluid block-gray">
                         <div class="row">
                             <div class="col-xs-12 col-sm-4">
                                 <asp:LinkButton ID="LinkButton_Revise" runat="server" CommandName="PrevView" ForeColor="LightGray" Font-Size="48px" ToolTip="Make changes to the request.">
                                     <i class="glyphicon glyphicon-circle-arrow-left"></i>
                                 </asp:LinkButton>
                             </div>
                            <div class="col-xs-12 col-sm-4" style="text-align: center">
                                <div>
                                    <i class="glyphicon glyphicon-thumbs-up" style="font-size: 48px"></i>
                                </div>
                                <h4 style="font-weight: bold">Step 3 of 3: Review and Submit ETR</h4>
                            </div>
                        </div>
                        <hr />
                         <div class="row">
                            <div class="col-xs-12">
                                Selected Employee(s):
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <asp:BulletedList ID="BulletedList_SelectedEmployees" runat="server" Font-Bold="true" OnLoad="BulletedList_SelectedEmployees_Load"></asp:BulletedList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <asp:Label ID="Label_SelectedEmployeeCount" runat="server" Font-Italic="true" ForeColor="LightGray" OnLoad="Label_SelectedEmployeeCount_Load"></asp:Label>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-12">
                                Comments:
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <asp:Label ID="Label_Comments" runat="server" Font-Bold="true"></asp:Label>
                            </div>
                        </div>
                        <hr />
                         <div class="row">
                            <div class="col-xs-12">
                                Submitted By:
                                <asp:Label ID="Label_Username" runat="server" Font-Bold="true" OnLoad="Label_Username_Load"></asp:Label>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-xs-12">
                                Current Date:
                                <asp:Label ID="Label_SubmitDate" runat="server" Font-Bold="true" OnLoad="Label_SubmitDate_Load"></asp:Label>
                            </div>
                        </div>
                        <hr />
                        <div class="row" style="display:none">
                            <div class="col-xs-12 col-sm-8 col-sm-offset-2" style="text-align:center">
                                <asp:CheckBox ID="CheckBox_Sign" runat="server" OnCheckedChanged="CheckBox_Sign_CheckedChanged"  AutoPostBack="true"/>
                                I agree that the above ETR information is correct and that I have permission to create this ETR.
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-sm-offset-4">
                                <asp:LinkButton ID="LinkButton_Submit" runat="server" CssClass="btn btn-default btn-block btn-lg" ForeColor="White" BackColor="YellowGreen" OnCommand="LinkButton_Submit_Command" CommandName="NextView">
                                    Submit ETR
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="View_Submitted" runat="server">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12" style="text-align:center">
                                <asp:Panel runat="server" ID="sucessfulPannel">
                                    Your request has been submitted for approval, and you will get an email whether approved or declined. In the meantime, you can view its status <a href="ViewRequests.aspx">here</a> or submit a new SAR <a href="ETR.aspx">here</a>.
                                </asp:Panel>
                                <asp:Panel runat="server" ID="failurePannel">
                                    Ops :( Your request cannot be submitted. Please try it later or contact IT department.<br />
                                    Err: <asp:Label runat="server" ID="errMessage"></asp:Label>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="LinkButton_Submit" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="updatePanel">
        <ProgressTemplate>
            <style type="text/css">
                #loading-div {
                    width: 572px;
                    height: 304px;
                    text-align: center;
                    position: absolute;
                    left: 50%;
                    top: 50%;
                    margin-left: -300px;
                    margin-top: -100px;
                }

                #loading-div-background {
                    position: fixed;
                    top: 0;
                    left: 0;
                    background: gray;
                    width: 100%;
                    height: 100%;
                }
            </style>
            <div id="loading-div-background">
                <div id="loading-div" class="ui-corner-all">
                    <img src="images/please_wait.gif" alt="Loading.." />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
