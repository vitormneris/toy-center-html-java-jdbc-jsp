<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
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
    <title>Atualizar Brinquedo</title>
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
    

	<a class="botao" href="ToyController?action=getAllToyAdm">Voltar</a>


    <main id="Main_ContentET" class="Container_NewToy">
        <jsp:useBean id="toy" scope="session" class="br.edu.toycenter.model.Toy" />
        <form id="Content_EditToy" action="ToyController?action=updateToy" method="POST" enctype="multipart/form-data">

    <div class="title-container">
        <h1 class="titleAlt">Catálogo de Brinquedos: Editar Brinquedo</h1>
        <div class="title-lineAlt" align="center" ></div>
    </div>
            
            <div class="fieldsetBox">
                <label for="code_ET">Code</label>
                <input type="number" placeholder="Digite o Código do Brinquedo" readonly="readonly" name="toy_code" id="code_ET" 
                	value="<%=toy.getId()%>">
            </div>

            <div class="fieldsetBox">
                <label for="name_ET">Nome</label>
                <input type="text" placeholder="Digite o Novo Nome do Brinquedo" name="toy_name" id="name_ET" value="<%=toy.getName()%>">
            </div>
            
            <div class="fieldsetBox">
            <label for="brand_ET">Marca</label>
            <input type="text" placeholder="" name="toy_brand" id="brand_ET" value="<%=toy.getBrand()%>">
            </div>

            <div class="fieldsetBox">
            <label for="description_ET">Descrição</label>
            <input type="text" placeholder="Digite a Nova Descrição do Brinquedo" name="toy_description" id="description_ET" 
            	value="<%=toy.getDescription()%>">
            </div>
            
            <div class="fieldsetImageBox">
            <label for="file_ET">Imagem</label>
            <input type="file" name="toy_image" id="file_ET">
            <img class="img_show" src="<%=toy.getImage()%>" width="400px" height="400px">
            </div>

            <div class="fieldsetPriceBox">
            <label for="price_ET">Valor R$:</label>
            <input type="number" placeholder="Digite o Valor" min="0" step="0.01" class="price_et" name="toy_price"
            	 id="price_ET" value="<%=toy.getPrice()%>">
            </div>


            
                <div>
                    <p class="categoryLabel">Categorias:</p>
                    <select name="toy_categories" id="categorias" multiple>
                    <%
                    List<Category> categoryList = (ArrayList<Category>) request.getAttribute("categoryList");
                    String message = (String) request.getAttribute("message");
                    String message1 = (String) request.getAttribute("message1");

                    for (Category category : categoryList) {
                        boolean status = false;
                        for (Category toyCategory : toy.getCategories()) {
                            if (category.getId() == toyCategory.getId()) {
                    %>
                               <option value="<%= category.getId() %>" selected><%= category.getName() %></option>
                    <%
                                status = true;
                                break;
                            }
                        }
                        if (!status) {
                    %>
                               <option value="<%= category.getId() %>"><%= category.getName() %></option>
                    <%
                        }
                    }
                    %> 

                </div>
		
			<textarea class="detailsBoxAlt" width="1" name="toy_details"  id="details_NT" ></textarea>
			
			
			<div class="fieldsetBox">
			<label for="details_NT">Detalhes</label>			
			<textarea class="detailsBox" maxlength="1080" placeholder="Escreva os Detalhes do Brinquedo" name="toy_details"  id="details_NT"><%=toy.getDetails()%></textarea>
			</div>

			<div class="fieldsetNT_btn">
			    <button id="confirmBtn" onclick="confirmSubmission()">Salvar</button>
			</div>
             <p>
				<%
				if (!(message == null))
					out.print(message);
				 else if (!(message1 == null))
					out.print(message1);
				%>
			</p>
            
        </form>        
    </main>
    	<script>
	    function confirmSubmission() {
	        if (confirm("Tem certeza de que deseja atualizar este brinquedo?")) {
	            document.getElementById("Content_EditToy").submit();
	        } else {
	            return false;
	        }
	    }
	</script>
	<script> new MultiSelectTag('categorias') </script> 
</body>
</html>


