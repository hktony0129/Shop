<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://spin.js.org/spin.min.js"></script>


<style>
	.title{
		margin-bottom: 50px;
	}
	.subtitle{
		background-color: rgb(209,209,209);
		margin-bottom: 5px;
    	vertical-align: middle;
    	font-size:20px;
	}
	.marginbot{
		margin-bottom:10px;
	}
	textarea {
  	 resize: none;
	}
	.well{
		background-color: rgb(248,248,248);
	}
	.btn.btn-lg {
        width: 49.6%;
        height: 50px;
        padding: 13px 13px;
        font-size: 18px;
        line-height: 1.33;
     }
     body{
     	margin-bottom:20px;
     }
</style>
<c:set var="name" value="${sessionScope.username}"/>
<%String username = (String)pageContext.getAttribute("name");
String decoded = URLDecoder.decode(username,"UTF-8");%>
<nav class="navbar navbar-default ">
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
        <li><img src="IMG/users/${sessionScope.username}.jpg" onerror="if (this.src != 'IMG/users/default.jpg') this.src = 'IMG/users/default.jpg';" height = "50px"></li>
        <li><a id="topright"> <span id="welcome">Welcome</span><%out.print(decoded);%></a></li>
        <li><a href="ShoppingCartController"><span class="glyphicon glyphicon-shopping-cart"></span><span id="cart">Shopping cart</span></a></li>
        <li><a href="SignOutController" id="signout">Sign out</a></li>
    </div>
</nav>

<c:if test="${sessionScope.username == 'Guest'}">
    <%response.sendError(401);%>
</c:if>  

<title>Check Out</title>

</head>
<body>

<div class="container">
  <div class=" text-center title"><h1><b id="title" >CHECK OUT</b></h1></div>
  <div class="row">
    <div class="col-sm-6">
      <div class="subtitle"><p><b id="sub1">&nbsp;Shipping Information</b></p></div>
      <form role="form" class= "well">
      	<div class="marginbot"><b id="addselect">Select An Address:</b></div>
      	<div class="form-group" id="addressdiv">
          <textarea style="min-width: 100%" rows="3" id="address" class="form-control" readonly >${address}</textarea>
        </div>
        <br>
        <div data-toggle="buttons">
          <label class="btn btn-default btn-lg active" id = "oldadd" onclick="defaultadd()">Default Address</label>
          <label class="btn btn-default btn-lg" id = "newadd" onclick="newadd()">New Address</label>
        </div>
      </form>
    </div>
    <div class="col-sm-6" >
      <div class="subtitle"><p><b id="sub2">&nbsp;Shipping Method</b></p></div>
      <form role="form" class= "well">
      	<b id="free">Free Shipping</b>
        <div class="radio">
          <label><input type="radio" name="optradio" value="0" onclick="handleClick(this)" checked ><span id="standard">Standard Shipping</span> <b>$0</b></label>
        </div>
        <b id="express">Express Delivery</b>
        <div class="radio">
          <label><input type="radio" name="optradio" value="6" onclick="handleClick(this)"><span id="4day">4 Days Express Shipping</span> <b>$6</b></label>
        </div>
        <div class="radio">
          <label><input type="radio" name="optradio" value="18" onclick="handleClick(this)"><span id="2day">2 Days Air</span> <b>$18</b></label>
        </div>
        <div class="radio">
          <label><input type="radio" name="optradio" value="30" onclick="handleClick(this)"><span id="1day">24 Hours Delivery</span> <b>$30</b></label>
        </div>
      </form>
    </div>
  </div>
  <div class="row">
    <div class="col-sm-6">
      <div class="subtitle"><p><b id="sub3">&nbsp;Payment Method</b></p></div>
      	<div class = "well">
	        <div class="input-group" id = "carddiv">
			  <span class="input-group-addon">
		        <i class="glyphicon glyphicon-credit-card"></i>
		   	  </span>
		      <input type="text" class="form-control" name="card" id="card" placeholder="Credit Card" maxlength = "19">
			</div>
			<div class="input-group" id = "persondiv">
			  <span class="input-group-addon">
		        <i class="glyphicon glyphicon-user"></i>
		   	  </span>
		      <input type="text" class="form-control" name="name" id="person" placeholder="Name On The Card" maxlength = "30">
		    </div>
			<div class="input-group" id = "datediv">
			  <span class="input-group-addon">
		        <i class="glyphicon glyphicon-calendar"></i>
		   	  </span>
			  <select class="form-control" name="expiry-month" id="expiry-month">
	            <option value="" id="month">Month</option>
	            <option value="01">01</option>
	            <option value="02">02</option>
	            <option value="03">03</option>
	            <option value="04">04</option>
	            <option value="05">05</option>
	            <option value="06">06</option>
	            <option value="07">07</option>
	            <option value="08">08</option>
	            <option value="09">09</option>
	            <option value="10">10</option>
	            <option value="11">11</option>
	            <option value="12">12</option>
	          </select>
	          <select class="form-control" name="expiry-month" id="expiry-year">
	            <option value="" id="year">Year</option>
	            <option value="16">2016</option>
	            <option value="17">2017</option>
	            <option value="18">2018</option>
	            <option value="19">2019</option>
	            <option value="20">2020</option>
	            <option value="21">2021</option>
	            <option value="22">2022</option>
	            <option value="23">2023</option>
	            <option value="24">2024</option>
	            <option value="25">2025</option>
	            <option value="26">2026</option>
	            <option value="27">2027</option>
	          </select>
		   </div>
		   <div class="input-group" id = "codediv">
			  <span class="input-group-addon">
		        <i class="glyphicon glyphicon-lock"></i>
		   	  </span>
		      <input type="text" class="form-control" name="card" id = "securitycode" placeholder="CARD VERIFICATION VALUE CODE (CVV)" maxlength = "4">
		  </div>
	   </div>
    </div>
    <div class="col-sm-6" >
      <div class="subtitle"><p><b id="sub4">&nbsp;Cost total</b></p></div>
      <form role="form" class= "well">
      	<b id="items">Items:</b>
      	<br>
      	<c:set var="subtotal" value="${0}"/>
      	<c:forEach items="${pets}" var="pet" varStatus="status">
      	  &nbsp;&nbsp;<c:out value="${pet.breed}"/></a>
  	      $<c:out value="${pet.price}" /> * <c:out value="${amounts[status.index]}" /> = $<c:out value="${amounts[status.index] * pet.price}" />
  	      <c:set var="subtotal" value="${subtotal + amounts[status.index] * pet.price}"/>  
  	      <br>
  	      
      	</c:forEach>
      	<b><span id="subtotaltext">Subtotal</span>: $<span id="subtotal"><c:out value="${subtotal}"/></span>
      	<br><br>
        <span id="shippingtext">Shipping Price</span>: $<span id="shipping">0</span>
        <br><br>
        <span id="totaltext">Total</span>: $<span id="total"><c:out value="${subtotal}"/></span></b>
      </form>
    </div>
  </div> 
