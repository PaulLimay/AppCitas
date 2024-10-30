package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBConnection;

/**
 * Servlet implementation class GuardarDatosUsuario
 */
public class GuardarDatosUsuario extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String celular = request.getParameter("celular");
        String fechanacimiento = request.getParameter("fechanacimiento");
        String tipo = request.getParameter("tipo");
        String nombreusuario = request.getParameter("nombreusuario");
        String contraseña = request.getParameter("contraseña");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // 1. Cargar el Driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Establecer la conexión con la base de datos
            con = DBConnection.getConnection();

            // 3. Verificar si el nombre de usuario ya existe en las tablas 'usuario' y 'profesional'
            String checkUserQuery = "SELECT nombreusuario FROM usuario WHERE nombreusuario = ? " +
                                     "UNION SELECT nombreusuario FROM profesional WHERE nombreusuario = ?";
            ps = con.prepareStatement(checkUserQuery);
            ps.setString(1, nombreusuario);
            ps.setString(2, nombreusuario);
            rs = ps.executeQuery();

            // 4. Comprobar si el nombre de usuario ya está registrado
            if (rs.next()) {
                // El nombre de usuario ya existe
                request.setAttribute("error", "Nombre de usuario ya registrado. Por favor, elija otro.");
                request.setAttribute("mensaje", "El nombre de usuario ya existe, elija otro."); // Mensaje de error
                request.getRequestDispatcher("Registrar.jsp").forward(request, response);
                return; // Finaliza la ejecución del servlet
            }

            // 5. Verificar si el tipo es "profesional"
            if ("profesional".equals(tipo)) {
                // Obtener el parámetro adicional 'servicio'
                String servicio = request.getParameter("servicio");

                // 6. Si es profesional, definir la consulta SQL para insertar en la tabla 'profesional'
                String query = "INSERT INTO profesional (nombres, apellidos, celular, fechanacimiento, tipo, servicio, nombreusuario, contraseña) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(query);

                // 7. Asignar los valores a los placeholders, incluyendo el nuevo campo 'servicio'
                ps.setString(1, nombres);
                ps.setString(2, apellidos);
                ps.setString(3, celular);
                ps.setString(4, fechanacimiento);
                ps.setString(5, tipo);
                ps.setString(6, servicio);  // Nuevo campo para 'servicio'
                ps.setString(7, nombreusuario);
                ps.setString(8, contraseña);
            } else {
                // 8. Si no es profesional, insertar en la tabla 'usuario'
                String query = "INSERT INTO usuario (nombres, apellidos, celular, fechanacimiento, tipo, nombreusuario, contraseña) VALUES (?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(query);

                // 9. Asignar los valores a los placeholders
                ps.setString(1, nombres);
                ps.setString(2, apellidos);
                ps.setString(3, celular);
                ps.setString(4, fechanacimiento);
                ps.setString(5, tipo);
                ps.setString(6, nombreusuario);
                ps.setString(7, contraseña);
            }

            // 10. Ejecutar la consulta
            int rowsInserted = ps.executeUpdate();

            // 11. Verificar si se insertaron los datos
            if (rowsInserted > 20) {
                System.out.println("Datos guardados exitosamente.");
                response.sendRedirect("mensajeregistroexitoso.jsp");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Driver no encontrado: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error SQL: " + e.getMessage());
        } finally {
            // 12. Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
