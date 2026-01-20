<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="UniversityVotingSystem.UserDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Welcome to Your Dashboard</h2>
    <div style="padding: 20px;">
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px; margin-bottom: 30px;">
            <h3 style="margin: 0; color: white;">👋 Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label>!</h3>
            <p style="margin: 10px 0 0 0; opacity: 0.9;">Student ID: <asp:Label ID="lblStudentID" runat="server"></asp:Label></p>
        </div>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 30px;">
            <div style="background: #fff; border: 2px solid #3498db; padding: 25px; border-radius: 10px; text-align: center;">
                <h4 style="color: #3498db; margin-bottom: 15px;">🗳️ Cast Your Vote</h4>
                <p style="margin-bottom: 20px;">Participate in active elections</p>
                <asp:Button ID="btnVote" runat="server" Text="Go to Voting" 
                            OnClick="btnVote_Click"
                            style="padding: 10px 25px; background: #3498db; color: white; border: none; cursor: pointer; border-radius: 5px; font-weight: bold;" />
            </div>
            
            <div style="background: #fff; border: 2px solid #27ae60; padding: 25px; border-radius: 10px; text-align: center;">
                <h4 style="color: #27ae60; margin-bottom: 15px;">📊 View Results</h4>
                <p style="margin-bottom: 20px;">Check election results</p>
                <asp:Button ID="btnResults" runat="server" Text="View Results" 
                            OnClick="btnResults_Click"
                            style="padding: 10px 25px; background: #27ae60; color: white; border: none; cursor: pointer; border-radius: 5px; font-weight: bold;" />
            </div>
            
            <div style="background: #fff; border: 2px solid #e74c3c; padding: 25px; border-radius: 10px; text-align: center;">
                <h4 style="color: #e74c3c; margin-bottom: 15px;">🚪 Logout</h4>
                <p style="margin-bottom: 20px;">End your session</p>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" 
                            OnClick="btnLogout_Click"
                            style="padding: 10px 25px; background: #e74c3c; color: white; border: none; cursor: pointer; border-radius: 5px; font-weight: bold;" />
            </div>
        </div>
    </div>
</asp:Content>
