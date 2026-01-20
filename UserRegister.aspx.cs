using System;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;

namespace UniversityVotingSystem
{
    public partial class UserRegister : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                ShowMessage("❌ Passwords do not match!", false);
                return;
            }

            // Get face descriptor (can be null if user skipped)
            string faceDescriptor = hfFaceDescriptor.Value;

            string query = @"INSERT INTO Users (FullName, Email, StudentID, Department, Password, FaceDescriptor, IsActive) 
                           VALUES (@FullName, @Email, @StudentID, @Department, @Password, @FaceDescriptor, 1)";

            SqlParameter[] parameters = {
                new SqlParameter("@FullName", txtFullName.Text.Trim()),
                new SqlParameter("@Email", txtEmail.Text.Trim()),
                new SqlParameter("@StudentID", txtStudentID.Text.Trim()),
                new SqlParameter("@Department", txtDepartment.Text.Trim()),
                new SqlParameter("@Password", txtPassword.Text),
                new SqlParameter("@FaceDescriptor", string.IsNullOrEmpty(faceDescriptor) ? (object)DBNull.Value : faceDescriptor)
            };

            try
            {
                int result = DBHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    string message = string.IsNullOrEmpty(faceDescriptor)
                        ? "✅ Registration successful! You can now login with password."
                        : "✅ Registration successful with face authentication! You can now login using your face or password.";

                    ShowMessage(message, true);
                    ClearFields();
                }
                else
                {
                    ShowMessage("❌ Registration failed. Please try again.", false);
                }
            }
            catch (SqlException ex)
            {
                if (ex.Message.Contains("duplicate") || ex.Message.Contains("UNIQUE"))
                {
                    ShowMessage("❌ Email or Student ID already exists!", false);
                }
                else
                {
                    ShowMessage("❌ Error: " + ex.Message, false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error: " + ex.Message, false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? Color.Green : Color.Red;
            lblMessage.BackColor = isSuccess ? Color.LightGreen : Color.LightPink;
            lblMessage.Visible = true;
        }

        private void ClearFields()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtStudentID.Text = "";
            txtDepartment.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            hfFaceDescriptor.Value = "";
        }
    }
}