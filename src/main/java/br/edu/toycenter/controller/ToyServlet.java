package br.edu.toycenter.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.edu.toycenter.builder.ToyBuilder;
import br.edu.toycenter.exceptions.InvalidFieldException;
import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;
import br.edu.toycenter.services.CategoryService;
import br.edu.toycenter.services.ToyService;

@WebServlet("/ToyController")
@MultipartConfig
public class ToyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ToyService toyService;
	
	public ToyServlet() {
		toyService = new ToyService();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        HttpSession session;
		CategoryService categoryService = new CategoryService();

		try {
    		switch (action) {
	    		case "getAllToy":
					findAll(request, response, false);
					break;
	    		case "getOneToy":
	        		findById(request, response);
	        		break;
	    		case "getAllToyAdm":
					screenBlock(request, response);
	        		findAll(request, response, true);
	        		break;
	    		case "insertToy":
	    			screenBlock(request, response);
	        		request.setAttribute("categoryList", categoryService.findAll());
		            forwardToPage(request, response, "jsp/toy/insertToy.jsp");
		            break;
	    		case "updateToy":
	    			screenBlock(request, response);
			    	request.setAttribute("categoryList", categoryService.findAll());
	    			session = request.getSession(true);
	        		session.setAttribute("toy", toyService.findById(getIdFromRequest(request)));
		            forwardToPage(request, response, "jsp/toy/updateToy.jsp");
		            break;
	    		case "deleteToy":
	    			screenBlock(request, response);
	        		session = request.getSession(true);
	        		session.setAttribute("toy", toyService.findById(getIdFromRequest(request)));
		            forwardToPage(request, response, "jsp/toy/deleteToy.jsp");
		            break;
	    		default:
	            	request.setAttribute("message", "Page not found");
	            	forwardToPage(request, response, "jsp/error.jsp");
	    	}
				
 		} catch (Exception e) {
        	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
        }
	}
	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");		
        
        try {          
            switch (action) {
            	case "getOneToy":
    				findById(request, response);
    				break;
            	case "insertToy":
    				insert(request, response);
    				break;
            	case "updateToy":
	        		update(request, response);
                    break;
            	case "deleteToy":
                    delete(request, response);
                    break;
                default:
                	request.setAttribute("message", "Page not found");
                	forwardToPage(request, response, "jsp/error.jsp");
                	break;
            }
        } catch (Exception e) {
        	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
        }
    }
	
    private void findAll(HttpServletRequest request, HttpServletResponse response, boolean isAdministrator) throws ServletException, IOException {
		request.setAttribute("toyList", toyService.findAll());
		forwardToPage(request, response, (isAdministrator) ? "jsp/toy/getAllToyAdm.jsp" : "jsp/toy/getAllToy.jsp");
	}
	
	private void findById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("toy", toyService.findById(getIdFromRequest(request)));
    	forwardToPage(request, response, "jsp/toy/getOneToy.jsp");
	}
	
	private void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {		
		try {
			toyService.insert(createObjectToyFromRequest(request), request.getParts());
			request.setAttribute("message", "<script>window.location.href='ToyController?action=getAllToyAdm'</script>");
			forwardToPage(request, response, "index.jsp");
		} catch (InvalidFieldException e) {
			request.setAttribute("message", "<script>window.location.href='ToyController?action=insertToy&message1=" + e.getMessage() + "';</script>");
			forwardToPage(request, response, "index.jsp");
		}
	}
	
	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		try {
			toyService.update(getIdFromRequest(request), createObjectToyFromRequest(request), request.getParts());
			request.setAttribute("message", "<script>window.location.href='ToyController?action=getAllToyAdm'</script>");
	    	forwardToPage(request, response, "index.jsp");
		} catch (InvalidFieldException e) {
			String jsCode = "<script>window.location.href='ToyController?action=updateToy&toy_code=" 
					+ getIdFromRequest(request) + "&message1=" + e.getMessage() + "';</script>";
			request.setAttribute("message", jsCode);
			forwardToPage(request, response, "index.jsp");	
		}
	} 
	
	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		toyService.delete(getIdFromRequest(request));
	    request.setAttribute("message", "Brinquedo excluido com sucesso!");
		findAll(request, response, true);
	}
	
	private Toy createObjectToyFromRequest(HttpServletRequest request) {	
		String price = request.getParameter("toy_price");
		String[] categoriesSelected = request.getParameterValues("toy_categories");
		ToyBuilder toyBuilder = new ToyBuilder();
		
		Toy toy = toyBuilder.builder()
				.name(request.getParameter("toy_name"))
				.brand(request.getParameter("toy_brand"))
				.price(price == null || price.equals("") ? BigDecimal.ZERO : BigDecimal.valueOf(Double.parseDouble(price)))
				.description(request.getParameter("toy_description"))
				.details(request.getParameter("toy_details"))
				.categories(getCategoriesSelecteds(categoriesSelected == null ? new String[] {} :  categoriesSelected)).build();
		
		return toy;
	}
	
	private Integer getIdFromRequest(HttpServletRequest request) {
		String id = request.getParameter("toy_code");
		return id == null ? null : Integer.parseInt(id);
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}
	
	private List<Category> getCategoriesSelecteds(String[] parameters) {
		CategoryService categoryService = new CategoryService();
				
		List<Category> categories = new ArrayList<>();
 		for (String categoryId : parameters) 
			for (Category category : categoryService.findAll()) 
				if (category.getId() ==  Integer.parseInt(categoryId)) 
					categories.add(category);
		
		return categories;
	}
	
	private void screenBlock(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "jsp/login.jsp");
	}
}