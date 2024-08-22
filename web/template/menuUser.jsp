<%-- 
    Document   : menuUser
    Created on : 19/04/2024, 09:12:04 AM
    Author     : ninoj
--%>

<%@page import="com.uts.modelo.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">TechUTS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="../user/indexUser.jsp">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../user/producto.jsp">Productos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../user/contacto.jsp">Contacto</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../user/perfil.jsp">Perfil De Usuario</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../user/carrito.jsp">
                            <img src="${pageContext.servletContext.contextPath}/img/carrito.png" alt="Carrito" width="35px">
                            <i class="bi bi-cart-fill"></i> Carrito
                        </a>
                    </li>
                </ul>
            </div>
            <div class="d-flex flex-column align-items-center">
                <!-- Usuario y botón de cerrar sesión -->
                <form class="d-flex align-items-center">
                    <%-- Obtener el usuario desde la sesión --%>
                    <%
                        usuario usuario = (usuario) session.getAttribute("usuario");
                        if (usuario != null) {
                    %>
                    <div class="text-center">
                        <h2 style="font-size: smaller; margin-right: 10px;">Usuario: <%= usuario.getNombreUsuario() %></h2>
                    </div>
                    <% } %>
                    <a class="btn btn-outline-danger ml-3" href="${pageContext.servletContext.contextPath}/LogoutServlet">Cerrar Sesión</a>
                </form>
            </div>
        </div>
        </nav>

