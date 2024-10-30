<%@page import="db.DBConnection"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Cita</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        // Función para seleccionar un horario
        function seleccionarHorario(idhorario, dia, inicio, fin) {
            // Mostrar el horario seleccionado en el formulario
            document.getElementById("horarioSeleccionado").innerText = dia + ": " + inicio + " - " + fin;
            document.getElementById("diaSeleccionado").value = dia; // Guarda el día
            document.getElementById("horaSeleccionada").value = inicio; // Guarda la hora
            
            // NUEVO: Guarda el inicio en un campo oculto
            document.getElementById("inicioSeleccionado").value = inicio; // Guarda el inicio
            
            // NUEVO: Guarda el fin en un campo oculto
            document.getElementById("finSeleccionado").value = fin; // Guarda el fin
            
            // Guarda el idhorario en un campo oculto
            document.getElementById("idhorarioSeleccionado").value = idhorario; // Guarda el idhorario
            
            // Calcular la fecha del próximo día correspondiente
            const today = new Date();
            const dayOfWeek = today.getDay(); // 0=Domingo, 1=Lunes, ..., 6=Sábado
            
            // Mapear los días de la semana
            const dias = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"];
            const indexDia = dias.indexOf(dia);

            // Calcular los días restantes hasta el próximo día seleccionado
            const daysUntilNext = (indexDia - dayOfWeek + 7) % 7 || 7; // 7 para el próximo día si hoy es ese día
            
            today.setDate(today.getDate() + daysUntilNext);
            
            // Formatear la fecha en formato YYYY-MM-DD
            const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
            const formattedDate = today.toLocaleDateString('en-CA', options).replace(/(\d{2})\/(\d{2})\/(\d{4})/, '$3-$1-$2');

            document.getElementById("fechaSeleccionada").value = formattedDate; // Guarda la fecha
            console.log("Fecha seleccionada:", formattedDate); // Verificar el valor de la fecha
        }
    </script>
</head>
<body>

<header>
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
                        <li class="nav-item"><a class="nav-link" href="listarcita.jsp">Mis Citas</a></li>
                        <li class="nav-item"><a class="nav-link" href="calendario.jsp">Calendario</a></li>
                        <li class="nav-item"><a class="nav-link" href="crearcita.jsp">Crear cita</a></li>
                        <li class="nav-item"><a class="nav-link" href="listarprofesionalesusuario.jsp">Buscar Profesional</a></li>
                        <li class="nav-item"><a class="nav-link" href="perfilusuario.jsp">Mi Perfil</a></li>
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
</header>


