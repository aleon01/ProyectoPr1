<%@ Page Title="" Language="C#" MasterPageFile="~/View/Administrador/Administrador.master" AutoEventWireup="true" CodeFile="~/Controller/Administrador/MosServicios.aspx.cs" Inherits="View_Administrador_MosServicios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
	<style type="text/css">
		.auto-style17 {
			margin-left: 188px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<table class="w-100">
		<tr>
			<td>&nbsp;</td>
			<td>
				<div class="text-center">
				<asp:GridView ID="GV_MServicios" runat="server" AutoGenerateColumns="False" DataKeyNames="id_ser" DataSourceID="ODS_MosServicio" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" CssClass="auto-style17" GridLines="Horizontal" OnRowUpdating="GV_MServicios_RowUpdating">
					<Columns>
						<asp:BoundField DataField="NomServicio" HeaderText="NomServicio" SortExpression="NomServicio" />
						<asp:BoundField DataField="Costo" HeaderText="Costo" SortExpression="Costo" />
						<asp:BoundField DataField="Tiempo" HeaderText="Tiempo" SortExpression="Tiempo" />
						<asp:TemplateField HeaderText="Foto">
							<EditItemTemplate>
								<asp:FileUpload ID="FU_EdiFServ" runat="server" />
								<asp:Image ID="EditImgSer" runat="server" />
							</EditItemTemplate>
							<ItemTemplate>
								<asp:Image ID="Img_Servicio" runat="server" ImageUrl='<%# Eval("Foto") %>' style="width: 180px" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="Descripcion" HeaderText="Descripcion" SortExpression="Descripcion" />
						<asp:CommandField ShowEditButton="True" />
						<asp:CommandField ShowDeleteButton="True" />
					</Columns>
					<FooterStyle BackColor="White" ForeColor="#333333" />
					<HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
					<PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
					<RowStyle BackColor="White" ForeColor="#333333" />
					<SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
					<SortedAscendingCellStyle BackColor="#F7F7F7" />
					<SortedAscendingHeaderStyle BackColor="#487575" />
					<SortedDescendingCellStyle BackColor="#E5E5E5" />
					<SortedDescendingHeaderStyle BackColor="#275353" />
				</asp:GridView>
				</div>
				<asp:ObjectDataSource ID="ODS_MosServicio" runat="server" DeleteMethod="eliminarServicio" SelectMethod="obtenerServicio" TypeName="DaoServicios" UpdateMethod="actualizarServicio">
					<DeleteParameters>
						<asp:Parameter Name="id_ser" Type="Int32" />
					</DeleteParameters>
					<UpdateParameters>
						<asp:Parameter Name="NomServicio" Type="String" />
						<asp:Parameter Name="Costo" Type="Int32" />
						<asp:Parameter Name="Tiempo" Type="String" />
						<asp:Parameter Name="Foto" Type="String" />
						<asp:Parameter Name="Descripcion" Type="String" />
						<asp:Parameter Name="Id_ser" Type="Int32" />
					</UpdateParameters>
				</asp:ObjectDataSource>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</asp:Content>

