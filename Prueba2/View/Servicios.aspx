<%@ Page Title="" Language="C#" MasterPageFile="~/View/Inicio.master" AutoEventWireup="true" CodeFile="~/Controller/Servicios.aspx.cs" Inherits="View_Servicios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style type="text/css">
		.auto-style4 {
			width: 119px;
		}
		.auto-style5 {
			width: 209px;
		}
		.auto-style6 {
			width: 190px;
			text-align: center;
		}
		.auto-style9 {
			width: 222px;
		}
		.auto-style11 {
			width: 372px;
			text-align: center;
		}
		.auto-style12 {
			width: 80%
		}
		.auto-style13 {
			width: 320px;
			text-align: center;
		}
		.auto-style14 {
			width: 203px;
			text-align: center;
		}
		.auto-style15 {
			width: 230px;
		}
	.auto-style16 {
		color: #000000;
	}
		.auto-style20 {
			font-size: x-large;
		}
		.auto-style21 {
			width: 216px;
			text-align: center;
		}
		</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<br />	
	<br />
	<table class="w-100">
		<tr>
			<td>&nbsp;</td>
			<td>
				<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ODS_ServiciosIni">
					<Columns>
						<asp:BoundField DataField="Id_ser" HeaderText="Id_ser" SortExpression="Id_ser" />
						<asp:BoundField DataField="NomServicio" HeaderText="NomServicio" SortExpression="NomServicio" />
						<asp:BoundField DataField="Costo" HeaderText="Costo" SortExpression="Costo" />
						<asp:BoundField DataField="Tiempo" HeaderText="Tiempo" SortExpression="Tiempo" />
						<asp:BoundField DataField="Foto" HeaderText="Foto" SortExpression="Foto" />
						<asp:BoundField DataField="Descripcion" HeaderText="Descripcion" SortExpression="Descripcion" />
					</Columns>
				</asp:GridView>
				<asp:ObjectDataSource ID="ODS_ServiciosIni" runat="server" SelectMethod="obtenerServicio" TypeName="DaoServicios"></asp:ObjectDataSource>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<br />
	<br />
	<br />
</asp:Content>

