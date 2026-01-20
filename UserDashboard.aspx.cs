using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace UniversityVotingSystem
{
    public partial class UserDashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("UserLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
            }
        }

        private void LoadUserInfo()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            string query = "SELECT FullName, StudentID FROM Users WHERE UserID=@UserID";
            SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };

            DataTable dt = DBHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                lblUserName.Text = dt.Rows[0]["FullName"].ToString();
                lblStudentID.Text = dt.Rows[0]["StudentID"].ToString();
            }
        }

        protected void btnVote_Click(object sender, EventArgs e)
        {
            Response.Redirect("VotePage.aspx");
        }

        protected void btnResults_Click(object sender, EventArgs e)
        {
            Response.Redirect("Results.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear all session data
            Session.Clear();
            Session.Abandon();

            // Redirect to login page
            Response.Redirect("UserLogin.aspx");
        }
    }
}