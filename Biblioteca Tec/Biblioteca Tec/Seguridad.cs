using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Biblioteca_Tec
{
    class Seguridad
    {
        public static string encript(string palabra)
        {
            string res = string.Empty;
            byte[] encriptar = System.Text.Encoding.Unicode.GetBytes(palabra);
            res = Convert.ToBase64String(encriptar);
            return res;
        }

        public static string des(string palabra)
        {
            if (palabra != "Error al realizar el registro")
            {
                string result = string.Empty;
                byte[] desencrip = Convert.FromBase64String(palabra);
                result = System.Text.Encoding.Unicode.GetString(desencrip);
                return result;
            }
            else
                return "";
        }
    }
}
