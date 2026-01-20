using System;
using System.Web.UI;

namespace UniversityVotingSystem
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatistics();
            }
        }

        private void LoadStatistics()
        {
            try
            {
                // Get total registered users
                string userQuery = "SELECT COUNT(*) FROM Users WHERE IsActive=1";
                object userCount = DBHelper.ExecuteScalar(userQuery, null);
                lblTotalUsers.Text = userCount != null ? userCount.ToString() : "0";

                // Get total elections
                string electionQuery = "SELECT COUNT(*) FROM Elections";
                object electionCount = DBHelper.ExecuteScalar(electionQuery, null);
                lblTotalElections.Text = electionCount != null ? electionCount.ToString() : "0";

                // Get total votes cast
                string voteQuery = "SELECT COUNT(*) FROM Votes";
                object voteCount = DBHelper.ExecuteScalar(voteQuery, null);
                lblTotalVotes.Text = voteCount != null ? voteCount.ToString() : "0";
            }
            catch (Exception ex)
            {
                // Handle errors silently on home page
                lblTotalUsers.Text = "0";
                lblTotalElections.Text = "0";
                lblTotalVotes.Text = "0";
            }
        }
    }
}