<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Inicio</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>

<body>
	<%@include file="header.jsp" %>
	<section>
	<h2>Formulario de Ingreso:</h2>

	<%
	
	if(session.getAttribute("usuario")!=null){
		response.sendRedirect("Bienvenida.jsp");
	}
	
	String mensaje = (String) request.getAttribute("mensaje");
	if (mensaje != null) {
	%>
	<div>
		<h1 style="color: red;"><%=mensaje%></h1>
	</div>

	<%
	}
	%>
	<div>
		<form action="seSesiones" method="post">
			<div>
				<input type="email" name="correo" placeholder="usuario@dominio.ext"
					required="true" />
			</div>
			<div>
				<input type="password" name="clave" placeholder="1234"
					required="true" />
			</div>

			<div>
				<button type="reset" class="reset">Limpiar</button>
				<button type="submit" class="submit">Enviar</button>
			</div>
		</form>
	</div>
	</section>


	<div>
		<footer>
		<p></p>
		</footer>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</html>