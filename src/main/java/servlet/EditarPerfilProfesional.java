package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import db.DBConnection; // Importa tu clase de conexión

public class EditarPerfilProfesional extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Logger para registrar eventos
    private static final Logger LOGGER = Logger.getLogger(EditarPerfilProfesional.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idprofesional = request.getParameter("idprofesional"); // ID no editable
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String celular = request.getParameter("celular");
        String fechanacimiento = request.getParameter("fechanacimiento");
        String tipo = request.getParameter("tipo");
        String servicio = request.getParameter("servicio");

        // Registro de información recibida para depuración
        LOGGER.info("Datos recibidos: ID Profesional=" + idprofesional + ", Nombres=" + nombres + ", Apellidos=" + apellidos + ", Celular=" + celular + ", Fecha de Nacimiento=" + fechanacimiento + ", Tipo=" + tipo + ", Servicio=" + servicio);

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            // Obtener conexión desde la clase de conexión
            con = DBConnection.getConnection();

            // Validar que los campos no sean nulos o vacíos
            if (idprofesional == null || idprofesional.isEmpty() || nombres == null || nombres.isEmpty() ||
                apellidos == null || apellidos.isEmpty() || celular == null || celular.isEmpty() ||
                fechanacimiento == null || fechanacimiento.isEmpty() || tipo == null || tipo.isEmpty() ||
                servicio == null || servicio.isEmpty()) {
                throw new IllegalArgumentException("Todos los campos deben ser completados.");
            }

            // Actualizar los datos del profesional en la base de datos
            String query = "UPDATE profesional SET nombres = ?, apellidos = ?, celular = ?, fechanacimiento = ?, tipo = ?, servicio = ? WHERE idprofesional = ?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, nombres);
            stmt.setString(2, apellidos);
            stmt.setString(3, celular);
            stmt.setString(4, fechanacimiento);
            stmt.setString(5, tipo);
            stmt.setString(6, servicio);
            stmt.setString(7, idprofesional);

            int rowsUpdated = stmt.executeUpdate();

            // Comprobar si la actualización fue exitosa
            if (rowsUpdated > 0) {
                LOGGER.info("Perfil profesional actualizado correctamente para el ID: " + idprofesional);
                request.setAttribute("mensaje", "Datos actualizados correctamente."); // Mensaje de éxito

                // Actualizar los datos en la sesión (opcional)
                HttpSession session = request.getSession();
                session.setAttribute("nombres", nombres);
                session.setAttribute("apellidos", apellidos);
                session.setAttribute("celular", celular);
                session.setAttribute("fechanacimiento", fechanacimiento);
                session.setAttribute("tipo", tipo);
                session.setAttribute("servicio", servicio);
            } else {
                LOGGER.warning("No se encontró el profesional para actualizar. ID Profesional: " + idprofesional);
                request.setAttribute("mensaje", "No se pudo actualizar el perfil. Verifique los datos."); // Mensaje de error
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error SQL al actualizar los datos del profesional", e);
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

        // Redirigir a perfilprofesional.jsp con el mensaje
        request.getRequestDispatcher("perfilprofesional.jsp").forward(request, response);
    }
}
