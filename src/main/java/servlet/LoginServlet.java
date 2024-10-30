package servlet;

import db.DBConnection; // Importa la clase DBConnection
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreusuario = request.getParameter("nombreusuario");
        String contraseña = request.getParameter("contraseña");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Obtener la conexión usando la clase DBConnection
            con = DBConnection.getConnection();

            // Verificar en la tabla usuario
            String query = "SELECT idusuario, nombreusuario, nombres, apellidos, celular, fechanacimiento, tipo, fotoperfil FROM usuario WHERE nombreusuario = ? AND contraseña = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, nombreusuario);
            ps.setString(2, contraseña);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Usuario encontrado en la tabla usuario
                int idusuario = rs.getInt("idusuario");
                System.out.println("Usuario encontrado con ID: " + idusuario);

                // Almacenar el ID y otros datos en la sesión
                HttpSession session = request.getSession();
                session.setAttribute("idusuario", idusuario);
                session.setAttribute("nombreusuario", rs.getString("nombreusuario"));
                session.setAttribute("nombres", rs.getString("nombres"));
                session.setAttribute("apellidos", rs.getString("apellidos"));
                session.setAttribute("celular", rs.getString("celular"));
                session.setAttribute("fechanacimiento", rs.getString("fechanacimiento"));
                session.setAttribute("tipo", rs.getString("tipo"));
                session.setAttribute("fotoperfil", rs.getString("fotoperfil")); // Almacenar foto de perfil del usuario

                // Redirigir a la página de perfil de usuario
                response.sendRedirect("perfilusuario.jsp");
                return;
            }

            // Verificar en la tabla profesional
            query = "SELECT idprofesional, nombreusuario, nombres, apellidos, celular, fechanacimiento, tipo, servicio, fotoperfil FROM profesional WHERE nombreusuario = ? AND contraseña = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, nombreusuario);
            ps.setString(2, contraseña);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Usuario encontrado en la tabla profesional
                int idprofesional = rs.getInt("idprofesional");
                System.out.println("Profesional encontrado con ID: " + idprofesional);

                // Almacenar el ID y otros datos en la sesión
                HttpSession session = request.getSession();
                session.setAttribute("idprofesional", idprofesional);
                session.setAttribute("nombreusuario", rs.getString("nombreusuario"));
                session.setAttribute("nombres", rs.getString("nombres"));
                session.setAttribute("apellidos", rs.getString("apellidos"));
                session.setAttribute("celular", rs.getString("celular"));
                session.setAttribute("fechanacimiento", rs.getString("fechanacimiento"));
                session.setAttribute("tipo", rs.getString("tipo"));
                session.setAttribute("servicio", rs.getString("servicio"));
                session.setAttribute("fotoperfil", rs.getString("fotoperfil")); // Almacenar foto de perfil del profesional

                // Redirigir a la página de perfil profesional
                response.sendRedirect("perfilprofesional.jsp");
                return;
            }

            // Si no se encontró en ninguna tabla, establecer el mensaje de error
            request.setAttribute("errorMessage", "Nombre de usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error en la consulta de la base de datos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) DBConnection.closeConnection();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

