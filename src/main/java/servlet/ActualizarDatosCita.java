package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import db.DBConnection; // Importa tu clase de conexión


public class ActualizarDatosCita extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Logger para registrar eventos
    private static final Logger LOGGER = Logger.getLogger(ActualizarDatosCita.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idusuario = request.getParameter("idusuario");
        String idprofesional = request.getParameter("idprofesional");
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        String motivo = request.getParameter("motivo");
        String detalles = request.getParameter("detalles");

        // Registro de información recibida para depuración
        LOGGER.info("Datos recibidos: ID Usuario=" + idusuario + ", ID Profesional=" + idprofesional + ", Fecha=" + fecha + ", Hora=" + hora + ", Motivo=" + motivo + ", Detalles=" + detalles);

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            // Obtener conexión desde la clase de conexión
            con = DBConnection.getConnection();

            // Validar que los campos no sean nulos o vacíos
            if (idusuario == null || idusuario.isEmpty() || idprofesional == null || idprofesional.isEmpty() || fecha == null || fecha.isEmpty() || hora == null || hora.isEmpty()) {
                throw new IllegalArgumentException("ID del usuario, ID del profesional, fecha o hora no pueden estar vacíos.");
            }

            // Actualizar los datos de la cita en la base de datos
            String query = "UPDATE cita SET fecha = ?, hora = ?, motivo = ?, detalles = ? WHERE idusuario = ? AND idprofesional = ?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, fecha);
            stmt.setString(2, hora);
            stmt.setString(3, motivo);
            stmt.setString(4, detalles);
            stmt.setString(5, idusuario);
            stmt.setString(6, idprofesional);

            int rowsUpdated = stmt.executeUpdate();

            // Comprobar si la actualización fue exitosa
            if (rowsUpdated > 0) {
                LOGGER.info("Cita actualizada correctamente para el usuario: " + idusuario);
                request.setAttribute("mensaje", "Cita actualizada correctamente."); // Mensaje de éxito
            } else {
                LOGGER.warning("No se encontró la cita para actualizar. ID Usuario: " + idusuario + ", ID Profesional: " + idprofesional);
                request.setAttribute("mensaje", "No se pudo actualizar la cita. Verifique los datos."); // Mensaje de error
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error SQL al actualizar los datos de la cita", e);
            request.setAttribute("mensaje", "Error en la base de datos: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Datos de entrada no válidos: " + e.getMessage(), e);
            request.setAttribute("mensaje", "Error en los datos de entrada: " + e.getMessage());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error inesperado", e);
            request.setAttribute("mensaje", "Ocurrió un error inesperado: " + e.getMessage());
        } finally {
            // Cerrar recursos en el bloque finally
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error al cerrar la conexión o el statement", e);
            }
        }

        // Redirigir a misCitas.jsp con el mensaje
        request.getRequestDispatcher("mensajeactualizar.jsp").forward(request, response);
    }
}

