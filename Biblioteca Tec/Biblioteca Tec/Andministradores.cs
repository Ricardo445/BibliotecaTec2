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
    public partial class Andministradores : Form
    {
        public Andministradores()
        {
            InitializeComponent();
        }

        private void Andministradores_Load(object sender, EventArgs e)
        {
            
        }
        Datos D = new Datos();
        
        private void btnActualizarAgregar_Click(object sender, EventArgs e)
        {
            if (txtContraseña.Text!= "")
            {
                const string fic = @"password.txt";
                string texto = Seguridad.encript(txtContraseña.Text);

                System.IO.StreamWriter sw = new System.IO.StreamWriter(fic);
                sw.WriteLine(texto);
                sw.Close();
                MessageBox.Show("Contraseña Cambiada");
                Close();

            }
            else
                MessageBox.Show("No puede dejar el campo vacio");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
