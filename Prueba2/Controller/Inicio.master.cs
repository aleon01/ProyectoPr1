using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Inicio : System.Web.UI.MasterPage
{
	
	protected void LB_Inicio_Click(object sender, EventArgs e)
	{
		Response.Redirect("~/View/Inicio.aspx");
	}

	protected void LB_Servicios_Click(object sender, EventArgs e)
	{
		Response.Redirect("~/View/Servicios.aspx");
	}

	protected void LB_Contactenos_Click(object sender, EventArgs e)
	{
		Response.Redirect("~/View/Contactenos.aspx");
	}

	protected void LB_InicioS_Click(object sender, EventArgs e)
	{
		Response.Redirect("~/View/Login.aspx");
	}
}
