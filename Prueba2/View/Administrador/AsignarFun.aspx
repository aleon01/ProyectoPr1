<%@ Page Title="" Language="C#" MasterPageFile="~/View/Administrador/Administrador.master" AutoEventWireup="true" CodeFile="~/Controller/Administrador/AsignarFun.aspx.cs" Inherits="View_Administrador_AsignarFun" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<table class="w-100">
		<tr>
			<td>&nbsp;</td>
			<td>
				<table class="w-100">
					<tr>
						<td class="text-center"><strong>Servicio:<br />
							</strong>
							<asp:DropDownList ID="DropDownList1" runat="server" class="form-control">
							</asp:DropDownList>
						</td>
						<td class="text-center">&nbsp;</td>
					</tr>
					<tr>
						<td><strong>Empleado:<br />
							</strong>
							<asp:DropDownList ID="DropDownList2" runat="server" class="form-control">
							</asp:DropDownList>
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</asp:Content>

