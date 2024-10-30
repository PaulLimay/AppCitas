package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import db.DBConnection;

/**
 * Servlet implementation class GuardarDatosCita
 */
public class GuardarDatosCita extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idusuario = request.getParameter("idusuario");
        String idprofesional = request.getParameter("idprofesional");
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        String motivo = request.getParameter("motivo");
        String detalles = request.getParameter("detalles");
        String idhorario = request.getParameter("idhorarios"); // Obtener el idhorario

        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement psUpdate = null;

        try {
            // 1. Cargar el Driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Establecer la conexión con la base de datos
            con = DBConnection.getConnection();

            // 3. Crear el statement para la consulta SQL para insertar la cita
            String query = "INSERT INTO cita (idusuario, idprofesional, fecha, hora, motivo, detalles) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);

            // 4. Asignar los valores a los placeholders
            ps.setString(1, idusuario);
            ps.setString(2, idprofesional);
            ps.setString(3, fecha);
            ps.setString(4, hora);
            ps.setString(5, motivo);
            ps.setString(6, detalles);

            // 5. Ejecutar la consulta para insertar la cita
            int rowsInserted = ps.executeUpdate();

            // 6. Verificar si se insertaron los datos
            if (rowsInserted > 0) {
                System.out.println("Datos guardados exitosamente.");

                // Actualizar el estado del horario a 'ocupado'
                String updateQuery = "UPDATE horarios SET estado = 'ocupado' WHERE idhorarios = ?";
                psUpdate = con.prepareStatement(updateQuery);
                psUpdate.setString(1, idhorario);
                psUpdate.executeUpdate();
            }

            // Redirigir al usuario a la página de listado
            response.sendRedirect("mensajeregistrocita.jsp");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Driver no encontrado: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error SQL: " + e.getMessage());
        } finally {
            // 7. Cerrar recursos
            try {
                if (ps != null) ps.close();
                if (psUpdate != null) psUpdate.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
