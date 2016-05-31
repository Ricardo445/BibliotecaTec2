using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.Configuration;


namespace Biblioteca_Tec
{
    class Datos
    {
        //Conexion de la Base Datos -------------------------------------------------
        SqlConnection con;

        string cadena = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;

        private SqlConnection abrir()
        {
            try
            {
                con = new SqlConnection(cadena);
                con.Open();
                return con;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        private void cerrar()
        {
            try { con.Close(); }
            catch (Exception ex) { }
        }
        //--------------------------------------------------------------------------

        //Metodo para ejecutar un comando SQL---------------------------------------
        public string RegistrarUsuario(string usuario, string contraseña)
        {
            try
            {
                SqlCommand comand = new SqlCommand("Insertar_Usuario", abrir());
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add(new SqlParameter("@Usuarios", usuario));
                comand.Parameters.Add(new SqlParameter("@Contraseña", contraseña));
                SqlParameter mensaje = new SqlParameter("@msg", SqlDbType.VarChar,50);
                mensaje.Direction = ParameterDirection.Output;
                comand.Parameters.Add(mensaje);
                comand.ExecuteNonQuery();
                return comand.Parameters["@msg"].Value.ToString();

            }
            catch (Exception)
            {
                return "Error al realizar el registro";
            }
            finally
            {
                cerrar();
            }
        }
        //-----------------------------------------------------------------------------

        public string GetPassword(string sql)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(sql, abrir());
                return cmd.ExecuteScalar().ToString();

            }
            catch (Exception)
            {
                return "Error al realizar el registro";
            }
            finally
            {
                cerrar();
            }
        }

        public string RegistrarVisitas(string Matricula)
        {
            try
            {
                SqlCommand comand = new SqlCommand("InsertarEntradas", abrir());
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add(new SqlParameter("@Matricula", Matricula));
                SqlParameter mensaje = new SqlParameter("@msg", SqlDbType.VarChar, 50);
                mensaje.Direction = ParameterDirection.Output;
                comand.Parameters.Add(mensaje);
                comand.ExecuteNonQuery();
                return comand.Parameters["@msg"].Value.ToString();

            }
            catch (Exception)
            {
                return "Error";
            }
            finally
            {
                cerrar();
            }
        }
    }
}
