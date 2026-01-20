<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="UniversityVotingSystem.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>Admin Login</h2>
    <div style="max-width: 450px; margin: 50px auto;">
        <div style="background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%); color: white; padding: 20px; border-radius: 10px 10px 0 0; text-align: center;">
            <h3 style="margin: 0; color: white;">👨‍💼 Administrator Access</h3>
            <p style="margin: 10px 0 0 0; opacity: 0.9; font-size: 14px;">Authorized Personnel Only</p>
        </div>
        
        <div style="background: white; padding: 30px; border: 2px solid #e74c3c; border-radius: 0 0 10px 10px;">
            <asp:Label ID="lblMessage" runat="server" 
                       style="display: block; margin-bottom: 20px; padding: 12px; border-radius: 5px;"
                       Font-Bold="true"></asp:Label>
            
            <table style="width: 100%; border-spacing: 15px;">
                <tr>
                    <td style="padding: 10px; font-weight: bold; width: 35%;">Username:</td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server"
                                     style="width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 5px; font-size: 14px;">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                                                   ControlToValidate="txtUsername"
                                                   ErrorMessage="*Required" 
                                                   ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 10px; font-weight: bold;">Password:</td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                                     style="width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 5px; font-size: 14px;">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                                   ControlToValidate="txtPassword"
                                                   ErrorMessage="*Required" 
                                                   ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-top: 20px;">
                        <asp:Button ID="btnLogin" runat="server" Text="Admin Login" 
                                    OnClick="btnLogin_Click"
                                    style="padding: 12px 50px; background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%); 
                                           color: white; border: none; cursor: pointer; font-size: 16px; 
                                           font-weight: bold; border-radius: 5px; width: 200px;" />
                    </td>
                </tr>
            </table>
            
            
        </div>
    </div>
</asp:Content>

