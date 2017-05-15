<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%response.setContentType("text/html;charset=utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
body{
	text-align:center;
	margin:0px auto;
}
form{
	padding-bottom: 50px;
}
.container{
    margin-top: 20vh;
}
.btn{
	width: 41.5%;
	margin-top:10px;
	margin-bottom:10px;
}
.navbar {
      border-radius: 0;
    }

</style>
<title>Fancy Login Page</title>


</head>
<body>
  <nav class="navbar navbar-default " id="notloggedin" style="display:block">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand">ThisIsAWebsite</a>
      </div>
      <ul class="nav navbar-nav navbar-left">
        <li class="active"><a href="#" id="login">Login / Register</a></li>
        <li><a href="PetsController?page=1" id="pets2">View Pets</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a id="guest">You are not logged in</a> </li>
        <li><a href="ShoppingCartController"><span class="glyphicon glyphicon-shopping-cart"></span><span id="cart2">Shopping cart</span></a></li>
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
  <div class="container center_div" >
  
  
  <form id= "loginform" role="form" method = "POST" class="form-horizontal" acceptCharset="UTF-8" >
    <h2 id="logintext">Login</h2>
  	<div class="form-group">
      <label class="control-label col-sm-2 usernametext" for="username">Username:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" id="username1" name="username" placeholder="Enter Username" maxlength = "20">
      </div>
     </div>
     <div class="form-group">
      <label class="control-label col-sm-2 passwordtext" for="password" >Password:</label>
      <div class="col-sm-9">
        <input type="password" class="form-control" id="password1" name="password" placeholder="Enter Password" maxlength = "20">
      </div>
    </div>
    <button type="submit" class="btn btn-info " formaction="SignInController" id="loginbtn">Login</button>
    <button type="button" class="btn btn-info " id="regiformbtn" onclick="document.getElementById('loginform').style.display='none'; document.getElementById('registerform').style.display='block'">Register A New Account</button>
  </form>
  
  
  
  <form name="registerForm" style="display:none" id= "registerform" role="form" method = "POST" acceptCharset="UTF-8" class = "form-horizontal" onsubmit="return validateForm();">
    <h2 id="registertext">Register</h2>
  	<div  id="username"  class="form-group">
      <label class="control-label col-sm-2 usernametext" for="username">Username:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" id="username2" name="username" placeholder="Enter Username (20 Character Max)" maxlength = "20" onkeyup="validateUsername(this.value)" required>
      </div>
    </div>
    <div id="password"  class="form-group" >
      <label class="control-label col-sm-2 passwordtext" for="password">Password:</label>
      <div class="col-sm-9">
        <input type="password" class="form-control" id="password2" name="password" placeholder="Enter Password (8 - 20 Characters, Must Include At Least 1 Lowercase Letter, 1 Uppercase Letter and 1 Special Character )" maxlength = "20" onkeyup="validatePassword(this.value)" required>
      </div>
    </div>
    <div id="email"  class="form-group ">
      <label class="control-label col-sm-2" for="email" id="emailtext">Email:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" name="email" id="emailform" placeholder="Enter Email" maxlength = "254" onkeyup="validateEmail(this.value)" required>
      </div>
    </div>
    <button type="submit" class="btn btn-info " formaction="RegisterController" id="registerbtn">Register</button>
    <button type="button" class="btn btn-info " id="loginformbtn" onclick="document.getElementById('loginform').style.display='block'; document.getElementById('registerform').style.display='none'">Sign In To An Existing Account</button>
  </form>
</div>
  
<c:if test="${sessionScope.username == null }">
	<c:set  var="username"  value="Guest"  scope="session"  />
	<c:set  var="pets"  value=""  scope="session"  />
</c:if>
<c:if test="${sessionScope.username != 'Guest'}">
   <script>
   		window.location="PetsController?page=1";
   </script>
</c:if>  
<c:if test="${cookie.language.value == null}">
    <script type="text/javascript">
 		var userLang = navigator.language || navigator.userLanguage; 
 		userLang = userLang.substring(0, 2);
 		document.cookie = "language=" + userLang;
 		location.reload();
 	</script>
</c:if>    
</body>
<c:if test="${cookie.language.value == 'zh'}">
    <script>
    	$('#cart2').html('购物车');
    	$('#pets2').html('查看宠物');
    	$('#login').html('登陆/注册');
    	$('#guest').html('您还未登录');
    	$('#logintext').html('登录');
    	$('.usernametext').html('用户名');
    	$('.passwordtext').html('密码');
    	$('#loginbtn').html('登录');
    	$('#regiformbtn').html('注册新账号');
    	$('#registertext').html('注册');
    	$('#birthdaytext').html('生日');
    	$('#emailtext').html('电子邮件');
    	$('#gendertext').html('性别');
    	$('#registerbtn').html('注册');
    	$('#loginformbtn').html('登录到已有账号');
    	$('#male').html('男');
    	$('#female').html('女');
    	$('#other').html('其他');
     	$('#username1').attr('placeholder', '请输入用户名');
    	$('#password1').attr('placeholder', '请输入密码');
    	$('#username2').attr('placeholder', '请输入用户名(最多20个字符)');
    	$('#password2').attr('placeholder', '请输入密码(8-20个字符,至少要包含一个小写字母,一个大写字母以及一个符号)');
    	$('#emailform').attr('placeholder', '请输入电子邮件');
    </script>
</c:if>
<script>
function validateForm() {
    var x = document.forms["registerForm"]["email"].value;
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
        alert("Email Is Not Valid");
        return false;
    }
    var y = document.forms["registerForm"]["password"].value;
    if(/[a-z]/.test(y) && /[A-Z]/.test(y) && /[~!@#\$%\^\&*\)\(+=._-]/.test(y) && y.length > 7){
    } else {
        alert("Password Is Not Valid, Must Include At Least 1 Lowercase Letter, 1 Uppercase Letter and 1 Special Character And A Minimum of 8 Character");
        return false;
    }
    if (document.getElementById("username").className === "form-group has-warning"){
    	alert("That username is taken. Try another.");
    	return false;
    }
}
function validateEmail(email){
	var atpos = email.indexOf("@");
    var dotpos = email.lastIndexOf(".");
	var d = document.getElementById("email");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length) {
        d.className = "form-group has-error";
    } else {
        d.className = "form-group has-success";
    }
}
function validatePassword(str){
	var d = document.getElementById("password");
	if(/[a-z]/.test(str) && /[A-Z]/.test(str) && /[~!@#\$%\^\&*\)\(+=._-]/.test(str) && str.length > 7){
        d.className = "form-group has-success";
    } else {
        d.className = "form-group has-error";
    }
}
function validateUsername(str) {
	var xhttp = new XMLHttpRequest();
	var d = document.getElementById("username");
	xhttp.onreadystatechange = function() {
	    if (xhttp.readyState == 4 && xhttp.status == 200) {
	      if (xhttp.responseText === "true"){
	    	  d.className = "form-group has-success";
	   	  } else {
	    	  d.className = "form-group has-warning";
	      }
	    }
	};
	xhttp.open("GET", "CheckNameAction?name="+str, true);
	xhttp.send();
}

</script>	
</html>