<%@ Page Title="" Language="C#" MasterPageFile="~/menu.Master" AutoEventWireup="true" CodeBehind="Tecnicos.aspx.cs" Inherits="Examen2.tipo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container text-center">
        <h1> Tecnicos <h1>
    <div>
            <div>
    <br />
    <br />
    <asp:GridView runat="server" ID="datagrid" PageSize="10" HorizontalAlign="Center"
        CssClass="mydatagrid" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header"
        RowStyle-CssClass="rows" AllowPaging="True" />

    <br />
    <br />
    <br />

</div>
            </div>
        <div class="container text-center">
    Tecnicos: <asp:TextBox ID="Tecnicos" class="form-control" runat="server"></asp:TextBox>
   
 </div>
    Nombre: <asp:TextBox ID="Nombre" class="form-control" runat="server"></asp:TextBox>
    Especialidad: <asp:TextBox ID="Especialidad" class="form-control" runat="server"></asp:TextBox>
</div>
<div class="container text-center">
    <asp:Button ID="Button1" class="btn btn-outline-primary" runat="server" Text="Agregar"  />
    <asp:Button ID="Button2" class="btn btn-outline-secondary" runat="server" Text="Borrar" />
    <asp:Button ID="Bconsulta" runat="server" class="btn btn-outline-danger" Text="Consultarconfiltro"/>
    <asp:Button ID="Button3" class="btn btn-outline-secondary" runat="server" Text="Modificar" />

</div>
</asp:Content>
