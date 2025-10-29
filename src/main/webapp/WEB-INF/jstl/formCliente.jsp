<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<jsp:useBean id="cliente" class="org.ies63.progI.entities.Cliente" scope="request" />
<jsp:useBean id="clienteDao" class="org.ies63.progI.dao.ClienteImpl" scope="page" />

<!-- Cargar cliente solo si estamos en modo edición -->
<c:if test="${param.operacion == 'editar' && not empty param.id}">
       <c:set var="idCliente" value="${Integer.parseInt(param.id)}" />
       <c:set var="clienteEditar" value="${clienteDao.getById(idCliente)}" />
</c:if>

<h2>
    <c:choose>
        <c:when test="${param.operacion == 'editar'}">Editar Cliente</c:when>
        <c:otherwise>Nuevo Cliente</c:otherwise>
    </c:choose>
</h2>

<form action="seCliente" method="GET">

    <input type="hidden" name="operacion"
           value="${param.operacion == 'editar' ? 'editar' : 'nuevo'}" />

    <input type="hidden" name="txtId"
           value="${not empty clienteEditar.id ? clienteEditar.id : (not empty param.id ? param.id : '-1')}" />

    <label for="txtNombre">Nombre</label>
    <input type="text" name="txtNombre" id="txtNombre"
           placeholder="Nombre"
           value="${not empty clienteEditar.nombre ? clienteEditar.nombre : (not empty cliente.nombre ? cliente.nombre : '')}"
           required />
    <br>

    <label for="txtApellido">Apellido</label>
    <input type="text" name="txtApellido" id="txtApellido"
           placeholder="Apellido"
           value="${not empty clienteEditar.apellido ? clienteEditar.apellido : (not empty cliente.apellido ? cliente.apellido : '')}"
           required />
    <br>

    <label for="txtTelefono">Telefono</label>
    <input type="text" name="txtTelefono" id="txtTelefono"
           placeholder="Telefono"
           value="${not empty clienteEditar.telefono ? clienteEditar.telefono : (not empty cliente.telefono ? cliente.telefono : '')}"
           required />
    <br>

    <input type="submit"
           value="${param.operacion == 'editar' ? 'Actualizar Cliente' : 'Crear Cliente'}" />

</form>

<a href="listadoClientes.jsp">Ver Listado de Clientes</a> |
<a href="index.jsp">Ir a Inicio</a>

<%@ include file="footer.jsp" %>
</body>
</html>