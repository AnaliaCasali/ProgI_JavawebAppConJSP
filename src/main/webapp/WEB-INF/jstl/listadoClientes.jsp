<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="header.jsp" %>

<jsp:useBean id="clienteDao" class="org.ies63.progI.dao.ClienteImpl" scope="page" />
<c:set var="listaClientes" value="${clienteDao.getAll()}" />

<h2>Listado de Clientes</h2>

<c:if test="${not empty listaClientes}">
    <table border="1" cellpadding="8" cellspacing="0" style="border-collapse: collapse; width: 100%;">
        <thead style="background-color: #f8f9fa;">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Teléfono</th>
                <th>Editar</th>
                <th>Borrar</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${listaClientes}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.nombre}</td>
                    <td>${c.apellido}</td>
                    <td>${c.telefono}</td>
                    <td>
                        <a href="formCliente.jsp?operacion=editar&id=${c.id}">Editar Cliente</a>

                    </td>
                    <td>
                        <a href="formCliente.jsp?operacion=eliminar&id=${c.id}"
                           onclick="return confirm('¿Está seguro?')">Borrar</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <p>Total de clientes: ${listaClientes.size()}</p>
</c:if>

<c:if test="${empty listaClientes}">
    <p>No hay clientes registrados.</p>
</c:if>

<a href="nuevoCliente.jsp">Agregar Nuevo Cliente</a>