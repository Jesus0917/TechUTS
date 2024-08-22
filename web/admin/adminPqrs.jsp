<%-- 
    Document   : adminPqrs
    Created on : 26/04/2024, 12:32:55 PM
    Author     : ninoj
--%>

<%@page import="com.uts.modelo.admin"%>
<%@page import="com.uts.dao.PqrsDAO"%>
<%@page import="com.uts.modelo.pqrs"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<%
    // Verificar si el usuario está autenticado antes de mostrar los productos
    admin admin = (admin)session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:PQRS:.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    </head>
    <body>
        <%!
            PqrsDAO pqrsDAO = new PqrsDAO();
        %>
        <div class="container">
            <%@include file="../template/menuAdmin.jsp" %>
            <hr>
            <div class="row">
                <div class="col-8"><h1>Visualizar PQRS</h1></div>
                <div class="col-4 align-self-center">
                </div>
            </div>
            <hr>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <th>Id</th>
                        <th>Descripcion</th>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<pqrs> ListaPqrs = pqrsDAO.mostrarPQRS();
                            for (pqrs elem : ListaPqrs) {
                        %>
                        <tr>
                            <td class="id"><%= elem.getId() %></td>
                            <td class="descripcion"><%=elem.getDescripcion()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        
    </body>
</html>
