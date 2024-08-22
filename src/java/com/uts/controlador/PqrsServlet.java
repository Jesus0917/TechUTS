/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.uts.controlador;

import com.uts.dao.PqrsDAO;
import com.uts.modelo.pqrs;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ninoj
 */
public class PqrsServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String idString = request.getParameter("txtId");
            int id = 0; // Valor predeterminado en caso de que no se pueda convertir

            if (idString != null && !idString.isEmpty()) {
                id = Integer.parseInt(idString);
            } else {
                // Manejar el caso en el que el ID esté vacío
                // Puedes imprimir un mensaje de error o realizar alguna otra acción aquí
            }

            String descripcion = request.getParameter("txtDescripcion");

            String mensaje = "Error";
            int res;
            
            pqrs p = new pqrs(id, descripcion);
            PqrsDAO pqrsDAO = new PqrsDAO();
            
            if(request.getParameter("btnGuardar") != null){
                res = pqrsDAO.insertarPQRS(p);
                if(res != 0){
                    mensaje = "PQRS agregada correctamente";
                }
            }
            
            request.setAttribute("message", mensaje);
            request.getRequestDispatcher("/user/contacto.jsp").forward(request, response);
            } catch (Exception e){
                System.out.println("Error "+e.getLocalizedMessage());
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
