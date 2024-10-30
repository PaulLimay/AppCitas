<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendario de Citas</title>

    <!-- FullCalendar -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/index.global.min.js'></script>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.9.1/font/bootstrap-icons.min.css">

    <style>
      .calendar-container {
        max-width: 900px;
        margin: 50px auto;
        background-color: #f8f9fa;
        border: 1px solid #000;
        padding: 20px;
        border-radius: 10px;
      }
        .avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
  }
    </style>
<head>
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
          <li class="nav-item"><a class="nav-link" href="reghorarioprof.jsp">Gestionar Horarios</a></li>
          <li class="nav-item"><a class="nav-link" href="listarcita.jsp">Citas</a></li>
          <li class="nav-item"><a class="nav-link active" href="calendario.jsp">Calendario</a></li>
          <li class="nav-item"><a class="nav-link" href="perfilprofesional.jsp">Mi perfil</a></li>
        </ul>
        <!-- Avatar del usuario y nombre -->
        <ul class="navbar-nav ms-3">
          <li class="nav-item d-flex align-items-center">
            <div class="dropdown">
              <button class="btn p-0" data-bs-toggle="dropdown" aria-expanded="false" style="border: none; background: none;">
                <img src="<%= session.getAttribute("fotoperfil") != null ? session.getAttribute("fotoperfil") : "https://via.placeholder.com/40" %>" class="rounded-circle" alt="Avatar" width="40" height="40">
              </button>
              <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="perfilprofesional.jsp">Mi perfil</a></li>
                <li><a class="dropdown-item" href="eliminarcuenta.jsp">Eliminar Cuenta</a></li>
                <li><a class="dropdown-item" href="CerrarSesion">Cerrar Sesión</a></li>
              </ul>
            </div>
            <span class="text-white ms-2"><%= session.getAttribute("nombreusuario") %></span> <!-- Nombre del usuario -->
          </li>
        </ul>
      </div>
    </div>
  </nav>
</div>

</head>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        
        // Inicialización del calendario
        const calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',  // Mostrar la vista mensual
          locale: 'es',  // Idioma español
          selectable: true,  // Permite seleccionar fechas
          dateClick: function(info) {
            // Al hacer clic en una fecha, se abrirá el modal para añadir una cita
            document.getElementById('dateSelected').value = info.dateStr;
            var myModal = new bootstrap.Modal(document.getElementById('addEventModal'), {
              keyboard: false
            });
            myModal.show();
          },
          events: [] // Lista de eventos vacía que se llenará dinámicamente
        });

        calendar.render();

        // Función para guardar y añadir eventos al calendario
        document.getElementById('saveEventBtn').addEventListener('click', function() {
          const eventName = document.getElementById('eventName').value;
          const eventDescription = document.getElementById('eventDescription').value;
          const eventTime = document.getElementById('eventTime').value;
          const eventDate = document.getElementById('dateSelected').value;

          if (eventName && eventTime) {
            // Formatear la hora de inicio del evento
            const start = `${eventDate}T${eventTime}`;
            
            // Añadir el evento al calendario
            calendar.addEvent({
              title: eventName,
              start: start,
              description: eventDescription
            });

            // Cierra el modal
            var modal = bootstrap.Modal.getInstance(document.getElementById('addEventModal'));
            modal.hide();

            // Limpiar el formulario
            document.getElementById('eventForm').reset();
          } else {
            alert('Por favor, complete todos los campos obligatorios.');
          }
        });
      });
    </script>
  </head>
  <body>
    <div class="container text-center mt-5">
      <h1 class="display-4">Calendario Online</h1>
     
    </div>

    <!-- Contenedor del Calendario -->
    <div class="calendar-container">
      <div id='calendar'></div>
    </div>

    <!-- Modal para añadir una cita -->
    <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addEventModalLabel">Añadir Cita</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="eventForm">
              <div class="mb-3">
                <label for="dateSelected" class="form-label">Fecha</label>
                <input type="text" class="form-control" id="dateSelected" readonly>
              </div>
              <div class="mb-3">
                <label for="eventName" class="form-label">Nombre del Evento</label>
                <input type="text" class="form-control" id="eventName" required>
              </div>
              <div class="mb-3">
                <label for="eventDescription" class="form-label">Descripción</label>
                <textarea class="form-control" id="eventDescription" rows="3"></textarea>
              </div>
              <div class="mb-3">
                <label for="eventTime" class="form-label">Hora</label>
                <input type="time" class="form-control" id="eventTime" required>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-primary" id="saveEventBtn">Guardar Cita</button>
          </div>
        </div>
      </div>
    </div>
  </body>
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
</html>
