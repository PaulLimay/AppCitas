<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registro</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.9.1/font/bootstrap-icons.min.css">
<style>
body {
	background-color: #f5f5f5;
}

.custom-header {
	background-color: #000000;
	padding: 1rem 0;
}

.custom-footer {
	background-color: #000000;
	color: #fff;
	text-align: center;
	padding: 1rem 0;
}
.alert {
    width: 50%;
    margin: 20px auto;
    padding: 15px;
    border: 1px solid #dc3545; /* Color del borde rojo */
    background-color: #f8d7da; /* Color de fondo rojo claro */
    color: #721c24; /* Color del texto rojo oscuro */
    border-radius: 5px;
    text-align: center;
    position: relative;
}

        .alert::before {
            content: "";
            display: block;
            width: 30px;
            height: 4px;
            background-color: #dc3545;
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
.custom-form {
	background-color: #ffffff;
	border-radius: 8px;
	padding: 2rem;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
	<!-- Encabezado -->
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
                <form class="d-flex ms-auto">
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

<script>
  function closeAlert() {
            var alert = document.getElementById("alert");
            alert.style.display = "none"; // Oculta el mensaje de alerta
        }
</script>

<% 
    String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null) {
%>
    <div id="alert" class="alert" role="alert">
        <button class="close-btn" onclick="closeAlert()">✖</button> <!-- Botón de cerrar -->
        <%= mensaje %>
    </div>
<% 
    }
%>
	<!-- Formulario de Registro -->
	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="custom-form">
					<h2 class="text-center mb-4">Registro</h2>
					<form action="	GuardarDatosUsuario" method="POST">
						<div class="mb-3">
							<label for="nombres" class="form-label">Nombres</label> <input
								type="text" class="form-control" id="nombres" name="nombres"
								required>
						</div>
						<div class="mb-3">
							<label for="apellidos" class="form-label">Apellidos</label> <input
								type="text" class="form-control" id="apellidos" name="apellidos"
								required>
						</div>
						<div class="mb-3">
							<label for="celular" class="form-label">Celular</label> <input
								type="tel" class="form-control" id="celular" name="celular"
								required>
						</div>
						<div class="mb-3">
							<label for="fechaNacimiento" class="form-label">Fecha de
								Nacimiento</label> <input type="date" class="form-control"
								id="fechanacimiento" name="fechanacimiento" required>
						</div>
						<div class="mb-3">
							<label for="tipo" class="form-label">Tipo</label> <select
								class="form-select" id="tipo" name="tipo"
								onchange="toggleProfessionalFields()" required>
								<option value="">Seleccione tipo</option>
								<option value="usuario">Usuario</option>
								<option value="profesional">Profesional</option>
							</select>
						</div>
						<div id="professionalFields" style="display: none;">
							<div class="mb-3">
								<label for="servicio" class="form-label">Servicio</label> <select
									class="form-select" id="servicio" name="servicio">
									<option value="">Seleccione servicio</option>
									<option value="plomero">Plomero</option>
									<option value="electricista">Electricista</option>
									<option value="carpintero">Carpintero</option>
									<option value="fontanero">Fontanero</option>
									<option value="jardinero">Jardinero</option>
									<option value="pintor">Pintor</option>
									<option value="mecánico">Mecánico</option>
									<option value="constructor">Constructor</option>
									<option value="herrero">Herrero</option>
									<option value="albañil">Albañil</option>
									<option value="arquitecto">Arquitecto</option>
									<option value="diseñador">Diseñador</option>
									<option value="abogado">Abogado</option>
									<option value="contador">Contador</option>
									<option value="médico">Médico</option>
									<option value="enfermero">Enfermero</option>
									<option value="profesor">Profesor</option>
									<option value="ingeniero">Ingeniero</option>
									<option value="psicólogo">Psicólogo</option>
									<option value="odontólogo">Odontólogo</option>

									<!-- Agrega más opciones según tus necesidades -->
								</select>
							</div>
						</div>
						<div class="mb-3">
							<label for="usuario" class="form-label">Nombre de Usuario</label>
							<input type="text" class="form-control" id="nombreusuario"
								name="nombreusuario" required>
						</div>
						<div class="mb-3">
							<label for="contraseña" class="form-label">Contraseña</label> <input
								type="password" class="form-control" id="contraseña"
								name="contraseña" required>
						</div>
						<button type="submit" class="btn btn-dark w-100">Registrarse</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Pie de página -->
	<footer class="custom-footer">
		<h5>Agendame</h5>
		<ul class="list-unstyled d-flex justify-content-center mb-3">
			<li class="mx-3"><a href="#about"
				class="text-white text-decoration-none">Acerca de</a></li>
			<li class="mx-3"><a href="#services"
				class="text-white text-decoration-none">Servicios</a></li>
			<li class="mx-3"><a href="#contact"
				class="text-white text-decoration-none">Contacto</a></li>
		</ul>
		<ul class="list-unstyled d-flex justify-content-center mb-3">
			<li class="mx-3"><a href="https://www.facebook.com"
				target="_blank" class="text-white"><i class="bi bi-facebook"></i></a></li>
			<li class="mx-3"><a href="https://www.twitter.com"
				target="_blank" class="text-white"><i class="bi bi-twitter"></i></a></li>
			<li class="mx-3"><a href="https://www.instagram.com"
				target="_blank" class="text-white"><i class="bi bi-instagram"></i></a></li>
		</ul>
		<p class="mb-0">© 2024 Nombre de tu Sitio Web. Todos los derechos
			reservados.</p>
	</footer>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function toggleProfessionalFields() {
			var tipo = document.getElementById('tipo').value;
			var professionalFields = document
					.getElementById('professionalFields');
			professionalFields.style.display = tipo === 'profesional' ? 'block'
					: 'none';
		}
	</script>
</body>
</html>
