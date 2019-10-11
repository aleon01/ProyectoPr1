using Npgsql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de DaoFunciones
/// </summary>
public class DaoFunciones
{
	public List<EServicios> obtenerServicios()
	{
		DataTable servicios = new DataTable();
		List<EServicios> listServicios = new List<EServicios>();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("servicios.f_obtener_asignars", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

			conection.Open();
			dataAdapter.Fill(servicios);
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

		listServicios = servicios.AsEnumerable().Select(m => new EServicios()
		{
			NomServicio = m.Field<string>("servicio_nom"),
		}).ToList();

		return listServicios;
	}
}