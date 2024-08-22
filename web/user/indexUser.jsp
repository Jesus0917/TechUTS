<%-- 
    Document   : indexUser
    Created on : 19/04/2024, 09:12:39 AM
    Author     : ninoj
--%>

<%@page import="com.uts.modelo.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:TechUTS - Venta de Componentes de PC:.</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            .carousel {
            max-width: 100%;
        }

        .carousel-item img {
            object-fit: cover;
            max-height: 500px; /* Ajusta la altura máxima según tus necesidades */
        }

        .carousel-item {
            height: 500px; /* Establece la altura del carrusel según tus necesidades */
        }
        
        .carousel-inner {
            border-radius: 10px; /* Bordes redondeados para las imágenes del carrusel */
        }
        
        main {
            padding-top: 20px; /* Espaciado superior del contenido principal */
            padding-bottom: 20px; /* Espaciado inferior del contenido principal */
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
        .btn-login {
            background-color: #007bff; /* Color de fondo del botón de inicio de sesión */
            border-color: #007bff;
            color: white;
        }
        .btn-login:hover {
            background-color: #0056b3; /* Color de fondo del botón de inicio de sesión al pasar el mouse */
            border-color: #0056b3;
        }
        .container {
            margin-top: 40px; /* Espacio superior para el contenido */
        }
        footer {
            background-color: #343a40; /* Color de fondo del pie de página */
            color: #fff; /* Color de texto del pie de página */
            padding: 20px 0; /* Espaciado interno del pie de página */
        }

        footer a {
            color: #fff; /* Color de texto de los enlaces en el pie de página */
        }

        footer a:hover {
            text-decoration: underline; /* Subrayado al pasar el mouse sobre los enlaces */
        }
        /* Estilos personalizados para el carrusel */
        .carousel {
            max-width: 100%;
        }

        .carousel-item img {
            object-fit: cover;
            max-height: 500px; /* Ajusta la altura máxima según tus necesidades */
        }

        .carousel-item {
            height: 500px; /* Establece la altura del carrusel según tus necesidades */
        }
        </style>
    </head>
    <body>
        <%@include file="../template/menuUser.jsp" %>
        <main class="container">
        <section class="my-5">
            <div class="row">
                <div class="col-md-6">
                    <h2 class="mb-4">Bienvenido a TechUTS</h2>
                    <p>Creemos que la tecnología debe ser accesible para todos. Ofrecemos una amplia variedad de productos, desde componentes básicos hasta avanzados, a precios competitivos. Explora nuestras categorías como hardware, periféricos, accesorios, ofertas especiales y promociones.</p>
                    <p>Crea una cuenta para guardar tus componentes favoritos y recibir notificaciones sobre nuevas llegadas y ofertas especiales. Ya sea que estés construyendo una nueva PC o actualizando tu equipo existente, TechUTS es tu destino ideal.</p>
                </div>
                <div class="col-md-6">
                    <img src="${pageContext.servletContext.contextPath}/img/logo.jpg" alt="Imagen de muestra" class="img-thumbnail w-50">
                </div>
            </div>
        </section>

        <section class="my-5">
            <div class="row">
                <div class="col-md-6">
                    <!-- Carrusel de imágenes -->
                    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                                class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                                aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                                aria-label="Slide 3"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3"
                                aria-label="Slide 4"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="${pageContext.servletContext.contextPath}/img/carrusel1.png" class="d-block w-100" alt="Primera imagen">
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.servletContext.contextPath}/img/carrusel2.png" class="d-block w-100" alt="Segunda imagen">
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.servletContext.contextPath}/img/carrusel3.png" class="d-block w-100" alt="Tercera imagen">
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.servletContext.contextPath}/img/carrusel4.png" class="d-block w-100" alt="Cuarta imagen">
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button"
                            data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Anterior</span>
                        </button>
                        <button class="carousel-control-next" type="button"
                            data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Siguiente</span>
                        </button>
                    </div>
                </div>
                <div class="col-md-6">
                    <h2 class="mb-4">Nuestros Productos:</h2>
                    <p>En TechUTS, nos esforzamos continuamente por brindarte las últimas novedades en tecnología informática. Nuestro catálogo se actualiza regularmente con los componentes más recientes, para que puedas encontrar siempre lo que necesitas para potenciar tu experiencia con tu PC.</p>
                </div>
            </div>
        </section>
    </main>

    <footer class="text-center py-4">
        <p class="mb-0">Derechos Reservados &copy; Miguel Cuervo - Jesus Garcia</p>
        <!-- Enlaces adicionales, información de contacto, redes sociales, etc. -->
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
