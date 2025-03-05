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
import br.edu.toycenter.model.ToyCategory;
import br.edu.toycenter.util.ConnectionFactory;

public class CategoryDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs; 

	public CategoryDAO() {
	}
	
	private void openConnection() {
		conn = ConnectionFactory.getConnection();
	}
	
	public List<Category> findAll() {
		List<Category> categoryList = new ArrayList<>();
		Category category = new Category();

		try {
			openConnection();
			ps = conn.prepareStatement("SELECT * FROM category_table");
			rs = ps.executeQuery();
			
			while (rs.next()) {
				category = CategoryBuilder.builder()
						.id(rs.getInt("category_code"))
						.name(rs.getString("category_name"))
						.image(rs.getString("category_image")).build();
				
				category.setToys(getToysByCategoryId(category.getId()));
				categoryList.add(category);	
			}
			
			return categoryList;
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		}  finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public Category findById(Integer categoryId) {
		Category category = new Category();

		try {
			openConnection();
			ps = conn.prepareStatement("SELECT * FROM category_table WHERE category_code = ?");
			ps.setInt(1, categoryId);
			rs = ps.executeQuery();
			
			if (rs.next()) 
				category = CategoryBuilder.builder()
						.id(rs.getInt("category_code"))
						.name(rs.getString("category_name"))
						.image(rs.getString("category_image")).build();
			
				category.setToys(getToysByCategoryId(category.getId()));
			
			return category;
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public List<Toy> getToysByCategoryId(Integer categoryId) {
		List<Toy> toys = new ArrayList<>();
		
		try {
			String querySql = "SELECT DISTINCT t.toy_code, t.toy_image, t.toy_name, t.toy_brand, t.toy_price, t.toy_description, t.toy_details "
					     + "FROM toy_table t " 
				       	 + "INNER JOIN toy_category tc ON tc.toy_code_fk = t.toy_code "
					     + "INNER JOIN category_table c ON tc.category_code_fk = ?";
			
			PreparedStatement ps = conn.prepareStatement(querySql);
			ps.setInt(1, categoryId);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				Toy toy = ToyBuilder.builder()
						.id(rs.getInt("toy_code"))
						.image(rs.getString("toy_image"))
						.name(rs.getString("toy_name"))
						.brand(rs.getString("toy_brand"))
						.price(rs.getBigDecimal("toy_price"))
						.description(rs.getString("toy_description"))
						.details(rs.getString("toy_details")).build();
				toys.add(toy);
			}
			
			return toys; 	
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		} finally {
			//ConnectionFactory.closeConnection(null, ps, rs);
		}
	}

	public void insert(Category category) {
		try {			
			openConnection();
			ps = conn.prepareStatement("INSERT INTO category_table (category_name, category_image) VALUES (?, ?)");	
			ps.setString(1, category.getName());
			ps.setString(2, category.getImage());

			ps.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0004);
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void update(Integer categoryId, Category category) {
		try {			
			openConnection();
			ps = conn.prepareStatement("UPDATE category_table SET category_name = ?, category_image = ? WHERE category_code = ?");
			ps.setString(1, category.getName());
			ps.setString(2, category.getImage());
			ps.setInt(3, categoryId);
				
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0005);
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void delete(Integer categoryId) {
		ToyDAO toyDAO = new ToyDAO();
		try {		
			openConnection();

			boolean status = false;
			for (ToyCategory toyCategoryRegisters : findAllToyCategoryRegisters()) {
				if (toyCategoryRegisters.getCategoryId() == categoryId) {
					status = true;
					break;
				}
			}
			
			if (status) {	
				ps = conn.prepareStatement("DELETE FROM toy_category WHERE category_code_fk = ?");
				ps.setInt(1, categoryId);
				ps.executeUpdate();
				
				for (Toy toy : toyDAO.findAll()) 
					if (toy.getCategories().size() == 0) 
						toyDAO.delete(toy.getId());
			}
			
			ps = conn.prepareStatement("DELETE FROM category_table WHERE category_code = ?");
			ps.setInt(1, categoryId);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0006);
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public List<ToyCategory> findAllToyCategoryRegisters() {
		List<ToyCategory> listToyCategoryRegisters = new ArrayList<>();

		try {
			openConnection();
			ps = conn.prepareStatement("SELECT * FROM toy_category");
			rs = ps.executeQuery();

			while (rs.next()) 
				listToyCategoryRegisters.add(new ToyCategory(rs.getInt("toy_code_fk"), rs.getInt("category_code_fk")));
			
			return listToyCategoryRegisters;
		} catch (SQLException e) {
			throw new DatabaseException(RuntimeErrorEnum.ERR0003);
		}  finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
}