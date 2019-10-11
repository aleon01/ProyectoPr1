<%@ Page Title="" Language="C#" MasterPageFile="~/View/Administrador/Administrador.master" AutoEventWireup="true" CodeFile="~/Controller/Administrador/RegServ.aspx.cs" Inherits="View_RegServ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style type="text/css">
		.auto-style6 {
			width: 156px;
		}
		.auto-style7 {
			width: 550px;
		}
		.auto-style8 {
			text-align: justify;
			width: 550px;
		}
		.auto-style9 {
			width: 262px;
		}
		.auto-style10 {
			width: 79px;
		}
		.auto-style11 {
			width: 100px;
		}
		.auto-style16 {
			width: 128%;
			height: 17px;
		}
		.auto-style17 {
			width: 214%
		}
		.auto-style18 {
			width: 83px;
		}
		.auto-style19 {
			width: 604px;
			height: 17px;
			text-align: left;
		}
		.auto-style21 {
			text-align: justify;
			height: 15px;
			width: 55px;
		}
		.auto-style24 {
			font-weight: 300;
			width: 55px;
		}
		.auto-style26 {
			font-weight: 300;
			width: 55px;
			height: 26px;
		}
		.auto-style27 {
			width: 83px;
			height: 26px;
		}
		.auto-style28 {
			width: 286px;
			height: 15px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<table class="auto-style19">
		<tr>
			<td class="auto-style24">&nbsp;</td>
			<td class="auto-style18">
				<asp:Button ID="B_MostrarSer" runat="server" Text="Mostrar" class="btn btn-success" OnClick="B_MostrarSer_Click" />
			</td>
		</tr>
		<tr>
			<td class="auto-style26"></td>
			<td class="auto-style27">
				</td>
		</tr>
		<tr>
			<td class="auto-style24">
				<table class="auto-style17">
					<tr>
						<td>
							Nombre:<br />
							<asp:TextBox ID="TB_NomServicio" runat="server" class="form-control" Width="241px" ></asp:TextBox>
						</td>
						
						<td>Foto Servicio:<br />
							<asp:FileUpload ID="FU_FotoServicio" runat="server" Width="280px" />
						</td>
					</tr>
					<tr>
						<td>
							Costo:<br />
							<asp:TextBox ID="TB_CostoServicio" runat="server" class="form-control" Width="242px"></asp:TextBox>
						</td>
						
						<td>zDescripcion Servicio:<br />
							<asp:TextBox ID="TB_DescripcionSer" runat="server" class="form-control"></asp:TextBox>
							<br />
							</td>
					</tr>
					<tr>
						<td>
							Tiempo:<br />
							<asp:TextBox ID="TB_TiempoServicio" runat="server" class="form-control" Width="242px" />
						</td>
						<td>
							&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="auto-style21">
				<table class="w-100">
					<tr>
						<td class="auto-style9">&nbsp;</td>
						<td class="auto-style28">
							<br />
				<asp:Button ID="B_AgregarServ" runat="server" Text="Agregar" class="btn btn-outline-success" Width="91px" OnClick="B_AgregarServ_Click"/>
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</asp:Content>

