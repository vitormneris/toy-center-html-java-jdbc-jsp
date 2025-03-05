package br.edu.toycenter.services;

import java.util.Collection;
import java.util.List;

import javax.servlet.http.Part;

import br.edu.toycenter.dao.ToyDAO;
import br.edu.toycenter.enums.TypeEntityEnum;
import br.edu.toycenter.model.Toy;

public class ToyService {
	private final ToyDAO toyDAO;
	
	public ToyService() {
		this.toyDAO = new ToyDAO();
	}
	
	public List<Toy> findAll() {
		return toyDAO.findAll();
	}
	
	public Toy findById(Integer toyId) {
		return toyDAO.findById(toyId);
	}
	
	public void insert(Toy toy, Collection<Part> parts) {
		ValidationFieldService.validationField(toy);
		ValidationFieldService.validationField(parts,  TypeEntityEnum.TOY);
		UploadImageService.uploadImage(parts, null, toy);
		toyDAO.insert(toy);
	}
	
	public void update(Integer toyId, Toy toy, Collection<Part> parts) {
		ValidationFieldService.validationField(toy);
		UploadImageService.uploadImage(parts, toyId, toy);
		toyDAO.update(toyId, toy);
	}
	
	public void delete(Integer toyId) {
		toyDAO.delete(toyId);
	}
}
