using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;

namespace UniversityVotingSystem
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if admin is already logged in
            if (!IsPostBack)
            {
                if (Session["AdminID"] != null)
                {
                    Response.Redirect("AdminDashboard.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // SQL Query to check admin credentials
            string query = "SELECT AdminID, FullName FROM Admins WHERE Username=@Username AND Password=@Password";

            SqlParameter[] parameters = {
                new SqlParameter("@Username", txtUsername.Text.Trim()),
                new SqlParameter("@Password", txtPassword.Text)
            };

            try
            {
                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    // Login successful - store admin info in session
                    Session["AdminID"] = dt.Rows[0]["AdminID"];
                    Session["AdminName"] = dt.Rows[0]["FullName"];
                    Session["Role"] = "Admin";

                    // Redirect to admin dashboard
                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    ShowMessage("❌ Invalid username or password!", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }

        // Helper method to show messages
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? Color.Green : Color.Red;
            lblMessage.BackColor = isSuccess ? Color.LightGreen : Color.LightPink;
            lblMessage.Visible = true;
        }
    }
}