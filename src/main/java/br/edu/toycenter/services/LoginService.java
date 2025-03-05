package br.edu.toycenter.services;

import br.edu.toycenter.dao.LoginDAO;
import br.edu.toycenter.model.User;

public class LoginService {
	private final LoginDAO loginDAO;
	
	public LoginService() {
		loginDAO = new LoginDAO();
	}
	
	public boolean loginUser(User user) {
		ValidationFieldService.validationField(user.getEmail(), user.getPassword());
		return loginDAO.loginUser(user.getEmail(), user.getPassword());
	}
}
