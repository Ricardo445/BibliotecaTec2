using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Biblioteca_Tec
{
    class FormToPanel
    {
        public void AddFormInPanel(object formHijo, Panel panel1 )
        {
            //panel1.Controls.RemoveAt(0);
            if (panel1.Controls.Count > 0)
                panel1.Controls.Clear();

            Form fh = formHijo as Form;
            fh.TopLevel = false;
            fh.FormBorderStyle = FormBorderStyle.None;
            fh.Dock = DockStyle.Fill;
            panel1.Controls.Add(fh);
            panel1.Tag = fh;
            fh.Show();

        }
    }
}
