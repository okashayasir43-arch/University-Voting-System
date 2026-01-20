<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="UniversityVotingSystem.Results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h2>Election Results</h2>
    
    <div style="margin: 20px 0;">
        <label style="font-weight: bold; font-size: 16px; margin-right: 10px;">Select Election:</label>
        <asp:DropDownList ID="ddlElections" runat="server" AutoPostBack="true" 
                          OnSelectedIndexChanged="ddlElections_SelectedIndexChanged"
                          style="padding: 10px; font-size: 14px; border: 2px solid #ddd; border-radius: 5px; min-width: 300px;">
        </asp:DropDownList>
    </div>
    
    <asp:Panel ID="pnlResults" runat="server" Visible="false" style="margin-top: 30px;">
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px; margin-bottom: 30px;">
            <h3 style="margin: 0; color: white;">📊 Election Results</h3>
            <p style="margin: 10px 0 0 0; opacity: 0.9;">
                <asp:Label ID="lblElectionInfo" runat="server"></asp:Label>
            </p>
        </div>
        
        <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" 
                      Width="100%" CellPadding="15" 
                      style="border: 2px solid #ddd; border-radius: 8px; overflow: hidden;"
                      HeaderStyle-BackColor="#27ae60"
                      HeaderStyle-ForeColor="White"
                      HeaderStyle-Font-Bold="true"
                      HeaderStyle-Padding="15px"
                      RowStyle-BackColor="#f9f9f9"
                      AlternatingRowStyle-BackColor="White">
            <Columns>
                <asp:TemplateField HeaderText="Rank">
                    <ItemTemplate>
                        <div style="text-align: center; font-size: 24px; font-weight: bold; color: #27ae60;">
                            #<%# Container.DataItemIndex + 1 %>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CandidateName" HeaderText="Candidate Name" 
                               ItemStyle-Font-Bold="true" ItemStyle-Font-Size="16px" />
                <asp:BoundField DataField="Position" HeaderText="Position" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:TemplateField HeaderText="Votes">
                    <ItemTemplate>
                        <div style="text-align: center;">
                            <span style="font-size: 24px; font-weight: bold; color: #3498db;">
                                <%# Eval("VoteCount") %>
                            </span>
                            <span style="font-size: 14px; color: #7f8c8d;"> votes</span>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Percentage">
                    <ItemTemplate>
                        <div style="text-align: center;">
                            <div style="background: #ecf0f1; border-radius: 10px; height: 25px; position: relative; overflow: hidden;">
                                <div style='background: linear-gradient(90deg, #27ae60, #2ecc71); 
                                           width: <%# Eval("Percentage") %>%; 
                                           height: 100%; 
                                           border-radius: 10px;
                                           transition: width 0.5s;'>
                                </div>
                                <span style="position: absolute; top: 3px; left: 0; right: 0; font-weight: bold; color: #2c3e50;">
                                    <%# Eval("Percentage") %>%
                                </span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        
        <div style="margin-top: 30px; padding: 20px; background: #e8f5e9; border: 2px solid #27ae60; border-radius: 8px;">
            <h4 style="color: #27ae60; margin-bottom: 10px;">📈 Total Votes Cast: 
                <asp:Label ID="lblTotalVotes" runat="server" Font-Bold="true"></asp:Label>
            </h4>
        </div>
    </asp:Panel>
    
    <asp:Panel ID="pnlNoResults" runat="server" Visible="false" 
               style="margin-top: 30px; padding: 30px; background: #fff3cd; border: 2px solid #ffc107; border-radius: 8px; text-align: center;">
        <h3 style="color: #856404;">ℹ️ No Results Available</h3>
        <p style="color: #856404; margin-top: 10px;">Results will be available after the election ends.</p>
    </asp:Panel>
</asp:Content>
