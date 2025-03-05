package br.edu.toycenter.builder;

import java.math.BigDecimal;
import java.util.List;

import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;

public class ToyBuilder {
	private static Toy toy;
	
	private ToyBuilder() {
	}
	
	public static ToyBuilder builder() {
		toy = new Toy();
		return new ToyBuilder();
	}
	
	public ToyBuilder id(Integer id) {
		toy.setId(id);
		return this;
	}
	
	public ToyBuilder image(String image) {
		toy.setImage(image);
		return this;
	}
	
	public ToyBuilder name(String name) {
		toy.setName(name);
		return this;
	}
	
	public ToyBuilder brand(String brand) {
		toy.setBrand(brand);
		return this;
	}
	
	public ToyBuilder price(BigDecimal price) {
		toy.setPrice(price);
		return this;
	}
	
	public ToyBuilder description(String description) {
		toy.setDescription(description);
		return this;
	}
	
	public ToyBuilder details(String details) {
		toy.setDetails(details);
		return this;
	}
	
	public ToyBuilder categories(List<Category> categories) {
		toy.setCategories(categories);
		return this;
	}
	
	public Toy build() {
		return toy;
	}
}
