using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Administrador : System.Web.UI.MasterPage
{
	protected void Page_Load(object sender, EventArgs e)
	{

	}

	protected void B_Cierre_Click(object sender, EventArgs e)
	{
		Session["user_id"] = null;
		Session["nombre"] = null;

		DaoPelu user = new DaoPelu();
		EUsuario datos = new EUsuario();
		datos.Session = Session.SessionID;
		user.cerrarSession(datos);

		Response.Redirect("~/View/Login.aspx");

	}



	protected void LB_Registrar_Click(object sender, EventArgs e)
	{
		Response.Redirect("~/View/Administrador/RegServ.aspx");
	}

	protected void LB_VisualizarS_Click(object sender, EventArgs e)
	{
		Response.Redirect("~/View/Administrador/MosServicios.aspx");
	}

	protected void LB_CerrarS_Click(object sender, EventArgs e)
	{
		Session["user_id"] = null;
		Session["nombre"] = null;

		DaoPelu user = new DaoPelu();
		EUsuario datos = new EUsuario();
		datos.Session = Session.SessionID;
		user.cerrarSession(datos);

		Response.Redirect("~/View/Login.aspx");

	}
		
}
