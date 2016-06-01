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
    public partial class Estudiayes : Form
    {
        public Estudiayes()
        {
            InitializeComponent();
        }
        Datos dat = new Datos();
        private void btnActualizarAgregar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(masked1.Text)&& string.IsNullOrWhiteSpace(txtNombre.Text) && string.IsNullOrWhiteSpace(txtApellido.Text) && string.IsNullOrWhiteSpace(txtApellido2.Text) && string.IsNullOrWhiteSpace(cbxCarrera.Text) && string.IsNullOrWhiteSpace(cbxsemestre.Text)&& string.IsNullOrWhiteSpace(cbxSexo.Text))
            {
                MessageBox.Show("No puede dejar campos vacios", "SISTEMA", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                string men = dat.Registraralumnos(masked1.Text, txtNombre.Text, txtApellido.Text, txtApellido2.Text, cbxCarrera.SelectedValue.ToString(), int.Parse(cbxsemestre.Text), cbxSexo.Text);
                MessageBox.Show(men, "SISTEMA", MessageBoxButtons.OK, MessageBoxIcon.Information);                
            }
        }

        private void Estudiayes_Load(object sender, EventArgs e)
        {
            dat.ComboCarrera(cbxCarrera);
        }
    }
}
