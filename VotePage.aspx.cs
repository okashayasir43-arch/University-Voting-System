using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniversityVotingSystem
{
    public partial class VotePage : Page
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
                LoadActiveElections();
            }
        }

        private void LoadActiveElections()
        {
            string query = @"SELECT ElectionID, ElectionName, Description 
                           FROM Elections 
                           WHERE IsActive=1 AND GETDATE() BETWEEN StartDate AND EndDate 
                           ORDER BY ElectionName";

            DataTable dt = DBHelper.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                ddlElections.DataSource = dt;
                ddlElections.DataTextField = "ElectionName";
                ddlElections.DataValueField = "ElectionID";
                ddlElections.DataBind();
                ddlElections.Items.Insert(0, new ListItem("-- Select an Election --", "0"));

                pnlNoElections.Visible = false;
            }
            else
            {
                ddlElections.Visible = false;
                pnlNoElections.Visible = true;
            }
        }

        protected void ddlElections_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlElections.SelectedValue != "0")
            {
                int userID = Convert.ToInt32(Session["UserID"]);
                int electionID = Convert.ToInt32(ddlElections.SelectedValue);

                // Check if user already voted in this election
                string checkQuery = "SELECT COUNT(*) FROM Votes WHERE UserID=@UserID AND ElectionID=@ElectionID";
                SqlParameter[] checkParams = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@ElectionID", electionID)
                };

                int voteCount = Convert.ToInt32(DBHelper.ExecuteScalar(checkQuery, checkParams));

                if (voteCount > 0)
                {
                    ShowMessage("✅ You have already voted in this election. Thank you for participating!", true);
                    pnlCandidates.Visible = false;
                }
                else
                {
                    LoadCandidates();
                    pnlCandidates.Visible = true;
                }
            }
            else
            {
                pnlCandidates.Visible = false;
                lblMessage.Visible = false;
            }
        }

        private void LoadCandidates()
        {
            string query = @"SELECT CandidateID, CandidateName, Position, Department, Manifesto 
                           FROM Candidates 
                           WHERE ElectionID=@ElectionID AND IsActive=1 
                           ORDER BY Position, CandidateName";

            SqlParameter[] parameters = {
                new SqlParameter("@ElectionID", ddlElections.SelectedValue)
            };

            DataTable dt = DBHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                gvCandidates.DataSource = dt;
                gvCandidates.DataBind();
            }
            else
            {
                ShowMessage("⚠️ No candidates available for this election.", false);
                pnlCandidates.Visible = false;
            }
        }

        protected void btnVote_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int candidateID = Convert.ToInt32(btn.CommandArgument);
            int userID = Convert.ToInt32(Session["UserID"]);
            int electionID = Convert.ToInt32(ddlElections.SelectedValue);

            // Double-check if already voted (security measure)
            string checkQuery = "SELECT COUNT(*) FROM Votes WHERE UserID=@UserID AND ElectionID=@ElectionID";
            SqlParameter[] checkParams = {
                new SqlParameter("@UserID", userID),
                new SqlParameter("@ElectionID", electionID)
            };

            int voteCount = Convert.ToInt32(DBHelper.ExecuteScalar(checkQuery, checkParams));

            if (voteCount > 0)
            {
                ShowMessage("❌ You have already voted in this election!", false);
                pnlCandidates.Visible = false;
                return;
            }

            // Cast the vote
            string insertQuery = @"INSERT INTO Votes (UserID, ElectionID, CandidateID, VotedDate) 
                                 VALUES (@UserID, @ElectionID, @CandidateID, GETDATE())";

            SqlParameter[] insertParams = {
                new SqlParameter("@UserID", userID),
                new SqlParameter("@ElectionID", electionID),
                new SqlParameter("@CandidateID", candidateID)
            };

            try
            {
                DBHelper.ExecuteNonQuery(insertQuery, insertParams);
                ShowMessage("🎉 Vote cast successfully! Thank you for participating in the election.", true);
                pnlCandidates.Visible = false;

                // Reload elections to update status
                LoadActiveElections();
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error casting vote: " + ex.Message, false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? Color.Green : Color.Red;
            lblMessage.BackColor = isSuccess ? Color.LightGreen : Color.LightPink;
            lblMessage.Visible = true;
        }
    }
}