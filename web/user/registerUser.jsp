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
    <title>.:Registro de nuevos usuarios:.</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .login-container {
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .login-form {
            padding: 20px;
        }

        .login-form label {
            font-weight: bold;
        }

        .login-form input {
            border-radius: 5px;
        }

        .login-form button {
            border-radius: 5px;
        }

        .close-button {
            background-color: #6c757d;
            color: #fff;
        }

        .match {
            border-color: green !important;
        }

        .no-match {
            border-color: red !important;
        }
        
        header {
            border-bottom: 1px solid #dee2e6; /* Borde inferior del encabezado */
        }

        .navbar-brand {
            font-size: 1.5rem; /* Tamaño de fuente del logo */
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
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="login-container">
                    <form action="${pageContext.servletContext.contextPath}/RegisterServlet" method="post" enctype="multipart/form-data" class="login-form">
                        <h2 class="text-center">Registro de nuevos usuarios</h2>
                        <div class="row mb-3">
                            <div class="col">
                                    <!-- Vista previa de la imagen -->
                                    <img id="imgPreview" src="" alt="Vista Previa" class="img-fluid mb-2" style="max-height: 200px;">
                                    <!-- Campo de entrada de la imagen -->
                                    <label>Foto de perfil</label>
                                    <input type="file" name="txtImagen" class="form-control" id="txtImagen" onchange="previewImage()">
                            </div>
                        </div>    
                        <div class="row mb-3">
                            <div class="col">
                                <label for="nombres" class="form-label">Nombres:</label>
                                <input type="text" id="txtNombres" name="txtNombres" class="form-control" required autocomplete="off">
                            </div>
                            <div class="col">
                                <label for="apellidos" class="form-label">Apellidos:</label>
                                <input type="text" id="txtApellidos" name="txtApellidos" class="form-control" required autocomplete="off">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col">
                                <label for="telefono" class="form-label">Teléfono:</label>
                                <input type="number" id="txtTelefono" name="txtTelefono" class="form-control" pattern="[0-9]+" required autocomplete="off">
                            </div>
                            <div class="col">
                                <label for="correo" class="form-label">Correo electrónico:</label>
                                <input type="email" id="txtCorreo" name="txtCorreo" class="form-control" required autocomplete="off">
                                <span id="correoError" class="text-danger">${requestScope.correoError}</span>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="tipoDocumento" class="form-label">Tipo de Documento:</label>
                            <select id="txtTipoDocumento" name="txtTipoDocumento" class="form-control" required autocomplete="off">
                                <option value="">Selecciona un tipo de documento</option>
                                <option value="TI">Tarjeta de Identidad (TI)</option>
                                <option value="CC">Cédula de Ciudadanía (CC)</option>
                                <option value="CE">Cédula de Extranjería</option>
                                <option value="PAS">Pasaporte</option>
                            </select>
                        </div>

                        <div class="row mb-3">
                            <div class="col">
                                <label for="documento" class="form-label">Número de Documento:</label>
                                <input type="number" id="txtDocumento" name="txtDocumento" class="form-control" pattern="[0-9]+" required autocomplete="off">
                            </div>
                            <div class="col">
                                <label for="nombreUsuario" class="form-label">Nombre de Usuario:</label>
                                <input type="text" id="txtNombreUsuario" name="txtNombreUsuario" class="form-control" required autocomplete="off">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col">
                                <label for="contrasena" class="form-label">Contraseña:</label>
                                <input type="password" id="txtContrasena" name="txtContrasena" class="form-control" required autocomplete="off">
                            </div>
                            <div class="col">
                                <label for="confirmarContrasena" class="form-label">Confirmar Contraseña:</label>
                                <input type="password" id="confirmarContrasena" name="confirmarContrasena" class="form-control" required autocomplete="off">
                            </div>
                        </div>

                        <button type="submit" name="btnRegistrar" class="btn btn-primary btn-block">Registrarse</button>
                        <button type="button" class="btn btn-secondary btn-block close-button" onclick="cerrarNavegador()">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
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

        function validarContrasena() {
            var contrasena = document.getElementById("txtContrasena").value;
            var confirmarContrasena = document.getElementById("confirmarContrasena");
            if (contrasena === confirmarContrasena.value) {
                confirmarContrasena.classList.remove("no-match");
                confirmarContrasena.classList.add("match");
            } else {
                confirmarContrasena.classList.remove("match");
                confirmarContrasena.classList.add("no-match");
            }
        }
        
        function mostrarErrorCorreo(mensaje) {
        var correoError = document.getElementById("correoError");
        correoError.textContent = mensaje;
        }

        // Agregar evento para verificar el correo electrónico cuando cambie
        document.getElementById("txtCorreo").addEventListener("input", function() {
            // Obtener el valor del campo de correo electrónico
            var correo = document.getElementById("txtCorreo").value;

            // Aquí debes enviar una solicitud al servidor para verificar si el correo está registrado
            // Esto puede ser a través de una llamada AJAX a un servlet o una función de JavaScript que consulte una base de datos
            // Por ahora, asumiremos que la variable 'correoRegistrado' contiene el resultado de la verificación

            var correoRegistrado = false; // Este valor debe ser reemplazado por el resultado de la verificación

            if (correoRegistrado) {
                // Si el correo está registrado, mostrar un mensaje de error
                mostrarErrorCorreo("El correo electrónico ya está en uso. Por favor, utilice otro.");
            } else {
                // Si el correo no está registrado, borrar cualquier mensaje de error existente
                mostrarErrorCorreo("");
            }
        });

        // Llamar a la función de actualización inicial
        updateClock();

        // Agregar evento para validar la contraseña cuando cambie
        document.getElementById("confirmarContrasena").addEventListener("input", validarContrasena);
        
        // Mostrar mensaje de confirmación cuando el formulario se envíe con éxito
        document.querySelector('form').addEventListener('submit', function () {
            document.getElementById('confirmationMessage').style.display = 'block';
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
   
</body>
</html>