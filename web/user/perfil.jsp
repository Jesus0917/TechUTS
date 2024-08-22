<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.uts.modelo.usuario" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>

<%
    usuario usuarioMenu = (usuario)session.getAttribute("usuario");
    if (usuarioMenu == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
<div class="container mt-5">
    <table class="table">
        <tbody>
            <tr>
                <td class="imagen" rowspan="11" style="align-content: center">
                    <img src="data:image/jpg;base64,<%= javax.xml.bind.DatatypeConverter.printBase64Binary(usuario.getImagen()) %>" class="rounded-circle mx-auto d-block" alt="Foto de perfil" width="150" height="150">
                </td>
                <td><b>ID unico:</b></td>
                <td class="id"><%= usuario.getId() %></td>
            </tr>
            <tr>
                <td><b>Nombres:</b></td>
                <td class="nombres"><%= usuario.getNombres() %></td>
            </tr>
            <tr>
                <td><b>Apellidos:</b></td>
                <td class="apellidos"><%= usuario.getApellidos() %></td>
            </tr>
            <tr>
                <td><b>Telefono:</b></td>
                <td class="telefono"><%= usuario.getTelefono() %></td>
            </tr>
            <tr>
                <td><b>Correo:</b></td>
                <td class="correo"><%= usuario.getCorreo() %></td>
            </tr>
            <tr>
                <td><b>Tipo Documento:</b></td>
                <td class="tipoDocumento"><%= usuario.getTipoDocumento() %></td>
            </tr>
            <tr>
                <td><b>Documento:</b></td>
                <td class="documento"><%= usuario.getDocumento() %></td>
            </tr>
            <tr>
                <td><b>Nombre Usuario:</b></td>
                <td class="nombreUsuario"><%= usuario.getNombreUsuario() %></td>
            </tr>
            <tr>
                <td><b>Contraseña:</b></td>
                <td class="contrasena"><%= usuario.getContrasena() %></td>
            </tr>
            <tr>
                <td colspan="2" style="align-content: center">
                    <button type="button" class="btn btn-primary btnEditar" data-bs-toggle="modal" data-bs-target="#exampleModal">Editar Perfil</button>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<!-- Modal de edición de perfil -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Datos usuario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formEditarPerfil" action="${pageContext.servletContext.contextPath}/UserServlet2" method="POST" enctype="multipart/form-data" role="form">
                    <div class="row">
                        <div class="col-6">
                            <!-- Vista previa de la imagen -->
                            <img id="imgPreview" src="" alt="Vista Previa" class="img-fluid mb-2" style="max-height: 200px;">
                            <!-- Campo de entrada de la imagen -->
                            <label>foto de perfil</label>
                            <input type="file" name="txtImagen" class="form-control" id="txtImagen" onchange="previewImage()">
                        </div>
                        <div class="col-6">
                            <label>Id</label>
                            <input type="number" name="txtId" class="form-control" id="txtId" readonly placeholder="Id generado automáticamente">
                        </div>
                        <div class="col-6">
                            <label>Nombres</label>
                            <input type="text" name="txtNombres" class="form-control" id="txtNombres">
                        </div>
                        <div class="col-6">
                            <label>Apellidos</label>
                            <input type="text" name="txtApellidos" class="form-control" id="txtApellidos">
                        </div>
                        <div class="col-6">
                            <label>Telefono</label>
                            <input type="number" name="txtTelefono" class="form-control" id="txtTelefono">
                        </div>
                        <div class="col-6">
                            <label>Correo</label>
                            <input type="mail" name="txtCorreo" class="form-control" id="txtCorreo">
                        </div>
                        <div class="mb-3">
                            <label for="tipoDocumento" class="form-label">Tipo de Documento:</label>
                            <select id="txtTipoDocumento" name="txtTipoDocumento" class="form-control">
                                <option value="">Selecciona un tipo de documento</option>
                                <option value="TI">Tarjeta de Identidad (TI)</option>
                                <option value="CC">Cédula de Ciudadanía (CC)</option>
                                <option value="CE">Cédula de Extranjería</option>
                                <option value="PAS">Pasaporte</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label>Documento</label>
                            <input type="number" name="txtDocumento" class="form-control" id="txtDocumento">
                        </div>
                        <div class="col-6">
                            <label>Nombre Usuario</label>
                            <input type="text" name="txtNombreUsuario" class="form-control" id="txtNombreUsuario">
                        </div>
                        <div class="col-6">
                            <label>Contraseña</label>
                            <input type="password" name="txtContrasena" class="form-control" id="txtContrasena">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <hr>
                            <button type="submit" name="btnEditar" class="btn btn-primary">Guardar Cambios</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/usuario2.js"></script>
<script>
            // Función para mostrar la vista previa de la imagen seleccionada en el modal de edición
    function previewImage() {
            var fileInput = document.getElementById('txtImagen');
            var imgPreview = document.getElementById('imgPreview');
                
            if (fileInput.files && fileInput.files[0]) {
            var reader = new FileReader();
                    
        reader.onload = function(e) {
            imgPreview.src = e.target.result;
        }
                    
        reader.readAsDataURL(fileInput.files[0]);
    }
}
</script>
</body>
</html>
