<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/remodel.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <title>Toy Center início</title>
</head>

<body>
    <header>
		<nav class="nav-logo">
			<div class="logo">
				<a href="ToyController?action=getAllToy"> <img
					src="image/logoToyCenterAlt.svg" alt=""></a>
			</div>

			<div class="store-name">
				<h1>TOY CENTER</h1>
			</div>

			<div class="space"></div>
		</nav>

		<nav class="menu">
			<div class="menuList">
				<a href="ToyController?action=getAllToy">Início</a> 
				<a href="CategoryController?action=getAllCategory">Categorias</a> 				
				
				<div class="dropdown">
 				<button class="dropbtn">Administração</button>
  				<div class="dropdown-content">
				<a href="ToyController?action=getAllToyAdm">Brinquedos</a>
				<a href="CategoryController?action=getAllCategoryAdm">Categorias</a>
				<a href="UserController?action=getAllUser">Usuarios</a>
  				</div>
				</div>
			
				<a href="html/sobre_a_equipe.html">Sobre a Equipe</a>
			</div>
		</nav>

	</header>


    
    <%
        List<Toy> toyList = (ArrayList) request.getAttribute("toyList");
        boolean show = false;
        int codeCat = 0;
        if (toyList != null) {
        	for (Toy toy : toyList) {
        		for (Category category : toy.getCategories()) {
        	if (category.getName().equals("Hot Wheels")) {
        		show = true;
        		codeCat = category.getId();
        	}
        		}
        	}
        	if (show) {
        %>
    <main class="banner_container">
            <div class="banner_content">
               <a href="CategoryController?action=getOneCategory&category_code=<%= codeCat %>" ><img src="image/mp-brinquedos-hotwheels.png" alt=""></a>
            </div>
    </main>
	<%
		}
	}
	%>
	
    <div class="title-container">
        <h1 class="title">Principais brinquedos</h1>
        <div class="title-line" align="center" ></div>
    </div>

    <div class="cards-container">
        <div class="row">
        <%
        boolean cmf = false; 
		if (toyList != null) {
			for (Toy toy : toyList) {
	    %>
	            <div class="card">
	                <a class="centralize" href="ToyController?action=getOneToy&toy_code=<%= toy.getId() %>">
	                	<img src="<%= toy.getImage() %>" alt="Image" title="Ver mais sobre <%= toy.getName() %>"></a>
	                <h4><%= toy.getName() %></h4>
	                <p>R$<%= toy.getPrice() %></p>
	            </div>
	    <%
			}
		cmf = true;
		} else {
	    %>
			<p style="color: white; font-size: 30px">
	    <%
			out.print("Toy not found");
		%>	
			</p>
		<%
		}
	    %>
        </div>
    </div>
    <% if (cmf) {%>
		<div class="title-container">
	        <h1 class="title">Veja também: Instrumentos Musicais</h1>
	        <div class="title-line" align="center" ></div>
	    </div>
	    
    <% } %>    		
    <div class="cards-container">
        <div class="row">
        <%
		if (toyList != null) {

			for (Toy toy : toyList) {
				for (Category category : toy.getCategories()) {
					if (category.getName().equals("Instrumentos Musicais")) {
		%>
	            <div class="card">
	                <a href="ToyController?action=getOneToy&toy_code=<%= toy.getId() %>">
	                	<img src="<%= toy.getImage() %>" alt="Image" title="Ver mais sobre <%= toy.getName() %>"></a>
	                <h4><%= toy.getName() %></h4>
	                <p>R$<%= toy.getPrice() %></p>
	            </div>
        <%
					}
				}
			}
		} 
		%>
        </div>
    </div>
</body>
</html>


