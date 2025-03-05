package br.edu.toycenter.builder;

import br.edu.toycenter.model.User;

public class UserBuilder {
	private static User user;
	
	private UserBuilder() {
	}
	
	public static UserBuilder builder() {
		user = new User();
		return new UserBuilder();
	}
	
	public UserBuilder id(Integer id) {
		user.setId(id);
		return this;
	}
	
	public UserBuilder name(String name) {
		user.setName(name);
		return this;
	}
	
	public UserBuilder email(String email) {
		user.setEmail(email);
		return this;
	}
	
	public UserBuilder password(String password) {
		user.setPassword(password);
		return this;
	}
	
	public User build() {
		return user;
	}
}
