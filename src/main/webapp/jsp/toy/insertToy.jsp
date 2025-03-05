
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/styleForm.css">
	<link rel="stylesheet" href="css/remodel.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@3.0.1/dist/css/multi-select-tag.css">
	<script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@3.0.1/dist/js/multi-select-tag.js"></script>
	<title>Inserir Brinquedo</title>

</head>
<body>
    <header>
		<nav class="nav-logo">
			<div class="logo">
				<a href="ToyController?action=getAllToy"> 
					<img src="image/logoToyCenterAlt.svg" alt="">
				</a>
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


	<a class="botao" href="ToyController?action=getAllToyAdm">Voltar</a>
	
	
	<main id="Main_ContentNT" class="Container_NewToy">
	
		<%
		List<Category> categoryList = (ArrayList<Category>) request.getAttribute("categoryList");
		String message = (String) request.getParameter("message1");
		if (categoryList != null) {
		%>
		<form id="Content_NewToy" action="ToyController" method="POST"
			enctype="multipart/form-data">
			<input type="hidden" name="action" value="insertToy">

		    <div class="title-container">
		        <h1 class="titleAlt">Catálogo de Brinquedos: Novo Brinquedo</h1>
		        <div class="title-lineAlt" align="center" ></div>
		    </div>

			<div class="fieldsetBox">
				<label for="name_NT">Nome</label> 
				<input type="text" placeholder="Digite o Nome do Brinquedo" name="toy_name" id="name_NT" required>
			</div>

			<div class="fieldsetBox">
				<label for="brand_NT">Marca</label> 
				<input type="text" placeholder="Digite o nome da Marca do Brinquedo" name="toy_brand" id="brand_NT" required>
			</div>

			<div class="fieldsetBox">
				<label for="description_NT">Descrição</label> 
				<input type="text" placeholder="Digite a Descrição do Brinquedo" name="toy_description" id="description_NT" required>
			</div>

			<div class="fieldsetImageBox">
				<label for="file_NT">Imagem</label> 
				<input type="file" name="toy_image" id="file_NT" required>
			</div>

			<div class="fieldsetPriceBox">
				<label for="price_NT">Valor R$</label> 
				<input type="number" min="0" max="1000000000" step="0.01" placeholder="Digite o Valor" class="price_nt" name="toy_price" id="price_NT" required>
			</div>

			<div >
		
			    <label class="categoryLabel">Categorias:</label>
			    <select name="toy_categories" id="categorias" multiple>
			    <%
			    	for (Category category : categoryList) {
			    %>
			    	<option value="<%=category.getId()%>"> <%=category.getName()%></option>
			    <%
			    	}
			    %>
			    </select>
          
			</div>

			<div class="fieldsetBox">
				<label for="details_NT">Detalhes</label>
				<textarea class="detailsBox" maxlength="1080" placeholder="Escreva os Detalhes do Brinquedo" name="toy_details"  id="details_NT"></textarea>
			</div>

			<div class="centralize">
			    <button id="confirmBtn" onclick="confirmSubmission()">Salvar</button>
			</div>
			<br>
			<br>
			<p>
				<%
				if (!(message == null)) out.print(message);
				%>
			</p>

		</form>	
		<%
		} else {
	    %>
			<p style="color: white; font-size: 30px">
	    <%
			out.print("Adicione uma categoria.");
		%>	
			</p>
		<%
		}
	    %>
	</main>
	
	<script>
	    function confirmSubmission() {
	        if (confirm("Tem certeza de que deseja salvar este brinquedo?")) {
	            document.getElementById("Content_NewToy").submit();
	        } else {
	            return false;
	        }
	    }
	    
	</script>
	<script> new MultiSelectTag('categorias') </script> 
</body>
</html>