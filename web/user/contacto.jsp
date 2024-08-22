<%-- 
    Document   : conatcto
    Created on : 25/04/2024, 09:15:24 PM
    Author     : ninoj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Contactanos:.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa; /* Color de fondo */
                color: #000; /* Color de texto principal */
            }

            header {
                background-color: #ffffff; /* Color de fondo del encabezado */
                border-bottom: 1px solid #dee2e6; /* Borde inferior del encabezado */
            }

            .navbar-brand {
                font-size: 1.5rem; /* Tamaño de fuente del logo */
                color: #000; /* Color del texto del logo */
            }

            .navbar-toggler-icon {
                background-color: #007bff; /* Color del ícono del botón de navegación en modo cerrado */
            }

            .navbar-nav .nav-link {
                color: #000 !important; /* Color del texto del enlace en la barra de navegación */
            }

            main {
                padding: 20px; /* Espaciado interno del contenido principal */
            }

            #pqrs-form {
                max-width: 600px; /* Ancho máximo del formulario */
                margin: auto; /* Centrar el formulario en la pantalla */
            }

            #pqrs-message {
                height: 150px; /* Altura del área de texto del mensaje */
            }

            footer {
                background-color: #343a40; /* Color de fondo del pie de página */
                color: #fff; /* Color de texto del pie de página */
                padding: 20px 0; /* Espaciado interno del pie de página */
                border-top: 1px solid #dee2e6; /* Borde superior del pie de página */
            }
        </style>
    </head>
    <body>
        <%@include file="../template/menuUser.jsp" %>
        <main class="mt-5">
            <h1 class="text-center my-5">Página de Contacto</h1>
            <!-- Formulario de PQRS -->
            <section id="pqrs-form" class="my-5">
                <h2 class="text-center mb-4">Formulario de PQRS</h2>
                <form action="${pageContext.servletContext.contextPath}/PqrsServlet" method="POST" role="form">
                    <!-- Campos para preguntas, quejas, reclamos, sugerencias, etc. -->
                    <div class="mb-3">
                        <label for="pqrs-message" class="form-label">Mensaje:</label>
                        <textarea id="txtDescripcion" name="txtDescripcion" class="form-control" required></textarea>
                    </div>
                    <div class="text-center">
                        <button type="submit" name="btnGuardar" class="btn btn-primary">Mandar PQRS</button>
                    </div>
                </form>
            </section>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%
            if(request.getAttribute("message")!= null){   
        %>
        <script>alert(<%= request.getAttribute("message") %>') </script>
        <%
         }
        %>
    </body>
</html>
