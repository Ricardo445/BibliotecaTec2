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
    public partial class Visitas : Form
    {
        public Visitas()
        {
            InitializeComponent();
        }

        Datos D = new Datos();
        private void button1_Click(object sender, EventArgs e)
        {
            label2.Text = D.RegistrarVisitas(txtMatricula.Text);
            label2.Location = new Point((this.Width - label2.Width) / 2, ((this.Height - label2.Height) / 2) + 225);
        }

        private void Visitas_Load(object sender, EventArgs e)
        {
            label2.Location = new Point((this.Width - label2.Width) / 2, ((this.Height - label2.Height) / 2) + 225);
            label3.Location = new Point((this.Width - label3.Width) / 2, ((this.Height - label3.Height) / 2) - 50);
            label1.Location = new Point((this.Width - label1.Width) / 2, ((this.Height - label1.Height) / 2) - 100);

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void txtMatricula_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode== Keys.Return)
            {
                label2.Text = D.RegistrarVisitas(txtMatricula.Text);
                label2.Location = new Point((this.Width - label2.Width) / 2, ((this.Height - label2.Height) / 2) + 225);
            }
        }
    }
}
