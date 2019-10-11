using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de EServicios
/// </summary>
public class EServicios
{
	private int id_ser;
	private string nomServicio;
	private int costo;
	private string tiempo;
	private string foto;
	private string descripcion;

	public int Id_ser { get => id_ser; set => id_ser = value; }
	public string NomServicio { get => nomServicio; set => nomServicio = value; }
	public int Costo { get => costo; set => costo = value; }
	public string Tiempo { get => tiempo; set => tiempo = value; }
	public string Foto { get => foto; set => foto = value; }
	public string Descripcion { get => descripcion; set => descripcion = value; }
}