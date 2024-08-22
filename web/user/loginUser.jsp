<%-- 
    Document   : index
    Created on : 19-nov-2023, 10:02:12
    Author     : ninoj
--%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>.:Inicio de sesion:.</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa; /* Color de fondo */
        }

        header {
            border-bottom: 1px solid #dee2e6; /* Borde inferior del encabezado */
        }

        .navbar-brand {
            font-size: 1.5rem; /* Tamaño de fuente del logo */
        }

        #login-section {
            background-color: #ffffff; /* Color de fondo del formulario */
            border-radius: 10px; /* Bordes redondeados */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Sombra suave */
            padding: 20px;
            max-width: 400px; /* Ancho máximo del formulario */
            margin: auto; /* Centrar en la pantalla */
        }

        #login-section h2 {
            color: black; /* Color del encabezado */
        }

        #no-login-btn {
            margin-top: 10px; /* Espaciado superior */
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <!-- Logo de la tienda -->
                    <a class="navbar-brand" href="../index.jsp">TechUTS</a>
                <!-- Botón para ir a inicio.html -->
            </div>
        </nav>
    </header>
    <main class="container my-5">
        <!-- Sección de inicio de sesión -->
        <section id="login-section" class="text-center">
            <h2 class="mb-4">Iniciar Sesión</h2>
            <form action="${pageContext.servletContext.contextPath}/UserLoginServlet" method="post" class="login-form">
                <!-- Campos de inicio de sesión: usuario y contraseña -->
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo:</label>
                    <input type="mail" id="txtCorreo" name="txtCorreo" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="contrasena" class="form-label">Contraseña:</label>
                    <input type="password" id="txtContrasena" name="txtContrasena" class="form-control" required>
                </div>
                <div class="mb-3">
                    <input type="submit" value="Iniciar sesión" class="btn btn-primary btn-block rounded-pill">
                </div>
            </form>
            
            <!-- Botón para redirigir a la página de registro -->
            <div class="mt-3">
                <a href="registerUser.jsp" class="btn btn-link">Registrarse</a>
            </div>
        </section>
    </main>
    <footer class="text-center mt-4">
        <p id="clock"></p>
        <p>Hecho por: Miguel Cuervo - Jesus Garcia</p>
    </footer>
    <script>
        function cerrarNavegador() {
            window.close();
        }

        function updateClock() {
            var now = new Date();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();
            var formattedTime = padZero(hours) + ":" + padZero(minutes) + ":" + padZero(seconds);

            var date = now.toDateString();

            document.getElementById("clock").innerHTML = "Hora: " + formattedTime + " | Fecha: " + date;

            setTimeout(updateClock, 1000); // Actualizar cada segundo
        }

        function padZero(num) {
            return (num < 10 ? '0' : '') + num;
        }

        // Llamar a la función de actualización inicial
        updateClock();
        </script>
        <%-- Verificar si hay un mensaje de error y mostrar una alerta si es necesario --%>
        <% String errorMessage = (String) session.getAttribute("errorMessage");
           if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <script>
                alert("<%= errorMessage %>");
            </script>
        <% session.removeAttribute("errorMessage");
           } %> 
    </script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>

