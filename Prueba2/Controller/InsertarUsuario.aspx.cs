using System;

public partial class View_InsertarUsuario : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{

	}

	protected void B_Registrar_Click(object sender, EventArgs e)
	{
		ERegistrarCliente data = new ERegistrarCliente();
		DaoRegistrarCliente user = new DaoRegistrarCliente();



		data.Nombre = TB_Nombre.Text.ToString();
		data.Apellido = TB_Apellido.Text.ToString();
		data.TipoIdentificacion1 = DDL_TipoIdentificacion.Text.ToString();
		data.NumeroIdentificacion = Int32.Parse(TB_NumeroIdenti.Text.ToString());
		data.Correo = TB_CorreoElectronico.Text.ToString();
		data.Usuario = TB_UserName.Text.ToString();
		data.Clave = TB_Contraseña.Text.ToString();
		data.RolId = 3;
		data.Sesion = Session.SessionID;

		user.InsertarPersona(data);
	}

	protected void TB_NumeroIdenti_TextChanged(object sender, EventArgs e)
	{

	}
}