<div class="container my-5">
    <div class="card mx-auto">
        <div class="card-header">
            <h5 class="card-title">Registrar Cita</h5>
        </div>
        <div class="card-body">
            <%
                // Obtener el idprofesional de la URL
                String idProfesionalParam = request.getParameter("idprofesional");
                int idprofesional = (idProfesionalParam != null) ? Integer.parseInt(idProfesionalParam) : 0;

                if (idprofesional > 0) {
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DBConnection.getConnection();

                        // Consulta para obtener los horarios disponibles del profesional
                        String sql = "SELECT idhorarios, dia, inicio, fin, estado FROM horarios WHERE idprofesional = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, idprofesional);
                        rs = stmt.executeQuery();
            %>

            <h6>Horarios disponibles:</h6>
            <div class="list-group mb-3">
                <% 
                    // Mostrar cada horario obtenido de la base de datos
                    while (rs.next()) { 
                        int idhorario = rs.getInt("idhorarios"); // Obtener el idhorario
                        String dia = rs.getString("dia");
                        String inicio = rs.getString("inicio");
                        String fin = rs.getString("fin");
                        String estado = rs.getString("estado"); // Obtener el estado del horario
                        String etiquetaEstado = "Disponible"; // Valor por defecto
                        String claseEtiqueta = "badge bg-success"; // Clase de Bootstrap por defecto

                        if ("ocupado".equalsIgnoreCase(estado)) {
                            etiquetaEstado = "Ocupado";
                            claseEtiqueta = "badge bg-danger"; // Clase de Bootstrap para ocupado
                        }
                %>
                    <div class="list-group-item list-group-item-action <%= "ocupado".equalsIgnoreCase(estado) ? "disabled" : "" %>" 
                         onclick="<%= "ocupado".equalsIgnoreCase(estado) ? "return false;" : "seleccionarHorario(" + idhorario + ", '" + dia + "', '" + inicio + "', '" + fin + "');" %>">
                        <strong><%= dia %>:</strong>
                        <span><%= inicio %> - <%= fin %></span>
                        <span class="<%= claseEtiqueta %> ms-2"><%= etiquetaEstado %></span>
                    </div>
                <% 
                    } 
                %>
            </div>

            <h6>Horario Seleccionado:</h6>
            <p id="horarioSeleccionado" class="fw-bold"></p>

            <% 
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger'>Ocurrió un error al conectar con la base de datos: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch(SQLException ignored) {}
                        if (stmt != null) try { stmt.close(); } catch(SQLException ignored) {}
                        if (conn != null) try { conn.close(); } catch(SQLException ignored) {}
                    }
                } else {
            %>
                <div class="alert alert-danger" role="alert">
                    Error: No se ha proporcionado un ID de profesional válido. Por favor, <a href="listarprofesionales.jsp">regrese</a> y seleccione un profesional.
                </div>
            <% 
                } 
            %>

            <!-- Formulario de registro de cita -->
            <form action="GuardarDatosCita" method="POST" onsubmit="return validarFormulario();">
                <input type="hidden" name="idusuario" value="<%= session.getAttribute("idusuario") %>">
                <input type="hidden" name="idprofesional" value="<%= idprofesional %>">

                <!-- Campos ocultos para enviar información al servlet -->
                <input type="hidden" id="diaSeleccionado" name="dia" />
                <input type="hidden" id="horaSeleccionada" name="hora" />
                <input type="hidden" id="fechaSeleccionada" name="fecha" /> <!-- Campo para la fecha -->
                <input type="hidden" id="inicioSeleccionado" name="inicio" /> <!-- NUEVO: Campo oculto para inicio -->
                <input type="hidden" id="finSeleccionado" name="fin" /> <!-- NUEVO: Campo oculto para fin -->
                <input type="hidden" id="idhorarioSeleccionado" name="idhorarios" /> <!-- NUEVO: Campo oculto para idhorario -->

                <div class="mb-3">
                    <label for="motivo" class="form-label">Motivo</label>
                    <input type="text" class="form-control" name="motivo" id="motivo" placeholder="Ingrese el motivo de la cita" required>
                </div>
                <div class="mb-3">
                    <label for="detalles" class="form-label">Detalles</label>
                    <textarea class="form-control" id="detalles" name="detalles" rows="3" placeholder="Ingrese detalles adicionales" required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">Registrar</button>
            </form>

            <script>
                function validarFormulario() {
                    // Verifica si se ha seleccionado un horario
                    const horarioSeleccionado = document.getElementById("horarioSeleccionado").innerText;
                    const fechaSeleccionada = document.getElementById("fechaSeleccionada").value;

                    if (!horarioSeleccionado) {
                        alert("Por favor, seleccione un horario antes de registrar la cita.");
                        return false; // Impide que el formulario se envíe
                    }

                    if (!fechaSeleccionada) {
                        alert("Por favor, seleccione una fecha.");
                        return false; // Impide que el formulario se envíe
                    }

                    console.log("Fecha a enviar:", fechaSeleccionada); // Verifica el valor de la fecha
                    return true; // Permite que el formulario se envíe
                }
            </script>
        </div>
    </div>
</div>

<footer class="bg-dark text-white text-center mt-auto py-4">
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