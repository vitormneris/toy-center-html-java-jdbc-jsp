<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
	  <meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <title>Toy Center ADM</title>
	  <link rel="stylesheet" href="css/styleAdm.css">
    <link rel="stylesheet" href="css/remodel.css">
    <link rel="stylesheet" href="css/styleForm.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
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
  

	<div class="containerAdm">
	  <div class="camada0">
	    <div class="camada1">
	        <h2 class="subtitulo">Administração: Categorias</h2>
	            <div class="tabela">
	            <table>
	                <thead>
	                    <tr>
	                        <th>Código da categoria</th>
	                        <th>Imagem da categoria</th>
	                        <th>Nome da categoria</th>
	                        <th>Operações da categoria</th>
	                    </tr>
	                </thead>
	                <tbody>                   
	                    <%
						List<Category> categoryList = (ArrayList) request.getAttribute("categoryList");
						String message = (String) request.getAttribute("message");
						int c = 0;
						if (categoryList != null) {
							for (Category category : categoryList) {
								c++;
								if (c % 2 == 0) { 
					    %>
								<tr class="trb">
					    <%	
					  			} else {
					    %>
								<tr class="trw">
					    <% 
					  			} 
					    %>
								<td><%= category.getId() %></td>
								<td class="toy-compact-cell" ><%= category.getName() %></td>
								<td><img src="<%= category.getImage() %>" width="100px" height="100px"></td>
								<td class="controls">
									<a class="linkDelete" onclick="deleteCategory(<%= category.getId() %>)">Deletar</a>
								    <a class="linkEdit" href="CategoryController?action=updateCategory&category_code=<%= category.getId() %>">Atualizar</a>
								</td>
							</tr>
						<%
							}
						} else {
							out.println("Category not found");
						}
						%>
	                </tbody>
	            </table>
	        </div>
	        <br>
	        <div class="centralize">
	        <a id="confirmBtn" href="html/category/insertCategory.html">Adicionar</a>
				<br><br>
				<a id="confirmBtn" onclick="logOff()">Deslogar</a>
	        <br><br>
	        </div>
            <p> <% if (!(message == null)) out.print(message); %> </p>
            <script>
			function deleteCategory(number) {
			    if (window.confirm("Você tem certeza de que deseja Excluir a categoria?")) {
			        console.log("Category deleted successfully!");
			        fetch('http://localhost:8080/ToyCenter/CategoryController?action=deleteCategory&category_code=' + number, {
			            method: 'POST', 
			        })
			        .then(response => {
			            console.log('Server response:', response);
			            window.location.href = "http://localhost:8080/ToyCenter/CategoryController?action=getAllCategoryAdm";
			        })
			        .catch(error => {
			            console.error('Request error:', error);
			        });
			    } else {
			        console.log("Deletion canceled by category.");
			        
			    }
			}
			
			function logOff() {
			    if (window.confirm("Você tem certeza de que deseja sair?")) {
			        console.log("User quit successfully!");
			        fetch('http://localhost:8080/ToyCenter/UserController?action=logOut', {
			            method: 'GET', 
			        })
			        .then(response => {
			            console.log('Server response:', response);
			            window.location.href = "http://localhost:8080/ToyCenter/CategoryController?action=getAllCategoryAdm";
			        })
			        .catch(error => {
			            console.error('Request error:', error);
			        });
			    } else {
			        console.log("User not quit.");
			        
			    }
			}
		
		  </script>
	    </div>
	    </div>
    </div>
</body>
</html>