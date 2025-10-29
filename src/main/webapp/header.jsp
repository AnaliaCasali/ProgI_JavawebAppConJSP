<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proyecto Web JSP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <!-- Configurar variables para uso en JSTL -->
    <c:set var="usuario" value="${sessionScope.usuario}" />
    <c:set var="correoUsuario" value="${not empty usuario ? usuario.correo : ''}" />
    <c:set var="rolUsuario" value="${not empty usuario ? usuario.rol : 'INVITADO'}" />

    <header>
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">
                    <c:choose>
                        <c:when test="${rolUsuario == 'ADMIN'}">
                            🛠️ Panel Admin
                        </c:when>
                        <c:when test="${rolUsuario == 'USER'}">
                            👤 Mi Cuenta
                        </c:when>
                        <c:otherwise>
                            🌐 Proyecto Web
                        </c:otherwise>
                    </c:choose>
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarMain" aria-controls="navbarMain"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarMain">
                    <!-- Menú de navegación según rol -->
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">🏠 Inicio</a>
                        </li>

                        <c:choose>
                            <c:when test="${rolUsuario == 'ADMIN'}">
                                <!-- Menú para ADMIN -->
                                <li class="nav-item">
                                    <a class="nav-link" href="listadoCLientes.jsp">👥 Clientes</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="listadoAutos.jsp">📊 Autos</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="">⚙️ Configuración</a>
                                </li>
                            </c:when>

                            <c:when test="${rolUsuario == 'USER'}">
                                <!-- Menú para USER -->
                                <li class="nav-item">
                                    <a class="nav-link" href="miPerfil.jsp">👤 Mi Perfil</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="misDatos.jsp">📁 Mis Datos</a>
                                </li>
                            </c:when>

                            <c:otherwise>
                                <!-- Menú para INVITADO -->
                                <li class="nav-item">
                                    <a class="nav-link" href="acercaDe.jsp">ℹ️ Acerca de</a>
                                </li>
                            </c:otherwise>
                        </c:choose>

                    </ul>

                    <!-- Área de usuario/login -->
                    <div class="d-flex align-items-center gap-3">
                        <c:choose>
                            <c:when test="${empty usuario}">
                                <!-- Usuario NO logueado -->
                                <a href="registro.jsp" class="btn btn-outline-primary">📝 Registrarse</a>
                                <a href="frmIniciarSesion.jsp" class="btn btn-outline-success">🔐 Iniciar Sesión</a>
                            </c:when>

                            <c:otherwise>
                                <!-- Usuario logueado -->
                                <div class="d-flex align-items-center gap-2">
                                    <c:choose>
                                        <c:when test="${rolUsuario == 'ADMIN'}">
                                            <span class="badge bg-danger">ADMIN</span>
                                        </c:when>
                                        <c:when test="${rolUsuario == 'USER'}">
                                            <span class="badge bg-primary">USER</span>
                                        </c:when>
                                    </c:choose>

                                    <span class="navbar-text text-dark fw-bold">${correoUsuario}</span>
                                </div>

                                <div class="btn-group">
                                    <a href="seSesiones?cerrarSesion=true" class="btn btn-outline-danger">🚪 Cerrar Sesión</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

