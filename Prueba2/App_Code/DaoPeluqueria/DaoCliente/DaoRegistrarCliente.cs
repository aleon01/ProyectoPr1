using Npgsql;
using NpgsqlTypes;
using System;
using System.Configuration;
using System.Data;

/// <summary>
/// Descripción breve de DaoRegistrarCliente
/// </summary>
public class DaoRegistrarCliente
{
	public DataTable InsertarPersona(ERegistrarCliente registrarCliente)
	{
		DataTable Usuario = new DataTable();
		NpgsqlConnection conection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Postgres"].ConnectionString);

		try
		{
			NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter("usuarios.f_insertar_usuarios", conection);
			dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

			dataAdapter.SelectCommand.Parameters.Add("_nombre", NpgsqlDbType.Text).Value = registrarCliente.Nombre;
			dataAdapter.SelectCommand.Parameters.Add("_apellido", NpgsqlDbType.Text).Value = registrarCliente.Apellido;
			dataAdapter.SelectCommand.Parameters.Add("_numero_identificacion", NpgsqlDbType.Integer).Value = registrarCliente.NumeroIdentificacion;
			dataAdapter.SelectCommand.Parameters.Add("_correo", NpgsqlDbType.Text).Value = registrarCliente.Correo;
			dataAdapter.SelectCommand.Parameters.Add("_usuario", NpgsqlDbType.Text).Value = registrarCliente.Usuario;
			dataAdapter.SelectCommand.Parameters.Add("_clave", NpgsqlDbType.Text).Value = registrarCliente.Clave;
			dataAdapter.SelectCommand.Parameters.Add("_rol_id", NpgsqlDbType.Integer).Value = registrarCliente.RolId;
			dataAdapter.SelectCommand.Parameters.Add("_session", NpgsqlDbType.Text).Value = registrarCliente.Sesion;
			dataAdapter.SelectCommand.Parameters.Add("_tipo_identificacion", NpgsqlDbType.Text).Value = registrarCliente.TipoIdentificacion1;
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