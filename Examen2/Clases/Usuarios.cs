﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace Examen2.Clases
{
    public class UsuariosID
    {
        internal static object text;

        private int id { get; set; }
        public string Nombre { get; set; } 
        public int telefono { get; set; }

        public string Correoele { get; set; }
        public static object DBConn { get; private set; }
        public static string Text { get; internal set; }
        public string Telefono { get; internal set; }
        public string CorreoEle { get; internal set; }
        public int Usuarios { get; internal set; }

        public UsuariosID(int Id, String Nombre, int Telefono, String Correoele)

        {
            id = Id;
            this.Nombre = Nombre;
            Telefono = telefono;
            this.Correoele = Correoele;

        }

        public UsuariosID(int v1, string v2)
        {
        }

        public static int Agregar(string NOMBRE, int telefono, string CORREOELE)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = DBconn.obtenerconexion())
                {
                    SqlCommand cmd = new SqlCommand("INGRESAR", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@NOMBRE", NOMBRE));
                    cmd.Parameters.Add(new SqlParameter("@CORREOELE", CORREOELE));
                    cmd.Parameters.Add(new SqlParameter("@TELEFONO", telefono));


                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;

        }

        public static int Borrar(int id)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = DBconn.obtenerconexion())
                {
                    SqlCommand cmd = new SqlCommand("BORRARTIPO", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@CODIGO", id));


                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;


        }

        public static List<tipo> ConsultaFiltro(int id)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            List<tipo> tipos = new List<tipo>();
            try
            {

                using (Conn = DBconn.obtenerconexion())
                {
                    SqlCommand cmd = new SqlCommand("CONSULTAR_FILTROTIPOS", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@id", id));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            tipo tipo = new UsuariosID(reader.GetInt32(0), reader.GetString(1));  // instancia
                            tipos.Add(tipo);

                        }


                    }
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return tipos;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }

            return tipos;
        }

        public static int Modificar(int Usuarios, string Nombre, string CorreoEle, string Telefono)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = DBconn.obtenerconexion())
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Usuarios SET Nombre = @Nombre, CorreoElectronico = @CorreoElectronico, Telefono = @Telefono WHERE UsuarioID = @UsuarioID", Conn)
                    {
                        CommandType = CommandType.Text
                    };
                    cmd.Parameters.Add(new SqlParameter("@UsuarioID", Usuarios));
                    cmd.Parameters.Add(new SqlParameter("@Nombre", Nombre));
                    cmd.Parameters.Add(new SqlParameter("@CorreoElectronico", CorreoEle));
                    cmd.Parameters.Add(new SqlParameter("@Telefono", Telefono));

                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;

        }

    }
}