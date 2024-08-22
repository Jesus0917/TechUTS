let productosEnCarrito = JSON.parse(localStorage.getItem('productosEnCarrito')) || [];

// Función para guardar el carrito en el almacenamiento local
function guardarCarritoEnLocalStorage() {
  localStorage.setItem('productosEnCarrito', JSON.stringify(productosEnCarrito));
}

// Función para mostrar los productos en el carrito
function mostrarProductosEnCarrito() {
  const carritoProductos = document.getElementById('carrito-productos');
  const totalElement = document.getElementById('total');
  let total = 0;

  carritoProductos.innerHTML = ''; // Limpiar el contenido actual del carrito

  if (productosEnCarrito.length === 0) {
    // Manejar carrito vacío
    const carritoVacio = document.createElement('p');
    carritoVacio.textContent = 'El carrito está vacío';
    carritoProductos.appendChild(carritoVacio);
  } else {
    productosEnCarrito.forEach(producto => {
      const productoHTML = document.createElement('li');
      productoHTML.innerHTML = `
        <p>${producto.nombre}</p>
        <p>Precio: $${producto.precio}</p>
        <input type="number" value="${producto.cantidad}" min="1">
        <button class="btn btn-danger btn-eliminar" data-producto-id="${producto.id}">Eliminar</button>
      `;

      carritoProductos.appendChild(productoHTML);
      total += producto.precio * producto.cantidad;
    });
  }

  totalElement.textContent = `$${total}`;
}

// Función para agregar productos al carrito desde producto.html
function agregarProductoAlCarrito(e) {
  e.preventDefault();
  const productoNombre = e.target.getAttribute('data-nombre');
  const productoPrecio = parseFloat(e.target.getAttribute('data-precio'));
  const productoId = productosEnCarrito.length + 1;

  // Simulación de datos del producto (reemplazar con datos reales)
  const producto = {
    id: productoId,
    nombre: productoNombre,
    precio: productoPrecio,
    cantidad: 1
  };

  // Verificar si el producto ya está en el carrito
  const productoExistente = productosEnCarrito.find(item => item.nombre === producto.nombre);
  if (productoExistente) {
    productoExistente.cantidad++;
  } else {
    productosEnCarrito.push(producto);
  }

  guardarCarritoEnLocalStorage();
  mostrarProductosEnCarrito();
}

// Manejar clic en botones "Agregar al carrito" en producto.html
const botonesAgregarCarrito = document.querySelectorAll('.agregar-carrito');
botonesAgregarCarrito.forEach(boton => {
  boton.addEventListener('click', agregarProductoAlCarrito);
});

// Manejar clic en botones "Eliminar" en el carrito
const botonesEliminar = document.querySelectorAll('.btn-eliminar');
botonesEliminar.forEach(boton => {
  boton.addEventListener('click', e => {
    const itemId = parseInt(e.target.dataset.productoId);
    productosEnCarrito = productosEnCarrito.filter(item => item.id !== itemId);
    guardarCarritoEnLocalStorage();
    mostrarProductosEnCarrito();
  });
});

// Llamar a la función para mostrar los productos en el carrito al cargar la página
mostrarProductosEnCarrito();