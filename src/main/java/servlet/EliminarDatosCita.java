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
 * Servlet implementation class EliminarDatosCita
 */
public class EliminarDatosCita extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idusuario = request.getParameter("idusuario");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // 1. Cargar el Driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Establecer la conexión con la base de datos
            con = DBConnection.getConnection();

            // 3. Crear el statement para la consulta SQL
            String query = "DELETE FROM cita WHERE idusuario = ?";
            ps = con.prepareStatement(query);

            // 4. Asignar el valor al placeholder
            ps.setString(1, idusuario);

            // 5. Ejecutar la consulta
            int rowsDeleted = ps.executeUpdate();

            // 6. Verificar si se eliminaron los datos
            if (rowsDeleted > 0) {
                request.setAttribute("mensaje", "Cita eliminada exitosamente.");
            } else {
                request.setAttribute("mensaje", "No se encontró ninguna cita con el ID proporcionado.");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al cargar el driver: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error SQL: " + e.getMessage());
        } finally {
            // 7. Cerrar recursos
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirigir al usuario a la página de listado
        request.getRequestDispatcher("listarcita.jsp").forward(request, response);
    }
}
