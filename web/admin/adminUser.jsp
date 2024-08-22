<%-- 
    Document   : adminUser
    Created on : 19/04/2024, 11:12:40 AM
    Author     : ninoj
--%>

<%@page import="com.uts.modelo.usuario"%>
<%@page import="com.uts.dao.UsuarioDAO"%>
<%@page import="com.uts.modelo.admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <title>.:Inventario:.</title>
    </head>
    <body>
        <%!
            UsuarioDAO usuarioDAO = new UsuarioDAO();
        %>
        <div class="container">
            <%@include file="../template/menuAdmin.jsp" %>
            <hr>
            <div class="row">
                <div class="col-8"><h1>Gestion de usuarios</h1></div>
                <div class="col-4 align-self-center">
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModalA">Agregar nuevo usuario</button>
                    </div>
                </div>
            </div>
            <hr>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <th>Id</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Telefono</th>
                        <th>Correo</th>
                        <th>Tipo Documento</th>
                        <th>Documento</th>
                        <th>Nombre Usuario</th>
                        <th>Imagen</th>
                        <th>Contraseña</th>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<usuario> ListaUsuario = usuarioDAO.mostrarUsuarios();
                            for (usuario elem : ListaUsuario) {
                        %>
                        <tr>
                            <td class="id"><%= elem.getId() %></td>
                            <td class="nombres"><%= elem.getNombres() %></td>
                            <td class="apellidos"><%= elem.getApellidos() %></td>
                            <td class="telefono"><%= elem.getTelefono() %></td>
                            <td class="correo"><%= elem.getCorreo() %></td>
                            <td class="tipoDocumento"><%= elem.getTipoDocumento() %></td>
                            <td class="documento"><%= elem.getDocumento() %></td>
                            <td class="nombreUsuario"><%= elem.getNombreUsuario() %></td>
                            <td class="imagen">
                                <img src="data:image/jpg;base64,<%= javax.xml.bind.DatatypeConverter.printBase64Binary(elem.getImagen()) %>" width="100" height="100">
                            </td>
                            <td class="contrasena"><%= elem.getContrasena() %></td>
                            <td>
                                <button type="button" class="btn btn-primary btnEditar" data-bs-toggle="modal" data-bs-target="#exampleModal">Editar</button>
                                <button type="button" class="btn btn-danger btnEliminar" data-bs-toggle="modal" data-bs-target="#exampleModal">Eliminar</button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Modal Editar -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Datos usuario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="${pageContext.servletContext.contextPath}/UserServlet" method="POST" enctype="multipart/form-data" role="form">
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
                              <input type="number" name="txtId" class="form-control" id="txtId">
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
                              <button type="submit" name="btnEditar" class="btn btn-primary">Editar</button>
                              <button type="submit" name="btnEliminar" class="btn btn-danger">Eliminar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
          </div>
        </div>
        <!-- Modal Agregar -->
        <div class="modal fade" id="exampleModalA" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Datos usuario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="${pageContext.servletContext.contextPath}/UserServlet" method="POST" enctype="multipart/form-data" role="form">
                      <div class="row">
                            <div class="col-6">
                                <!-- Vista previa de la imagen -->
                                <img id="imgPreview" src="" alt="Vista Previa" class="img-fluid mb-2" style="max-height: 200px;">
                                <!-- Campo de entrada de la imagen -->
                                <label>Foto de perfil</label>
                                <input type="file" name="txtImagen" class="form-control" id="txtImagen" onchange="previewImage()">
                            </div>
                            <div class="col-6">
                              <label>Id</label>
                            <input type="number" name="txtId" class="form-control" id="txtId" readonly placeholder="Generacion automatica">
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
                              <button type="submit" name="btnGuardar" class="btn btn-success">Agregar Usuario</button>
                              <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                            </div>
                        </div>
                    </form>
                </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <%
            if(request.getAttribute("message")!= null){   
        %>
        <script>alert('<%= request.getAttribute("message") %>') </script>
        <%
         }
        %>
        <script src="${pageContext.servletContext.contextPath}/js/usuario.js"></script>
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

            // Función para mostrar la vista previa de la imagen seleccionada en el modal de inserción
            function previewImageInsertar() {
                var fileInput = document.getElementById('fileImagenInsertar');
                var imgPreview = document.getElementById('imgPreviewInsertar');
                
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
