using Npgsql;
using NpgsqlTypes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de DaoPelu
/// </summary>
public class DaoPelu
{

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

	public void InsertServicios(EServicios servicios)
	{
		DataTable servicio = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("proyecto1.f_insertar_servicio", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
			dataAdapter.SelectCommand.Parameters.Add("_nom_ser", NpgsqlDbType.Text).Value = servicios.NomServicio;
			dataAdapter.SelectCommand.Parameters.Add("_costo", NpgsqlDbType.Integer).Value = servicios.Costo;
			dataAdapter.SelectCommand.Parameters.Add("_tiempo", NpgsqlDbType.Text).Value = servicios.Tiempo;
			

			conection.Open();
			dataAdapter.Fill(servicio);
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

	}

	public List<EServicios> obtenerServicio()
	{
		DataTable servicio = new DataTable();
		List<EServicios> listservicio = new List<EServicios>();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("proyecto1.f_Obtener_servicios", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

			conection.Open();
			dataAdapter.Fill(servicio);
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

		listservicio = servicio.AsEnumerable().Select(m => new EServicios()
		{
			Id_ser = m.Field<int>("id_ser"),
			NomServicio = m.Field<string>("nom_ser"),
			Costo= m.Field<int>("costo"),
			Tiempo = m.Field<string>("tiempo"),
		}).ToList();

		return listservicio;
	}
	public void actualizarServicio(EServicios servicios)
	{
		DataTable servicio = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("proyecto1.f_actualizar_servicios", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

			dataAdapter.SelectCommand.Parameters.Add("_nom_ser", NpgsqlDbType.Text).Value = servicios.NomServicio;
			dataAdapter.SelectCommand.Parameters.Add("_costo", NpgsqlDbType.Integer).Value = servicios.Costo;
			dataAdapter.SelectCommand.Parameters.Add("_tiempo", NpgsqlDbType.Text).Value = servicios.Tiempo;
			
			conection.Open();
			dataAdapter.Fill(servicio);
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
	}

	public void eliminarServicio(EServicios servicio)
	{
		DataTable Servicios = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("proyecto1.f_eliminar_servicios", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
			dataAdapter.SelectCommand.Parameters.Add("_id_ser", NpgsqlDbType.Integer).Value = servicio.Id_ser;

			conection.Open();
			dataAdapter.Fill(Servicios);
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
	}
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