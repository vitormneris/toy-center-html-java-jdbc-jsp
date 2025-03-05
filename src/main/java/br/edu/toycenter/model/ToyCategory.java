package br.edu.toycenter.model;

public class ToyCategory {
	private Integer toyId;
	private Integer categoryId;
	
	public ToyCategory() {
	}
		
	public ToyCategory(Integer toyId, Integer categoryId) {
		this.toyId = toyId;
		this.categoryId = categoryId;
	}

	public Integer getToyId() {
		return toyId;
	}
	
	public void setToyId(Integer toyId) {
		this.toyId = toyId;
	}
	
	public Integer getCategoryId() {
		return categoryId;
	}
	
	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
}