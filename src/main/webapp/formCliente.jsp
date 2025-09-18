<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %> .
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<body>
<h2>Formulario de Cliente</h2>

<form action="seCliente" method="GET">

<input type="hidden" name="txtId" id="txtId" value="-1" />
<input type="hidden" name="operacion" id="operacion" value="nuevo" />

<label for="txtNombre">Nombre</label>
<input type="text" name="txtNombre" id="txtNombre" placeholder="Nombre" required />
<br>
<label for="txtApellido">Apellido</label>
<input type="text" name="txtApellido" id="txtApellido" placeholder="Apellido" required />
<br>
<label for="txttelefono">Telefono</label>
<input type="text" name="txtTelefono" id="txtTelefono"  placeholder="Telefono" required />
<br>
<input type="submit" value="Enviar" />

</form>



        <a href="index.jsp"> Ir a Inicio </a>

</body>

</html>
