package br.edu.toycenter.services;

import java.util.Collection;
import java.util.List;

import javax.servlet.http.Part;

import br.edu.toycenter.dao.CategoryDAO;
import br.edu.toycenter.model.Category;

public class CategoryService {
	private final CategoryDAO categoryDAO;
	
	public CategoryService() {
		this.categoryDAO = new CategoryDAO();
	}
	
	public List<Category> findAll() {
		return categoryDAO.findAll();
	}
	
	public Category findById(Integer toyId) {
		return categoryDAO.findById(toyId);
	}
	
	public void insert(Category category, Collection<Part> parts) throws NumberFormatException, Exception {
		ValidationFieldService.validationField(category, parts);
		UploadImageService.uploadImage(parts, null, "category");
		categoryDAO.insert(category);
	}
	
	public void update(Integer categoryId, Category category, Collection<Part> parts) throws NumberFormatException, Exception {
		ValidationFieldService.validationField(category, parts);
		UploadImageService.uploadImage(parts, categoryId, "category");
		categoryDAO.update(categoryId, category);
	}
	
	public void delete(Integer categoryId) {
		categoryDAO.delete(categoryId);
	}
}
