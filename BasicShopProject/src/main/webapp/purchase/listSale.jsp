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

<!-- jQuery UI toolTip 사용 CSS-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip 사용 JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
	  body {
            padding-top : 50px;
      }
      body > div.container{
      		border: 3px solid black;
      		margin-top: 10px;
      }
</style>
<script type="text/javascript">

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$('form').attr("method","POST").attr("action","/purchase/saleList").submit();
	}
	
	$(function(){
		
		$("input[name=searchKeyword]").on("keydown",function(){
			if(event.keyCode == 13){
				fncGetList(1);
			}
		});
		
		$("button.btn.btn-default").on("click",function(){
			fncGetList(1);
		});
		
		$("td:nth-child(2)").on("click",function(){
			var userId = $(this).text().trim();
			self.location = "/user/getUser?userId="+userId;
		});
		
		$("td:nth-child(3)").on("click",function(){
			var tranNo = $(this).find("input").val();
			self.location = "/purchase/getPurchase?tranNo="+tranNo;
		});
		
		$("td:nth-child(6)").on("click",function(){
			var prodNo = $(this).find("input").val();
			self.location = "/purchase/deletePurchase?prodNo="+prodNo;
		});
		
		$("td:nth-child(2)").css("color","red");
		$("td:nth-child(3)").css("color","blue");
		
	});
</script>
</head>

<body >

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-default">
			<h3>판매완료상품</h3>
	    </div>
	    
	    <div class="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-default">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition ==0 ? "selected" : "" }>상품번호</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition ==1 ? "selected" : "" }>상품명</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
		</div>
		
		<table class="table table-hover table-striped" >
      
	        <thead>
	          <tr>
	            <th align="center">No</th>
	            <th align="left">구매자ID</th>
	            <th align="left">상품명</th>
	            <th align="left">가격</th>
	            <th align="left">판매일자</th>
	            <th align="left">삭제</th>
	          </tr>
	        </thead>
       
			<tbody>
			
				<c:set var="i" value="0"/>
				<c:forEach var="purchase" items="${ list }">
					<c:set var="i" value="${ i+1 }"/>
					<tr>
						<td align="left">${ i }</td>
						<td align="left">
							${ purchase.buyer.userId }
						</td>
						<td align="left">
							<input type="hidden" id="tranNo" value="${ purchase.tranNo }"/>
							${ purchase.purchaseProd.prodName }
						</td>
						<td align="left">${ purchase.purchaseProd.price }</td>
						<td align="left">${ purchase.orderDate }</td>
						<td align="left">
							<input type="hidden" id="prodNo" value="${ purchase.purchaseProd.prodNo }"/>
							<ins>삭제하기</ins>
						</td>			
					</tr>
				</c:forEach>
	        
	        </tbody>
      
      	</table>
      	
      	<jsp:include page="../common/pageNavigator_new.jsp"/>
	
	</div>

</body>
</html>

