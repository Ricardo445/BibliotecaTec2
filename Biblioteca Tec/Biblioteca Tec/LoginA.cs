﻿using System;
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
    public partial class LoginA : Form
    {
        public LoginA()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        FormToPanel F = new FormToPanel();
        Datos D = new Datos();
        private void btnCancelar_Click(object sender, EventArgs e)
        {
            F.AddFormInPanel(new Opciones(), panel1);
        }

        private void btnIngresas_Click(object sender, EventArgs e)
        {
            const string fic = @"password.txt";
            string texto;

            System.IO.StreamReader sr = new System.IO.StreamReader(fic);
            texto = sr.ReadToEnd();
            sr.Close();
            if (txtUsuario.Text=="admin1"&& txtContraseña.Text==Seguridad.des(texto))
            {
                Administrador A = new Administrador();
                F.AddFormInPanel(new Opciones(), panel1);
                txtContraseña.Text = "";
                txtUsuario.Text = "";
                A.ShowDialog();
        }
            else
                MessageBox.Show("Las credenciales no son validas");



        }
        Andministradores A = new Andministradores();
        private void button1_Click(object sender, EventArgs e)
        {
            const string fic = @"password.txt";
            string texto;

            System.IO.StreamReader sr = new System.IO.StreamReader(fic);
            texto = sr.ReadToEnd();
            sr.Close();
            if (txtUsuario.Text == "admin1" && txtContraseña.Text == Seguridad.des(texto))
            {
                txtContraseña.Text = "";
                txtUsuario.Text = "";
                A.ShowDialog();
            }
            else
                MessageBox.Show("Las credenciales no son validas");
        }
    }
}
