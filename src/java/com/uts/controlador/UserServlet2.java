/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.uts.controlador;

import com.uts.dao.UsuarioDAO;
import com.uts.modelo.usuario;
import com.uts.util.InputStreamUtils;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author yisus
 */
@MultipartConfig
public class UserServlet2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                Part filePart = request.getPart("txtImagen");
            InputStream inputStream = filePart != null ? filePart.getInputStream() : null;
            int id = 0;
            String idString = request.getParameter("txtId");
            if (idString != null && !idString.isEmpty()) {
                id = Integer.parseInt(idString);
            }
            String nombres = request.getParameter("txtNombres");
            String apellidos = request.getParameter("txtApellidos");
            long telefono = 0;
            String telefonoString = request.getParameter("txtTelefono");
            if (telefonoString != null && !telefonoString.isEmpty()) {
                telefono = Long.parseLong(telefonoString);
            }
            String correo = request.getParameter("txtCorreo");
            String tipoDocumento = request.getParameter("txtTipoDocumento");
            long documento = 0;
            String documentoString = request.getParameter("txtDocumento");
            if (documentoString != null && !documentoString.isEmpty()) {
                documento = Long.parseLong(documentoString);
            }
            String nombreUsuario = request.getParameter("txtNombreUsuario");
            String contrasena = request.getParameter("txtContrasena");
            String mensaje = "Error";
            int res;

            byte[] imagenBytes = null;
            if (inputStream != null) {
                imagenBytes = InputStreamUtils.readAllBytes(inputStream);
            } else {
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                usuario usuarioActual = usuarioDAO.obtenerUsuarioPorId(id);
                if (usuarioActual != null) {
                    imagenBytes = usuarioActual.getImagen();
                }
            }

            usuario u = new usuario(id, nombres, apellidos, telefono, correo, tipoDocumento, documento, nombreUsuario, imagenBytes, contrasena);
            UsuarioDAO usuarioDAO = new UsuarioDAO();

            if (request.getParameter("btnGuardar") != null) {
                res = usuarioDAO.insertarUsuario(u);
                if (res != 0) {
                    mensaje = "Registro Agregado";
                }
            } else if (request.getParameter("btnEditar") != null) {
                res = usuarioDAO.modificarUsuario(u);
                if (res != 0) {
                    mensaje = "Registro modificado";

                    // Actualizar la sesión con los nuevos datos del usuario
                    usuario usuarioActualizado = usuarioDAO.obtenerUsuarioPorId(id);
                    if (usuarioActualizado != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("usuario", usuarioActualizado);
                    }
                }
            } else if (request.getParameter("btnEliminar") != null) {
                res = usuarioDAO.eliminarUsuario(u);
                if (res != 0) {
                    mensaje = "Registro eliminado";

                    // Eliminar el usuario de la sesión si se elimina de la base de datos
                    HttpSession session = request.getSession();
                    session.removeAttribute("usuario");
                }
            }

            request.setAttribute("message", mensaje);
            request.getRequestDispatcher("/user/perfil.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error " + e.getLocalizedMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
