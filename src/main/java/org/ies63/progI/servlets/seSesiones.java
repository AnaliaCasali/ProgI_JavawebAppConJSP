package org.ies63.progI.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.ies63.progI.dao.UsuarioImpl;
import org.ies63.progI.entities.Usuario;
import org.ies63.progI.util.PasswordUtil;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class seSesiones extends HttpServlet {
  private static final long serialVersionUID = 1L;

  private UsuarioImpl usuarioDAO = new UsuarioImpl();
  private static Map<String, Usuario> usuariosActivos = new ConcurrentHashMap<>();

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    String cerrarSesionParam = request.getParameter("cerrarSesion");

    if ("true".equals(cerrarSesionParam)) {
      cerrarSesion(request, response);
    } else {
      response.sendRedirect("index.jsp");
    }
  }

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    iniciarSesion(request, response);
  }

  private void cerrarSesion(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    if (session != null) {
      Usuario usuario = (Usuario) session.getAttribute("usuario");
      if (usuario != null) {
        usuariosActivos.remove(usuario.getCorreo());
      }
      session.invalidate();
    }

    request.setAttribute("mensajeExito", "Se ha cerrado la sesión correctamente");
    redirigirA("frmIniciarSesion.jsp", request, response);
  }

  private void iniciarSesion(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    // obtengo los parametros de la peticion
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

    // llamo a dos funciones: validar credenciales y redirigir A
    String destino = validarCredenciales(correo, clave, request);
    redirigirA(destino, request, response);
  }

  private String validarCredenciales(String correo, String clave, HttpServletRequest request) {
    if (correo == null || clave == null || correo.trim().isEmpty() || clave.trim().isEmpty()) {
      request.setAttribute("mensajeError", "Correo y contraseña son obligatorios");
      return "frmIniciarSesion.jsp";
    }

    correo = correo.trim();

    if (usuariosActivos.containsKey(correo)) {
      request.setAttribute("mensajeError",
          "No puedes iniciar sesión en dos equipos al mismo tiempo");
      return "frmIniciarSesion.jsp";
    }

    Usuario usuario = usuarioDAO.getById(correo);

    if (usuario == null) {
      request.setAttribute("mensajeError", "Credenciales no válidas");
      return "frmIniciarSesion.jsp";
    }

    // Verificar contraseña con BCrypt - con manejo de errores
    try {
      if (!PasswordUtil.verifyPassword(clave, usuario.getClave())) {
        request.setAttribute("mensajeError", "Credenciales no válidas");
        return "frmIniciarSesion.jsp";
      }
    } catch (Exception e) {
      System.err.println("Error verificando contraseña: " + e.getMessage());
      request.setAttribute("mensajeError", "Error en el sistema de autenticación");
      return "frmIniciarSesion.jsp";
    }

    usuariosActivos.put(correo, usuario);
    HttpSession sesion = request.getSession();
    sesion.setAttribute("usuario", usuario);

    request.setAttribute("mensajeExito", "Sesión iniciada correctamente");
    return "index.jsp";
  }

  private void redirigirA(String destino, HttpServletRequest request,
                          HttpServletResponse response)
      throws ServletException, IOException {

    RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
    dispatcher.forward(request, response);
  }
}