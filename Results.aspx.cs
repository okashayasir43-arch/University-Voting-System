using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace UniversityVotingSystem
{
    public partial class Results : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCompletedElections();
            }
        }

        private void LoadCompletedElections()
        {

            string query = "SELECT ElectionID, ElectionName, Description FROM Elections ORDER BY ElectionName";
            DataTable dt = DBHelper.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                ddlElections.DataSource = dt;
                ddlElections.DataTextField = "ElectionName";
                ddlElections.DataValueField = "ElectionID";
                ddlElections.DataBind();
                ddlElections.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select an Election --", "0"));
            }
        }

        protected void ddlElections_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlElections.SelectedValue != "0")
            {
                LoadResults();
            }
            else
            {
                pnlResults.Visible = false;
                pnlNoResults.Visible = false;
            }
        }

        private void LoadResults()
        {
            int electionID = Convert.ToInt32(ddlElections.SelectedValue);

            
            string electionQuery = "SELECT ElectionName, Description, StartDate, EndDate FROM Elections WHERE ElectionID=@ElectionID";
            SqlParameter[] electionParams = { new SqlParameter("@ElectionID", electionID) };
            DataTable electionDt = DBHelper.ExecuteQuery(electionQuery, electionParams);

            if (electionDt.Rows.Count > 0)
            {
                string electionName = electionDt.Rows[0]["ElectionName"].ToString();
                string description = electionDt.Rows[0]["Description"].ToString();
                lblElectionInfo.Text = $"{electionName} - {description}";
            }

            // Get results with vote counts and percentages
            string query = @"
                SELECT 
                    C.CandidateName, 
                    C.Position, 
                    C.Department, 
                    COUNT(V.VoteID) as VoteCount,
                    CASE 
                        WHEN (SELECT COUNT(*) FROM Votes WHERE ElectionID = @ElectionID) = 0 THEN 0
                        ELSE CAST(COUNT(V.VoteID) * 100.0 / 
                             (SELECT COUNT(*) FROM Votes WHERE ElectionID = @ElectionID) AS DECIMAL(5,2))
                    END as Percentage
                FROM Candidates C
                LEFT JOIN Votes V ON C.CandidateID = V.CandidateID
                WHERE C.ElectionID = @ElectionID
                GROUP BY C.CandidateName, C.Position, C.Department
                ORDER BY VoteCount DESC, C.CandidateName";

            SqlParameter[] parameters = { new SqlParameter("@ElectionID", electionID) };
            DataTable dt = DBHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                gvResults.DataSource = dt;
                gvResults.DataBind();

                // Calculate total votes
                string totalQuery = "SELECT COUNT(*) FROM Votes WHERE ElectionID=@ElectionID";
                int totalVotes = Convert.ToInt32(DBHelper.ExecuteScalar(totalQuery, parameters));
                lblTotalVotes.Text = totalVotes.ToString();

                pnlResults.Visible = true;
                pnlNoResults.Visible = false;
            }
            else
            {
                pnlResults.Visible = false;
                pnlNoResults.Visible = true;
            }
        }
    }
}