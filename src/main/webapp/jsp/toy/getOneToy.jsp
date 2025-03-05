<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/remodel.css">
    <link rel="stylesheet" href="css/styleToy.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <title>Brinquedo</title>
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
		Toy toy = (Toy) request.getAttribute("toy");
		String message = (String) request.getAttribute("message");
		%>
	<div class="containerToy">
		<div class="toyContent">
			<div class="toyInfo">

				<img src="<%= toy.getImage() %>" alt="">
				<h3 class="brand"><%= toy.getBrand() %></h3>
				<div class="align">
				<h2 class="name"><%= toy.getName() %></h2>
				<p class="price">R$<%= toy.getPrice() %></p>
				<button class="buy">Comprar</button>
				</div>

				<p class="description"><%= toy.getDescription() %></p>
				<p class="details"><%= toy.getDetails() %></p>

			</div>
		</div>
	</div>
	<p> <% if (!(message == null)) out.print(message); %> </p>
    
</body>
</html>