<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">

<%@ include file="header.jsp" %>

<main class="container mt-4">
    <!-- Mensajes de estado simplificados -->
    <c:if test="${not empty mensajeExito}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${mensajeExito}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty mensajeError}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${mensajeError}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Encabezado principal -->
    <div class="text-center mb-4">
        <h2 class="mb-3">
            <c:choose>
                <c:when test="${rolUsuario == 'ADMIN'}">Panel de Administración</c:when>
                <c:when test="${rolUsuario == 'USER'}">Área Personal</c:when>
                <c:otherwise>Bienvenido al Sistema</c:otherwise>
            </c:choose>
        </h2>

        <c:if test="${not empty usuario}">
            <p class="text-muted">
                Conectado como: <strong>${correoUsuario}</strong>
                <span class="badge ms-2 ${rolUsuario == 'ADMIN' ? 'bg-danger' : rolUsuario == 'USER' ? 'bg-primary' : 'bg-secondary'}">
                    ${rolUsuario}
                </span>
            </p>
        </c:if>
    </div>

    <!-- Contenido según rol -->
    <c:choose>
        <c:when test="${rolUsuario == 'ADMIN'}">
            <!-- Panel Admin -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Gestión de Clientes</h5>
                            <p class="card-text">Administra los clientes del sistema</p>
                            <div class="d-grid gap-2">
                                <a href="listadoClientes.jsp" class="btn btn-primary">Ver Clientes</a>
                                <a href="formCliente.jsp" class="btn btn-outline-primary">Nuevo Cliente</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Gestión de Autos</h5>
                            <p class="card-text">Administra el inventario de autos</p>
                            <div class="d-grid gap-2">
                                <a href="listadoAutos.jsp" class="btn btn-primary">Ver Autos</a>
                                <a href="formAuto.jsp" class="btn btn-outline-primary">Nuevo Auto</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>

        <c:when test="${rolUsuario == 'USER'}">
            <!-- Panel Usuario -->
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Bienvenido a tu Área Personal</h5>
                            <p class="card-text">Gestiona tu perfil y datos personales</p>
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <a href="miPerfil.jsp" class="btn btn-primary">Mi Perfil</a>
                                <a href="misDatos.jsp" class="btn btn-outline-primary">Mis Datos</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Panel Invitado -->
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Acceso al Sistema</h5>
                            <p class="card-text">Inicia sesión o regístrate para continuar</p>
                            <div class="d-grid gap-2">
                                <a href="frmIniciarSesion.jsp" class="btn btn-primary">Iniciar Sesión</a>
                                <a href="registro.jsp" class="btn btn-outline-primary">Registrarse</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Enlaces de navegación rápida (solo para desarrollo/depuración) -->
    <c:if test="${rolUsuario == 'ADMIN' || empty usuario}">
        <div class="mt-5 pt-3 border-top">
            <div class="text-center">
                <small class="text-muted">Enlaces rápidos:</small>
                <div class="mt-2">
                    <a href="hello" class="btn btn-sm btn-outline-secondary me-1">HelloServlet</a>
                    <c:if test="${rolUsuario == 'ADMIN' || empty usuario}">
                        <a href="formAuto.jsp" class="btn btn-sm btn-outline-secondary me-1">Nuevo Auto</a>
                        <a href="formCliente.jsp" class="btn btn-sm btn-outline-secondary me-1">Nuevo Cliente</a>
                        <a href="listadoClientes.jsp" class="btn btn-sm btn-outline-secondary me-1">Clientes</a>
                        <a href="listadoAutos.jsp" class="btn btn-sm btn-outline-secondary me-1">Autos</a>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>
</main>

<%@ include file="footer.jsp" %>