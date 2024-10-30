<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Evitar acceso a la página después de cerrar sesión
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    response.setDateHeader("Expires", -1);

    // Verificar si la sesión está activa
    if (session.getAttribute("nombreusuario") == null) {
        response.sendRedirect("login.jsp"); // Redirige al login si no hay sesión
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil de Usuario</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.9.1/font/bootstrap-icons.min.css">

    <style>
        .custom-border {
            border: 1px solid #000 !important;
        }
        .card-img-top {
            transition: transform 0.3s ease;
        }
        .card-img-top:hover {
            transform: scale(1.05);
        }
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }
        .alert {
            width: 50%;
            margin: 20px auto;
            padding: 15px;
            border: 1px solid #28a745;
            background-color: #d4edda;
            color: #155724;
            border-radius: 5px;
            text-align: center;
            position: relative;
        }

        .alert::before {
            content: "";
            display: block;
            width: 30px;
            height: 4px;
            background-color: #28a745;
            margin: 0 auto 10px;
        }

        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            border: none;
            background: none;
            color: #155724;
            font-size: 16px;
            cursor: pointer;
        }

        .avatar-option {
            cursor: pointer;
            border: 2px solid transparent;
            transition: border 0.3s;
        }
        .avatar-option:hover {
            border: 2px solid #007bff; /* Color al pasar el ratón */
        }
        .selected {
            border: 2px solid #007bff; /* Color del borde para el avatar seleccionado */
        }
        .avatar-option {
    width: 100px; /* Ajusta el tamaño según sea necesario */
    height: 100px; /* Mantiene el mismo tamaño para ancho y alto */
    object-fit: cover; /* Asegura que la imagen cubra el contenedor sin distorsión */
    border-radius: 50%; /* Hace que la imagen sea circular */
    cursor: pointer; /* Cambia el cursor al pasar el ratón */
    
}

.avatar-option.selected {
    border: 2px solid #007bff; /* Resalta el avatar seleccionado */
}
    </style>
</head>
<body>

<div style="background-color: #000000;">
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
                    <li class="nav-item"><a class="nav-link" href="listarcitausuario.jsp">Mis Citas</a></li>
                    <li class="nav-item"><a class="nav-link" href="calendario.jsp">Calendario</a></li>
                    <li class="nav-item"><a class="nav-link" href="crearcita.jsp">Crear cita</a></li>
                    <li class="nav-item"><a class="nav-link" href="listarprofesionalesusuario.jsp">Buscar Profesional</a></li>
                    <li class="nav-item"><a class="nav-link active" href="perfilusuario.jsp">Mi Perfil</a></li>
                </ul>
                <ul class="navbar-nav ms-3">
                    <li class="nav-item d-flex align-items-center">
                        <div class="dropdown">
                            <button class="btn p-0" data-bs-toggle="dropdown" aria-expanded="false" style="border: none; background: none;">
                                <img src="<%= session.getAttribute("fotoperfil") != null ? session.getAttribute("fotoperfil") : "https://via.placeholder.com/40" %>" class="rounded-circle" alt="Avatar" width="40" height="40">
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="perfilusuario.jsp">Mi Perfil</a></li>
                                <li><a class="dropdown-item" href="eliminarcuenta.jsp">Eliminar Cuenta</a></li>
                                <li><a class="dropdown-item" href="CerrarSesion">Cerrar Sesión</a></li>
                            </ul>
                        </div>
                        <span class="text-white ms-2"><%= session.getAttribute("nombreusuario") %></span>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>

<div class="container text-center mt-5">
    <h1 class="display-4">PERFIL DE USUARIO</h1>
    <p class="lead">Consulta y actualiza tu perfil personal.</p>
</div>

<script>
    function closeAlert() {
        var alert = document.getElementById("alert");
        alert.style.display = "none";
    }
</script>

<% 
    String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null) {
%>
    <div id="alert" class="alert" role="alert">
        <button class="close-btn" onclick="closeAlert()">✖</button>
        <%= mensaje %>
    </div>
<% 
    }
%>

<div class="container mt-5">
    <div class="row">
       <div class="col-lg-4 text-center">
    <div class="position-relative">
        <img src="<%= session.getAttribute("fotoperfil") != null ? session.getAttribute("fotoperfil") : "https://via.placeholder.com/150"  %>" class="rounded-circle" alt="Avatar del usuario" width="150" height="150">
        <a href="#" class="position-absolute top-0 start-100 translate-middle p-2 bg-primary rounded-circle" data-bs-toggle="modal" data-bs-target="#editarFotoModal">
            <i class="bi bi-pencil-fill text-white"></i>
        </a>
    </div>
    <h3 class="mt-3"><%= session.getAttribute("nombreusuario") %></h3>
