package br.edu.toycenter.enums;

public enum TypeEntityEnum {
	CATEGORY("Category"),
	TOY("Toy");
	
	private final String entity;
	
	TypeEntityEnum(String entity) {
		this.entity = entity;
	}
	
	public String getEntity() {
		return entity;
	}
}
