package org.ies63.progI.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.ies63.progI.dao.ClienteImpl;
import org.ies63.progI.entities.Cliente;

import java.io.IOException;
import java.util.Date;

public class seCliente extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    String operacion="nuevo";
    String nombre="";
    String apellido="";
    String telefono="";
    int id=-1;

    nombre=req.getParameter("txtNombre");
    apellido=req.getParameter("txtApellido");
    telefono=req.getParameter("txtTelefono");
    operacion=req.getParameter("operacion");
    id= Integer.parseInt(req.getParameter("txtId"));


    // para guardar el cliente
    Cliente clienteNuevo= new Cliente(id,nombre,apellido,telefono);
    ClienteImpl clienteDAO= new ClienteImpl();
    clienteDAO.insert(clienteNuevo);

    RequestDispatcher rd = req.getRequestDispatcher("/index.jsp");
    rd.forward(req, res);
  }

}
