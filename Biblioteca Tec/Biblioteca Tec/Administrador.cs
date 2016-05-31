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
    public partial class Administrador : Form
    {
        public Administrador()
        {
            InitializeComponent();
        }

        private void Administrador_Load(object sender, EventArgs e)
        {
            F.AddFormInPanel(new Estudiayes(), panel4);
            this.Location = Screen.PrimaryScreen.WorkingArea.Location;
            this.Size = Screen.PrimaryScreen.WorkingArea.Size;
            panel1.Width = this.Width+3;
            panel2.Width = this.Width+3;
            panel2.Location = new Point(0, ClientSize.Height-59);
            button4.Location = new Point(ClientSize.Width - 29, 0);
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        FormToPanel F = new FormToPanel();
        private void button2_Click(object sender, EventArgs e)
        {
            F.AddFormInPanel(new Estudiayes(),panel4);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            F.AddFormInPanel(new Andministradores(), panel4);
        }

        private void panel4_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            F.AddFormInPanel(new Reportes(), panel4);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
