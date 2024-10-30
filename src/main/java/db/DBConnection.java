package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	 private static final String URL = "jdbc:mysql://localhost:3306/paginacitas"; // Cambia esto según tu configuración
	    private static final String USER = "root"; // Usuario de la base de datos
	    private static final String PASSWORD = "200229"; // Contraseña de la base de datos
	    private static Connection connection = null;

	    public static Connection getConnection() throws SQLException {
	        if (connection == null || connection.isClosed()) {
	            try {
	                Class.forName("com.mysql.cj.jdbc.Driver"); // Asegúrate de usar el driver correcto
	                connection = DriverManager.getConnection(URL, USER, PASSWORD);
	            } catch (ClassNotFoundException | SQLException e) {
	                e.printStackTrace();
	                throw new SQLException("Error al conectar a la base de datos.", e);
	            }
	        }
	        return connection;
	    }

	    public static void closeConnection() throws SQLException {
	        if (connection != null && !connection.isClosed()) {
	            connection.close();
	        }
	    }
	}