</div>
        
        <div class="col-lg-8">
            <h4>Información del Usuario</h4>
            <ul class="list-group">
                <li class="list-group-item"><strong>Nombres:</strong> <%= session.getAttribute("nombres") %></li>
                <li class="list-group-item"><strong>Apellidos:</strong> <%= session.getAttribute("apellidos") %></li>
                <li class="list-group-item"><strong>Celular:</strong> <%= session.getAttribute("celular") %></li>
                <li class="list-group-item"><strong>Fecha de Nacimiento:</strong> <%= session.getAttribute("fechanacimiento") %></li>
                <li class="list-group-item"><strong>Tipo de Cuenta:</strong> <%= session.getAttribute("tipo") %></li>
            </ul>
            <div class="mt-4">
                <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editarPerfilModal">Editar Perfil</a>
                <a href="eliminarcuenta.jsp" class="btn btn-danger">Eliminar Cuenta</a>
            </div>
        </div>
    </div>
</div>

<!-- Modal para editar perfil -->
<div class="modal fade" id="editarPerfilModal" tabindex="-1" aria-labelledby="editarPerfilLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarPerfilLabel">Editar Perfil Usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="EditarPerfilUsuario" method="post">
                    <div class="mb-3">
                        <label for="nombres" class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="nombres" name="nombres" value="<%= session.getAttribute("nombres") %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="apellidos" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="apellidos" name="apellidos" value="<%= session.getAttribute("apellidos") %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="celular" class="form-label">Celular</label>
                        <input type="tel" class="form-control" id="celular" name="celular" value="<%= session.getAttribute("celular") %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="fechanacimiento" class="form-label">Fecha de Nacimiento</label>
                        <input type="date" class="form-control" id="fechanacimiento" name="fechanacimiento" value="<%= session.getAttribute("fechanacimiento") %>" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal para editar foto y nombre -->
<div class="modal fade" id="editarFotoModal" tabindex="-1" aria-labelledby="editarFotoLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarFotoLabel">Actualizar Foto de Perfil y Nombre de Usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="ActualizarFotoYNombre" method="post">
                    <div class="mb-3">
                        <label class="form-label">Elige un Avatar</label>
                        <div class="row">
                            <div class="col-4">
                                <img src="https://scontent.fcja2-1.fna.fbcdn.net/v/t39.30808-6/347786795_155796960807292_3059690283304320469_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=0nr8PPXv9ksQ7kNvgF_ZTlO&_nc_zt=23&_nc_ht=scontent.fcja2-1.fna&_nc_gid=Aidd4304tY3X4o2vdYDqImK&oh=00_AYDJhaqb1gOyFsEcXK59gV9_ZLlpdCRzTPmhLEhCj5B7SA&oe=67127078" class="avatar-option rounded-circle" alt="Avatar 1" onclick="selectAvatar('avatar1')">
                            </div>
                            <div class="col-4">
                                <img src="https://img.freepik.com/psd-gratis/ilustracion-3d-avatar-o-perfil-humano_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1728086400&semt=ais_hybrid" class="avatar-option rounded-circle" alt="Avatar 2" onclick="selectAvatar('avatar2')">
                            </div>
                            <div class="col-4">
                                <img src="https://img.freepik.com/psd-gratis/ilustracion-3d-avatar-o-perfil-humano_23-2150671122.jpg" class="avatar-option rounded-circle" alt="Avatar 3" onclick="selectAvatar('avatar3')">
                            </div>
                            <div class="col-4">
                                <img src="https://via.placeholder.com/100" class="avatar-option rounded-circle" alt="Avatar 4" onclick="selectAvatar('avatar4')">
                            </div>
                            <div class="col-4">
                                <img src="https://via.placeholder.com/100" class="avatar-option rounded-circle" alt="Avatar 5" onclick="selectAvatar('avatar5')">
                            </div>
                            <div class="col-4">
                                <img src="https://via.placeholder.com/100" class="avatar-option rounded-circle" alt="Avatar 6" onclick="selectAvatar('avatar6')">
                            </div>
                        </div>
                        <input type="hidden" id="selectedAvatar" name="selectedAvatar" value="">
                    </div>
                    <div class="mb-3">
                        <label for="nuevoNombre" class="form-label">Nuevo Nombre de Usuario</label>
                        <input type="text" class="form-control" id="nuevoNombre" name="nuevoNombre" value="<%= session.getAttribute("nombreusuario") %>" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Actualizar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function selectAvatar(avatar) {
        // Limpiar la selección anterior
        const avatars = document.querySelectorAll('.avatar-option');
        avatars.forEach((img) => img.classList.remove('selected'));

        // Marcar el avatar seleccionado
        const selectedImg = document.querySelector(`img[alt='${avatar}']`);
        selectedImg.classList.add('selected');

        // Guardar el valor del avatar seleccionado en el campo oculto
        document.getElementById('selectedAvatar').value = avatar;
    }
</script>


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