<button type="button" class="btn btn-danger btn-block" id = "pay"><strong>Pay $<c:out value="${subtotal}"/></strong>  </button>
</div>
</body>
<c:if test="${cookie.language.value == 'zh'}">
    <script>
    	$('#signout').html('登出');
    	$('#welcome').html('欢迎');
    	$('#cart').html('购物车');
    	$('#land').html('到达页面');
    	$('#manage').html('管理账号');
    	$('#pets').html('查看宠物');
    	$('#title').html('付款');
    	$('#sub1').html('收货地址');
    	$('#sub2').html('邮寄信息');
    	$('#sub3').html('付款方式');
    	$('#sub4').html('总金额 ');
    	$('#addselect').html('选择收货地址');
    	$('#oldadd').html('默认地址');
    	$('#newadd').html('新地址');
    	$('#free').html('包邮');
    	$('#express').html('快递');
    	$('#standard').html('平邮');
    	$('#4day').html('4天陆运');
    	$('#2day').html('2天空运');
    	$('#1day').html('隔夜递');
    	$('#card').attr("placeholder","信用卡号");
    	$('#person').attr("placeholder","持卡人姓名");
    	$('#month').html('月份');
    	$('#year').html('年份');
    	$('#securitycode').attr("placeholder","CVV代码");
    	$('#items').html('商品:');
    	$('#subtotaltext').html('累计');
    	$('#shippingtext').html('运费');
    	$('#totaltext').html('总金额');
    </script>
</c:if>
<script>
function defaultadd(){
	if ($('#oldadd').hasClass("disabled")){
		newadd();
	} else {
		$('#address').attr('readonly','readonly');
		$('#address').val('${address}');
		$('#oldadd').addClass("active");
		$('#newadd').removeClass("active");
	}
}
function newadd(){
	$('#address').removeAttr('readonly');
	$('#address').val('');
	$('#newadd').addClass("active");
	$('#oldadd').removeClass("active");
}

function handleClick(radio) {
	document.getElementById("shipping").innerHTML = radio.value;
	document.getElementById("total").innerHTML = parseInt(radio.value) + parseInt(<c:out value="${subtotal}"/>);
	document.getElementById("pay").innerHTML = "<strong>Pay $" + (parseInt(radio.value) + parseInt(<c:out value="${subtotal}"/>)) + "</strong>";
}

document.getElementById('card').addEventListener('input', function (e) {
	  e.target.value = e.target.value.replace(/[^\d]/g, '').replace(/(.{4})/g, '$1 ').trim();
});

document.getElementById('securitycode').addEventListener('input', function (e) {
	  e.target.value = e.target.value.replace(/[^\d]/g, '');
});

//window.onbeforeunload = function(){
//	  return ' ';
//};

document.getElementById('pay').onclick = function () {
	var bool = true;
	if(document.getElementById('address').value == ''){
		document.getElementById('addressdiv').className = "form-group has-error";
		bool = false;
	} else {
		document.getElementById('addressdiv').className = "form-group";
	}
	if(document.getElementById('card').value.length < 19){
		document.getElementById('carddiv').className = "input-group has-error";
		bool = false;
	} else {
		document.getElementById('carddiv').className = "input-group";
	}
	if(document.getElementById('person').value == ''){
		document.getElementById('persondiv').className = "input-group has-error";
		bool = false;
	} else {
		document.getElementById('persondiv').className = "input-group";
	}
	if(document.getElementById('expiry-year').value == '' || document.getElementById('expiry-year').value == ''){
		document.getElementById('datediv').className = "input-group has-error";
		bool = false;
	} else {
		document.getElementById('datediv').className = "input-group";
	}
	if(document.getElementById('securitycode').value.length < 3){
		document.getElementById('codediv').className = "input-group has-error";
		bool = false;
	} else {
		document.getElementById('codediv').className = "input-group";
	}
	
	if(bool){
	    window.onbeforeunload = null;
	    this.disabled = true;
	    this.innerHTML = "<strong>Please wait!</strong>";
	    window.location = "Process.html";
	}
};

var address = '<c:out value="${address}"/>';
if (address === ""){
	newadd();
	$('#newadd').addClass("active");
	$('#oldadd').addClass("disabled");
	$('#oldadd').removeClass("active");

}
</script>
</html>