package br.edu.toycenter.services;

import java.util.Collection;

import javax.servlet.http.Part;

import br.edu.toycenter.exceptions.InvalidFieldException;
import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;
import br.edu.toycenter.model.User;

public class ValidationFieldService {
	
	public static void validationField(Toy toy, Collection<Part> parts) {
		if (toy.getName() == null || toy.getName().trim().equals(""))   
			throw new InvalidFieldException("O nome nao pode ficar em branco.");
		
		if (toy.getBrand() == null || toy.getBrand().trim().equals("")) 
			throw new InvalidFieldException("A marca nao pode ficar em branco.");
		
		boolean isImage = false;
		for (Part part : parts) 
			if (part.getName().equals("toy_image") && part.getSize() > 0)
				isImage = true;		
		if (!isImage) throw new InvalidFieldException("Envie uma imagem");	
		
		if (toy.getPrice() == null)	
			throw new InvalidFieldException("Digite um valor para o brinquedo.");
		
		if (toy.getDescription() == null || toy.getDescription().trim().equals(""))
			throw new InvalidFieldException("A descricao nao pode ficar em branco.");
		
		if (toy.getCategories() == null || toy.getCategories().size() < 1)
			throw new InvalidFieldException("Selecione ao menos uma categoria.");

		if (toy.getDetails() == null || toy.getDetails().trim().equals(""))
			throw new InvalidFieldException( "Detalhes nao pode ficar em branco.");
	}
	
	public static void validationField(User user) {
		if (user.getName() == null || user.getName().trim().equals("")) 
			throw new InvalidFieldException("O nome nao pode ficar em branco.");
		
		if (user.getEmail() == null || user.getEmail().trim().equals(""))     	
			throw new InvalidFieldException("O e-mail nao pode ficar em branco.");
		
		if (user.getPassword() == null || user.getPassword().trim().equals(""))    	
			throw new InvalidFieldException("A senha nao pode ficar em branco.");
	}
	
	public static void validationField(String email, String password) {
		if (email == null || email.trim().equals(""))     	
			throw new InvalidFieldException("O e-mail nao pode ficar em branco.");
		
		if (password == null || password.trim().equals(""))    	
			throw new InvalidFieldException("A senha nao pode ficar em branco.");
	}
	
	public static void validationField(Category category, Collection<Part> parts) {
		if (category.getName() == null || category.getName().trim().equals(""))   
			throw new InvalidFieldException("O nome nao pode ficar em branco.");
		
		boolean isImage = false;
		for (Part part : parts) 
			if (part.getName().equals("category_image") && part.getSize() > 0)
				isImage = true;		
		if (!isImage) throw new InvalidFieldException("Envie uma imagem");		    	
	}
}
