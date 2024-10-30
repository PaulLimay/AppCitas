<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.9.1/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Color de fondo más suave */
        }
        .custom-border {
            border: 1px solid #343a40 !important;
            border-radius: 8px;
        }
        /* Efecto de interacción para las imágenes */
        .card-img-top {
            transition: transform 0.3s ease, filter 0.3s ease;
        }
        .card-img-top:hover {
            transform: scale(1.05); /* Efecto de zoom */
            filter: brightness(85%); /* Efecto de oscurecimiento */
        }
        .hero-section {
            background-color: #343a40;
            color: white;
            padding: 50px 0;
            border-radius: 8px;
        }
        .footer {
            background-color: #343a40;
        }
        .footer a {
            color: #ffffff;
            transition: color 0.3s ease;
        }
        .footer a:hover {
            color: #17a2b8; /* Color de hover */
        }
    </style>
</head>
<div class="text-center py-3" style="background: linear-gradient(to bottom, #fafafa, #f5f5f5);">
    <img src="https://i.ibb.co/M1xqhhQ/logo-citas.png" class="img-fluid img-rounded" alt="Logo" width="900" height="250">
</div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="listarprofesionales.jsp">Profesionales</a></li>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Calendario</a></li>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Mis Citas</a></li>
                    <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                </ul>
              <form class="d-flex ms-auto" method="GET" action="listarprofesionales.jsp">
               <input class="form-control me-2" type="text" name="search" placeholder="Buscar" aria-label="Buscar" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">

                <button class="btn btn-outline-light" type="submit">Buscar</button>
            </form>

                <ul class="navbar-nav ms-3">
                    <li class="nav-item"><a class="nav-link" href="Registrar.jsp"><i class="bi bi-person-plus"></i> Registrate</a></li>
                    <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="bi bi-box-arrow-in-right"></i> Acceder</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="hero-section text-center mt-4">
        <h1 class="display-4">¡BIENVENIDO!</h1>
        <p class="lead">Reserva citas con profesionales en distintas áreas de manera fácil y rápida.</p>
        <a href="crearcita.jsp" class="btn btn-success btn-lg">CONTRATAR</a>
    </div>

    <div class="container mt-5">
        <h2 class="mb-4 text-center">RECOMENDADOS</h2>
        <div class="row g-4">
            <div class="col-lg-4">
                <div class="card h-100 custom-border">
                    <img src="https://img.freepik.com/fotos-premium/doctores-medicos-medicos-hospital_739685-1907.jpg?w=360" class="card-img-top" alt="Medicos">
                    <div class="card-body">
                        <h5 class="card-title">MÉDICOS</h5>
                        <p class="card-text">Encuentra y agenda citas con los mejores profesionales de la salud en diversas especialidades.</p>
                        <div class="d-flex justify-content-between">
                            <a href="login.jsp" class="btn btn-success">Contratar</a>
                            <a href="#" class="btn btn-primary">Información</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card h-100 custom-border">
                    <img src="https://sanmiguel.law/wp-content/uploads/2024/04/Alan-San-Miguel.-Managing-Attorney-Abogado-360x360.jpg" class="card-img-top" alt="Abogados">
                    <div class="card-body">
                        <h5 class="card-title">ABOGADOS</h5>
                        <p class="card-text">Accede a una red de abogados especializados para consultas legales y representación en diversos casos.</p>
                        <div class="d-flex justify-content-between">
                            <a href="login.jsp" class="btn btn-success">Contratar</a>
                            <a href="#" class="btn btn-primary">Información</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card h-100 custom-border">
                    <img src="https://img.freepik.com/fotos-premium/retrato-albanil-cemento-acabador-hormigon_1077802-118502.jpg?w=360" class="card-img-top" alt="Servicios Generales">
                    <div class="card-body">
                        <h5 class="card-title">SERVICIOS GENERALES</h5>
                        <p class="card-text">Contrata expertos en servicios esenciales como reparación, mantenimiento y asistencia técnica.</p>
                        <div class="d-flex justify-content-between">
                            <a href="login.jsp" class="btn btn-success">Contratar</a>
                            <a href="#" class="btn btn-primary">Información</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer text-white text-center mt-5 py-4">
        <h5>Agendame</h5>
        <ul class="list-unstyled d-flex justify-content-center mb-3">
            <li class="mx-3"><a href="#about" class="text-white text-decoration-none">Acerca de</a></li>
            <li class="mx-3"><a href="#services" class="text-white text-decoration-none">Servicios</a></li>
            <li class="mx-3"><a href="#contact" class="text-white text-decoration-none">Contacto</a></li>
        </ul>
        <ul class="list-unstyled d-flex justify-content-center mb-3">
            <li class="mx-3"><a href="https://www.facebook.com" target="_blank" class="text-white"><i class="bi bi-facebook"></i></a></li>
            <li class="mx-3"><a href="https://www.twitter.com" target="_blank" class="text-white"><i class="bi bi-twitter"></i></a></li>
            <li class="mx-3"><a href="https://www.instagram.com" target="_blank" class="text-white"><i class="bi bi-instagram"></i></a></li>
        </ul>
        <p class="mb-0">© 2024 Nombre de tu Sitio Web. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
