<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.net.URLDecoder"%>
<%response.setContentType("text/html;charset=utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Manage Account</title>
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
<body>
<nav class="navbar navbar-default ">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">ThisIsAWebsite</a>
      </div>
      <ul class="nav navbar-nav navbar-left">
        <li><a href="success.jsp" id = "land">Landing Page</a></li>
        <li  class="active"><a href="#" id = "manage">Manage Account</a></li>
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
<div class="container">
  <h2 id = "info">User Information</h2>
  <table class="table table-striped">
    <thead>
      <tr>
        <th id = "information">Information</th>
        <th id = "value">Value</th>
        <th id = "action">Action</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td id="username">Username</td>
        <td><%out.println(decoded);%></td>
        <td></td>
      </tr>
      <tr>
        <td id="password">Password</td>
        <td id = "currentPassword"><c:out value="${user.password}" /></td>
        <td id = "changePassword" style="display:none">
          <form class="form-inline" role="form"  method = "POST" acceptCharset="UTF-8">
		    <label id = "newpassword">New Password</label>
			<input type="text" class="form-control" name = "Password" id="passwordform" placeholder="Insert new Password" maxlength = "20" required >
			<button type="submit" class="btn btn-info">Submit</button>
		  </form>
		</td>    
        <td><a onclick="changePassword()" class="change">Change</a></td>
      </tr>
      <tr>
        <td id="email">Email</td>
        <td id = "currentEmail"><c:out value="${user.email}" /></td>
        <td id = "changeEmail" style="display:none">
          <form class="form-inline" role="form"  method = "POST" acceptCharset="UTF-8">
		    <label id = "newemail">New Email</label>
			<input type="email" class="form-control" name = "Email" id="emailform" placeholder="Insert new Email" maxlength = "30" required>
			<button type="submit" class="btn btn-info">Submit</button>
		  </form>
		</td>      
        <td><a onclick="changeEmail()"  class="change">Change</a></td>
      </tr>
      <tr>
        <td id="picture">Profile Picture</td>
        <td id = "currentPic"><img src="IMG/users/<%out.println(decoded);%>.jpg" onerror="if (this.src != 'IMG/users/default.jpg') this.src = 'IMG/users/default.jpg';" height = "50px"></td>
        <td id = "changePic" style="display:none">
          <form action="UploadServlet" method="post" enctype="multipart/form-data">
    		<input type="file" name="file" id = "f" accept="image/png image/jpeg"/>
    		<input type="submit"/>
		  </form>
		</td>
        <td><a onclick="changePic()"  class="change">Change</a></td>
      </tr>
      <tr>
        <td id="address">Address</td>
        <td id = "currentAddress"><c:out value="${user.address}" /></td>
        <td id = "changeAddress" style="display:none">
          <form class="form-inline" role="form"  method = "POST" acceptCharset="UTF-8">
		    <label id = "newaddress">New Address</label>
			<input type="text" class="form-control" name = "DefaultAddress" id="addressform" placeholder="Insert new Address" required>
			<button type="submit" class="btn btn-info">Submit</button>
		  </form>
		</td>      
        <td><a onclick="changeAddress()"  class="change">Change</a></td>
      </tr>
    </tbody>
  </table>
</div>
<c:if test="${cookie.language.value == 'zh'}">
    <script>
    	$('#signout').html('登出');
    	$('#welcome').html('欢迎');
    	$('#cart').html('购物车');
    	$('#land').html('到达页面');
    	$('#manage').html('管理账号');
    	$('#pets').html('查看宠物');
    	$('#info').html('用户信息');
    	$('#information').html('信息');
    	$('#value').html('值');
    	$('#action').html('指令');
    	$('#username').html('账号');
    	$('#password').html('密码');
    	$('#email').html('电子邮箱');
    	$('#birthday').html('生日');
    	$('#picture').html('用户图片');
    	$('#address').html('默认地址');
    	$('#newpassword').html('新密码');
    	$('#newbirthday').html('新生日');
    	$('#newemail').html('新邮箱');
    	$('#newaddress').html('新地址');
    	$('.change').html('修改');
    	$('.btn').html('上传');
    	$('#passwordform').attr("placeholder", "输入新的密码");
    	$('#emailform').attr("placeholder", "输入新的邮箱");
    	$('#addressform').attr("placeholder", "输入新的地址");
    </script>
</c:if>
<script>

function changeAddress() {
	document.getElementById('currentAddress').style.display='none';
	document.getElementById('changeAddress').style.display='block';
}
function changePic() {
	document.getElementById('currentPic').style.display='none';
	document.getElementById('changePic').style.display='block';
}
function changeBirthday() {
	document.getElementById('currentBirthday').style.display='none';
	document.getElementById('changeBirthday').style.display='block';
}
function changeEmail() {
	document.getElementById('currentEmail').style.display='none';
	document.getElementById('changeEmail').style.display='block';
}
function changePassword() {
	document.getElementById('currentPassword').style.display='none';
	document.getElementById('changePassword').style.display='block';
}

var fl = document.getElementById('f');
fl.onchange = function(e){ 
    var ext = this.value.match(/\.(.+)$/)[1];
    switch(ext)
    {
        case 'jpg':
        case 'png':	
            break;
        default:
            alert('File extension not permitted');
            this.value='';
    }
};
</script>
</html>
