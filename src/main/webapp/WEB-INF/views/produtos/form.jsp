<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:url value="/resources/css" var="cssPath" />
<c:url value="/resources/js" var="jsPath" />
<link rel="stylesheet" href="${cssPath}/bootstrap.min.css" />
<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" />
<link rel="stylesheet" href="${cssPath}/bootstrap-theme.min.css" />
<script src="${jsPath}/bootstrap.min.js"></script>
<title>Livro java, Spring, Php e muito mais</title>
<style type="text/css">
body {
	padding: 60px 0px;
}
</style>
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${s:mvcUrl('HC#index').build()}">Casa do Código</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="${s:mvcUrl('PC#listar').build()}">Lista de
							Produtos</a></li>
					<li><a href="${s:mvcUrl('PC#form').build()}">Cadastro de
							Produtos</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
	</nav>
	<div class="container">
		<h1>Cadastro de Produto</h1>
		<form:form action="${s:mvcUrl('PC#gravar').build() }" method="post"
			commandName="produto" enctype="muiltpart/form-data">
			<div class="form-group">
				<label>Titulo</label>
				<form:input path="titulo" cssClass="form-control" />
				<form:errors path="titulo" />
			</div>
			<div>
				<label>Descrição</label>
				<form:textarea path="descricao" cssClass="form-control" />
				<form:errors path="descricao" />
			</div>
			<div class="form-group">
				<label>Paginas</label> <input type="text" name=paginas
					cssClass="form-control">
				<form:errors path="paginas" />
			</div>
			<div class="form-group">
				<label>Data de lançamento</label>
				<form:input path="DataLancamento" cssClass="form-control" />
				<form:errors path="DataLancamento" />
			</div>
			<c:forEach items="${tipos}" var="tipoPreco" varStatus="status">
				<div class="form-group">
					<label>${tipoPreco }</label>
					<form:input type="text" path="listPrecos[${status.index }].valor"
						cssClass="form-control" />
					<form:input type="hidden"
						path="listPrecos[${status.index }].tipoPreco"
						value="${tipoPreco }" />
				</div>
			</c:forEach>
			<button type="submit" class="btn btn-primary">Cadastrar</button>
		</form:form>
	</div>
</body>
</html>