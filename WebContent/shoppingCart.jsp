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
<link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>Shopping Cart</title>
<style>
    .navbar {
      border-radius: 0;	
    }
    td {
      padding-top: .5em;
      padding-bottom: .5em;
   	  font-size: 25px;
   	  font-family: 'Montserrat', sans-serif;
	}
	.table tbody>tr>td.vert-align{
    	vertical-align: middle;
	}
	span.glyphicon-remove{
		color: black !important;
    	text-decoration: none;
	}
	span.glyphicon-remove:hover{
		color:#424949   !important;
	}
	footer {
	
      background-color: #f2f2f2;
      padding: 10px;
    }
    h1{
    	margin-bottom: 40px;
    }
    .pull-right{
    	margin-right: 100px;
    }
    #icon{
    	font-size: 12px;
    }
    .container{
    	margin-bottom: 80px;
    }
    .modal-dialog {
      width: 300px;
      margin-top:150px;
    }
    form{
    	margin:20px;
    }
    .input-group-addon {
  	background: white;
	}
	textarea {
    resize: none;
	}
	select{
		width: 50% !important;
	}
</style>
</head>
<c:set var="name" value="${sessionScope.username}"/>
<%String username = (String)pageContext.getAttribute("name");
String decoded = URLDecoder.decode(username,"UTF-8");%>
<c:if test="${cookie.language.value == null}">
    <script type="text/javascript">
 		var userLang = navigator.language || navigator.userLanguage; 
 		userLang = userLang.substring(0, 2);
 		document.cookie = "language=" + userLang;
 		location.reload();
 	</script>
</c:if>  
<nav class="navbar navbar-default " id="notloggedin" style="display:block">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand">ThisIsAWebsite</a>
      </div>
      <ul class="nav navbar-nav navbar-left">
        <li><a href="main.jsp" id="login">Login / Register</a></li>
        <li><a href="PetsController?page=1" id="pets2">View Pets</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a id="guest">You are not logged in</a> </li>
        <li  class="active"><a href="#"><span class="glyphicon glyphicon-shopping-cart"></span><span id="cart2">Shopping cart</span></a></li>
      	<li class="dropdown">
        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Lang/语言 <span class="caret"></span></a>
            <ul class="dropdown-menu">
            <li><a href="changeLanguage?lang=EN">English</a></li>
            <li><a href="changeLanguage?lang=zh">中文</a></li>
      		</ul>
      	</li>
      </ul>
    </div>
  </nav>
  <nav class="navbar navbar-default " id="loggedin" style="display:none">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">ThisIsAWebsite</a>
      </div>
      <ul class="nav navbar-nav navbar-left">
        <li><a href="success.jsp" id = "land">Landing Page</a></li>
        <li><a href="AdminManageController" id = "manage">Manage Account</a></li>
        <li><a href="PetsController?page=1" id = "pets">View Pets</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li><img src="IMG/users/<c:url value="${sessionScope.username}"/>.jpg" onerror="if (this.src != 'IMG/users/default.jpg') this.src = 'IMG/users/default.jpg';" height = "50px"></li>
        <li><a id="topright"><span id="welcome">Welcome</span><%out.print(decoded);%></a></li>
        <li  class="active"><a href="ShoppingCartController"><span class="glyphicon glyphicon-shopping-cart"></span><span id="cart">Shopping cart</span></a></li>
        <li><a href="SignOutController" id="signout">Sign out</a></li>
      	<li class="dropdown">
        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Lang/语言 <span class="caret"></span></a>
            <ul class="dropdown-menu">
            <li><a href="changeLanguage?lang=EN">English</a></li>
            <li><a href="changeLanguage?lang=zh">中文</a></li>
      		</ul>
      	</li>
      </ul>
    </div>
  </nav>

<div class="container">
	<div class = "text-center">
		<h1><b id="title">SHOPPING CART</b></h1>
	</div>
	<table class="table table-hover">
      <c:set var="total" value="${0}"/>
	  <c:forEach items="${pets}" var="pet">
	    <tr>
  	      <fmt:parseNumber var="i" integerOnly="true" type="number" value="${(pet.id - 1) / 8 + 1}" />
  	      <td class="col-md-1"><a href="PetsController?page=<c:url value="${i}"/>#<c:url value="${pet.id}"/>"><img src="IMG/pets/<c:url value="${pet.id}"/>.jpg" onerror="if (this.src != 'IMG/pets/default.jpg') this.src = 'IMG/pets/default.jpg';" class="img-rounded" height="60"></a></td>
  	      <td class="col-md-2 text-center vert-align "><a href="PetsController?page=<c:url value="${i}"/>#<c:url value="${pet.id}"/>"><c:out value="${pet.breed}" /></a></td>
  	      <td class="col-md-6 text-center vert-align"><span class="<c:out value="${pet.type}" />"><c:out value="${pet.type}" /></span>, <span class="age">Age</span>: <c:out value="${pet.age}" /></td>
  	      <td class="col-md-1 text-center vert-align"><input class = "inputs" type="number" min="1" max = "20" step="1" value="1" oninput="myFunction()"/></td>
  	      <td class="col-md-1 text-center vert-align prices">$<c:out value="${pet.price}" /></td>
  	      <td class="col-md-1 text-center vert-align"><a href="DeleteFromCartController?petId=${pet.id}"><span class="glyphicon glyphicon-remove" id = "icon"></span></a></td>
  	    </tr>
  	    <c:set var="total" value="${total + pet.price}"/>  
	  </c:forEach>
  </table>
  <hr>
  	<div class = "pull-right">
		<h3><b><span id = "totaltext">Your Total</span>: $<span id = "total"><c:out value="${total}"/></span></b></h3>
		<br>
		<button onclick="openModal()" id ="checkOut" type="button" class="btn btn-danger btn-block"  >Check Out</button>
	</div>
