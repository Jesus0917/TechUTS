<%-- 
    Document   : pago
    Created on : 9 may. 2024, 15:16:28
    Author     : yisus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Pago:.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
          body {
            background-color: #f8f9fa;
            color: #333;
          }

          .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 30px;
          }

          .tabla-productos {
            margin-top: 50px;
          }

          .tabla-productos th {
            text-align: center;
            background-color: #f2f2f2;
          }

          .tabla-productos td {
            text-align: center;
          }

          .btn-pagar {
            margin-top: 30px;
            margin-right: 10px;
          }

          .btn-cancelar {
            margin-top: 30px;
          }
        </style>
    </head>
    <body>
        <main class="container">
            <h2 class="text-center mt-4">Detalles de la compra</h2>

            <table class="table tabla-productos">
              <thead>
                <tr>
                  <th>Producto</th>
                  <th>Precio</th>
                </tr>
              </thead>
              <tbody id="tablaProductos">
              </tbody>
            </table>

            <h2 class="text-center mt-4">Forma de Pago</h2>

            <form class="row g-3 needs-validation" novalidate>
              <div class="col-md-6">
                <label for="nombreTitular" class="form-label">Nombre del titular</label>
                <input type="text" class="form-control" id="nombreTitular" placeholder="Nombre" required>
                <div class="invalid-feedback">
                  Por favor, ingresa el nombre del titular.
                </div>
              </div>
              <div class="col-md-6">
                <label for="numeroTarjeta" class="form-label">Número de tarjeta</label>
                <input type="number" class="form-control" id="numeroTarjeta" placeholder="Numero de tarjeta" required>
                <div class="invalid-feedback">
                  Por favor, ingresa el número de tarjeta.
                </div>
              </div>
              <div class="col-md-6">
                <label for="fechaExpiracion" class="form-label">Fecha de expiración</label>
                <input type="date" class="form-control" id="fechaExpiracion" placeholder="Fecha expiracion" required>
                <div class="invalid-feedback">
                  Por favor, ingresa la fecha de expiración.
                </div>
              </div>
              <div class="col-md-6">
                <label for="codigoSeguridad" class="form-label">Código de seguridad</label>
                <input type="number" class="form-control" id="codigoSeguridad" placeholder="Codigo de Seguridad" required>
                <div class="invalid-feedback">
                  Por favor, ingresa el código de seguridad.
                </div>
              </div>
              <div class="col-12">
                <div class="text-center">
                  <button class="btn btn-primary btn-pagar" id="btnPagar">Pagar</button>
                  <button type="button" class="btn btn-secondary btn-cancelar" id="btnCancelar">Cancelar</button>
                </div>
              </div>
            </form>
          </main>
                <script>
        function mostrarProductosSeleccionados() {
          const tablaProductos = document.getElementById('tablaProductos');
          let productosEnCarrito = localStorage.getItem('productosEnCarrito');
          productosEnCarrito = productosEnCarrito ? JSON.parse(productosEnCarrito) : [];

          productosEnCarrito.forEach(producto => {
            const fila = document.createElement('tr');
            fila.innerHTML = `
              <td>${producto.nombre}</td>
              <td>$${producto.precio}</td>
            `;
            tablaProductos.appendChild(fila);
          });
        }

        document.addEventListener('DOMContentLoaded', () => {
          mostrarProductosSeleccionados();
        });

        document.getElementById('btnPagar').addEventListener('click', (event) => {
          const form = document.querySelector('form');
          if (form.checkValidity()) {
            // Mostrar notificación de compra exitosa
            mostrarNotificacion('¡Pago realizado con éxito!');
          } else {
            form.classList.add('was-validated');
          }
          event.preventDefault(); // Evitar el comportamiento predeterminado del formulario
        });

        document.getElementById('btnCancelar').addEventListener('click', () => {
          const confirmar = confirm('¿Estás seguro que deseas cancelar?');
          if (confirmar) {
            window.location.href = 'indexUser.jsp';
          }
        });

        function mostrarNotificacion(mensaje) {
          // Verificar si el navegador soporta notificaciones
          if ('Notification' in window) {
            Notification.requestPermission().then(permission => {
              if (permission === 'granted') {
                new Notification('CarpiShop', {
                  body: mensaje,
                  icon: 'icono-de-tu-sitio.png' // Reemplaza con la URL del icono de tu sitio
                });
              }
            });
          }
        }
      </script>
    </body>
</html>
