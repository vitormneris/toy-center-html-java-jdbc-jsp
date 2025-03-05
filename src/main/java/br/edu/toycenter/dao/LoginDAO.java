package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.edu.toycenter.enums.RuntimeErrorEnum;
import br.edu.toycenter.exceptions.DatabaseException;
import br.edu.toycenter.util.ConnectionFactory;

public class LoginDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs;

	public LoginDAO() {
		conn = ConnectionFactory.getConnection();
	}
	
	private void openConnection() {
		conn = ConnectionFactory.getConnection();
	}
	
	public boolean loginUser(String email, String password) {
		try {			
			openConnection();
			ps = conn.prepareStatement("SELECT user_email, user_password FROM user_table");
			rs = ps.executeQuery();
	
			while(rs.next()) {
				String emailDB = rs.getString("user_email");
				String passwordDB = rs.getString("user_password");
				if (emailDB.equals(email)) 
					if (passwordDB.equals(password)) 
						return true;
			}
		} catch (SQLException e) {
			new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return false;
	}
}
