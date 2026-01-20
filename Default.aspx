<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UniversityVotingSystem.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Hero Section -->
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 60px 30px; border-radius: 15px; text-align: center; margin-bottom: 40px;">
        <h1 style="font-size: 3em; margin: 0; color: white; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">🗳️ Welcome to University Online Voting System</h1>
        <p style="font-size: 1.3em; margin: 20px 0 30px 0; opacity: 0.95;">Secure, Transparent & Democratic Elections for Students</p>
        <div style="margin-top: 30px;">
            <a href="UserRegister.aspx" style="display: inline-block; padding: 15px 40px; background: white; color: #667eea; text-decoration: none; font-weight: bold; border-radius: 8px; margin: 10px; font-size: 1.1em;">
                📝 Register Now
            </a>
            <a href="UserLogin.aspx" style="display: inline-block; padding: 15px 40px; background: #27ae60; color: white; text-decoration: none; font-weight: bold; border-radius: 8px; margin: 10px; font-size: 1.1em;">
                🔐 Login to Vote
            </a>
        </div>
    </div>

    <!-- Features Section -->
    <h2 style="text-align: center; color: #1e3c72; margin-bottom: 30px;">Why Choose Our Voting System?</h2>
    
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 25px; margin-bottom: 40px;">
        <!-- Feature 1 -->
        <div style="background: white; border: 2px solid #3498db; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
            <div style="font-size: 3em; margin-bottom: 15px;">🔒</div>
            <h3 style="color: #3498db; margin-bottom: 15px;">Secure & Private</h3>
            <p style="color: #555; line-height: 1.6;">Your vote is completely confidential. Advanced security measures protect your privacy and ensure fair elections.</p>
        </div>

        <!-- Feature 2 -->
        <div style="background: white; border: 2px solid #27ae60; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
            <div style="font-size: 3em; margin-bottom: 15px;">⚡</div>
            <h3 style="color: #27ae60; margin-bottom: 15px;">Fast & Easy</h3>
            <p style="color: #555; line-height: 1.6;">Register once, vote anytime. Simple interface makes voting quick and hassle-free from anywhere.</p>
        </div>

        <!-- Feature 3 -->
        <div style="background: white; border: 2px solid #e74c3c; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
            <div style="font-size: 3em; margin-bottom: 15px;">📊</div>
            <h3 style="color: #e74c3c; margin-bottom: 15px;">Transparent Results</h3>
            <p style="color: #555; line-height: 1.6;">Real-time vote counting and instant results. View detailed statistics and election outcomes immediately.</p>
        </div>

        <!-- Feature 4 -->
        <div style="background: white; border: 2px solid #f39c12; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
            <div style="font-size: 3em; margin-bottom: 15px;">✅</div>
            <h3 style="color: #f39c12; margin-bottom: 15px;">One Vote Per Person</h3>
            <p style="color: #555; line-height: 1.6;">Fair elections guaranteed. System ensures each student can vote only once per election.</p>
        </div>

        <!-- Feature 5 -->
        <div style="background: white; border: 2px solid #9b59b6; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
            <div style="font-size: 3em; margin-bottom: 15px;">📱</div>
            <h3 style="color: #9b59b6; margin-bottom: 15px;">Access Anywhere</h3>
            <p style="color: #555; line-height: 1.6;">Vote from your computer, tablet, or phone. Available 24/7 during election period.</p>
        </div>

        <!-- Feature 6 -->
        <div style="background: white; border: 2px solid #16a085; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
            <div style="font-size: 3em; margin-bottom: 15px;">👥</div>
            <h3 style="color: #16a085; margin-bottom: 15px;">For All Students</h3>
            <p style="color: #555; line-height: 1.6;">Every registered student has equal voting rights. Your voice matters in shaping our university.</p>
        </div>
    </div>

    <!-- How It Works Section -->
    <div style="background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 40px; border-radius: 15px; margin-bottom: 40px;">
        <h2 style="text-align: center; color: white; margin-bottom: 30px;">How It Works</h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 30px; text-align: center;">
            <div>
                <div style="font-size: 3em; margin-bottom: 10px;">1️⃣</div>
                <h4 style="color: white; margin-bottom: 10px;">Register</h4>
                <p style="opacity: 0.9;">Sign up with your student ID and email</p>
            </div>
            <div>
                <div style="font-size: 3em; margin-bottom: 10px;">2️⃣</div>
                <h4 style="color: white; margin-bottom: 10px;">Login</h4>
                <p style="opacity: 0.9;">Access your dashboard securely</p>
            </div>
            <div>
                <div style="font-size: 3em; margin-bottom: 10px;">3️⃣</div>
                <h4 style="color: white; margin-bottom: 10px;">Vote</h4>
                <p style="opacity: 0.9;">Choose your candidate and cast vote</p>
            </div>
            <div>
                <div style="font-size: 3em; margin-bottom: 10px;">4️⃣</div>
                <h4 style="color: white; margin-bottom: 10px;">Results</h4>
                <p style="opacity: 0.9;">View live results after voting closes</p>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div style="background: #f8f9fa; padding: 40px; border-radius: 15px; text-align: center; border: 3px solid #667eea;">
        <h2 style="color: #1e3c72; margin-bottom: 20px;">Ready to Make Your Voice Heard?</h2>
        <p style="font-size: 1.2em; color: #555; margin-bottom: 30px;">Join thousands of students participating in democratic elections</p>
        <a href="UserRegister.aspx" style="display: inline-block; padding: 18px 50px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; text-decoration: none; font-weight: bold; border-radius: 10px; font-size: 1.2em; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
            Get Started Now →
        </a>
    </div>

    <!-- Stats Section -->
    <div style="margin-top: 40px; text-align: center; padding: 30px; background: linear-gradient(135deg, #27ae60 0%, #229954 100%); border-radius: 15px;">
        <h3 style="color: white; margin-bottom: 20px;">System Statistics</h3>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 20px;">
            <div>
                <div style="font-size: 2.5em; font-weight: bold; color: white;">
                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                </div>
                <p style="color: white; opacity: 0.9; margin-top: 5px;">Registered Students</p>
            </div>
            <div>
                <div style="font-size: 2.5em; font-weight: bold; color: white;">
                    <asp:Label ID="lblTotalElections" runat="server" Text="0"></asp:Label>
                </div>
                <p style="color: white; opacity: 0.9; margin-top: 5px;">Total Elections</p>
            </div>
            <div>
                <div style="font-size: 2.5em; font-weight: bold; color: white;">
                    <asp:Label ID="lblTotalVotes" runat="server" Text="0"></asp:Label>
                </div>
                <p style="color: white; opacity: 0.9; margin-top: 5px;">Votes Cast</p>
            </div>
        </div>
    </div>
</asp:Content>
