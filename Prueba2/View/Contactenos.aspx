<%@ Page Title="" Language="C#" MasterPageFile="~/View/Inicio.master" AutoEventWireup="true" CodeFile="~/Controller/Contactenos.aspx.cs" Inherits="View_Contactenos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
	<style type="text/css">
		.auto-style20 {
			width: 220px;
		}
		.auto-style22 {
			width: 70px;
		}
		.auto-style23 {
			width: 100%;
			margin-right: 0px;
		}
		.auto-style24 {
			width: 220px;
			text-align: right;
		}
		.auto-style25 {
			width: 172px;
		}
		.auto-style26 {
			width: 339px;
		}
		.auto-style27 {
			width: 285px;
		}
	.auto-style28 {
		width: 285px;
		text-align: left;
	}
	.auto-style29 {
		text-align: center;
	}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<table class="auto-style23">
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style27">&nbsp;</td>
			<td class="auto-style25">&nbsp;</td>
			<td class="auto-style20">&nbsp;</td>
			<td>&nbsp;</td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style27">&nbsp;</td>
			<td class="auto-style25">&nbsp;</td>
			<td colspan="2"><strong><br />
				</strong></td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style27">&nbsp;</td>
			<td class="auto-style25">&nbsp;</td>
			<td class="text-left" colspan="2"><strong>Sugerencias</strong></td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style27"><strong>Contacto</strong></td>
			<td class="auto-style25">&nbsp;</td>
			<td class="text-left" colspan="2">
				<asp:Label ID="Label1" runat="server" class="font-weight-light" Text="Nombre"></asp:Label>
				<br />
				<asp:TextBox ID="TextBox1" runat="server" class="form-control"></asp:TextBox>
			</td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style28"><strong>Correo:</strong><br />
				is2637770@gmail.com</td>
			<td class="auto-style25">&nbsp;</td>
			<td class="text-left" colspan="2">
				<asp:Label ID="Label2" runat="server" class="font-weight-light" Text="Correo"></asp:Label>
				<br />
				<asp:TextBox ID="TextBox2" runat="server" class="form-control"></asp:TextBox>
			</td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style28"><strong>Telefono:<br />
				</strong>3122567608</td>
			<td class="auto-style25">&nbsp;</td>
			<td class="text-left" colspan="2">
				<asp:Label ID="Label3" runat="server" class="font-weight-light" Text="Telefono"></asp:Label>
				<br />
				<asp:TextBox ID="TextBox3" class="form-control" runat="server"></asp:TextBox>
			</td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style27">&nbsp;</td>
			<td class="auto-style25">&nbsp;</td>
			<td class="text-left" colspan="2">
				<asp:Label ID="Label4" runat="server" Text="Mensaje"></asp:Label>
				<br />
				<asp:TextBox ID="TextBox4" runat="server" class="form-control"></asp:TextBox>
			</td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style27">&nbsp;</td>
			<td class="auto-style25">&nbsp;</td>
			<td class="auto-style24">
				<br />
			</td>
			<td class="auto-style29">
				<br />
				<asp:Button ID="Button1" runat="server" Text="Enviar" class="btn btn-outline-success" />
			</td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
		<tr>
			<td class="auto-style26">&nbsp;</td>
			<td class="auto-style27">&nbsp;</td>
			<td class="auto-style25">&nbsp;</td>
			<td class="auto-style20">&nbsp;</td>
			<td>&nbsp;</td>
			<td class="auto-style22">&nbsp;</td>
		</tr>
	</table>
</asp:Content>

