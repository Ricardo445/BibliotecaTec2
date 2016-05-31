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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.DoubleBuffered = true;
        }

        Login L = new Login();

        int cont = 0;
        private void timer1_Tick(object sender, EventArgs e)
        {
            if (cont == 50)
            {
                this.Hide();
                timer1.Enabled = false;
                L.ShowDialog();
                
            }
            cont++;
        }
    }
}
