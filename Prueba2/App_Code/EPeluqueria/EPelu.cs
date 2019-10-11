using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de EPelu
/// </summary>
public class EPelu
{
	private string userName;
	private string clave;
	private int rolId;
	private string rolNombre;

	public string UserName { get => userName; set => userName = value; }
	public string Clave { get => clave; set => clave = value; }
	public string RolNombre { get => rolNombre; set => rolNombre = value; }
	public int RolId { get => rolId; set => rolId = value; }
}