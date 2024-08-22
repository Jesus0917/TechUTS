<%-- 
    Document   : adminProductos
    Created on : 19-nov-2023, 10:40:34
    Author     : ninoj
--%>

<%@page import="com.uts.modelo.admin"%>
<%@page import="com.uts.modelo.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.uts.modelo.producto" %>
<%@page import="com.uts.dao.ProductoDAO" %>
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
            ProductoDAO productoDAO = new ProductoDAO();
        %>
        <div class="container">
            <%@include file="../template/menuAdmin.jsp" %>
            <hr>
            <div class="row">
                <div class="col-8"><h1>Gestion de productos</h1></div>
                <div class="col-4 align-self-center">
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModalA">Agregar nuevo producto</button>
                    </div>
                </div>
            </div>
            <hr>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <th>Id</th>
                        <th>Código Producto</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Cantidad Disponible</th>
                        <th>Estado</th>
                        <th>Imagen</th> <!-- Nuevo encabezado para imagen -->
                        <th>Opciones</th>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<producto> ListaProducto = productoDAO.mostrarProductos();
                            for (producto elem : ListaProducto) {
                        %>
                        <tr>
                            <td class="id"><%=elem.getId()%></td>
                            <td class="codigoProducto"><%=elem.getCodigoProducto()%></td>
                            <td class="nombre"><%= elem.getNombre() %></td>
                            <td class="descripcion"><%= elem.getDescripcion() %></td>
                            <td class="precio"><%= elem.getPrecio() %></td>
                            <td class="cantidad"><%= elem.getCantidad() %></td>
                            <td class="estado"><%= elem.getEstado()%></td>
                            <td class="imagen">
                                <img src="data:image/jpg;base64,<%= javax.xml.bind.DatatypeConverter.printBase64Binary(elem.getImagen()) %>" width="100" height="100">
                            </td><!-- Mostrar imagen -->
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
                <h1 class="modal-title fs-5" id="exampleModalLabel">Datos Producto</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="${pageContext.servletContext.contextPath}/ProductoServlet" method="POST" enctype="multipart/form-data" role="form">
                      <div class="row">
                            <div class="col-6">
                                <!-- Vista previa de la imagen -->
                                <img id="imgPreview" src="" alt="Vista Previa" class="img-fluid mb-2" style="max-height: 200px;">
                                <!-- Campo de entrada de la imagen -->
                                <label>Imagen</label>
                                <input type="file" name="txtImagen" class="form-control" id="txtImagen" onchange="previewImage()">
                            </div>
                          <div class="col-6">
                              <label>Id</label>
                              <input type="number" name="txtId" class="form-control" id="txtId" placeholder="id generado automaticamente" readonly>
                          </div>
                          <div class="col-6">
                              <label>Codigo Producto</label>
                              <input type="text" name="txtCodigoProducto" class="form-control" id="txtCodigoProducto">
                          </div>
                          <div class="col-6">
                              <label>Nombre</label>
                              <input type="text" name="txtNombre" class="form-control" id="txtNombre">
                          </div>
                          <div class="col-6">
                              <label>Descripcion</label>
                              <input type="text" name="txtDescripcion" class="form-control" id="txtDescripcion">
                          </div>
                          <div class="col-6">
                                <label>Precio</label>
                                <input type="number" name="txtPrecio" class="form-control" id="txtPrecio">
                          </div>
                          <div class="col-6">
                              <label>Cantidad</label>
                              <input type="number" min="0" name="txtCantidad" class="form-control" id="txtCantidad" oninput="actualizarEstadoEditar()">
                          </div>
                           <div class="col-6">
                            <label>Estado:</label>
                            <input type="text" name="txtEstado" class="form-control" id="txtEstado" readonly>
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-12">
                              <hr>
                              <button type="submit" name="btnEditar" class="btn btn-success" id="btnEditar">Editar</button>
                              <button type="submit" name="btnEliminar" class="btn btn-danger">Eliminar</button>
                          </div>
                      </div>
                  </form>
              </div>
            </div>
          </div>
        </div>
        <!-- Modal insertar -->
        <div class="modal fade" id="exampleModalA" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Datos Producto</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="${pageContext.servletContext.contextPath}/ProductoServlet" method="POST" enctype="multipart/form-data" role="form">
                      <div class="row">
                          <div class="col-6">
                                <!-- Vista previa de la imagen -->
                                <img id="imgPreview" src="" alt="Vista Previa" class="img-fluid mb-2" style="max-height: 200px;">
                                <!-- Campo de entrada de la imagen -->
                                <label>Imagen</label>
                                <input type="file" name="txtImagen" class="form-control" id="txtImagen" onchange="previewImage()">
                            </div>
                          <div class="col-6">
                              <label>Id</label>
                              <input type="number" name="txtId" class="form-control" id="txtId" placeholder="id generado automaticamente" readonly>
                          </div>
                          <div class="col-6">
                              <label>Codigo Producto</label>
                              <input type="text" name="txtCodigoProducto" class="form-control" id="txtCodigoProducto">
                          </div>
                          <div class="col-6">
                              <label>Nombre</label>
                              <input type="text" name="txtNombre" class="form-control" id="txtNombre">
                          </div>
                          <div class="col-6">
                              <label>Descripcion</label>
                              <input type="text" name="txtDescripcion" class="form-control" id="txtDescripcion">
                          </div>
                          <div class="col-6">
                                <label>Precio</label>
                                <input type="number" name="txtPrecio" class="form-control" id="txtPrecio">
                          </div>
                          <div class="col-6">
                              <label>Cantidad</label>
                              <input type="number" min="0" name="txtCantidad" class="form-control" id="txtCantidadInsertar" >
                          </div>
                           <div class="col-6">
                            <label for="estado" class="form-label">Estado del producto:</label>
                            <select id="txtEstado" name="txtEstado" class="form-control" autocomplete="off">
                                <option value="">Selecciona el estado del producto:</option>
                                <option value="Disponible">Disponible</option>
                                <option value="Agotado">Agotado</option>
                            </select>
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-12">
                              <hr>
                              <button type="submit" name="btnGuardar" class="btn btn-success">Agregar Producto</button>
                              <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Cancelar</button>
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
        <script>alert(<%= request.getAttribute("message") %>') </script>
        <%
         }
        %>
        <script src="${pageContext.servletContext.contextPath}/js/producto.js"></script>
        <script>
            // Función para mostrar la vista previa de la imagen seleccionada en el modal de edición
            function previewImage() {
                var fileInput = document.getElementById('fileImagen');
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
        <script>
            // Función para actualizar el estado del producto
            function actualizarEstadoEditar() {
                var cantidad = document.getElementById('txtCantidad').value;
                var estadoElement = document.getElementById('txtEstado');

                if (cantidad == 0) {
                    estadoElement.value = 'Agotado';
                } else {
                    estadoElement.value = 'Disponible';
                }
            }

            // Agregar el evento oninput al campo de cantidad
            document.getElementById('txtCantidad').addEventListener('input', actualizarEstadoEditar); // Aquí se cambió a actualizarEstadoEditar
        </script>
        <script type="text/javascript">
            function previewImage() {
                var oFReader = new FileReader();
                oFReader.readAsDataURL(document.getElementById("txtImagen").files[0]);

                oFReader.onload = function (oFREvent) {
                    document.getElementById("imgPreview").src = oFREvent.target.result;
                };
            }
        </script>
    </body>
</html>
