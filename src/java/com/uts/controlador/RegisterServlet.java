package com.uts.controlador;

import com.uts.modelo.usuario;
import com.uts.dao.UsuarioDAO;
import com.uts.util.InputStreamUtils;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author ninoj
 */
public class RegisterServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Obtener el archivo de imagen desde la solicitud
            Part filePart = request.getPart("txtImagen");
            InputStream inputStream = filePart.getInputStream();
            String idParameter = request.getParameter("txtId");
            int id = 0; // Valor por defecto o manejo de error
            if (idParameter != null && !idParameter.isEmpty()) {
                try {
                    id = Integer.parseInt(idParameter);
                } catch (NumberFormatException e) {
                    // Manejar la excepción según sea necesario
                }
            }
            String nombres = request.getParameter("txtNombres");
            String apellidos = request.getParameter("txtApellidos");
            long telefono = Long.parseLong(request.getParameter("txtTelefono"));
            String correo = request.getParameter("txtCorreo");
            String tipoDocumento = request.getParameter("txtTipoDocumento");
            long documento = Long.parseLong(request.getParameter("txtDocumento"));
            String nombreUsuario = request.getParameter("txtNombreUsuario");
            String contrasena = request.getParameter("txtContrasena");
            // Convertir la imagen a un array de bytes
            byte[] imagenBytes = InputStreamUtils.readAllBytes(inputStream);
            String mensaje = "Error";

            // Crear un objeto usuario con los datos recibidos
            usuario u = new usuario(id, nombres, apellidos, telefono, correo, tipoDocumento, documento, nombreUsuario, imagenBytes, contrasena);

            // Verificar si el correo ya está registrado
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            boolean correoRegistrado = usuarioDAO.existeCorreo(correo);

            if (correoRegistrado) {
                mensaje = "El correo electrónico ya está registrado. Por favor, utilice otro correo.";
            } else {
                // Si el correo no está registrado, proceder con la inserción del nuevo usuario
                int res = usuarioDAO.insertarUsuario(u);

                if (res != 0) {
                    mensaje = "Registro Agregado";
                }
            }

            request.setAttribute("message", mensaje);
            request.getRequestDispatcher("/user/loginUser.jsp").forward(request, response);
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
