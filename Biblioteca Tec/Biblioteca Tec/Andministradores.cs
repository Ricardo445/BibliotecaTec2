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
         MessageBox.Show(D.RegistrarUsuario(txtusuario.Text  ,Seguridad.encript( txtContraseña.Text)));  

        }
    }
}
