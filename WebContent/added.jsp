<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%response.setContentType("text/html;charset=utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Pets</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JS/jquery.min.js"></script>
<script src="JS/bootstrap.min.js"></script>
</head>
<style>
	.text-center{
		margin-top:100px;
		
	}
	.btn{
		width: 30%;
		margin-top:150px;
		margin-bottom:10px;
		
	}

</style>
<body>
<div class="text-center">
  <div class = "jumbotron">
  	<c:choose>
	  <c:when test="${param.result == 'true'}">
	    <c:choose>
    	  <c:when test="${cookie.language.value == 'zh'}">
    	  	<h1>商品加入了购物车。</h1>
          </c:when>
    	  <c:otherwise>	
    	  	<h1>Item Added to Cart.</h1>
    	  </c:otherwise>
		</c:choose>
	  </c:when>
	  <c:when test="${param.result == 'false'}">
	    <c:choose>
    	  <c:when test="${cookie.language.value == 'zh'}">
    	  	<h1>商品已在购物车内。</h1>
          </c:when>
    	  <c:otherwise>	
    	  	<h1>Item is Already in the Cart.</h1>
    	  </c:otherwise>
		</c:choose>
	  </c:when>
	  <c:otherwise>
	    <%response.sendError(400);%>
      </c:otherwise>
    </c:choose>
    <div class="container">
      <button onclick="location.href = 'PetsController?page=1';" type="button" class="btn btn-lg btn-danger">Return To Store</button>
      <button onclick="location.href = 'ShoppingCartController';" type="button" class="btn btn-lg btn-warning">View Shopping Cart</button>
    </div>
  </div>  
</div>
<c:if test="${cookie.language.value == 'zh'}">
	<script>
		$('.btn-danger').html('返回到商店');
		$('.btn-warning').html('查看购物车');
    </script>
</c:if>
</body>
</html>