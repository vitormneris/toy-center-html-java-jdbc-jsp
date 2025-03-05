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

import br.edu.toycenter.builder.UserBuilder;
import br.edu.toycenter.exceptions.InvalidFieldException;
import br.edu.toycenter.exceptions.OperationNotAllowedException;
import br.edu.toycenter.model.User;
import br.edu.toycenter.services.LoginService;
import br.edu.toycenter.services.UserService;

@WebServlet("/UserController")
@MultipartConfig
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final UserService userService;
	
	public UserServlet() {
		userService = new UserService();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "jsp/login.jsp");
		
		try {			
			switch (action) {
				case "getAllUser":
					findAll(request, response);
					break;
				case "updateUser":
	        		session = request.getSession(true);
	        		session.setAttribute("user", userService.findById(getIdFromRequest(request)));
		            forwardToPage(request, response, "jsp/user/updateUser.jsp");
					break;
				case "deleteUser":
	        		session = request.getSession(true);
	        		session.setAttribute("user", userService.findById(getIdFromRequest(request)));
		            forwardToPage(request, response, "jsp/user/deleteUser.jsp");
					break;
				case "insertUser":
		            forwardToPage(request, response, "jsp/user/insertUser.jsp");
					break;
				case "logOut":
			    	loginOutUser(request, response);
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
	        	case "loginUser":
	    		    loginUser(request, response);
	    		    break;
            	case "getOneUser":
            		findById(request, response);
    				break;
            	case "insertUser":
            		insert(request, response);
    				break;
            	case "updateUser":
            		update(request, response);
                    break;
            	case "deleteUser":
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
    
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		LoginService loginService = new LoginService();
				
		User user = UserBuilder.builder()
				.email(request.getParameter("user_email"))
				.password(request.getParameter("user_password"))
				.build();
		
		if (loginService.loginUser(user)) {
			HttpSession session = request.getSession(true);
			session.setAttribute("loggedIn", true);
			request.setAttribute("message", "<script>window.location.href='ToyController?action=getAllToyAdm';</script>");
			forwardToPage(request, response, "index.jsp");
		} else {	    	
			request.setAttribute("message1", "E-mail ou senha errado");
			forwardToPage(request, response, "jsp/login.jsp");
		}
    }
    
    private void loginOutUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session != null) 
            session.invalidate();
		forwardToPage(request, response, "index.jsp");
	}
	
    private void findAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("userList", userService.findAll());
		forwardToPage(request, response, "jsp/user/getAllUser.jsp");
	}
	
	private void findById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		request.setAttribute("user", userService.findById(getIdFromRequest(request)));
	    forwardToPage(request, response, "jsp/user/getOneUser.jsp");
	}
	
	private void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			userService.insert(createObjectUserFromRequest(request));
		    request.setAttribute("message", "Usuário inserido com sucesso!");
		    
		    String text = request.getParameter("login");
		    if (text != null) 
	    		if (text.equals("true")) 
	            	forwardToPage(request, response, "index.jsp");
		    			
			request.setAttribute("message", "<script>window.location.href='UserController?action=getAllUser'</script>");
	    	forwardToPage(request, response, "index.jsp");
		    
		} catch (InvalidFieldException e) {
			String jsCode = "<script>window.location.href='UserController?action=insertUser&message1=" + e.getMessage() + "';</script>";
			request.setAttribute("message", jsCode);
			forwardToPage(request, response, "index.jsp");
		}
    }
	
	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			userService.update(getIdFromRequest(request), createObjectUserFromRequest(request));
			request.setAttribute("message", "<script>window.location.href='UserController?action=getAllUser'</script>");
	    	forwardToPage(request, response, "index.jsp");
		} catch (InvalidFieldException e) {
			String jsCode = "<script>window.location.href='UserController?action=updateUser&user_code=" 
					+ getIdFromRequest(request) + "&message1=" + e.getMessage() + "';</script>";
			request.setAttribute("message", jsCode);
			forwardToPage(request, response, "index.jsp");
		}
	} 
	
	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			userService.delete(getIdFromRequest(request));
		    request.setAttribute("message", "Usuário deletado com sucesso!");
		    findAll(request, response);
		} catch (OperationNotAllowedException e) {
			request.setAttribute("message", e.getMessage());
			findAll(request, response);
		}
	}
	
	private User createObjectUserFromRequest(HttpServletRequest request) {
		return UserBuilder.builder()
				.name(request.getParameter("user_name"))
				.email(request.getParameter("user_email"))
				.password(request.getParameter("user_password")).build();
	}
	
	private Integer getIdFromRequest(HttpServletRequest request) {
		String id = request.getParameter("user_code");
		return id == null ? null : Integer.parseInt(id);
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}	
}