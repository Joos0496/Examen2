using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Examen2.Clases
{
    public class DBconn
    {
        public static SqlConnection obtenerconexion()
        {
            string s = System.Configuration.ConfigurationManager.ConnectionStrings["conexiondeprueba"].ConnectionString;
            SqlConnection conexion = new SqlConnection(s);
            conexion.Open();
            return conexion;
        }
    }
}