<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tony.shop.service.UserService" %>
<%@ page import="java.net.URLDecoder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%response.setContentType("text/html;charset=utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Pets</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    .navbar {
      margin-bottom: 20px;
      border-radius: 0;
    }
    footer {
      background-color: #f2f2f2;
      padding: 10px;
    }
    .center_div{
	    margin-bottom: 20px;
	    margin-left: 20%;
	    margin-right: 20%;
	}
	.dropdown-menu {
	    width: 100%;
	}
	form{
		width: 90%;
		margin-left: 5%;
	    margin-right: 5%;
	}
	.row {
	 -moz-column-width: 25em;
	 -webkit-column-width: 25em;
	 -moz-column-gap: .5em;
	 -webkit-column-gap: .5em; 
	  
	}
	
	.panel {
	 display: inline-block;
	 margin:  .2em;
	 width:98%;
	}
	.popover  {
	background: gold;
	}
	.popover.top .arrow:after {
  	border-top-color:gold;
	}
	.container{
    	margin-bottom: 75px;
    }
     .modal-dialog {
      width: 300px;
      margin-top:80px;
    }
  </style>
</head>
<body>
<c:if test="${sessionScope.username == null }">
	<c:set  var="username"  value="Guest"  scope="session"  />
	<c:set  var="pets"  value=""  scope="session"  />
</c:if>
<c:if test="${param.page == null}">
	<c:redirect url="PetsController?page=1"/>
</c:if>

<c:set var="name" value="${sessionScope.username}"/>
	<%String username = (String)pageContext.getAttribute("name");
	String decoded = URLDecoder.decode(username,"UTF-8");%>
<c:if test="${name == null}">
	<c:set var="name" value="Guest" scope="session"  />
</c:if>
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
        <li class="active"><a href="#" id="pets2">View Pets</a></li>
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
  <nav class="navbar navbar-default " id="loggedin" style="display:none">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">ThisIsAWebsite</a>
      </div>
      <ul class="nav navbar-nav navbar-left">
        <li><a href="success.jsp" id = "land">Landing Page</a></li>
        <li><a href="AdminManageController" id = "manage">Manage Account</a></li>
        <li class="active"><a href="#" id = "pets">View Pets</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li><img src="IMG/users/<c:url value="${sessionScope.username}"/>.jpg" onerror="if (this.src != 'IMG/users/default.jpg') this.src = 'IMG/users/default.jpg';" height = "50px"></li>
        <li><a id="topright"><span id="welcome">Welcome</span><%out.print(decoded);%></a></li>
        <li><a href="ShoppingCartController"><span class="glyphicon glyphicon-shopping-cart"></span><span id="cart">Shopping cart</span></a></li>
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
<div class="dropdown dropdown-lg center_div">
	<button type="button" class="btn btn-info btn-block dropdown-toggle" data-toggle="dropdown"> <span class="glyphicon glyphicon-search" aria-hidden="true"></span> </button>
    	<div class="dropdown-menu" role="menu">
        	<form class="form" role="form" method = "GET">
            	<div class="form-group">
                	<label for="filter" id="filter">Filter by</label>
                    <select class="form-control" name="type">
                    	<option value="" id="all" selected>All Pets</option>
                    	<c:forEach items="${typeList}" var="type">
                        	<option value="${type}" id="${type}">${type}</option>
                        </c:forEach>
					</select>
                </div>
				<div class="form-group">
	                <label for="contain" id="name">Breed Types:</label>
	                <input class="form-control" type="text" name="breed" id="nameinput" placeholder="Enter breed"/>
            	</div>
            	<div class="form-inline" >
	                <label for="contain" id="age">Age:</label>
	                <input class="form-control" type="number" name="ageLow" id="agelow" placeholder="Minimum Age"/>
	                <label>-</label>
	                <input class="form-control" type="number" name="ageHigh" id="agehigh" placeholder="Maximum Age"/>
	                <input type = "hidden" name = "page" value = "1" />
            	</div>
            	<button type="submit" class="btn btn-primary pull-right"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
        	</form>
    	</div>
	</div>
