using Microsoft.Data.SqlClient;
using System;
using System.Data;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.Xml.Linq;

namespace class_1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_MouseClick(object sender, MouseEventArgs e)
        {
            string serverAddress = textBox1.Text;
            string database = textBox2.Text;
            string user = textBox3.Text;
            string password = textBox4.Text;
            

            TestDBConnection(serverAddress, database, user, password);
        }

        private void button2_MouseClick(object sender, MouseEventArgs e)
        {
            string serverAddress = textBox1.Text;
            string database = textBox2.Text;
            string user = textBox3.Text;
            string password = textBox4.Text;

            SqlConnection CN = new SqlConnection("Data Source = " + serverAddress + ";"
          + "Initial Catalog = " + database + "; uid = " + user + ";" + "password = " 
          + password + ";" + "Trusted_Connection = False; MultipleActiveResultSets = True; " +
          "Encrypt = True; TrustServerCertificate = True");
            
            string data = GetTableContent(CN);

            MessageBox.Show(data);
        }


        // Given Class Code
        private void TestDBConnection(string dbServer, string dbName, string userName, string userPass)
        {
            SqlConnection CN = new SqlConnection("Data Source = " + dbServer + ";"
           + "Initial Catalog = " + dbName + "; uid = " + userName + ";" + "password = " 
           + userPass + ";" + "Trusted_Connection = False; MultipleActiveResultSets = True; " +
           "Encrypt = True; TrustServerCertificate = True");

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    MessageBox.Show("Successful connection to database " + CN.Database + " on the "
                   + CN.DataSource + " server", "Connection Test", MessageBoxButtons.OK);
                }
                
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open connection to database due to the error \r\n" +
               ex.Message, "Connection Test", MessageBoxButtons.OK);
            }
            if (CN.State == ConnectionState.Open)
                CN.Close();
        }

        private string GetTableContent(SqlConnection CN)
        {
            string str = "";

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    int cnt = 1;
                    SqlCommand sqlcmd = new SqlCommand("SELECT * FROM Hello", CN);
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();
                    while (reader.Read())
                    {
                        str += cnt.ToString() + " - " + reader.GetInt32(reader.GetOrdinal("MsgID")) +
                       ", ";
                        str += reader.GetString(reader.GetOrdinal("MsgSubject"));
                        str += "\n";
                        cnt += 1;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(" Failed to open connection to database due to the error \r\n" +
               ex.Message, "Connection Error", MessageBoxButtons.OK);
            }
            if (CN.State == ConnectionState.Open)
                CN.Close();
            return str;
        }

    }
}