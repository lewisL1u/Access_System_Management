<%@ Page Title="Help - Authy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="Authy.Help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/docs.min.css" rel="stylesheet" />
    <script src="Scripts/docs.min.js"></script>
    <style type="text/css">
        p {
            margin: 0 0 10px;
        }

        h2 {
            font-size: 30px;
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: 500;
            line-height: 1.1;
            display: block;
            -webkit-margin-before: 0.83em;
            -webkit-margin-after: 0.83em;
            -webkit-margin-start: 0px;
            -webkit-margin-end: 0px;
        }

        img {
            margin: 0 0 10px;
            width: 100%;
        }
    </style>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h4>We highly recommend you viewing Authy through Chrome</h4>
            The following instructions are to show you how to use the Authy.
        </div>

    </div>
    <div class="container bs-docs-container">
        <div class="row">
            <div class="col-md-9" role="main">


                <div class="bs-docs-section">

                    <h2 id="overview" class="media-heading page-header">Overview</h2>
                    <p class="lead">Authy is an assistant of Authorization management to approach better, simpler, faster access request.  </p>
                </div>
                <asp:Panel ID="sar" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">


                            <h2 id="newRequest" class="media-heading page-header">How to Create a New Request</h2>

                            <h2 id="selectEmployee" class="media-heading">Select Employee</h2>
                            <p>Select any employee in the “Select Individual Employee(s)” list. All authorizations, the selected employee has been given so far, are shown right after the &quot;Employee Information&quot;. (As shown in the pic below)</p>
                        </div>
                        <div class="media-left">
                            <img class="media-object" src="Images/sar_help1.png">
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="selectEmployeeGroup">Select Employees Via Group</h2>
                            <p>(How to set up a group click <a href="#manageEmpGroups">here</a>) Select group&nbsp; in the “Select Employee Group” list and click “Select Group”. While the group is selected, employees who are in the group will appeare on the right side. (As shown in the pic below)</p>
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help2.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="unselectEmployee">Unselect Employee</h2>
                            <p>Once employees are selected, they will show in the “Selected Employee(s)” list. Everyone inside can be removed by clicking “Unselect Employee”. Also, related information is shown on the right. (As shown in the pic below)</p>
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help4.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="selectAuthorization">Select Authorization </h2>
                            <p>Select one authorization in the “Select Individual Authorizations” list and click the “Select Authorization” button. Authorization information is shown on the right. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help5.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="selectAuGroup">Select Authorization Group </h2>
                            <p>Select one group in the “Select Authorization Group” list and then click the “Select Authorization group” button. All authorizations in the selected group will be shown on the right. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help6.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="unselectAu">Unselect Authorization </h2>
                            <p>Select an authorization in the “Selected Authorization(s)” list and click the “Unselected Authorization” button. The authorization information will show on the right. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help7.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="comments">Comments </h2>
                            <p>Comments here are optional but highly recommend. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help8.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="submitRequest">Submit Request </h2>
                            <p>After you choose the “Review and Submit” button, all information will be shown here. (As shown in the pics below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help9.png" />
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help10.png" />
                        </div>
                        <div class="media-left">
                            <img src="Images/sar_help11.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="viewRequest" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 id="viewRequests" class="media-heading page-header">How to View Requests </h2>
                            <p>Filter requests to get narrow results.(As shown in the pic below)</p>
                            <ul style="display: list-item">
                                <li>My Request: Show your requests.</li>
                                <li>All Pending Request: Show your pending requests.</li>
                                <li>All Processed Request: Show your processed requests.</li>
                            </ul>
                        </div>
                        <div class="media-left">
                            <img src="Images/ViewRequests1.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="manageRequest" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 id="manageRequests" class="media-heading page-header">How to Manage Requests </h2>
                            <p>Executive is a role of an underwriter while IT is a role of an administrator. In other words, when an Executive approves a request, IT has the right to approve or decline it. However, if an Executive declines a request, it will be cancelled, which means IT will not receive a notification. Whether a request is approved or declined, a notification email will be sent to the person who submitted the request. </p>

                            <h2 class="media-heading" id="byAuthy">Via Authy </h2>
                            <p>Review request information and then click to approve or decline. (As shown in the pic below)</p>
                        </div>
                        <div class="media-left">
                            <img src="Images/manageRequests1.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="byEmail">Via Email </h2>
                            <p>An email notification from sar.helper@oecu.org will be sent with the request information, and an option to approve, approve with comments, or decline with comments. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/manageRequests2.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="authorReports" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 id="reports" class="media-heading page-header">Reports </h2>


                            <h2 class="media-heading" id="auReports">Authorization Reports (Under construction…) </h2>
                            <p>This report is to show every authorization with all related employees. </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/Page_Under_Construction.jpg" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="emlReports" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="employeeReports">Employee Reports  </h2>
                            <p>This report is to show every employee with all related authorizations. The function of “Generate Report” is under construction… (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/EmployeeReports1.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="manageAuth" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 id="authorizations" class="media-heading page-header">How to Manage Authorizations </h2>

                            <h2 class="media-heading" id="newAuth">Create New </h2>
                            <p>Input information of the new authorization. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/ManageAuthorizations1.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="modifyAuth">Modify Existing </h2>
                            <p>Choose an authorization and then click the “Edit” button. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/ManageAuthorizations2.png" />
                        </div>
                        <p>Edit information and save. (As shown in the pic below) </p>
                        <div class="media-left">
                            <img src="Images/ManageAuthorizations3.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="manageAuthGroup" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 id="manageAuthorizationsGroup" class="media-heading page-header">How to Manage Authorization Group </h2>
                            <p>First, type the group name and then click the “Create Group” button. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/authGroup1.png" />
                        </div>
                        <p>Then, click a new listing will appeare on the left of the “Current Authorizations” list. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/authGroup3.png" />
                        </div>
                        <p>Once the group is selected, the &quot;Edit&quot; button will appear. Click on this button. (As shown below)</p>
                        <div class="media-left">
                            <img src="Images/authGroup4.png" />
                        </div>
                        <p>Then, select an authorization in the “Available Authorizations” list and click the “Add” button. The selected item will move to the “Current Authorizations” list. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/authGroup5.png" />
                        </div>
                        <p>Last, click the “Save” button. Then new authorization group is set up. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/authGroup6.png" />
                        </div>
                        <p>The authorization count will update with your new selections (example: The &quot;0&quot; has now updated to &quot;2&quot;)</p>
                        <div class="media-left">
                            <img src="Images/authGroup7.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="removeAuthGroup">Remove Authorizations in Group </h2>
                            <p>Click the authorization group bar and then the “Edit” button. (As shown below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/authGroup8.png" />
                        </div>
                        <p>After that, the “remove” button appears. Select the item(s) in the “Current Authorizations” list and click the “remove” button. (As shown in below)</p>
                        <div class="media-left">
                            <img src="Images/authGroup9.png" />
                        </div>
                        <p>Finally, choose the &quot;save&quot; button to keep all changes. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/authGroup10.png" />
                        </div>
                        <p>“Group updated successfully!” will be shown. Also, the number of authorizations will be changed. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/authGroup11.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="manageEmp" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 id="employees" class="media-heading page-header">How to Manage Employees </h2>

                            <h2 class="media-heading" id="newEmployee">Create New </h2>
                            <p>Input all information for a new employee and click the “Create Employee” button. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/CreateEmployees1.png" />
                        </div>
                        <p>A successful message will appeare above the “Create Employee” button. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/CreateEmployees2.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="modifyEmployee">Modify Existing </h2>
                            <p>Select an employee and choose choose &quot;edit&quot; button. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/ModifyEmployee.png" />
                        </div>
                        <p>Edit the selected employee’s information and click to save or cancel. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/EditEmployees1.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="manageEmpGroup" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading page-header" id="manageEmpGroups">How to Manage Employee Group </h2>
                            <p>Click “Create New”, type role name, and click to select permissions. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="manageUser" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">


                            <h2 class="media-heading page-header" id="manageUsers">How to Manage Users</h2>

                            <h2 class="media-heading" id="newUser">Create a New User </h2>
                            <p>Click the “Create New” button, input information, and click the “Create User” button to save. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/createUser.png" />
                        </div>
                        <p>A successful message will show above the “Create User” button. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/createUser1.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="modifyUser">Modify Users </h2>
                            <p>Select a user and click the &quot;Edit&quot; button. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/editUser.png" />
                        </div>
                        <p>Modify user’s information first and then save or cancel. (As shown in the pic below)</p>
                        <div class="media-left">
                            <img src="Images/editUser1.png" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="manageRoles" runat="server" Visible="true">
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading page-header" id="manageRole">How to Manage Roles </h2>

                            <h2 class="media-heading" id="newRole">Create New</h2>
                            <p>Click “Create New”, type role name, and click to select permissions. (As shown in the pic below) </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/createRole.png" />
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-body">

                            <h2 class="media-heading" id="modifyRole">Modify Existing  </h2>
                            <p>Under Construction... </p>
                        </div>
                        <div class="media-left">
                            <img src="Images/Page_Under_Construction.jpg" />
                        </div>
                    </div>
                </asp:Panel>
            </div>
            <div class="col-md-3" role="complementary">
                <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix">
                    <ul class="nav bs-docs-sidenav">
                        <li>
                            <a href="#overview">Overview</a>
                        </li>
                        <li>
                            <a href="#newRequest">How to create a new request</a>
                            <ul class="nav">
                                <li>
                                    <a href="#selectEmployee">Select employee</a>
                                </li>
                                <li>
                                    <a href="#selectEmployeeGroup">Select employees via group</a>
                                </li>
                                <li>
                                    <a href="#unselectEmployee">Unselect employee</a>
                                </li>
                                <li>
                                    <a href="#selectAuthorization">Select authorization</a>
                                </li>
                                <li>
                                    <a href="#selectAuGroup">Select authorization group</a>
                                </li>
                                <li>
                                    <a href="#unselectAu">Unselect authorization</a>
                                </li>
                                <li>
                                    <a href="#comments">Comments</a>
                                </li>
                                <li>
                                    <a href="#submitRequest">Submit request</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#viewRequests">How to View Requests</a>
                        </li>
                        <li>
                            <a href="#manageRequests">How to Manage Requests</a>
                            <ul class="nav">
                                <li>
                                    <a href="#byAuthy">Via Authy</a>
                                </li>
                                <li>
                                    <a href="#byEmail">Via Email</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#reports">Reports</a>
                            <ul class="nav">
                                <li>
                                    <a href="#auReports">Authorization reports</a>
                                </li>
                                <li>
                                    <a href="#employeeReports">Employee reports</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#authorizations">How to Manage Authorizations</a>
                            <ul class="nav">
                                <li>
                                    <a href="#newAuth">Create new</a>
                                </li>
                                <li>
                                    <a href="#modifyAuth">Modify Existing</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#manageAuthorizationsGroup">How to Manage Authorization Group</a>
                            <ul class="nav">
                                <li>
                                    <a href="#removeAuthGroup">Remove authorizations in group</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#employees">How to Manage Employees</a>
                            <ul class="nav">
                                <li>
                                    <a href="#newEmployee">Create new</a>
                                </li>
                                <li>
                                    <a href="#modifyEmployee">Modify existing</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#manageEmpGroups">How to Manage Employee Group</a>
                        </li>
                        <li>
                            <a href="#manageUsers">How to Manage Users</a>
                            <ul class="nav">
                                <li>
                                    <a href="#newUser">Create new</a>
                                </li>
                                <li>
                                    <a href="#modifyUser">Modify existing</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#manageRole">How to Manage Roles</a>
                            <ul class="nav">
                                <li>
                                    <a href="#newRole">Create new</a>
                                </li>
                                <li>
                                    <a href="#modifyRole">Modify existing</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <a class="back-to-top" href="#top">Back to top </a>
                </nav>
            </div>
        </div>
    </div>
</asp:Content>
