<%-- 
    Document   : carrito
    Created on : 9 may. 2024, 15:03:40
    Author     : yisus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>.:Carrito:.</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
  <style>
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

    body {
      background-color: #f8f9fa;
      color: #495057;
    }

    main {
      padding: 20px;
    }

    .titulo-principal {
      text-align: center;
      margin-bottom: 30px;
      font-size: 24px;
    }

    .contenedor-carrito {
      max-width: 800px;
      margin: 0 auto;
      background-color: #ffffff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .barra-lateral {
      display: flex;
      justify-content: space-between;
      font-size: 18px;
      margin-bottom: 20px;
    }

    .carrito-productos li {
      margin-bottom: 20px;
      padding: 20px;
      border: 1px solid #dee2e6;
      border-radius: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .carrito-productos p {
      margin: 0;
      font-size: 16px;
    }

    .btn-vaciar,
    .btn-comprar,
    .btn-regresar {
      padding: 10px 20px;
      font-size: 16px;
      margin-right: 10px;
    }

    .btn-eliminar {
      background-color: #dc3545;
      color: white;
      border: none;
      padding: 5px 10px;
      font-size: 12px;
      cursor: pointer;
    }

    .carrito-acciones {
      display: flex;
      justify-content: flex-end;
    }
  </style>
</head>

<body>
  <%@include file="../template/menuUser.jsp" %>
  <main>
    <h2 class="titulo-principal">Carrito</h2>
    <div class="contenedor-carrito">
      <div class="barra-lateral">
        <p>Total:</p>
        <p id="total">$0</p>
      </div>

      <ul class="carrito-productos" id="carrito-productos">
        <!-- Los elementos del carrito se añadirán aquí mediante JavaScript -->
      </ul>

      <div class="carrito-acciones">
        <button class="btn btn-danger btn-vaciar">Vaciar carrito</button>
        <button class="btn btn-success btn-comprar" id="btnComprar">Comprar ahora</button>
        <a href="producto.jsp" class="btn btn-primary btn-regresar">Regresar a Productos</a>
      </div>
    </div>
  </main>

  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="./js/menu.js"></script>

  <script>
    // Función para obtener los productos del localStorage
    function obtenerProductosEnCarrito() {
      const productosEnCarrito = localStorage.getItem('productosEnCarrito');
      return productosEnCarrito ? JSON.parse(productosEnCarrito) : [];
    }

    // Función para mostrar los productos en el carrito
    function mostrarProductosEnCarrito() {
      const productosEnCarrito = obtenerProductosEnCarrito();
      const carritoProductos = document.getElementById('carrito-productos');
      carritoProductos.innerHTML = ''; // Limpiar el contenido actual del carrito

      if (productosEnCarrito.length === 0) {
        // Manejar carrito vacío
        const carritoVacio = document.createElement('p');
        carritoVacio.textContent = 'El carrito está vacío';
        carritoProductos.appendChild(carritoVacio);
      } else {
        const totalElement = document.getElementById('total');
        let total = 0;

        productosEnCarrito.forEach(producto => {
          const productoHTML = document.createElement('li');
          productoHTML.setAttribute('data-id', producto.id);
          productoHTML.classList.add('d-flex', 'justify-content-between', 'align-items-center', 'border-bottom', 'py-2');

          const nombreProducto = document.createElement('p');
          nombreProducto.textContent = producto.nombre;
          nombreProducto.classList.add('fw-bold', 'me-3');
          const precioProducto = document.createElement('p');
          precioProducto.textContent = `$${producto.precio.toFixed(2)}`;
          precioProducto.classList.add('text-muted');

          const accionesProducto = document.createElement('div');

          // Botón para eliminar el producto del carrito
          const botonEliminar = document.createElement('button');
          botonEliminar.textContent = 'Eliminar';
          botonEliminar.classList.add('btn', 'btn-danger', 'btn-eliminar', 'ms-auto');
          botonEliminar.dataset.id = producto.id; // Almacenar el ID del producto como un atributo de datos
          accionesProducto.appendChild(botonEliminar);

          productoHTML.appendChild(nombreProducto);
          productoHTML.appendChild(precioProducto);
          productoHTML.appendChild(accionesProducto);

          carritoProductos.appendChild(productoHTML);

          total += producto.precio * producto.cantidad;
        });

        totalElement.textContent = `$${total.toFixed(2)}`;
      }
    }

    // Evento para eliminar un producto del carrito
    document.getElementById('carrito-productos').addEventListener('click', e => {
      if (e.target.classList.contains('btn-eliminar')) {
        const itemId = parseInt(e.target.dataset.id); // Obtener el ID del producto a eliminar
        let productosEnCarrito = obtenerProductosEnCarrito();
        productosEnCarrito = productosEnCarrito.filter(item => item.id !== itemId);
        localStorage.setItem('productosEnCarrito', JSON.stringify(productosEnCarrito));
        mostrarProductosEnCarrito();
      }
    });

    // Evento para vaciar el carrito
    document.querySelector('.btn-vaciar').addEventListener('click', () => {
      localStorage.removeItem('productosEnCarrito');
      const totalElement = document.getElementById('total');
      totalElement.textContent = '$0'; // Reiniciar el total a cero al vaciar el carrito
      mostrarProductosEnCarrito();
    });

    // Evento para redirigir al usuario a la página de pago
    document.getElementById('btnComprar').addEventListener('click', () => {
      // Redirigir a la página de pago.html
      window.location.href = 'pago.jsp';
    });

    // Llamar a la función para mostrar los productos en el carrito al cargar la página
    mostrarProductosEnCarrito();
  </script>
</body>

</html>
