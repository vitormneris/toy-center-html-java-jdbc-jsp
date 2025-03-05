package br.edu.toycenter.services;

import java.util.List;

import br.edu.toycenter.dao.UserDAO;
import br.edu.toycenter.enums.RuntimeErrorEnum;
import br.edu.toycenter.exceptions.OperationNotAllowedException;
import br.edu.toycenter.model.User;

public class UserService {
	private final UserDAO userDAO;
	
	public UserService() {
		this.userDAO = new UserDAO();
	}
	
	public List<User> findAll() {
		return userDAO.findAll();
	}
	
	public User findById(Integer id) {
		return userDAO.findById(id);
	}
	
	public void insert(User user) {
		ValidationFieldService.validationField(user);
		userDAO.insert(user);
	}
	
	public void update(Integer id, User user) {
		ValidationFieldService.validationField(user);
		userDAO.update(id, user);
	}
	
	public void delete(Integer id) {
		blockDeletionOfTheSingleUser();
		userDAO.delete(id);
	}
	
	public void blockDeletionOfTheSingleUser() {
		if (userDAO.countUsersNumber() < 2)
			throw new OperationNotAllowedException(RuntimeErrorEnum.ERR0007);
	}
}
