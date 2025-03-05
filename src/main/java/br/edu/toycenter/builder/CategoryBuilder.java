package br.edu.toycenter.builder;

import java.util.List;

import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;

public class CategoryBuilder {
	private static Category category;
	
	private CategoryBuilder() {
	}
	
	public static CategoryBuilder builder() {
		category = new Category();
		return new CategoryBuilder();
	}
	
	public CategoryBuilder id(Integer id) {
		category.setId(id);
		return this;
	}
	
	public CategoryBuilder name(String name) {
		category.setName(name);
		return this;
	}
	
	public CategoryBuilder image(String image) {
		category.setImage(image);
		return this;
	}
	
	public CategoryBuilder toys(List<Toy> toys) {
		category.setToys(toys);
		return this;
	}
	
	public Category build() {
		return category;
	}
}
