using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_RegServ : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{

	}

	protected void B_MostrarSer_Click(object sender, EventArgs e)
	{
		Response.Redirect("~/View/Administrador/MosServicios.aspx");
	}

	protected void B_AgregarServ_Click(object sender, EventArgs e)
	{
		ClientScriptManager cm = this.ClientScript;
		EServicios servicios = new EServicios();

		servicios.NomServicio = TB_NomServicio.Text;
		servicios.Costo = int.Parse(TB_CostoServicio.Text);
		servicios.Tiempo = TB_TiempoServicio.Text;
		servicios.Descripcion = TB_DescripcionSer.Text;

		string nomArchivo = System.IO.Path.GetFileName(FU_FotoServicio.PostedFile.FileName);
		string extension = System.IO.Path.GetExtension(FU_FotoServicio.PostedFile.FileName);
		string saveLocation = "~\\Archivos";
		if ((extension.Equals(".jpg") || extension.Equals(".gif") || extension.Equals(".jpge") || extension.Equals(".png")))
		{
			saveLocation = saveLocation + "\\FotosS\\" + nomArchivo;
			servicios.Foto = saveLocation;
		}
		else
		{
			cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('El formato del archivo es invalido');</script>");
			return;
		}

		if (System.IO.File.Exists(Server.MapPath(saveLocation)))
		{
			cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Ya existe un archivo en el servidor con ese nombre');</script>");
			return;
		}
		FU_FotoServicio.PostedFile.SaveAs(Server.MapPath(saveLocation));
		new DaoServicios().InsertServicios(servicios);

	}
}