<%@ page language="java" contentType="text/html; charset=EUC-KR"%>


<html>
<head>
<title>상품등록</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>


<style>
      body > div.container{
      	border: 3px solid black;
      	margin-top: 10px;
      }
</style>

<script type="text/javascript">

	function fncAddProduct(){
		//Form 유효성 검증
	 	var name = $("input[name=prodName]").val();
		var detail = $("input[name=prodDetail]").val();
		var manuDate = $("input[name=manuDate]").val();
		var price = $("input[name=price]").val();
	
		
		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
	
		$('form').attr("method","POST").attr("action","/product/addProduct").submit();
	}
	
	$(function(){
		
		$('button.btn.btn-primary').on("click",function(){
			fncAddProduct();
		});
		
		$("a[href='#' ]").on("click",function(){
			$("form")[0].reset();
		});
		
		$('#datepicker').datepicker({
		    format: 'yyyy-mm-dd',
		    startDate: '-30d',
		    language: 'kr',
		    todayHighlight: 'true',
		    autoclose: 'true'
		});
	})

</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="navbar navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	
   	<div class="container">
   	
   		<h1 class="bg-primary text-center">상품등록</h1>
   		
   		<form class="form-horizontal" enctype="multipart/form-data">
   			<div class="form-group">
   				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
   				<div class="col-sm-2">
		      		<input type="text" class="form-control" id="prodName" name="prodName">
		    	</div>
   			</div>
   			<div class="form-group">
		    	<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상세정보</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="prodDetail" name="prodDetail">
		    	</div>
			</div>
			<div class="form-group">
		    	<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
    			<div class="col-sm-2">
    				<input type="text" id="datepicker" class="form-control" name="manuDate">
    			</div>
			</div>
			<div class="form-group">
		    	<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    	<div class="col-sm-2">
		      		<input type="text" class="form-control" id="price" name="price">
		    	</div>
		    	<label for="price" class="control-label">원</label>
			</div>
			<div class="form-group">
		    	<label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    	<div class="col-sm-3">
		      		<input type="file" id="file" name="file">
		    	</div>
			</div>
			
			<div class="form-group">
		    	<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="btn btn-primary"  >등&nbsp;록</button>
			  		<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    	</div>
		  	</div>
			
   		</form>
   	</div>
</body>
</html>