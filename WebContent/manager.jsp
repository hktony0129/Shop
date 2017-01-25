<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Manage People</title>
<style>
	.navbar {
      margin-bottom: 50px;
      border-radius: 0;
    }
</style>
</head>
<body>
<nav class="navbar navbar-default ">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">ThisIsAWebsite</a>
      </div>
      <ul class="nav navbar-nav navbar-left">
        <li><a href="main.jsp">Main Page</a></li>
        <li><a href="success.jsp">Landing Page</a></li>
        <li class="active"><a href="#">Manage Account</a></li>
        <li><a href="PetsController?page=1">View Pets</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><img src="IMG/users/<c:url value="${cookie.username.value}"/>.jpg" onerror="if (this.src != 'IMG/users/default.jpg') this.src = 'IMG/users/default.jpg';" height = "50px"></li>
        <li><a id="topright"></a></li>
        <li><a href="ShoppingCartController"><span class="glyphicon glyphicon-shopping-cart"></span>Shopping cart</a></li>
        <li><a href="SignOutController">Sign out</a></li>
      </ul>
    </div>
</nav>
<div class="container">
<c:if test = "${sessionScope.username != 'Superuser'}">
	<c:redirect url="UserManageController"/>
</c:if>
<h2 id = "test">User Information </h2>
	<table class="table table-striped">
	<thead>
	  <tr>
	    <th>Id</th>
	    <th>Username</th>
	    <th>Password</th>
	    <th>Email</th>
	    <th>Operation</th>
	  </tr>
	 </thead>
	  <c:forEach items="${users}" var="user">
	  	<tr>
	  	  <td>${user.id}</td>
	  	  <td><c:out value="${user.username}" /></td>
	  	  <td><c:out value="${user.password}" /></td>
	  	  <td><c:out value="${user.email}" /></td>
		  <td><a href="AdminManageController?action=delete&userId=<c:out value="${user.id}"/>">Delete</a></td>
	  	</tr>
	  </c:forEach>
	</table>
</div>
</body>
</html>