<body>
    
    
  <div class="container">
    <div class="row" id = "current">
      <c:forEach items="${pets}" var="pet">
          <div class="panel panel-info">
            <div class="panel-heading .text-primary"><h3><c:out value="${pet.type}" /> - <c:out value="${pet.breed}" /></h3></div>
            <br>
            <img src="IMG/pets/<c:url value="${pet.id}"/>.jpg" onerror="if (this.src != 'IMG/pets/default.jpg') this.src = 'IMG/pets/default.jpg';" class="img-responsive petimage" style="width:100%">
            <br>
            <div class="panel-footer"><button onclick="redirect(${pet.id})" type="button" class="btn  btn-warning pull-right"><span class="glyphicon glyphicon-shopping-cart"></span>Take Me Home</button><button type="button" class="btn btn-danger" data-toggle="modal" data-target="#${pet.id}">View Information</button></div> 
    	  </div>
    	  <div class="modal fade " id="${pet.id}">
    	    <div class="modal-dialog">
			  <div class="modal-content">
			    <div class="modal-header">
         		  <button type="button" class="close" data-dismiss="modal">&times;</button>
         		  <h3><c:out value="${pet.type}" /> - <c:out value="${pet.breed}" /></h3>
        		</div>
			  	<div class="modal-body">
			  	
			  	  <img src="IMG/pets/<c:url value="${pet.id}"/>.jpg" onerror="if (this.src != 'IMG/pets/default.jpg') this.src = 'IMG/pets/default.jpg';" class="img-responsive" style="width:100%">
			  	  <br>
			  	  <h3><span class="age">Age</span>: <c:out value="${pet.age}" /><br> <span class="price">Price</span>: <c:out value="${pet.price}" /></h3>
			  	</div>
			  </div>
			</div>
    	  </div>
      </c:forEach>
    </div>
  </div>
</body>


<footer class="container-fluid text-center footer navbar-fixed-bottom">
    <a id = "prev" href="?name=${param.breed}&type=${param.type}&ageLow=${param.ageLow}&ageHigh=${param.ageHigh}&page=<%=String.valueOf(Integer.parseInt(request.getParameter("page")) - 1) %>" class="btn btn-info">Previous</a>    
    <input value = "${param.page}" type = "number" min = "1" max = "${pageNum}" id = "page">
    <button onclick="page()" class="btn btn-default"><span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span></button>
	<a id = "next" href="?name=${param.breed}&type=${param.type}&ageLow=${param.ageLow}&ageHigh=${param.ageHigh}&page=<%=String.valueOf(Integer.parseInt(request.getParameter("page")) + 1) %>" class="btn btn-info">Next</a>
</footer>

<c:if test="${pageNum == page}">
   <script>
     var d = document.getElementById("next");
     d.className = d.className + " disabled";
   </script>
</c:if>

<c:if test="${page == 1}">
   <script>
   var d = document.getElementById("prev");
   d.className = d.className + " disabled";
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
<c:choose>
    <c:when test="${sessionScope.username != 'Guest'}">
       <script>
		document.getElementById('notloggedin').style.display='none';
		document.getElementById('loggedin').style.display='block';
		</script>
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
		$('.btn-danger').html('查看信息');
		$('.btn-warning').html('带我回家');
		$('#prev').html('上页');
    	$('#next').html('下页');
    	$('#filter').html('按类型查找');
    	$('#all').html('所有宠物');
    	$('#breed').html('按品种查找');
    	$('#age').html('按岁数查找');
    	$('.age').html('年龄');
    	$('.price').html('价格');
    	$('#breedinput').attr("placeholder", "输入种类");
    	$('#agelow').attr("placeholder", "最低年龄");
    	$('#agehigh').attr("placeholder", "最高年龄");
    </script>
</c:if>
<script>
$('img.img-petimage').height($('img.img-pet.image').width())
function page(){
	window.location = "?name=${param.breed}&type=${param.type}&ageLow=${param.ageLow}&ageHigh=${param.ageHigh}&page=" + document.getElementById('page').value;
}
function redirect(x) {
	window.setTimeout(function(){window.location = "AddToCartController?petId=" + x;}, 200);
}
if (window.location.hash) {
	var hash = window.location.hash;
	$(hash).modal('toggle');
}

</script>

</body>
</html>

