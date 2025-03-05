<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
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
				<h2 class="subtitulo">Administração: Brinquedos</h2>
				<div class="tabela">
					<table>
						<thead>
							<tr>
								<th>Código do brinquedo</th>
								<th>Imagem do brinquedo</th>
								<th>Nome do brinquedo</th>
								<th>Categorias do brinquedo</th>
								<th>Marca do brinquedo</th>
								<th>Preço do brinquedo</th>
								<th>Descrição do brinquedo</th>
								<th>Detalhes do brinquedo</th>
								<th>Operações do brinquedo</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Toy> list = (ArrayList) request.getAttribute("toyList");
							String message = (String) request.getAttribute("message");
							int c = 0;
							if (list != null) {
								for (Toy toy : list) {
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
								<td><%=toy.getId()%></td>
								<td><a
									href="ToyController?action=getOneToy&toy_code=<%=toy.getId()%>">
										<img src="<%=toy.getImage()%>" width="100px" height="100px">
								</a></td>
								<td class="toy-compact-cell"><%=toy.getName()%></td>
								<td class="toy-compact-cell">
									<%
									for (Category category : toy.getCategories()) {
										out.print(category.getName());
									%> <br> <%
									 }
									 %>
								</td>
								<td class="toy-compact-cell"><%=toy.getBrand()%></td>
								<td><%=toy.getPrice()%></td>
								<td class="toy-compact-cell"><%=toy.getDescription()%></td>
								<td class="toy-compact-cell"><%=toy.getDetails()%></td>
								<td class="controls"><a class="linkDelete" onclick="deleteToy(<%= toy.getId()%>)">Deletar</a> 
								<a class="linkEdit" href="ToyController?action=updateToy&toy_code=<%=toy.getId()%>">Atualizar</a>
								</td>
							</tr>

							<%
								}
							} else {
								out.println("Toy not found");
							}
							%>
						</tbody>
					</table>

				</div>
				<br> <br> 
				<div class="centralize">
				<a id="confirmBtn" href="ToyController?action=insertToy">Adicionar</a>
				<br><br>
				<a id="confirmBtn" onclick="logOff()">Deslogar</a>
				</div>
			</div>

		</div>
	</div>
	
	<p>
		<%
		if (!(message == null))
			out.print(message);
		%>
	</p>
	<script>
	function deleteToy(number) {
	    if (window.confirm("Você tem certeza de que deseja Excluir o brinquedo?")) {
	        console.log("Toy deleted successfully!");
	        fetch('http://localhost:8080/ToyCenter/ToyController?action=deleteToy&toy_code=' + number, {
	            method: 'POST', 
	        })
	        .then(response => {
	            console.log('Server response:', response);
	            window.location.href = "http://localhost:8080/ToyCenter/ToyController?action=getAllToyAdm";
	        })
	        .catch(error => {
	            console.error('Request error:', error);
	        });
	    } else {
	        console.log("Deletion canceled by toy.");
	        
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
	            window.location.href = "http://localhost:8080/ToyCenter/ToyController?action=getAllToyAdm";
	        })
	        .catch(error => {
	            console.error('Request error:', error);
	        });
	    } else {
	        console.log("User not quit.");
	        
	    }
	}

  </script>
	
</body>
</html>