using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de ERegistrarCliente
/// </summary>
public class ERegistrarCliente
{
	public ERegistrarCliente()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
	private String nombre;
	private String apellido;
	private String tipoIdentificacion;
	private Int32 numeroIdentificacion;
	private String correo;
	private String usuario;
	private String clave;
	private String sesion;
	private Int32 rolId;

	public string Nombre { get => nombre; set => nombre = value; }
	public string Apellido { get => apellido; set => apellido = value; }
	public int NumeroIdentificacion { get => numeroIdentificacion; set => numeroIdentificacion = value; }
	public string Correo { get => correo; set => correo = value; }
	public string Usuario { get => usuario; set => usuario = value; }
	public string Clave { get => clave; set => clave = value; }
	public string Sesion { get => sesion; set => sesion = value; }
	public int RolId { get => rolId; set => rolId = value; }
	public string TipoIdentificacion1 { get => tipoIdentificacion; set => tipoIdentificacion = value; }

}