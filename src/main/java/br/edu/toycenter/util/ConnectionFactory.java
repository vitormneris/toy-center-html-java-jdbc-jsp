package br.edu.toycenter.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import br.edu.toycenter.enums.RuntimeErrorEnum;
import br.edu.toycenter.exceptions.DatabaseException;

public class ConnectionFactory {
	
	private static final String CLASS_DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/toycenter_db?useSSL=false";
	private static final String USER = "root";
	private static final String PASSWORD = "password";
	
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName(CLASS_DRIVER);
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException | ClassNotFoundException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0001);
		}
		return conn;
	}
	
	public static void closeConnection(Connection conn, Statement stmt, ResultSet rs) {
		close(conn, stmt, rs);
	}
	
	public static void closeConnection(Connection conn, Statement stmt) {
		close(conn, stmt, null);
	}
	
	public static void closeConnection(Connection conn) {
		close(conn, null, null);
	}
	
	public static void close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if (rs != null ) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0002);
		}
	}
}