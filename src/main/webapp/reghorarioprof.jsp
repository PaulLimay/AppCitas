<%@page import="db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registrar Horario</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.9.1/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
body {
	background-color: #f8f9fa;
}

.container {
	background: white;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-top: 50px;
}

h2 {
	color: #343a40;
}

.form-label {
	font-weight: bold;
	color: #495057;
}

.btn-primary {
	background-color: #007bff;
	border: none;
}

.btn-primary:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div style="background-color: #000000;">
		<div class="text-center py-3"
			style="background: linear-gradient(to bottom, #fafafa, #f5f5f5);">
			<img src="https://i.ibb.co/M1xqhhQ/logo-citas.png"
				class="img-fluid img-rounded" alt="Logo" width="900" height="250">
		</div>

		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container-fluid">
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav me-auto">
						<li class="nav-item"><a class="nav-link active"
							href="reghorarioprof.jsp">Gestionar Horarios</a></li>
						<li class="nav-item"><a class="nav-link"
							href="listarcita.jsp">Citas</a></li>
						<li class="nav-item"><a class="nav-link"
							href="calendario.jsp">Calendario</a></li>
						<li class="nav-item"><a class="nav-link"
							href="perfilprofesional.jsp">Mi perfil</a></li>
					</ul>
					<!-- Avatar del usuario y nombre -->
					<ul class="navbar-nav ms-3">
						<li class="nav-item d-flex align-items-center">
							<div class="dropdown">
								<button class="btn p-0" data-bs-toggle="dropdown"
									aria-expanded="false" style="border: none; background: none;">
									<img
										src="<%=session.getAttribute("fotoperfil") != null ? session.getAttribute("fotoperfil")
		: "https://via.placeholder.com/40"%>"
										class="rounded-circle" alt="Avatar" width="40" height="40">
								</button>
								<ul class="dropdown-menu dropdown-menu-end">
									<li><a class="dropdown-item" href="perfilprofesional.jsp">Mi
											perfil</a></li>
									<li><a class="dropdown-item" href="eliminarcuenta.jsp">Eliminar
											Cuenta</a></li>
									<li><a class="dropdown-item" href="CerrarSesion">Cerrar
											Sesión</a></li>
								</ul>
							</div> <span class="text-white ms-2"><%=session.getAttribute("nombreusuario")%></span>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</div>

	<div class="container mt-5 p-4">
		<h2 class="text-center">Registrar Horario</h2>
		<form action="GuardarHorario" method="post">
			<%
			Integer idprofesional = (Integer) request.getSession().getAttribute("idprofesional");
			%>
			<input type="hidden" name="idprofesional"
				value="<%=idprofesional%>">

			<div class="mb-3">
				<label for="dia" class="form-label">Selecciona el Día:</label> <select
					class="form-select" id="dia" name="dia" required>
					<option value="">Seleccionar</option>
					<option value="Lunes">Lunes</option>
					<option value="Martes">Martes</option>
					<option value="Miércoles">Miércoles</option>
					<option value="Jueves">Jueves</option>
					<option value="Viernes">Viernes</option>
					<option value="Sábado">Sábado</option>
					<option value="Domingo">Domingo</option>
				</select>
			</div>
			<div class="mb-3">
				<label for="inicio" class="form-label">Hora de Inicio:</label> <input
					type="time" class="form-control" id="inicio" name="inicio" required>
			</div>
			<div class="mb-3">
				<label for="fin" class="form-label">Hora de Fin:</label> <input
					type="time" class="form-control" id="fin" name="fin" required>
			</div>
			<button type="submit" class="btn btn-primary btn-block">
				Registrar Horario <i class="fas fa-clock"></i>
			</button>
		</form>

		<h3 class="mt-5">Horarios Registrados</h3>

		<%
		String success = request.getParameter("success");
		String error = request.getParameter("error");

		if ("true".equals(success)) {
		%>
		<div class="alert alert-success alert-dismissible fade show"
			role="alert">
			Nuevo horario registrado con éxito.
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		} else if ("false".equals(success)) {
		if ("exists".equals(error)) {
		%>
		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">
			Este horario ya existe. Por favor, elige otro.
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		} else {
		%>
		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">
			Error al registrar el horario.
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		}
		%>

		<table class="table table-striped mt-3">
			<thead>
				<tr>
					<th>Día</th>
					<th>Hora de Inicio</th>
					<th>Hora de Fin</th>
					<th>Estado</th>
				</tr>
			</thead>
			<tbody>
    <%
    String newHorarioId = request.getParameter("newHorarioId");
    int newHorarioIdInt = -1;
    if (newHorarioId != null) {
        try {
            newHorarioIdInt = Integer.parseInt(newHorarioId);
        } catch (NumberFormatException e) {
            newHorarioIdInt = -1;
        }
    }

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement preparedStatement = connection
                 .prepareStatement("SELECT * FROM horarios WHERE idprofesional = ?")) {

        preparedStatement.setInt(1, idprofesional);
        try (ResultSet resultSet = preparedStatement.executeQuery()) {

            boolean hasRows = false;
            while (resultSet.next()) {
                hasRows = true;
                int horarioId = resultSet.getInt("idhorarios");
                boolean isNew = newHorarioIdInt != -1 && newHorarioIdInt == horarioId;
    %>
    <tr <%=isNew ? "class='table-success'" : ""%>>
        <td><%=resultSet.getString("dia")%></td>
        <td><%=resultSet.getString("inicio")%></td>
        <td><%=resultSet.getString("fin")%></td>
        <td>
            <% if (isNew) { %>
                <span class="badge bg-success">Nuevo</span>
            <% } %>
        </td>
    </tr>
    <%
            }
            if (!hasRows) {
    %>
    <tr>
        <td colspan="4" class="text-center">No hay horarios registrados.</td>
    </tr>
    <%
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    %>
</tbody>
		</table>
	</div>



</body>
<footer class="bg-dark text-white text-center mt-5 py-4">
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

</html>
