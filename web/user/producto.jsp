<%-- 
    Document   : producto
    Created on : 25/04/2024, 09:44:59 PM
    Author     : ninoj
--%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.uts.modelo.producto" %>
<%@page import="com.uts.dao.ProductoDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>.:Productos:.</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        #productos .card {
            height: 100%;
            transition: transform 0.3s ease-in-out;
            z-index: 1;
        }

        #productos .card:hover {
            transform: scale(1.05);
        }

        .navbar-brand {
            font-size: 1.5rem;
            color: #000;
        }

        .navbar-toggler-icon {
            background-color: #007bff;
        }

        .navbar-nav .nav-link {
            color: #000 !important;
        }

        #productos .card-body {
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        #productos .btn {
            margin-top: auto;
            z-index: 2;
        }

        #productos .card-img-top {
            height: 650px;
            object-fit: cover;
        }

        #productos .card-img-top1 {
            height: 350px;
            object-fit: cover;
        }

        #productos .btn {
            position: absolute;
            bottom: 10px;
        }
    </style>
</head>
<body>
    <%!
        ProductoDAO productoDAO = new ProductoDAO();
        NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.GERMAN); // Usa el formato de Alemania para puntos en los miles
    %>
    <%@include file="../template/menuUser.jsp" %>
    <main>
        <div class="container my-4">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="input-group mb-3">
                        <input type="text" id="inputBusqueda" class="form-control" placeholder="Buscar producto por nombre" aria-label="Buscar producto por nombre">
                        <select id="selectEstado" class="form-select">
                            <option value="todos">Todos</option>
                            <option value="disponible">Disponible</option>
                            <option value="agotado">Agotado</option>
                        </select>
                        <button class="btn btn-outline-secondary" type="button" id="btnBuscar">Buscar</button>
                    </div>
                </div>
            </div>

            <section id="product-list" class="my-5">
                <div class="container">
                    <div class="row" id="productos">
                        <% 
                            ArrayList<producto> listaProductos = productoDAO.mostrarProductos();
                            if (listaProductos.isEmpty()) { %>
                                <div class="col-12">
                                    <p>No hay productos disponibles.</p>
                                </div>
                        <% } else {
                            for (producto producto : listaProductos) {
                                String precioFormateado = numberFormat.format(producto.getPrecio());
                                String estadoFormateado = producto.getEstado().equalsIgnoreCase("disponible") ? "Disponible" : "Agotado";
                        %>
                            <div class="col-md-6 col-lg-4 mb-4 producto-card" data-nombre="<%= producto.getNombre().toLowerCase() %>" data-estado="<%= estadoFormateado.toLowerCase() %>">
                                <div class="card">
                                    <h5 class="card-title text-center estado-producto"><%= estadoFormateado %></h5>
                                    <img src="data:image/jpg;base64,<%= javax.xml.bind.DatatypeConverter.printBase64Binary(producto.getImagen()) %>" class="card-img-top mx-auto" style="width: 200px; height: 200px; object-fit: contain;" alt="Imagen del producto">
                                    <div class="card-body">
                                        <h5 class="card-title text-center nombre-producto"><%= producto.getNombre() %></h5>
                                        <p class="card-text"><%= producto.getDescripcion() %></p>
                                        <p style="margin-bottom: 10px;"><strong>$<%= precioFormateado %></strong></p>
                                        <% if (estadoFormateado.equals("Disponible")) { %>
                                            <div style="text-align: center;">
                                                <button class="btn btn-primary btn-block agregar-carrito"
                                                        data-nombre="<%= producto.getNombre() %>" data-precio="<%= producto.getPrecio() %>">Agregar al carrito</button>
                                            </div>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        <% }} %>
                    </div>
                    <div id="mensajeBusqueda" class="row">
                        <div class="col-12">
                            <p class="text-center" style="display:none;">No se encontraron productos con el nombre buscado.</p>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const botonesAgregarCarrito = document.querySelectorAll('.agregar-carrito');

        botonesAgregarCarrito.forEach(boton => {
            boton.addEventListener('click', e => {
                e.preventDefault();
                const nombreProducto = e.target.getAttribute('data-nombre');
                const precioProducto = parseFloat(e.target.getAttribute('data-precio'));

                const nuevoProducto = {
                    id: Date.now(), // ID único para cada producto
                    nombre: nombreProducto,
                    precio: precioProducto,
                    cantidad: 1
                };

                let productosEnCarrito = JSON.parse(localStorage.getItem('productosEnCarrito')) || [];
                productosEnCarrito.push(nuevoProducto);
                localStorage.setItem('productosEnCarrito', JSON.stringify(productosEnCarrito));

                alert(`${nombreProducto} agregado al carrito`);
            });
        });

        document.getElementById('btnBuscar').addEventListener('click', function () {
            const inputBusqueda = document.getElementById('inputBusqueda');
            const selectEstado = document.getElementById('selectEstado');
            const textoBusqueda = inputBusqueda.value.toLowerCase().trim();
            const estadoFiltro = selectEstado.value.toLowerCase();
            const productos = document.querySelectorAll('.producto-card');
            let productosEncontrados = 0;

            productos.forEach(producto => {
                const nombreProducto = producto.getAttribute('data-nombre');
                const estadoProducto = producto.getAttribute('data-estado');
                const nombreCoincide = nombreProducto.includes(textoBusqueda);
                const estadoCoincide = estadoFiltro === 'todos' || estadoProducto === estadoFiltro;

                if (nombreCoincide && estadoCoincide) {
                    producto.style.display = 'block';
                    productosEncontrados++;
                } else {
                    producto.style.display = 'none';
                }
            });

            const mensajeBusqueda = document.getElementById('mensajeBusqueda').querySelector('p');
            if (productosEncontrados === 0) {
                mensajeBusqueda.style.display = 'block';
            } else {
                mensajeBusqueda.style.display = 'none';
            }
        });
    });
    </script>
</body>
</html>
