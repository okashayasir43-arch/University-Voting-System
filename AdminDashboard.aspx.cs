using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniversityVotingSystem
{
    public partial class AdminDashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminID"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblAdminName.Text = Session["AdminName"].ToString();
                LoadElections();
                LoadElectionsDropdown();
            }
        }

        // Tab Navigation
        protected void btnTabElections_Click(object sender, EventArgs e)
        {
            ShowPanel("elections");
            LoadElections();
        }

        protected void btnTabCandidates_Click(object sender, EventArgs e)
        {
            ShowPanel("candidates");
            LoadCandidates();
            LoadElectionsDropdown();
        }

        protected void btnTabResults_Click(object sender, EventArgs e)
        {
            ShowPanel("results");
            LoadAllResults();
        }

        protected void btnTabAdmins_Click(object sender, EventArgs e)
        {
            ShowPanel("admins");
            LoadAdmins();
        }

        private void ShowPanel(string panel)
        {
            pnlElections.Visible = false;
            pnlCandidates.Visible = false;
            pnlResults.Visible = false;
            pnlAdmins.Visible = false;
            pnlEditElection.Visible = false;

            btnTabElections.Style["background"] = "#95a5a6";
            btnTabCandidates.Style["background"] = "#95a5a6";
            btnTabResults.Style["background"] = "#95a5a6";
            btnTabAdmins.Style["background"] = "#95a5a6";

            switch (panel)
            {
                case "elections":
                    pnlElections.Visible = true;
                    btnTabElections.Style["background"] = "#3498db";
                    break;
                case "candidates":
                    pnlCandidates.Visible = true;
                    btnTabCandidates.Style["background"] = "#3498db";
                    break;
                case "results":
                    pnlResults.Visible = true;
                    btnTabResults.Style["background"] = "#3498db";
                    break;
                case "admins":
                    pnlAdmins.Visible = true;
                    btnTabAdmins.Style["background"] = "#3498db";
                    break;
            }
        }

        // ============= ELECTIONS =============
        protected void btnCreateElection_Click(object sender, EventArgs e)
        {
            string query = @"INSERT INTO Elections (ElectionName, Description, StartDate, EndDate, IsActive) 
                           VALUES (@Name, @Desc, @Start, @End, 1)";

            SqlParameter[] parameters = {
                new SqlParameter("@Name", txtElectionName.Text.Trim()),
                new SqlParameter("@Desc", txtElectionDesc.Text.Trim()),
                new SqlParameter("@Start", txtStartDate.Text),
                new SqlParameter("@End", txtEndDate.Text)
            };

            try
            {
                DBHelper.ExecuteNonQuery(query, parameters);
                ShowMessage("✅ Election created successfully!", true);
                LoadElections();
                ClearElectionFields();
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, false);
            }
        }

        protected void gvElections_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int electionID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditElection")
            {
                LoadElectionForEdit(electionID);
            }
            else if (e.CommandName == "CancelElection")
            {
                CancelElection(electionID);
            }
        }

        private void LoadElectionForEdit(int electionID)
        {
            string query = "SELECT ElectionID, ElectionName, Description, StartDate, EndDate, IsActive FROM Elections WHERE ElectionID=@ElectionID";
            SqlParameter[] parameters = { new SqlParameter("@ElectionID", electionID) };

            DataTable dt = DBHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                hfEditElectionID.Value = electionID.ToString();
                txtEditElectionName.Text = dt.Rows[0]["ElectionName"].ToString();
                txtEditElectionDesc.Text = dt.Rows[0]["Description"].ToString();

                // Format dates correctly
                DateTime startDate = Convert.ToDateTime(dt.Rows[0]["StartDate"]);
                DateTime endDate = Convert.ToDateTime(dt.Rows[0]["EndDate"]);
                txtEditStartDate.Text = startDate.ToString("yyyy-MM-dd");
                txtEditEndDate.Text = endDate.ToString("yyyy-MM-dd");

                // Set the dropdown value correctly
                bool isActive = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                ddlEditStatus.SelectedValue = isActive ? "1" : "0";

                pnlEditElection.Visible = true;

                // Scroll to edit panel
                ScriptManager.RegisterStartupScript(this, GetType(), "ScrollToEdit",
                    "window.scrollTo(0, document.getElementById('" + pnlEditElection.ClientID + "').offsetTop);", true);
            }
        }

        protected void btnUpdateElection_Click(object sender, EventArgs e)
        {
            string query = @"UPDATE Elections 
                           SET ElectionName=@Name, Description=@Desc, StartDate=@Start, EndDate=@End, IsActive=@Active 
                           WHERE ElectionID=@ElectionID";

            SqlParameter[] parameters = {
                new SqlParameter("@Name", txtEditElectionName.Text.Trim()),
                new SqlParameter("@Desc", txtEditElectionDesc.Text.Trim()),
                new SqlParameter("@Start", txtEditStartDate.Text),
                new SqlParameter("@End", txtEditEndDate.Text),
                new SqlParameter("@Active", ddlEditStatus.SelectedValue),
                new SqlParameter("@ElectionID", hfEditElectionID.Value)
            };

            try
            {
                DBHelper.ExecuteNonQuery(query, parameters);
                ShowMessage("✅ Election updated successfully!", true);
                LoadElections();
                pnlEditElection.Visible = false;
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, false);
            }
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            pnlEditElection.Visible = false;
        }

        private void CancelElection(int electionID)
        {
            string query = "UPDATE Elections SET IsActive=0 WHERE ElectionID=@ElectionID";
            SqlParameter[] parameters = { new SqlParameter("@ElectionID", electionID) };

            try
            {
                DBHelper.ExecuteNonQuery(query, parameters);
                ShowMessage("✅ Election cancelled successfully!", true);
                LoadElections();
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, false);
            }
        }

        private void LoadElections()
        {
            string query = "SELECT ElectionID, ElectionName, Description, StartDate, EndDate, IsActive FROM Elections ORDER BY CreatedDate DESC";
            DataTable dt = DBHelper.ExecuteQuery(query);
            gvElections.DataSource = dt;
            gvElections.DataBind();
        }

        private void ClearElectionFields()
        {
            txtElectionName.Text = "";
            txtElectionDesc.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
        }

        // ============= CANDIDATES =============
        protected void btnAddCandidate_Click(object sender, EventArgs e)
        {
            if (ddlElections.SelectedValue == "0")
            {
                ShowMessage("❌ Please select an election!", false);
                return;
            }

            string query = @"INSERT INTO Candidates (ElectionID, CandidateName, Position, Department, Manifesto, IsActive) 
                           VALUES (@ElectionID, @Name, @Position, @Dept, @Manifesto, 1)";

            SqlParameter[] parameters = {
                new SqlParameter("@ElectionID", ddlElections.SelectedValue),
                new SqlParameter("@Name", txtCandidateName.Text.Trim()),
                new SqlParameter("@Position", txtPosition.Text.Trim()),
                new SqlParameter("@Dept", txtCandidateDept.Text.Trim()),
                new SqlParameter("@Manifesto", txtManifesto.Text.Trim())
            };

            try
            {
                DBHelper.ExecuteNonQuery(query, parameters);
                ShowMessage("✅ Candidate added successfully!", true);
                LoadCandidates();
                ClearCandidateFields();
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, false);
            }
        }

        private void LoadElectionsDropdown()
        {
            string query = "SELECT ElectionID, ElectionName FROM Elections ORDER BY ElectionName";
            DataTable dt = DBHelper.ExecuteQuery(query);

            ddlElections.DataSource = dt;
            ddlElections.DataTextField = "ElectionName";
            ddlElections.DataValueField = "ElectionID";
            ddlElections.DataBind();
            ddlElections.Items.Insert(0, new ListItem("-- Select Election --", "0"));
        }

        private void LoadCandidates()
        {
            string query = @"SELECT C.CandidateID, E.ElectionName, C.CandidateName, C.Position, C.Department, C.Manifesto 
                           FROM Candidates C 
                           INNER JOIN Elections E ON C.ElectionID = E.ElectionID 
                           ORDER BY E.ElectionName, C.CandidateName";
            DataTable dt = DBHelper.ExecuteQuery(query);
            gvCandidates.DataSource = dt;
            gvCandidates.DataBind();
        }

        private void ClearCandidateFields()
        {
            txtCandidateName.Text = "";
            txtPosition.Text = "";
            txtCandidateDept.Text = "";
            txtManifesto.Text = "";
            ddlElections.SelectedIndex = 0;
        }

        // ============= RESULTS =============
        private void LoadAllResults()
        {
            string query = @"SELECT E.ElectionName, C.CandidateName, C.Position, COUNT(V.VoteID) as VoteCount
                           FROM Elections E
                           INNER JOIN Candidates C ON E.ElectionID = C.ElectionID
                           LEFT JOIN Votes V ON C.CandidateID = V.CandidateID
                           GROUP BY E.ElectionName, C.CandidateName, C.Position
                           ORDER BY E.ElectionName, VoteCount DESC";

            DataTable dt = DBHelper.ExecuteQuery(query);
            gvResults.DataSource = dt;
            gvResults.DataBind();
        }

        // ============= ADMINS (NEW) =============
        protected void btnCreateAdmin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtAdminUsername.Text) || string.IsNullOrEmpty(txtAdminPassword.Text))
            {
                ShowMessage("❌ Username and Password are required!", false);
                return;
            }

            string query = @"INSERT INTO Admins (Username, Password, FullName, Email) 
                           VALUES (@Username, @Password, @FullName, @Email)";

            SqlParameter[] parameters = {
                new SqlParameter("@Username", txtAdminUsername.Text.Trim()),
                new SqlParameter("@Password", txtAdminPassword.Text), // In production, hash this!
                new SqlParameter("@FullName", txtAdminFullName.Text.Trim()),
                new SqlParameter("@Email", txtAdminEmail.Text.Trim())
            };

            try
            {
                DBHelper.ExecuteNonQuery(query, parameters);
                ShowMessage("✅ New admin created successfully!", true);
                LoadAdmins();
                ClearAdminFields();
            }
            catch (SqlException ex)
            {
                if (ex.Message.Contains("duplicate") || ex.Message.Contains("UNIQUE"))
                {
                    ShowMessage("❌ Username already exists!", false);
                }
                else
                {
                    ShowMessage("❌ Error: " + ex.Message, false);
                }
            }
        }

        private void LoadAdmins()
        {
            string query = "SELECT AdminID, Username, FullName, Email, CreatedDate FROM Admins ORDER BY CreatedDate DESC";
            DataTable dt = DBHelper.ExecuteQuery(query);
            gvAdmins.DataSource = dt;
            gvAdmins.DataBind();
        }

        private void ClearAdminFields()
        {
            txtAdminUsername.Text = "";
            txtAdminPassword.Text = "";
            txtAdminFullName.Text = "";
            txtAdminEmail.Text = "";
        }

        // ============= LOGOUT =============
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
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