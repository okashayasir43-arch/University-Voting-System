<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VotePage.aspx.cs" Inherits="UniversityVotingSystem.VotePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Cast Your Vote</h2>
    
    <asp:Label ID="lblMessage" runat="server" 
               style="display: block; margin: 20px 0; padding: 15px; border-radius: 5px;"
               Font-Bold="true"></asp:Label>
    
    <div style="margin: 20px 0;">
        <label style="font-weight: bold; font-size: 16px; margin-right: 10px;">Select Election:</label>
        <asp:DropDownList ID="ddlElections" runat="server" AutoPostBack="true" 
                          OnSelectedIndexChanged="ddlElections_SelectedIndexChanged"
                          style="padding: 10px; font-size: 14px; border: 2px solid #ddd; border-radius: 5px; min-width: 300px;">
        </asp:DropDownList>
    </div>
    
    <asp:Panel ID="pnlCandidates" runat="server" Visible="false" style="margin-top: 30px;">
        <h3 style="color: #1e3c72; margin-bottom: 20px;">Available Candidates</h3>
        
        <asp:GridView ID="gvCandidates" runat="server" AutoGenerateColumns="False" 
                      Width="100%" CellPadding="15" 
                      style="border: 2px solid #ddd; border-radius: 8px; overflow: hidden;"
                      HeaderStyle-BackColor="#1e3c72"
                      HeaderStyle-ForeColor="White"
                      HeaderStyle-Font-Bold="true"
                      HeaderStyle-Padding="15px"
                      RowStyle-BackColor="#f9f9f9"
                      AlternatingRowStyle-BackColor="White">
            <Columns>
                <asp:BoundField DataField="CandidateName" HeaderText="Candidate Name" 
                               ItemStyle-Font-Bold="true" ItemStyle-Font-Size="15px" />
                <asp:BoundField DataField="Position" HeaderText="Position" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Manifesto" HeaderText="Manifesto" 
                               ItemStyle-Width="300px" />
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnVote" runat="server" Text="Vote for This Candidate" 
                                    CommandArgument='<%# Eval("CandidateID") %>'
                                    OnClick="btnVote_Click"
                                    style="padding: 10px 20px; background: linear-gradient(135deg, #27ae60 0%, #229954 100%); 
                                           color: white; border: none; cursor: pointer; border-radius: 5px; 
                                           font-weight: bold; font-size: 14px;" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
    
    <asp:Panel ID="pnlNoElections" runat="server" Visible="false" 
               style="margin-top: 30px; padding: 30px; background: #fff3cd; border: 2px solid #ffc107; border-radius: 8px; text-align: center;">
        <h3 style="color: #856404;">⚠️ No Active Elections</h3>
        <p style="color: #856404; margin-top: 10px;">There are currently no active elections. Please check back later.</p>
    </asp:Panel>
</asp:Content>