</div>
<div class="modal fade " id="checkOutModal">
    <div class="modal-dialog">

      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"  id = "modalheader">Please Log In First</h4>
        </div>
        <div class="modal-body" id = "modalbody">
          <form id= "checkoutform" role="form" method = "POST" class="form-horizontal ">
          	<div class="input-group">
	          <span class="input-group-addon">
	            <i class="glyphicon glyphicon-user"></i>
	   	 	  </span>
		      <input type="text" class="form-control" name="username" maxlength = "20" placeholder="Username" id = "username">
		    </div>
		    <br>
		    <div class="input-group" id = "pwd">
		      <span class="input-group-addon">
	            <i class="glyphicon glyphicon-lock"></i>
	   	 	  </span>
		      <input type="password" class="form-control" id = "password" name="password" placeholder="Password" maxlength = "20" >
		    </div>
		    <br>
          </form>
          <button type="button" class="btn btn-info btn-block" id = "but" onclick="validatePassword()"><strong>Login</strong></button>
        </div>
      </div>
      
    </div>
  </div>
</body>
<c:choose>
    <c:when test="${sessionScope.username != 'Guest'}">
       <script>
		document.getElementById('notloggedin').style.display='none';
		document.getElementById('loggedin').style.display='block';
		</script>
		<c:if test="${total != 0}">
	      <script>
			$("#checkOut").attr("onclick", "redirect();");
		  </script>
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
    </c:when>
    <c:otherwise>
        <c:if test="${cookie.language.value == 'zh'}">
		    <script>
		    	$('#cart2').html('购物车');
		    	$('#pets2').html('查看宠物');
		    	$('#login').html('登陆/注册');
		    	$('#guest').html('您还未登录');
		    </script>
		</c:if>
    </c:otherwise>
</c:choose>
<c:if test="${cookie.language.value == 'zh'}">
	<script>
		$('#title').html('购物车');
		$('#totaltext').html('总金额');
		$('#checkOut').html('付款');
		$('.age').html('年龄');
    	$('.Turtle').html('类别: 乌龟');
    	$('.Toucan').html('类别: 犀鸟');
    	$('.Dog').html('类别: 狗');
    	$('#modalheader').html('请先登录');
    	$('#username').attr("placeholder","用户名");
    	$('#password').attr("placeholder","密码");
    </script>
</c:if>

<script>
function myFunction() {
    var x = document.getElementsByClassName("inputs");
    var y = document.getElementsByClassName("prices");
    var price = 0;
    for (i = 0; i < y.length; i++){
    	if(x[i].value > 20){
    		x[i].value = 20;
    	} else if (x[i].value < 1){
    		x[i].value = 1;
    	}
    	price += parseInt(y[i].innerHTML.substring(1))* x[i].value;
    }
    document.getElementById("total").innerHTML = price.toString();
}
function openModal(){
	
	var x = document.getElementsByClassName("inputs");
    var y = document.getElementsByClassName("prices");
    var price = 0;
    for (i = 0; i < y.length; i++){
    	price += parseInt(y[i].innerHTML.substring(1))* x[i].value;
    }
    $(checkOutModal).modal({backdrop: "static"});
    if (price == 0){
    	document.getElementById("modalheader").innerHTML = "";
    	var lang = getCookie("language");
    	if(lang === "zh"){
    		document.getElementById("modalbody").innerHTML = "购物车是空的";
    	} else {
    		document.getElementById("modalbody").innerHTML = "Your Cart is Empty";
    	}
    }
}

function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}
function redirect(){
	var y = document.getElementsByClassName("inputs");
	var amount = "";
	for (i = 0; i < y.length; i++){
		amount = amount + y[i].value.toString() + ",";
	}
	amount = amount.slice(0, -1);
	post({amounts: amount,});
}

function post(params) {
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "CheckOutController");

    for(var key in params) {
        if(params.hasOwnProperty(key)) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);
            form.appendChild(hiddenField);
         }
    }

    document.body.appendChild(form);
    form.submit();
}
function getCookie(name) {
	  var value = "; " + document.cookie;
	  var parts = value.split("; " + name + "=");
	  if (parts.length == 2) return parts.pop().split(";").shift();
}

function validatePassword(){
	var xhttp = new XMLHttpRequest();
	var u = document.getElementById("username").value;
	var p = document.getElementById("password").value;
	xhttp.onreadystatechange = function() {
	    if (xhttp.readyState == 4 && xhttp.status == 200) {
	    	if(xhttp.responseText == "true"){
	    		location.reload();
	    	} else {
	    		$('#pwd').addClass("has-error");
	    	}
	    }
	};
	xhttp.open("Post", "ValidatePasswordController", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("username=" + u + "&password=" + p);
}
</script>
</html>