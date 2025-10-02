<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="header.jsp" %>

<%@ page import="org.ies63.progI.dao.AutoImpl" %>
<%@ page import="org.ies63.progI.entities.Auto" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!-- abro bloque de declaracion java -->
<%!
    AutoImpl dao = new AutoImpl();
    Auto auto = new Auto();
    List<Auto> lista = dao.getAll();
 %>


<h2>Listado de Autos</h2>
<table >
    <thead>
        <tr>
        <th>ID</th>
        <th>Patente</th>
        <th>Color</th>
        <th>Año</th>
        <th>kilometraje</th>
        <th>Marca</th>
        <th>Modelo</th>
        <th>Cliente</th>
        <th>Seguro</th>
        <th>Editar</th>
        <th>Borrar</th>
        </tr>


    </thead>
    <tbody>

    <% for(Auto a : lista) { %>
        <tr>
       <td> <%=a.getIdAuto() %> </td>
        <td><%=a.getPatente() %> </td>
        <td><%=a.getColor() %> </td>
        <td><%=a.getAnio() %> </td>
        <td><%=a.getKilometraje() %> </td>
        <td><%=a.getMarca() %> </td>
        <td><%=a.getModelo() %> </td>
      <td><%=a.getCliente().getNombre()+ " " +  a.getCliente().getApellido() %> </td>
      <td><%=a.getSeguro().getCompañia() %> </td>

        <td><a href="formCliente.jsp?operacion=editar&id=<%=a.getIdAuto() %>">Editar </a></td>
         <td><a href="seCliente?operacion=eliminar&id=<%=a.getIdAuto() %>">Borrar</a></td>
        </tr>
    <% }  %>

    </tbody>
</table>
