using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Administrador_MosServicios : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{

	}


	protected void GV_MServicios_RowUpdating(object sender, GridViewUpdateEventArgs e)
	{
		GridViewRow fila = GV_MServicios.Rows[e.RowIndex];
		FileUpload FU_EPerfil = (FileUpload)fila.FindControl("FU_EdiFServ");
		ClientScriptManager cm = this.ClientScript;

		if (FU_EPerfil.PostedFile.FileName != "")
		{
			if (!(System.IO.Path.GetExtension(FU_EPerfil.PostedFile.FileName).Equals(".jpg") || System.IO.Path.GetExtension(FU_EPerfil.PostedFile.FileName).Equals(".jpeg")
				 || System.IO.Path.GetExtension(FU_EPerfil.PostedFile.FileName).Equals(".bmp") || System.IO.Path.GetExtension(FU_EPerfil.PostedFile.FileName).Equals(".gif")
				 || System.IO.Path.GetExtension(FU_EPerfil.PostedFile.FileName).Equals(".png")))
			{
				cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Solo se reciben imagenes');</script>");

				e.Cancel = true;

			}
			else
			{
				e.NewValues.Add("foto", ("~\\Archivos\\FotoS" + FU_EPerfil.PostedFile.FileName));

				if (File.Exists(Server.MapPath(e.NewValues["foto"].ToString())))
				{
					cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('La imagen ya existe en el servidor, Seleccione otra.');</script>");
					e.Cancel = true;
				}
				else
				{
					FU_EPerfil.PostedFile.SaveAs(Server.MapPath(e.NewValues["foto"].ToString()));
				}

			}

		}
		else
		{

			e.NewValues.Add("foto", ((Image)fila.FindControl("EditImgSer")).ImageUrl);
		}
	}
}