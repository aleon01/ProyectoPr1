using Npgsql;
using NpgsqlTypes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de DaoServicios
/// </summary>
public class DaoServicios
{
	//Registrar Servicios a prestar
	public void InsertServicios(EServicios servicios)
	{
		DataTable servicio = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("servicios.f_insertar_servicio", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
			dataAdapter.SelectCommand.Parameters.Add("_nom_ser", NpgsqlDbType.Text).Value = servicios.NomServicio;
			dataAdapter.SelectCommand.Parameters.Add("_costo", NpgsqlDbType.Integer).Value = servicios.Costo;
			dataAdapter.SelectCommand.Parameters.Add("_tiempo", NpgsqlDbType.Text).Value = servicios.Tiempo;
			dataAdapter.SelectCommand.Parameters.Add("_f_servicio", NpgsqlDbType.Text).Value = servicios.Foto;
			dataAdapter.SelectCommand.Parameters.Add("_descripcion", NpgsqlDbType.Text).Value = servicios.Descripcion;

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

	//Mostrar Servicios Registrados
	public List<EServicios> obtenerServicio()
	{
		DataTable servicio = new DataTable();
		List<EServicios> listservicio = new List<EServicios>();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("servicios.f_obtener_servicio", conection);
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
			Id_ser = m.Field<int>("servicio_id"),
			NomServicio = m.Field<string>("servicio_nom"),
			Costo = m.Field<int>("costo"),
			Tiempo = m.Field<string>("tiempo"),
			Foto = m.Field<string>("servicio_f"),
			Descripcion = m.Field<string>("servicio_des")
		}).ToList();

		return listservicio;
	}


	//Modificar caracteristica del Servicio
	public void actualizarServicio( string nomServicio, int costo, string tiempo, string foto, string descripcion, int id_ser)
	{
		DataTable servicio = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("servicios.f_actualizar_servicio", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

			dataAdapter.SelectCommand.Parameters.Add("_nom_ser", NpgsqlDbType.Text).Value = nomServicio;
			dataAdapter.SelectCommand.Parameters.Add("_costo", NpgsqlDbType.Integer).Value = costo;
			dataAdapter.SelectCommand.Parameters.Add("_tiempo", NpgsqlDbType.Text).Value = tiempo;
			dataAdapter.SelectCommand.Parameters.Add("_f_servicio", NpgsqlDbType.Text).Value = foto;
			dataAdapter.SelectCommand.Parameters.Add("_descripcion", NpgsqlDbType.Text).Value = descripcion;
			dataAdapter.SelectCommand.Parameters.Add("_id_ser", NpgsqlDbType.Integer).Value = id_ser;

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
	
	//Eliminar o Suspender un servicio
	public void eliminarServicio(int id_ser)
	{
		DataTable servicio = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("servicios.f_eliminar_servicios", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
			dataAdapter.SelectCommand.Parameters.Add("_id_ser", NpgsqlDbType.Integer).Value = id_ser;

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
}