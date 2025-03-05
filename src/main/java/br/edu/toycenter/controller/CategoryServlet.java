package br.edu.toycenter.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.edu.toycenter.builder.CategoryBuilder;
import br.edu.toycenter.exceptions.InvalidFieldException;
import br.edu.toycenter.model.Category;
import br.edu.toycenter.services.CategoryService;

@WebServlet("/CategoryController")
@MultipartConfig
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final CategoryService categoryService;
	
	public CategoryServlet() {
		categoryService = new CategoryService();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");		
        HttpSession session;
        
		try {
            switch (action) {
	            case "getAllCategory": 
					findAll(request, response, false);
					break;
	            case "updateCategory":
					screenBlock(request, response);
					session = request.getSession(true);
	        		session.setAttribute("category", categoryService.findById(getIdFromRequest(request)));
		            forwardToPage(request, response, "jsp/category/updateCategory.jsp");
					break;
	            case "deleteCategory":
					screenBlock(request, response);
	        		session = request.getSession(true);
	        		session.setAttribute("category", categoryService.findById(getIdFromRequest(request)));
		            forwardToPage(request, response, "jsp/category/deleteCategory.jsp");
					break;
	            case "getOneCategory":
			    	findById(request, response);
					break;
	            case "getAllCategoryAdm":
					screenBlock(request, response);
					findAll(request, response, true);
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
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "index.jsp");
        
        try {          
            switch (action) {
            	case "getOneCategory":
            		findById(request, response);
    				break;
            	case "insertCategory":
            		insert(request, response);
    				break;
            	case "updateCategory":
            		update(request, response);
                    break;
            	case "deleteCategory":
            		delete(request, response);
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
	
    private void findAll(HttpServletRequest request, HttpServletResponse response, boolean isAdministrator) throws ServletException, IOException {
		request.setAttribute("categoryList", categoryService.findAll());
	    forwardToPage(request, response, (isAdministrator) ? "jsp/category/getAllCategoryAdm.jsp" : "jsp/category/getAllCategory.jsp");
	}
	
	private void findById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("category", categoryService.findById(getIdFromRequest(request)));
	    forwardToPage(request, response, "jsp/category/getAllToyByCategory.jsp");
	}
	
	private void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		try {
			categoryService.insert(createObjectCategoryFromRequest(request), request.getParts());
			request.setAttribute("message", "<script>window.location.href='CategoryController?action=getAllCategoryAdm'</script>");
	    	forwardToPage(request, response, "index.jsp");
		} catch (InvalidFieldException e) {
			String jsCode = "<script>window.location.href='CategoryController?action=insertCategory&message1=" + e.getMessage() + "';</script>";	
			request.setAttribute("message", jsCode);
	    	forwardToPage(request, response, "index.jsp");
		}
    }
	
	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		try {
			categoryService.update(getIdFromRequest(request), createObjectCategoryFromRequest(request), request.getParts()); 
			request.setAttribute("message", "<script>window.location.href='CategoryController?action=getAllCategoryAdm'</script>");
	    	forwardToPage(request, response, "index.jsp");
		} catch (InvalidFieldException e) {
			String jsCode = "<script>window.location.href='CategoryController?action=updateCategory&category_code=" + request.getParameter("category_code") 
			+ "&message1=" + e.getMessage() + "';</script>";
			request.setAttribute("message", jsCode);
	    	forwardToPage(request, response, "index.jsp");
		}
    } 
	
	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		categoryService.delete(getIdFromRequest(request));
	    request.setAttribute("message", "Categoria deletada com sucesso!");
		findAll(request, response, true);
	}
	
	private Category createObjectCategoryFromRequest(HttpServletRequest request) {
		return CategoryBuilder.builder().name(request.getParameter("category_name")).build();
	}
	
	private Integer getIdFromRequest(HttpServletRequest request) {
		String id = request.getParameter("category_code");
		return id == null ? null : Integer.parseInt(id);
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}
	
	private void screenBlock(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "jsp/login.jsp");
	}
}