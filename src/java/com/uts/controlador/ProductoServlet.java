/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.uts.controlador;

import com.uts.dao.ProductoDAO;
import com.uts.modelo.producto;
import com.uts.util.InputStreamUtils;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Migue
 */
@MultipartConfig
public class ProductoServlet extends HttpServlet {

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
               // Obtener el archivo de imagen desde la solicitud
            Part filePart = request.getPart("txtImagen");
            InputStream inputStream = filePart.getInputStream();

            // Obtener otros parámetros del formulario
            String idString = request.getParameter("txtId");
            int id = 0;

            if (idString != null && !idString.isEmpty()) {
                id = Integer.parseInt(idString);
            }

            String codigoProducto = request.getParameter("txtCodigoProducto");
            String nombre = request.getParameter("txtNombre");
            String descripcion = request.getParameter("txtDescripcion");

            String precioString = request.getParameter("txtPrecio");
            double precio = 0.0;

            if (precioString != null && !precioString.isEmpty()) {
                precio = Double.parseDouble(precioString);
            }

            String cantidadString = request.getParameter("txtCantidad");
            int cantidad = 0;

            if (cantidadString != null && !cantidadString.isEmpty()) {
                cantidad = Integer.parseInt(cantidadString);
            }

            String estado = request.getParameter("txtEstado");

            // Convertir la imagen a un array de bytes
            byte[] imagenBytes = InputStreamUtils.readAllBytes(inputStream);

            // Crear un objeto producto con los datos obtenidos
            producto p = new producto(id, codigoProducto, nombre, descripcion, precio, cantidad, imagenBytes, estado);

            // Instanciar un objeto ProductoDAO para realizar operaciones en la base de datos
            ProductoDAO productoDAO = new ProductoDAO();

            // Variables para mensajes de respuesta
            String mensaje = "Error";
            int res = 0;

            // Determinar la acción a realizar según el botón presionado en el formulario
            if (request.getParameter("btnGuardar") != null) {
                res = productoDAO.insertarProducto(p);
                if (res != 0) {
                    mensaje = "Registro Agregado";
                }
            } else if (request.getParameter("btnEditar") != null) {
                res = productoDAO.modificarProducto(p);
                if (res != 0) {
                    mensaje = "Registro modificado";
                }
            } else if (request.getParameter("btnEliminar") != null) {
                res = productoDAO.eliminarProducto(p);
                if (res != 0) {
                    mensaje = "Registro eliminado";
                }
            }

            // Establecer mensaje de respuesta
            request.setAttribute("message", mensaje);
            // Redireccionar a la página de administración de productos
            request.getRequestDispatcher("/admin/adminProductos.jsp").forward(request, response);
        } catch (IOException | NumberFormatException | ServletException  e) {
            System.out.println("Error: " + e.getMessage());
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
