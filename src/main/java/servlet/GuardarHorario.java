package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import db.DBConnection;

public class GuardarHorario extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dia = request.getParameter("dia");
        String inicio = request.getParameter("inicio");
        String fin = request.getParameter("fin");
        Integer idprofesional = Integer.parseInt(request.getParameter("idprofesional"));

        Connection connection = null;
        PreparedStatement psCheck = null;
        PreparedStatement psInsert = null;
        ResultSet rs = null;

        try {
            connection = DBConnection.getConnection();

            // Verificar si el horario ya existe
            String checkQuery = "SELECT COUNT(*) FROM horarios WHERE idprofesional = ? AND dia = ? AND inicio = ? AND fin = ?";
            psCheck = connection.prepareStatement(checkQuery);
            psCheck.setInt(1, idprofesional);
            psCheck.setString(2, dia);
            psCheck.setString(3, inicio);
            psCheck.setString(4, fin);

            rs = psCheck.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                // Si el horario ya existe, redirigir con mensaje de error
                response.sendRedirect("reghorarioprof.jsp?success=false&error=exists");
            } else {
                // Insertar el nuevo horario y obtener el ID generado
                String insertQuery = "INSERT INTO horarios (idprofesional, dia, inicio, fin) VALUES (?, ?, ?, ?)";
                psInsert = connection.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                psInsert.setInt(1, idprofesional);
                psInsert.setString(2, dia);
                psInsert.setString(3, inicio);
                psInsert.setString(4, fin);

                int result = psInsert.executeUpdate();
                
                if (result > 0) {
                    // Obtener el ID del nuevo horario registrado
                    rs = psInsert.getGeneratedKeys();
                    int newHorarioId = -1;
                    if (rs.next()) {
                        newHorarioId = rs.getInt(1);
                    }
                    // Redirigir con éxito y pasar el ID del nuevo horario
                    response.sendRedirect("reghorarioprof.jsp?success=true&newHorarioId=" + newHorarioId);
                } else {
                    // Enviar mensaje de error si ocurrió un problema al insertar
                    response.sendRedirect("reghorarioprof.jsp?success=false");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("reghorarioprof.jsp?success=false");
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (psCheck != null) psCheck.close();
                if (psInsert != null) psInsert.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
