package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.toycenter.builder.CategoryBuilder;
import br.edu.toycenter.builder.ToyBuilder;
import br.edu.toycenter.enums.RuntimeErrorEnum;
import br.edu.toycenter.exceptions.DatabaseException;
import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;
import br.edu.toycenter.util.ConnectionFactory;

public class ToyDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs; 
	
	private void openConnection() {
		conn = ConnectionFactory.getConnection();
	}
	
	public List<Toy> findAll() {
		List<Toy> toyList = new ArrayList<>();
		ToyBuilder toyBuilder = new ToyBuilder();

		try {
			openConnection();
			ps = conn.prepareStatement("SELECT * FROM toy_table");
			rs = ps.executeQuery();

			while (rs.next()) {			
				Toy toy = toyBuilder.builder()
						.id(rs.getInt("toy_code"))
						.image(rs.getString("toy_image"))
						.name(rs.getString("toy_name"))
						.brand(rs.getString("toy_brand"))
						.price(rs.getBigDecimal("toy_price"))
						.description(rs.getString("toy_description"))
						.details(rs.getString("toy_details")).build();
				
				toy.setCategories(getCategoriesByToyId(toy.getId()));
				
				toyList.add(toy);
			}
			
			return toyList;
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public Toy findById(Integer toyId) {
		Toy toy = new Toy();
		ToyBuilder toyBuilder = new ToyBuilder();

		try {
			openConnection();
			ps = conn.prepareStatement("SELECT * FROM toy_table WHERE toy_code = ?");
			ps.setInt(1, toyId);
			rs = ps.executeQuery();

			if (rs.next()) {			
				toy = toyBuilder.builder()
						.id(rs.getInt("toy_code"))
						.image(rs.getString("toy_image"))
						.name(rs.getString("toy_name"))
						.brand(rs.getString("toy_brand"))
						.price(rs.getBigDecimal("toy_price"))
						.description(rs.getString("toy_description"))
						.details(rs.getString("toy_details")).build();
				
				toy.setCategories(getCategoriesByToyId(toy.getId()));
			}

			return toy;
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public List<Category> getCategoriesByToyId(Integer toyId) {
		List<Category> categories = new ArrayList<>();

		try {
			String querySql = "SELECT DISTINCT c.category_code, c.category_name, c.category_image "
					+ "FROM category_table c "
					+ "INNER JOIN toy_category tc ON tc.category_code_fk = c.category_code "
					+ "INNER JOIN toy_table t ON tc.toy_code_fk = ?;";
			
			PreparedStatement ps = conn.prepareStatement(querySql);
			ps.setInt(1, toyId);
			ResultSet rs = ps.executeQuery();
						
			while (rs.next()) {				
				Category category = CategoryBuilder.builder()
						.id(rs.getInt("category_code"))
						.name(rs.getString("category_name"))
						.image(rs.getString("category_image")).build();
				
				categories.add(category);
			}
			
			return categories; 	
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			//ConnectionFactory.closeConnection(null, ps, rs);
		}
	}

	public void insert(Toy toy) {
		try {
			String querySql = "INSERT INTO toy_table "
				       + "(toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) "
					   + "VALUES(?, ?, ?, ?, ?, ?)";
			
			openConnection();
			ps = conn.prepareStatement(querySql);
			ps.setString(1, toy.getImage());
			ps.setString(2, toy.getName());
			ps.setString(3, toy.getBrand());
			ps.setBigDecimal(4, toy.getPrice());
			ps.setString(5, toy.getDescription());
			ps.setString(6, toy.getDetails());
			
			if (ps.executeUpdate() > 0) {	
				for (Category category : toy.getCategories()) {
					ps = conn.prepareStatement("INSERT INTO toy_category (toy_code_fk, category_code_fk) VALUES (?, ?)");
					ps.setInt(1, getIdOfLastToyInserted());
					ps.setInt(2, category.getId());
					ps.executeUpdate();
				}
			} 
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0004);
		}  finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Integer getIdOfLastToyInserted() {
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT toy_code FROM toy_table WHERE toy_code = LAST_INSERT_ID()");
			ResultSet rs = ps.executeQuery();

			while (rs.next())
				return rs.getInt("toy_code");
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} 
		return 0;
	}
	
	public void update(Integer toyId, Toy toy) {
		try {

			String querySql = "UPDATE toy_table "
				   	   + "SET toy_image = ?, toy_name = ?, toy_brand = ?, toy_price = ?, toy_description = ?, toy_details = ? "
					   + "WHERE toy_code = ?";
			
			openConnection();
			ps = conn.prepareStatement(querySql);
			ps.setString(1, toy.getImage());
			ps.setString(2, toy.getName());
			ps.setString(3, toy.getBrand());
			ps.setBigDecimal(4, toy.getPrice());
			ps.setString(5, toy.getDescription());
			ps.setString(6, toy.getDetails());
			ps.setInt(7, toyId);
				
			if (ps.executeUpdate() > 0) {
				ps = conn.prepareStatement("DELETE FROM toy_category WHERE toy_code_fk = ?");
				ps.setInt(1, toyId);
				
				if (ps.executeUpdate() > 0) {
					for (Category category : toy.getCategories()) {
						ps = conn.prepareStatement("INSERT INTO toy_category (toy_code_fk, category_code_fk) VALUES (?, ?)");
						ps.setInt(1, toyId);
						ps.setInt(2, category.getId());
						ps.executeUpdate();
					}
				}
			}
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0005);
		}  finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void delete(Integer toyId) {
		try {
			openConnection();
			ps = conn.prepareStatement("DELETE FROM toy_category WHERE toy_code_fk = ?");
			ps.setInt(1, toyId);
			
			if (ps.executeUpdate() > 0) {
				ps = conn.prepareStatement("DELETE FROM toy_table WHERE toy_code = ?");
				ps.setInt(1, toyId);
				ps.executeUpdate();
			}
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0006);
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
}