package br.edu.toycenter.services;

import java.io.File;
import java.io.IOException;
import java.util.Collection;

import javax.servlet.http.Part;

import br.edu.toycenter.enums.RuntimeErrorEnum;
import br.edu.toycenter.exceptions.UploadImageException;
import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.EntityWithImage;
import br.edu.toycenter.model.Toy;

public class UploadImageService {
	private static String path = System.getProperty("user.dir");
	private static String partName;
	private static String imageDestination;
	
	public static void uploadImage(Collection<Part> parts, Integer id, EntityWithImage entity) {
		boolean isImage = false;
		String pathCurrent = path;
		
		if (entity instanceof Toy) {
			pathCurrent += "/src/main/webapp/image/dataBaseImageToy";
			partName = "toy_image";
			imageDestination = "image/dataBaseImageToy";
		}
		else if (entity instanceof Category) {
			pathCurrent += "/src/main/webapp/image/dataBaseImageCategory";
			partName = "category_image";
			imageDestination = "image/dataBaseImageCategory";
		}
		
		try {
			for(Part part : parts) {
				if (part.getName().equals(partName) && part.getSize() > 0) {
					part.write(pathCurrent + File.separator + part.getSubmittedFileName());
					entity.setImage(imageDestination + File.separator + part.getSubmittedFileName());
					isImage = true;
				}
			}
		} catch (IOException e) {
			throw new UploadImageException(RuntimeErrorEnum.ERR0008);	
		}
		
		if (!isImage && id != null) {
			if (entity instanceof Toy) {
				ToyService toyService = new ToyService();
				entity.setImage(toyService.findById(id).getImage());
			}
			else if (entity instanceof Category) {
				CategoryService categoryService = new CategoryService();
				entity.setImage(categoryService.findById(id).getImage());
			}
		} 		
	}
}
