using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace UniversityVotingSystem
{
    public partial class UserLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    Response.Redirect("UserDashboard.aspx");
                }
            }
        }

        // Traditional password login
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string query = "SELECT UserID, FullName FROM Users WHERE StudentID=@StudentID AND Password=@Password AND IsActive=1";

            SqlParameter[] parameters = {
                new SqlParameter("@StudentID", txtStudentID.Text.Trim()),
                new SqlParameter("@Password", txtPassword.Text)
            };

            try
            {
                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    // Login successful
                    Session["UserID"] = dt.Rows[0]["UserID"];
                    Session["UserName"] = dt.Rows[0]["FullName"];
                    Session["Role"] = "User";

                    Response.Redirect("UserDashboard.aspx");
                }
                else
                {
                    ShowMessage("❌ Invalid Student ID or Password!", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, false);
            }
        }

        // Face recognition login
        protected void btnFaceLogin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfDetectedFace.Value))
            {
                ShowMessage("❌ No face detected! Please try again or use password login.", false);
                return;
            }

            try
            {
                // Parse detected face descriptor
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                double[] detectedDescriptor = serializer.Deserialize<double[]>(hfDetectedFace.Value);

                // Get all users with face data
                string query = "SELECT UserID, FullName, StudentID, FaceDescriptor FROM Users WHERE FaceDescriptor IS NOT NULL AND IsActive=1";
                DataTable dt = DBHelper.ExecuteQuery(query);

                if (dt.Rows.Count == 0)
                {
                    ShowMessage("❌ No users registered with face authentication. Please use password login.", false);
                    return;
                }

                double bestMatchDistance = double.MaxValue;
                int matchedUserID = -1;
                string matchedName = "";
                string matchedStudentID = "";

                // Compare with all registered faces
                foreach (DataRow row in dt.Rows)
                {
                    string storedDescriptorJson = row["FaceDescriptor"].ToString();

                    if (string.IsNullOrEmpty(storedDescriptorJson))
                        continue;

                    try
                    {
                        double[] storedDescriptor = serializer.Deserialize<double[]>(storedDescriptorJson);

                        // Calculate Euclidean distance
                        double distance = CalculateEuclideanDistance(detectedDescriptor, storedDescriptor);

                        if (distance < bestMatchDistance)
                        {
                            bestMatchDistance = distance;
                            matchedUserID = Convert.ToInt32(row["UserID"]);
                            matchedName = row["FullName"].ToString();
                            matchedStudentID = row["StudentID"].ToString();
                        }
                    }
                    catch
                    {
                        // Skip this user if face data is corrupted
                        continue;
                    }
                }

                // Distance threshold for face match (lower is better, typically < 0.6 is good)
                if (bestMatchDistance < 0.6)
                {
                    // Face matched successfully!
                    Session["UserID"] = matchedUserID;
                    Session["UserName"] = matchedName;
                    Session["Role"] = "User";

                    ShowMessage($"✅ Welcome back, {matchedName}! Face recognized successfully.", true);

                    // Redirect after short delay to show message
                    Response.AddHeader("REFRESH", "1;URL=UserDashboard.aspx");
                }
                else
                {
                    ShowMessage($"❌ Face not recognized! (Match confidence: {(1 - bestMatchDistance) * 100:F1}%)\nPlease try again or use password login.", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error during face verification: " + ex.Message + "\nPlease use password login.", false);
            }
        }

        // Calculate Euclidean distance between two face descriptors
        private double CalculateEuclideanDistance(double[] descriptor1, double[] descriptor2)
        {
            if (descriptor1.Length != descriptor2.Length)
                return double.MaxValue;

            double sum = 0;
            for (int i = 0; i < descriptor1.Length; i++)
            {
                double diff = descriptor1[i] - descriptor2[i];
                sum += diff * diff;
            }

            return Math.Sqrt(sum);
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