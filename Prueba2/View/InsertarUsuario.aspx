<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/Controller/InsertarUsuario.aspx.cs" Inherits="View_InsertarUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Crear cuenta</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style4 {
            margin-left: 13px;
        }
        .auto-style5 {
            width: 300px;
        }
        .auto-style14 {
            width: 250px;
        }
        .auto-style18 {
            width: 302px;
            height: 22px;
        }
        .auto-style19 {
            height: 22px;
            width: 250px;
        }
        .auto-style20 {
            height: 22px;
        }
        .auto-style21 {
            height: 23px;
        }
        .auto-style23 {
            width: 302px;
            height: 23px;
        }
        .auto-style24 {
            height: 23px;
            width: 250px;
        }
        .auto-style27 {
            width: 300px;
            height: 26px;
        }
        .auto-style28 {
            width: 250px;
            height: 26px;
        }
        .auto-style29 {
            height: 26px;
        }
        .auto-style30 {
            width: 302px;
        }
        .auto-style32 {
            width: 302px;
            height: 26px;
        }
        .auto-style33 {
            width: 302px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2" colspan="5">
                        <h1>Crear cuenta</h1>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <p class="auto-style2">
                            <strong>
                        <asp:Label ID="Label1" runat="server" Text="Nombre"></asp:Label>
                            </strong>
                        </p>
                    </td>
                    <td class="auto-style30">
                        <asp:TextBox ID="TB_Nombre" runat="server" CssClass="auto-style4" Width="250px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFV_Nombre" runat="server" ControlToValidate="TB_Nombre" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                    <td class="auto-style14">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <p class="auto-style2">
                            <strong>
                        <asp:Label ID="Label2" runat="server" Text="Apellido"></asp:Label>
                            </strong>
                        </p>
                    </td>
                    <td class="auto-style33">
                        <asp:TextBox ID="TB_Apellido" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFV_Apellido" runat="server" ControlToValidate="TB_Apellido" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                    <td class="auto-style14">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <p class="auto-style2">
                            <strong>
                        <asp:Label ID="Label3" runat="server" Text="Tipo de identificación"></asp:Label>
                            </strong>
                        </p>
                    </td>
                    <td class="auto-style30">
                        <asp:DropDownList ID="DDL_TipoIdentificacion" runat="server" CssClass="auto-style4" Width="250px">
                            <asp:ListItem Value="0">Seleccione</asp:ListItem>
                            <asp:ListItem Value="1">Cédula de ciudadanía</asp:ListItem>
                            <asp:ListItem Value="2">Cédula de extranjería</asp:ListItem>
                            <asp:ListItem Value="3">Tarjeta de identificación</asp:ListItem>
                            <asp:ListItem Value="4">Pasaporte</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RangeValidator ID="RV_TipoIdentificacion" runat="server" ControlToValidate="DDL_TipoIdentificacion" ErrorMessage="Por favor, seleccione uno" MaximumValue="4" MinimumValue="1" ForeColor="Red" Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                    </td>
                    <td class="auto-style14">
                        <asp:TextBox ID="TB_NumeroIdenti" runat="server" CssClass="auto-style4" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFV_NumeroIdenti" runat="server" ControlToValidate="TB_NumeroIdenti" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <p class="auto-style2">
                            <strong>
                        <asp:Label ID="Label5" runat="server" Text="Correo electrónico"></asp:Label>
                            </strong>
                        </p>
                    </td>
                    <td class="auto-style30">
                        <asp:TextBox ID="TB_CorreoElectronico" runat="server" CssClass="auto-style4" Width="250px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFV_CorreoElectronico" runat="server" ControlToValidate="TB_CorreoElectronico" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                    <td class="auto-style14">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style27">
                        <p class="auto-style2">
                            <strong>
                        <asp:Label ID="Label6" runat="server" Text="Usuario"></asp:Label>
                            </strong>
                        </p>
                    </td>
                    <td class="auto-style32">
                        <asp:TextBox ID="TB_UserName" runat="server" CssClass="auto-style4" Width="250px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFV_Usuario" runat="server" ControlToValidate="TB_UserName" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                    <td class="auto-style28"></td>
                    <td class="auto-style29"></td>
                    <td class="auto-style29"></td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <p class="auto-style2">
                            <strong>
                        <asp:Label ID="Label7" runat="server" Text="Contraseña"></asp:Label>
                            </strong>
                        </p>
                    </td>
                    <td class="auto-style18">
                        <asp:TextBox ID="TB_Contraseña" runat="server" CssClass="auto-style4" Width="250px" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFV_Contraseña" runat="server" ControlToValidate="TB_Contraseña" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                    <td class="auto-style19"></td>
                    <td class="auto-style20"></td>
                    <td class="auto-style20"></td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <p class="auto-style2">
                            <strong>
                        <asp:Label ID="Label8" runat="server" Text="Confirmar contraseña"></asp:Label>
                            </strong>
                        </p>
                    </td>
                    <td class="auto-style23">
                        <asp:TextBox ID="TB_ConfirmarContraseña" runat="server" CssClass="auto-style4" Width="250px" TextMode="Password"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TB_Contraseña" ControlToValidate="TB_ConfirmarContraseña" ErrorMessage="No es la misma" ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
                    </td>
                    <td class="auto-style24"></td>
                    <td class="auto-style21"></td>
                    <td class="auto-style21"></td>
                </tr>
                <tr>
                    <td class="auto-style21" colspan="5"></td>
                </tr>
                <tr>
                    <td class="auto-style2" colspan="2">
                        <asp:Button ID="B_Atras" runat="server" Text="Atras" />
                    </td>
                    <td class="auto-style2" colspan="3">
                        <asp:Button ID="B_Registrar" runat="server" Text="Confirmar" OnClick="B_Registrar_Click" />
                    </td>
                </tr>
            </table>
            
        </div>
    </form>
</body>
</html>

