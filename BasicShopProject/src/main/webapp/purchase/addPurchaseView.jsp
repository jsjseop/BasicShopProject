<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
      body > div.container{
       	border: 3px solid black;
        margin-top: 10px;
       }
</style>
<script type="text/javascript">
	function fncAddPurchase() {
		$('form').attr("method","POST").attr("action","/purchase/addPurchase").submit();
	}
	
	$(function(){
		
		$('button.btn.btn-primary').on("click",function(){
			fncAddPurchase();
		});
		
		$('a.btn.btn-primary.btn').on("click",function(){
			history.go(-1);
		});
		
		$('#datepicker').datepicker({
		    format: 'yyyy-mm-dd',
		    language: 'kr',
		    todayHighlight: 'true',
		    autoclose: 'true'
		});
	});

</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="navbar  navbar-inverse">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Basic Shop</a>
   		</div>
   	</div>
   	
   	<div class="container">
   	
   		<h1 class="bg-primary text-center">��ǰ����</h1>
   		
   		<form class="form-horizontal">
   		
   			<div class="form-group">
   				<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
   				<div class="col-sm-2">
		      		<input type="text" class="form-control" id="prodNo" name="prodNo" value="${product.prodNo}" readonly>
		    	</div>
   			</div>
   			<div class="form-group">
   				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
   				<div class="col-sm-2">
		      		<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}" readonly>
		    	</div>
   			</div>
   			<div class="form-group">
		    	<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}" readonly>
		    	</div>
			</div>
			<div class="form-group">
		    	<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
    			<div class="col-sm-2">
    				<input type="text" class="form-control" name="manuDate" value="${product.manuDate}" readonly>
    			</div>
			</div>
			<div class="form-group">
		    	<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    	<div class="col-sm-2">
		      		<input type="text" class="form-control" id="price" name="price" value="${product.price}" readonly>
		    	</div>
		    	<label for="price" class="control-label">��</label>
			</div>
			<div class="form-group">
		    	<label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
    			<div class="col-sm-2">
    				<input type="text" class="form-control" name="regDate" value="${product.regDate}" readonly>
    			</div>
			</div>
			<div class="form-group">
		    	<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
    			<div class="col-sm-2">
    				<input type="text" class="form-control" name="buyerId" value="${user.userId}" readonly>
    			</div>
			</div>
			<div class="form-group">
		    	<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    	<div class="col-sm-2">
		      		<select class="form-control" name="paymentOption">
						<option value="1" selected="selected">���ݱ���</option>
						<option value="2">�ſ뱸��</option>
					</select>
		    	</div>
			</div>
			<div class="form-group">
		    	<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
    			<div class="col-sm-2">
    				<input type="text" class="form-control" name="receiverName" value="${user.userName}">
    			</div>
			</div>
			<div class="form-group">
		    	<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
    			<div class="col-sm-3">
    				<input type="text" class="form-control" name="receiverPhone" value="${user.phone}">
    			</div>
			</div>
			<div class="form-group">
		    	<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
    			<div class="col-sm-4">
    				<input type="text" class="form-control" name="divyAddr" value="${user.addr}">
    			</div>
			</div>
			<div class="form-group">
		    	<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ�û����</label>
    			<div class="col-sm-4">
    				<input type="text" class="form-control" name="divyRequest">
    			</div>
			</div>
			<div class="form-group">
		    	<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
    			<div class="col-sm-2">
    				<input type="text" id="datepicker" class="form-control" name="divyDate">
    			</div>
			</div>
			
			<div class="form-group">
		    	<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="btn btn-primary"  >��&nbsp;��</button>
			  		<a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    	</div>
		  	</div>
			
   		</form>
   		
   	</div>

</body>
</html>