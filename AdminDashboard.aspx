<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="UniversityVotingSystem.AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Admin Dashboard</h2>
    
    <div style="background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%); color: white; padding: 25px; border-radius: 10px; margin-bottom: 30px;">
        <h3 style="margin: 0; color: white;">👨‍💼 Welcome, <asp:Label ID="lblAdminName" runat="server"></asp:Label>!</h3>
        <p style="margin: 10px 0 0 0; opacity: 0.9;">Administrator Control Panel</p>
    </div>
    
    <asp:Label ID="lblMessage" runat="server" 
               style="display: block; margin: 20px 0; padding: 15px; border-radius: 5px;"
               Font-Bold="true"></asp:Label>
    
    <!-- Tabs -->
    <div style="margin-bottom: 20px; border-bottom: 3px solid #ddd;">
        <asp:Button ID="btnTabElections" runat="server" Text="📋 Manage Elections" OnClick="btnTabElections_Click"
                    style="padding: 12px 25px; margin-right: 5px; background: #3498db; color: white; border: none; cursor: pointer; font-weight: bold;" />
        <asp:Button ID="btnTabCandidates" runat="server" Text="👥 Manage Candidates" OnClick="btnTabCandidates_Click"
                    style="padding: 12px 25px; margin-right: 5px; background: #95a5a6; color: white; border: none; cursor: pointer; font-weight: bold;" />
        <asp:Button ID="btnTabResults" runat="server" Text="📊 View All Results" OnClick="btnTabResults_Click"
                    style="padding: 12px 25px; margin-right: 5px; background: #95a5a6; color: white; border: none; cursor: pointer; font-weight: bold;" />
        <asp:Button ID="btnTabAdmins" runat="server" Text="🔐 Manage Admins" OnClick="btnTabAdmins_Click"
                    style="padding: 12px 25px; background: #95a5a6; color: white; border: none; cursor: pointer; font-weight: bold;" />
    </div>
    
    <!-- Elections Panel -->
    <asp:Panel ID="pnlElections" runat="server" Visible="true">
        <h3 style="color: #3498db;">Create New Election</h3>
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px;">
            <table style="width: 100%; max-width: 800px;">
                <tr>
                    <td style="padding: 8px; width: 150px;">Election Name:</td>
                    <td><asp:TextBox ID="txtElectionName" runat="server" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Description:</td>
                    <td><asp:TextBox ID="txtElectionDesc" runat="server" TextMode="MultiLine" Rows="3" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Start Date:</td>
                    <td><asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" style="padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">End Date:</td>
                    <td><asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" style="padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="padding: 15px 8px;">
                        <asp:Button ID="btnCreateElection" runat="server" Text="Create Election" OnClick="btnCreateElection_Click"
                                    style="padding: 10px 30px; background: #27ae60; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px;" />
                    </td>
                </tr>
            </table>
        </div>
        
        <h3 style="color: #3498db;">All Elections</h3>
        <asp:GridView ID="gvElections" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="10"
                      HeaderStyle-BackColor="#3498db" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
                      RowStyle-BackColor="#f9f9f9" AlternatingRowStyle-BackColor="White"
                      OnRowCommand="gvElections_RowCommand">
            <Columns>
                <asp:BoundField DataField="ElectionID" HeaderText="ID" />
                <asp:BoundField DataField="ElectionName" HeaderText="Election Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="IsActive" HeaderText="Active" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                                    CommandName="EditElection" CommandArgument='<%# Eval("ElectionID") %>'
                                    style="padding: 5px 15px; background: #f39c12; color: white; border: none; cursor: pointer; border-radius: 3px; margin-right: 5px;" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                    CommandName="CancelElection" CommandArgument='<%# Eval("ElectionID") %>'
                                    OnClientClick="return confirm('Are you sure you want to cancel this election?');"
                                    style="padding: 5px 15px; background: #e74c3c; color: white; border: none; cursor: pointer; border-radius: 3px;" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        
        <!-- Edit Election Panel -->
        <asp:Panel ID="pnlEditElection" runat="server" Visible="false" style="margin-top: 30px; background: #fff3cd; padding: 20px; border-radius: 8px; border: 2px solid #ffc107;">
            <h3 style="color: #856404;">✏️ Edit Election</h3>
            <asp:HiddenField ID="hfEditElectionID" runat="server" />
            <table style="width: 100%; max-width: 800px;">
                <tr>
                    <td style="padding: 8px; width: 150px;">Election Name:</td>
                    <td><asp:TextBox ID="txtEditElectionName" runat="server" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Description:</td>
                    <td><asp:TextBox ID="txtEditElectionDesc" runat="server" TextMode="MultiLine" Rows="3" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Start Date:</td>
                    <td><asp:TextBox ID="txtEditStartDate" runat="server" TextMode="Date" style="padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">End Date:</td>
                    <td><asp:TextBox ID="txtEditEndDate" runat="server" TextMode="Date" style="padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Status:</td>
                    <td>
                        <asp:DropDownList ID="ddlEditStatus" runat="server" style="padding: 8px;">
                            <asp:ListItem Value="1">Active</asp:ListItem>
                            <asp:ListItem Value="0">Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td style="padding: 15px 8px;">
                        <asp:Button ID="btnUpdateElection" runat="server" Text="Update Election" OnClick="btnUpdateElection_Click"
                                    style="padding: 10px 30px; background: #27ae60; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px; margin-right: 10px;" />
                        <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" OnClick="btnCancelEdit_Click"
                                    style="padding: 10px 30px; background: #95a5a6; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>
    
    <!-- Candidates Panel -->
    <asp:Panel ID="pnlCandidates" runat="server" Visible="false">
        <h3 style="color: #3498db;">Add New Candidate</h3>
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px;">
            <table style="width: 100%; max-width: 800px;">
                <tr>
                    <td style="padding: 8px; width: 150px;">Select Election:</td>
                    <td>
                        <asp:DropDownList ID="ddlElections" runat="server" style="padding: 8px; width: 100%;"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Candidate Name:</td>
                    <td><asp:TextBox ID="txtCandidateName" runat="server" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Position:</td>
                    <td><asp:TextBox ID="txtPosition" runat="server" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Department:</td>
                    <td><asp:TextBox ID="txtCandidateDept" runat="server" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Manifesto:</td>
                    <td><asp:TextBox ID="txtManifesto" runat="server" TextMode="MultiLine" Rows="3" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="padding: 15px 8px;">
                        <asp:Button ID="btnAddCandidate" runat="server" Text="Add Candidate" OnClick="btnAddCandidate_Click"
                                    style="padding: 10px 30px; background: #27ae60; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px;" />
                    </td>
                </tr>
            </table>
        </div>
        
        <h3 style="color: #3498db;">All Candidates</h3>
        <asp:GridView ID="gvCandidates" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="10"
                      HeaderStyle-BackColor="#3498db" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
                      RowStyle-BackColor="#f9f9f9" AlternatingRowStyle-BackColor="White">
            <Columns>
                <asp:BoundField DataField="CandidateID" HeaderText="ID" />
                <asp:BoundField DataField="ElectionName" HeaderText="Election" />
                <asp:BoundField DataField="CandidateName" HeaderText="Candidate Name" />
                <asp:BoundField DataField="Position" HeaderText="Position" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Manifesto" HeaderText="Manifesto" />
            </Columns>
        </asp:GridView>
    </asp:Panel>
    
    <!-- Results Panel -->
    <asp:Panel ID="pnlResults" runat="server" Visible="false">
        <h3 style="color: #3498db;">All Election Results</h3>
        <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="10"
                      HeaderStyle-BackColor="#27ae60" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
                      RowStyle-BackColor="#f9f9f9" AlternatingRowStyle-BackColor="White">
            <Columns>
                <asp:BoundField DataField="ElectionName" HeaderText="Election" />
                <asp:BoundField DataField="CandidateName" HeaderText="Candidate" />
                <asp:BoundField DataField="Position" HeaderText="Position" />
                <asp:BoundField DataField="VoteCount" HeaderText="Votes" />
            </Columns>
        </asp:GridView>
    </asp:Panel>
    
    <!-- Admins Panel (NEW) -->
    <asp:Panel ID="pnlAdmins" runat="server" Visible="false">
        <h3 style="color: #e74c3c;">Create New Admin</h3>
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px;">
            <table style="width: 100%; max-width: 800px;">
                <tr>
                    <td style="padding: 8px; width: 150px;">Username:</td>
                    <td><asp:TextBox ID="txtAdminUsername" runat="server" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Password:</td>
                    <td><asp:TextBox ID="txtAdminPassword" runat="server" TextMode="Password" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Full Name:</td>
                    <td><asp:TextBox ID="txtAdminFullName" runat="server" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="padding: 8px;">Email:</td>
                    <td><asp:TextBox ID="txtAdminEmail" runat="server" TextMode="Email" style="width: 100%; padding: 8px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="padding: 15px 8px;">
                        <asp:Button ID="btnCreateAdmin" runat="server" Text="Create Admin" OnClick="btnCreateAdmin_Click"
                                    style="padding: 10px 30px; background: #e74c3c; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px;" />
                    </td>
                </tr>
            </table>
        </div>
        
        <h3 style="color: #e74c3c;">All Administrators</h3>
        <asp:GridView ID="gvAdmins" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="10"
                      HeaderStyle-BackColor="#e74c3c" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
                      RowStyle-BackColor="#f9f9f9" AlternatingRowStyle-BackColor="White">
            <Columns>
                <asp:BoundField DataField="AdminID" HeaderText="ID" />
                <asp:BoundField DataField="Username" HeaderText="Username" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>
    </asp:Panel>
    
    <div style="margin-top: 30px; text-align: center;">
        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click"
                    style="padding: 10px 30px; background: #e74c3c; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px;" />
    </div>
</asp:Content>
