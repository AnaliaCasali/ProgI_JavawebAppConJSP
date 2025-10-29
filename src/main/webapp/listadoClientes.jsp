<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="header.jsp" %>

<%@ page import="org.ies63.progI.dao.ClienteImpl" %>
<%@ page import="org.ies63.progI.entities.Cliente" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!-- Validación de sesión -->
<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="frmIniciarSesion.jsp?mensaje=Debes iniciar sesión para acceder a esta página"/>
</c:if>

<!-- Configuración de variables -->
<c:set var="usuario" value="${sessionScope.usuario}" />
<c:set var="rolUsuario" value="${not empty usuario ? usuario.rol : 'INVITADO'}" />

<!-- Solo ADMIN puede acceder -->
<c:if test="${rolUsuario != 'ADMIN'}">
    <div class="container mt-4">
        <div class="alert alert-danger text-center">
            <h4>❌ Acceso Denegado</h4>
            <p>No tienes permisos para acceder a esta página.</p>
            <a href="index.jsp" class="btn btn-primary">Volver al Inicio</a>
        </div>
    </div>
    <%@ include file="footer.jsp" %>

</c:if>

<%!
    ClienteImpl clienteDao = new ClienteImpl();
    Cliente cliente = new Cliente();
    List<Cliente> listaClientes = clienteDao.getAll();
 %>


<h2>Listado de Clientes</h2>
<table >
    <thead>
        <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Telefono</th>
        <th>Editar</th>
        <th>Borrar</th>
        </tr>
    </thead>
    <tbody>

    <% for(Cliente c : listaClientes) { %>
        <tr>
       <td> <%=c.getId() %> </td>
        <td><%=c.getNombre() %> </td>
        <td><%=c.getApellido() %> </td>
        <td><%=c.getTelefono() %> </td>
        <td><a href="formCliente.jsp?operacion=editar&id=<%=c.getId() %>">Editar </a></td>
         <td><a href="seCliente?operacion=eliminar&id=<%=c.getId() %>">Borrar</a></td>
        </tr>
    <% }  %>

    </tbody>
</table>
