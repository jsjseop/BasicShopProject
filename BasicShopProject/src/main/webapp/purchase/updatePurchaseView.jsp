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
	
<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!-- Bootstrap Datepicker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>
   
<style>
	body {
           padding-top : 50px;
    }
</style>
<script type="text/javascript">
	$(function(){
		
		$('button.btn.btn-primary').on("click",function(){
			$('form').attr("method","POST").attr("action","/purchase/updatePurchase?tranNo=${ purchase.tranNo }").submit();
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
	
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">구매정보수정</h3>
		</div>
		
		<form class="form-horizontal">
		
		  <div class="form-group">
		    	<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
    			<div class="col-sm-2">
    				<input type="text" class="form-control" name="buyerId" value="${ purchase.buyer.userId }" readonly>
    			</div>
			</div>
		
		  <div class="form-group">
		    	<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    	<div class="col-sm-2">
		      		<select class="form-control" name="paymentOption">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
					</select>
		    	</div>
			</div>
		  
		  <div class="form-group">
		    	<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
    			<div class="col-sm-2">
    				<input type="text" class="form-control" name="receiverName" value="${ purchase.receiverName }">
    			</div>
			</div>
		  
		  <div class="form-group">
		    	<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
    			<div class="col-sm-3">
    				<input type="text" class="form-control" name="receiverPhone" value="${ purchase.receiverPhone }">
    			</div>
			</div>
		  
		  <div class="form-group">
		    	<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
    			<div class="col-sm-4">
    				<input type="text" class="form-control" name="divyAddr" value="${ purchase.divyAddr }">
    			</div>
			</div>
		  
		  <div class="form-group">
		    	<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매자요청사항</label>
    			<div class="col-sm-4">
    				<input type="text" class="form-control" name="divyRequest" value="${ purchase.divyRequest }">
    			</div>
			</div>
		  
		  <div class="form-group">
		    	<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
    			<div class="col-sm-2">
    				<input type="text" id="datepicker" class="form-control" name="divyDate">
    			</div>
			</div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
		    </div>
		  </div>
		</form>
		
	</div>

</body>
</html>