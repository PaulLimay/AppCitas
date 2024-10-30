<%@page import="db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profesionales Disponibles</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.9.1/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f5f5f5; /* Fondo gris claro */
        }
        .card-profesional {
            margin: 15px;
            border: 1px solid #000;
            text-align: center; /* Centrar el texto en el card */
            border-radius: 10px; /* Bordes redondeados */
        }
        .foto-profesional {
            width: 100%; /* Ancho completo */
            height: auto; /* Alto automático para mantener la relación */
            aspect-ratio: 1 / 1; /* Mantener una relación de aspecto cuadrada */
            object-fit: cover; /* Ajuste de la imagen */
            margin: 0 auto; /* Centrar la imagen */
            transition: transform 0.3s; /* Efecto de transición */
        }
        .foto-profesional:hover {
            transform: scale(1.05); /* Efecto de aumento al pasar el cursor sobre la imagen */
        }
        .card-header {
            background-color: #343a40; /* Gris oscuro */
            color: #fff;
            text-align: center;
            border-top-left-radius: 10px; /* Bordes redondeados */
            border-top-right-radius: 10px; /* Bordes redondeados */
        }
        .card-body {
            padding: 20px; /* Espacio interior */
        }
        .info-container {
            background-color: #e9ecef; /* Fondo gris claro */
            padding: 10px; /* Espacio interior */
            border-radius: 5px; /* Bordes redondeados */
            margin: 10px 0; /* Margen superior e inferior */
        }
        .btn-container {
            display: flex;
            justify-content: space-between; /* Espacio entre botones */
            margin-top: 10px; /* Margen superior */
        }
        .modal-header, .modal-footer {
            background-color: #343a40;
            color: white;
        }
    </style>
</head>
<body>

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
                <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link active" href="listarprofesionales.jsp">Profesionales</a></li>
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

<div class="container mt-5">
    <div class="row">
        <!-- Conexión y consulta a la base de datos -->
        <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        String searchQuery = request.getParameter("search"); // Captura el parámetro de búsqueda

        try {
 
            con = DBConnection.getConnection();

            // Definir consulta SQL con filtro de búsqueda
            String query = "SELECT * FROM profesional"; // Consulta básica

            // Si hay un valor de búsqueda, modificar la consulta para incluir el filtro
            if (searchQuery != null && !searchQuery.isEmpty()) {
                query += " WHERE nombres LIKE '%" + searchQuery + "%' OR apellidos LIKE '%" + searchQuery + "%' OR servicio LIKE '%" + searchQuery + "%'";
            }

            // Ejecutar consulta
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);

            // Iterar sobre los resultados
            while (rs.next()) {
                String idprofesional = rs.getString("idprofesional");
                String nombre = rs.getString("nombres");
                String apellido = rs.getString("apellidos");
                String tipo = rs.getString("tipo");
                String servicio = rs.getString("servicio");
                String fotoperfil = rs.getString("fotoperfil");
        %>
        <!-- Generar una card para cada profesional -->
        <div class="col-md-4">
            <div class="card card-profesional">
                <div class="card-header">
                    <h5 class="card-title"><%= nombre + " " + apellido %></h5> <!-- Nombre completo -->
                </div>
                <img src="<%= fotoperfil %>" class="foto-profesional" alt="Foto de <%= nombre %>">
                <div class="card-body">
                    <div class="info-container">
                        <p class="card-text"><strong>Servicio:</strong> <%= servicio %></p> <!-- Servicio ofrecido -->
                    </div>
                    <div class="btn-container">
                        <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#detalleModal<%= idprofesional %>">
                            Detalles
                        </button>
                        <a href="login.jsp" class="btn btn-success">Contratar</a> <!-- Cambiado de button a enlace -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal para mostrar detalles completos del profesional -->
        <div class="modal fade" id="detalleModal<%= idprofesional %>" tabindex="-1" aria-labelledby="detalleModalLabel<%= idprofesional %>" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detalleModalLabel<%= idprofesional %>">Detalles de <%= nombre + " " + apellido %></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Nombre:</strong> <%= nombre %></p>
                        <p><strong>Apellido:</strong> <%= apellido %></p>
                        <p><strong>Tipo:</strong> <%= tipo %></p>
                        <p><strong>Servicio:</strong> <%= servicio %></p>
                        <img src="<%= fotoperfil %>" class="img-fluid" alt="Foto de <%= nombre %>">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <%
            } // Fin del while
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        }
        %>
    </div>
</div>

<!-- Bootstrap JS y dependencias -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"></script>

</body>
<!-- Footer -->
<footer class="bg-dark text-white text-center mt-5 py-4">
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
</html>
