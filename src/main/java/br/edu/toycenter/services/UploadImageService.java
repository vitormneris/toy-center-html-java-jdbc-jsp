package br.edu.toycenter.services;

import java.io.File;
import java.util.Collection;

import javax.servlet.http.Part;

import br.edu.toycenter.dao.CategoryDAO;
import br.edu.toycenter.dao.ToyDAO;
import br.edu.toycenter.enums.RuntimeErrorEnum;
import br.edu.toycenter.exceptions.UploadImageException;

public class UploadImageService {
	
	public static String uploadImage(Collection<Part> parts, Integer id, String mode) throws NumberFormatException, Exception {
		String path = System.getProperty("user.dir");
		
		if (mode.equals("toy")) {
			path += "/src/main/webapp/image/dataBaseImageToy";
		
			for(Part part : parts) {
				if (part.getName().equals("toy_image") && part.getSize() > 0) {
					part.write(path + File.separator + part.getSubmittedFileName());
					return "image/dataBaseImageToy" + File.separator + part.getSubmittedFileName();
				}
			}
			
			ToyDAO td = new ToyDAO();
			return td.findById(id).getImage();
		}
		
		else if ((mode.equals("category"))) {
			path += "/src/main/webapp/image/dataBaseImageCategory";
		
			for(Part part : parts) {
				if (part.getName().equals("toy_image") && part.getSize() > 0) {
					part.write(path + File.separator + part.getSubmittedFileName());
					return "image/dataBaseImageToy" + File.separator + part.getSubmittedFileName();
				}
			}
			
			CategoryDAO td = new CategoryDAO();
			return td.findById(id).getImage();
		}
	
		throw new UploadImageException(RuntimeErrorEnum.ERR0008);
	}

}
