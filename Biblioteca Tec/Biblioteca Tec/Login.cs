using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Biblioteca_Tec
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        
        FormToPanel F = new FormToPanel();
        private void Login_Load(object sender, EventArgs e)
        {
           F.AddFormInPanel(new Opciones(),panel1);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
