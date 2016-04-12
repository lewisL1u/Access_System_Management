<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SelectAuthorizationsUC.ascx.cs" Inherits="Authy.UserControl.SelectAuthorizationsUC" %>
<div class="container-fluid block-gray">
    <div class="row">
        <div class="col-xs-12" style="text-align: center">
            <div>
                <i class="glyphicon glyphicon-check" style="font-size: 48px"></i>
            </div>
            <h4 style="font-weight: bold">Step 2 of 4: Select Authorization(s) to ADD</h4>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-xs-12 col-sm-4">
            <h4>Select Individual Authorization(s)</h4>
            <i style="font-size:11px; color:gray;">Quickly addressing an authorization by typing its initials.</i>
            <asp:ListBox ID="ListBox_IndividualAuthorizations" runat="server" CssClass="form-control" ItemType="Authy.Models.Authy_Authorization" DataValueField="AuthorizationID" DataTextField="AuthorizationName" SelectMethod="ListView_IndividualAuthorizations_GetData" Rows="10" OnSelectedIndexChanged="ListBox_IndividualAuthorizations_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
            <div style="margin-top: 10px">
                <asp:Button ID="Button_SelectAuthorization" runat="server" Text="Select Authorization" CssClass="btn btn-default btn-block" OnClick="Button_SelectAuthorization_Click" BackColor="YellowGreen" ForeColor="White" BorderStyle="None" />
            </div>
            <div>
                <asp:Label ID="Label_SelectAuthorization" runat="server" ForeColor="Red" Text="* Authorization already selected or nothing selected." Visible="false"></asp:Label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-8">
            <h4>Authorization Information:</h4>
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    Name:
                                <asp:Label ID="Label_AuthorizationName" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    Contact:
                                <asp:Label ID="Label_AuthorizationContact" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    ID:<asp:Label ID="Label_AuthorizationID" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    Description:
                                        <asp:Label ID="Label_AuthorizationDescription" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-xs-12 col-sm-4">
            <div>- or -</div>
            <h4>Select Authorization Group</h4>
            
            <asp:DropDownList ID="DropDownList_AuthorizationGroup" runat="server" ItemType="Authy.Models.Authy_AuthorizationGroup" DataValueField="AuthorizationGroupID" DataTextField="AuthorizationGroupName" SelectMethod="DropDownList_AuthorizationGroup_GetData" CssClass="form-control" OnSelectedIndexChanged="DropDownList_AuthorizationGroup_SelectedIndexChanged" AutoPostBack="true">
            </asp:DropDownList>
            <div style="margin-top: 10px">
                <asp:Button ID="Button_SelectAuthorizationGroup" runat="server" Text="Select Authorization Group" CssClass="btn btn-default btn-block" BackColor="YellowGreen" BorderStyle="None" ForeColor="White" OnClick="Button_SelectAuthorizationGroup_Click" />
            </div>
            <div>
                <asp:Label ID="Label_AuthorizationGroup" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-8">
            <div>&nbsp</div>
            <h4>Authorizations in Group:</h4>
            <div class="row">
                <div class="col-xs-12">
                    <asp:ListView ID="ListView_AuthorizationGroupAuthorizations" runat="server" ItemType="Authy.Models.Authy_Authorization" DataKeyNames="AuthorizationID" SelectMethod="ListView_AuthorizationGroupAuthorizations_GetData">
                        <LayoutTemplate>
                            <div id="ItemPlaceholder" runat="server"></div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            > <b>&nbsp<%#: Eval("AuthorizationName") %></b>
                        </ItemTemplate>
                        <ItemSeparatorTemplate>
                            <br />
                        </ItemSeparatorTemplate>
                        <EmptyDataTemplate>No authorizations found in this group.</EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-xs-12 col-sm-4">
            <h4>Selected Authorization(s)</h4>
            <i style="font-size:11px; color:gray;">Quickly addressing an authorization by typing its initials.</i>
            <div>
                <asp:Label ID="Label_NoAuthorizations" runat="server" Text="* No authorizations selected." ForeColor="Red" Visible="false"></asp:Label>
            </div>
            <asp:ListBox ID="ListBox_SelectedAuthorizations" runat="server" ItemType="Authy.Models.Authy_Authorization" DataValueField="AuthorizationID" DataTextField="AuthorizationName" CssClass="form-control" Rows="10" OnSelectedIndexChanged="ListBox_SelectedAuthorizations_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
            <div class="col-xs-12">
                <asp:Label ID="Label_Create_SelectedAuthorizationsCount" runat="server" Font-Italic="true" ForeColor="LightGray"></asp:Label>
            </div>
            <div style="margin-top: 10px">
                <asp:Button ID="Button_UnselectAuthorization" runat="server" Text="Unselect Authorization" CssClass="btn btn-danger btn-block" OnClick="Button_UnselectAuthorization_Click" />
            </div>
        </div>
        <div class="col-xs-12 col-sm-8">
            <h4>Selected Authorization Information:</h4>
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    Name:
                                <asp:Label ID="Label_SelectedAuthorizationName" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    Contact:
                                <asp:Label ID="Label_SelectedAuthorizationContact" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    ID:
                    <asp:Label ID="Label_SelectedAuthorizationID" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    Description:
                                <asp:Label ID="Label_SelectedAuthorizationDescription" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</div>
