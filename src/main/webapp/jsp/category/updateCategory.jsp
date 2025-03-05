<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
    <title>Atualizar Categoria</title>
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
	

	<a class="botao" href="CategoryController?action=getAllCategoryAdm">Voltar</a>

	
    <main id="Main_ContentCT" class="Container_NewToy">
    	<jsp:useBean id="category" scope="session" class="br.edu.toycenter.model.Category" />
		<form id="Content_EditCategory" action="CategoryController?action=updateCategory" method="POST" enctype="multipart/form-data">

    <div class="title-container">
        <h1 class="titleAlt">Categoria: Editar categoria</h1>
        <div class="title-lineAlt" align="center" ></div>
    </div>

            <div class="fieldsetBox">
                <label for="code_EC">Code</label>
                <input type="number" placeholder="Digite o Código da Categoria" name="category_code"
                    id="code_EC" value="<%=category.getId()%>" readonly="readonly" required>
            </div>

            <div class="fieldsetBox">
                <label for="name_EC">Nome</label>
                <input type="text" placeholder="Digite o Novo Nome da Categoria" name="category_name" id="name_EC" 
                value="<%=category.getName()%>" required>
            </div>


            <div class="fieldsetImageBox">
                <label for="file_EC">Imagem</label>
                <input type="file" name="category_image" id="file_EC">
                <img class="img_show" src="<%=category.getImage()%>"> <br> 
            </div>

			<div class="centralize">
			    <button id="confirmBtn" onclick="confirmSubmission()">Salvar</button>
			</div>
        </form>
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
</body>

</html>