<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.net.URLDecoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>Welcome</title>
<style>
    .navbar {
      margin-bottom: 50px;
      border-radius: 0;
    }
</style>
</head>
<c:set var="name" value="${sessionScope.username}"/>
<%String username = (String)pageContext.getAttribute("name");
String decoded = URLDecoder.decode(username,"UTF-8");%>
<nav class="navbar navbar-default ">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">ThisIsAWebsite</a>
      </div>
      <ul class="nav navbar-nav navbar-left">
        <li  class="active"><a href="#" id = "land">Landing Page</a></li>
        <li><a href="AdminManageController" id = "manage">Manage Account</a></li>
        <li><a href="PetsController?page=1" id = "pets">View Pets</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><img src="IMG/users/${sessionScope.username}.jpg" onerror="if (this.src != 'IMG/users/default.jpg') this.src = 'IMG/users/default.jpg';" height = "50px"></li>
        <li><a id="topright"> <span id="welcome">Welcome</span><%out.print(decoded);%></a></li>
        <li><a href="ShoppingCartController"><span class="glyphicon glyphicon-shopping-cart"></span><span id="cart">Shopping cart</span></a></li>
        <li><a href="SignOutController" id="signout">Sign out</a></li>
        <li class="dropdown">
        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Lang/语言 <span class="caret"></span></a>
            <ul class="dropdown-menu">
            <li><a href="changeLanguage?lang=EN">English</a></li>
            <li><a href="changeLanguage?lang=zh">中文</a></li>
      		</ul>
      	</li>
    </div>
</nav>

<c:if test="${sessionScope.username == 'Guest'}">
    <%response.sendError(401);%>
</c:if>  

<c:if test="${cookie.language.value == 'zh'}">
    <script>
    	$('#signout').html('登出');
    	$('#welcome').html('欢迎');
    	$('#cart').html('购物车');
    	$('#land').html('到达页面');
    	$('#manage').html('管理账号');
    	$('#pets').html('查看宠物');
    </script>
</c:if>
<img src="http://i.imgur.com/MbaQr.png" alt="Approved" style="width:272px;height:231px">

</body>
</html>