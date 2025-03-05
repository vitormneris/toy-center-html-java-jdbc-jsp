package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.toycenter.builder.UserBuilder;
import br.edu.toycenter.enums.RuntimeErrorEnum;
import br.edu.toycenter.exceptions.DatabaseException;
import br.edu.toycenter.model.User;
import br.edu.toycenter.util.ConnectionFactory;

public class UserDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs;

	public UserDAO() {
		conn = ConnectionFactory.getConnection();
	}
	
	private void openConnection() {
		conn = ConnectionFactory.getConnection();
	}

	public List<User> findAll() {
		List<User> list = new ArrayList<>();

		try {
			openConnection();
			ps = conn.prepareStatement("SELECT * FROM user_table");
			rs = ps.executeQuery();

			while (rs.next()) {
				User user = UserBuilder.builder()
						.id(rs.getInt("user_code"))
						.name(rs.getString("user_name"))
						.email(rs.getString("user_email"))
						.password(rs.getString("user_password"))
						.build();
								 
				list.add(user);
			}
			
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
		
		return list;
	}

	public User findById(Integer userId) {	
		User user = new User();

		try {
			openConnection();
			ps = conn.prepareStatement("SELECT * FROM user_table WHERE user_code = ?");
			ps.setInt(1, userId);
			rs = ps.executeQuery();

			if (rs.next()) 
				user = UserBuilder.builder()
						.id(rs.getInt("user_code"))
						.name(rs.getString("user_name"))
						.email(rs.getString("user_email"))
						.password(rs.getString("user_password")).build();				
			
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
		
		return user;
	}

	public void insert(User user) {
		try {						
			openConnection();
			ps = conn.prepareStatement("INSERT INTO user_table (user_name, user_email, user_password) VALUES (?, ?, ?)");
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());

			ps.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0004);
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void update(Integer userId, User user) {
		try {
			openConnection();
			ps = conn.prepareStatement("UPDATE user_table SET user_name = ?, user_email = ?, user_password = ? WHERE user_code = ?");
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setInt(4, userId);
				
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0005);
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void delete(Integer userId) {
		try {			
			openConnection();
			ps = conn.prepareStatement("DELETE FROM user_table WHERE user_code = ?");
			ps.setInt(1, userId);
			
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0006);
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public int countUsersNumber() {
		try {			
			openConnection();
			ps = conn.prepareStatement("SELECT COUNT(*) AS number FROM user_table");
			rs = ps.executeQuery();
			
			while(rs.next()) 
				return rs.getInt("number");
			
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return 0;
	}
 }