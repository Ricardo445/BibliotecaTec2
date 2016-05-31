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
    public partial class Opciones : Form
    {
        public Opciones()
        {
            InitializeComponent();
        }
        FormToPanel F = new FormToPanel();
        Login L = new Login();
        private void btnLogin_Click(object sender, EventArgs e)
        {
            F.AddFormInPanel(new LoginA(), panel1);
            //button1.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Visitas V = new Visitas();
            V.ShowDialog();
        }
    }
}
