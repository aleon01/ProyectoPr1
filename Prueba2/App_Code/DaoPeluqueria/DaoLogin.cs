using Npgsql;
using NpgsqlTypes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de DaoLogin
/// </summary>
public class DaoLogin
{
	//Ingreso desde el Login
	public DataTable login1(string userName, String clave)
	{
		DataTable usuarios = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("security.f_loggin", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

			dataAdapter.SelectCommand.Parameters.Add("_usuario", NpgsqlDbType.Text).Value = userName;
			dataAdapter.SelectCommand.Parameters.Add("_clave", NpgsqlDbType.Text).Value = clave;

			conection.Open();
			dataAdapter.Fill(usuarios);
		}
		catch (Exception Ex)
		{
			throw Ex;
		}
		finally
		{
			if (conection != null)
			{
				conection.Close();
			}
		}
		//usuarios = usuarios.AsEnumerable().Select(m => new EPelu()
		//{
		//	RolNombre = m.Field<string>("rol_nombre"),
		//	RolId = m.Field<int>("rol_id")
		//}).ToList();
		return usuarios;

	}


	//Guardar datos de Session
	public DataTable guardadoSession(EUsuario datos)
	{
		DataTable Usuario = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("security.f_guardado_session", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
			dataAdapter.SelectCommand.Parameters.Add("_user_id", NpgsqlDbType.Integer).Value = datos.UserId;
			dataAdapter.SelectCommand.Parameters.Add("_ip", NpgsqlDbType.Varchar, 100).Value = datos.Ip;
			dataAdapter.SelectCommand.Parameters.Add("_mac", NpgsqlDbType.Varchar, 100).Value = datos.Mac;
			dataAdapter.SelectCommand.Parameters.Add("_session", NpgsqlDbType.Text).Value = datos.Session;

			conection.Open();
			dataAdapter.Fill(Usuario);
		}
		catch (Exception Ex)
		{
			throw Ex;
		}
		finally
		{
			if (conection != null)
			{
				conection.Close();
			}
		}
		return Usuario;
	}

	//Cerrar Sesion
	public DataTable cerrarSession(EUsuario datos)
	{
		DataTable Usuario = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("security.f_cerrar_session", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
			dataAdapter.SelectCommand.Parameters.Add("_session", NpgsqlDbType.Text).Value = datos.Session;

			conection.Open();
			dataAdapter.Fill(Usuario);
		}
		catch (Exception Ex)
		{
			throw Ex;
		}
		finally
		{
			if (conection != null)
			{
				conection.Close();
			}
		}
		return Usuario;
	}
}