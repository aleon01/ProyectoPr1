using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Login : System.Web.UI.Page
{

	protected void Login_Autenticate(object sender, EventArgs e)
	{
		DaoLogin IngresoU = new DaoLogin();
		DataTable data = IngresoU.login1(Login1.UserName.ToString(), Login1.Password.ToString());

		if (int.Parse(data.Rows[0]["user_id"].ToString()) > 0)
		{
			Session["nombre"] = data.Rows[0]["nombre"].ToString();
			Session["user_id"] = data.Rows[0]["user_id"].ToString();

			EUsuario datosUsuario = new EUsuario();
			MAC datosConexion = new MAC();

			/* ipAddress = HttpContext.Current.Request.UserHostAddress;
             mac = Utilidades.Mac.GetMAC(ref ipAddress);*/

			datosUsuario.UserId = int.Parse(Session["user_id"].ToString());
			datosUsuario.Ip = datosConexion.ip();
			datosUsuario.Mac = datosConexion.mac();
			datosUsuario.Session = Session.SessionID;
			datosUsuario.RolId = int.Parse(data.Rows[0]["rol_id"].ToString());
			Session["user"] = datosUsuario;
			IngresoU.guardadoSession(datosUsuario);
			if (datosUsuario.RolId == 1)
				Response.Redirect("~/View/Administrador/Admi.aspx");
			else
				Response.Redirect("MenuOperador.aspx");
		}
	}



}