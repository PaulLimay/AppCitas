<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Contacto</title>
<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.9.1/font/bootstrap-icons.min.css">

<style>
  body {
      background-color: #ffffff;
      color: #fff;
  }
  .contact-form {
      background-color: #333;
      padding: 2rem;
      border-radius: 15px;
      box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.1);
      transition: transform 0.3s ease-in-out;
  }
  .contact-form:hover {
      transform: scale(1.02);
  }
  .form-control {
      background-color: #fff; /* Fondo blanco */
      border: none;
      border-bottom: 2px solid #fff; /* Borde blanco solo en la parte inferior */
      border-radius: 0;
      border-radius: 5px;
      color: #000; /* Texto negro */
  }
  .form-control:focus {
      background-color: #fff;
      border-bottom-color: #1f8ef1; /* Borde azul en el foco */
      box-shadow: none;
  }
  .btn-custom:hover {
      background-color: #fff;
      color: #000;
  }
  .custom-border {
    border: 1px solid #000 !important;
  }
  .card-img-top {
    transition: transform 0.3s ease;
  }
  .card-img-top:hover {
    transform: scale(1.05);
  }
</style>
</head>

<body>
<!-- Header -->
<div  style="background: linear-gradient(to bottom, #fafafa, #f5f5f5);">
  <div class="text-center py-3">
    <img src="https://i.ibb.co/M1xqhhQ/logo-citas.png" class="img-fluid img-rounded" alt="Logo" width="900" height="250">
  </div>

  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
          <li class="nav-item"><a class="nav-link" href="listarprofesionales.jsp">Profesionales</a></li>
          <li class="nav-item"><a class="nav-link" href="login.jsp">Calendario</a></li>
          <li class="nav-item"><a class="nav-link" href="login.jsp">Mis Citas</a></li>
          <li class="nav-item"><a class="nav-link active" href="contacto.jsp">Contacto</a></li>
        </ul>
        <!-- Búsqueda idéntica a la de index.jsp -->
        <form class="d-flex">
          <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Buscar">
          <button class="btn btn-outline-light" type="submit">Buscar</button>
        </form>
        <ul class="navbar-nav ms-3">
          <li class="nav-item"><a class="nav-link" href="Registrar.jsp"><i class="bi bi-person-plus"></i> Registrate</a></li>
          <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="bi bi-box-arrow-in-right"></i> Acceder</a></li>
        </ul>
      </div>
    </div>
  </nav>
</div>

<!-- Formulario de contacto -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="contact-form mt-5">
                <h2 class="text-center mb-4">Contáctanos</h2>
                <form action="mensajeenviado.jsp" method="post">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="mensaje" class="form-label">Mensaje</label>
                        <textarea class="form-control" id="mensaje" name="mensaje" rows="4" required></textarea>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Enviar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center mt-5 py-4">
  <h5>Agendame</h5>
  <ul class="list-unstyled d-flex justify-content-center mb-3">
    <li class="mx-3"><a href="#about" class="text-white text-decoration-none">Acerca de</a></li>
    <li class="mx-3"><a href="#services" class="text-white text-decoration-none">Servicios</a></li>
    <li class="mx-3"><a href="#contact" class="text-white text-decoration-none">Contacto</a></li>
  </ul>
  <ul class="list-unstyled d-flex justify-content-center mb-3">
    <li class="mx-3"><a href="https://www.facebook.com/profile.php?id=61551294025673" target="_blank" class="text-white"><i class="bi bi-facebook"></i></a></li>
    <li class="mx-3"><a href="https://www.twitter.com" target="_blank" class="text-white"><i class="bi bi-twitter"></i></a></li>
    <li class="mx-3"><a href="https://www.instagram.com/zeusstoreof?igsh=MXdya25qZzUwNHYzbg==" target="_blank" class="text-white"><i class="bi bi-instagram"></i></a></li>
  </ul>
  <p class="mb-0">© 2024 Nombre de tu Sitio Web. Todos los derechos reservados.</p>
</footer>

</body>
</html>
