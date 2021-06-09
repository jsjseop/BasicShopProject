<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
		
		$("td:nth-child(1)").on("click",function(){
			var tranNo = $(this).find('input').val();
			self.location = "/purchase/getPurchase?tranNo="+tranNo;
		});
		$("td:nth-child(2)").on("click",function(){
			var userId = $(this).text().trim();
			self.location = "/user/getUser?userId="+userId;
		});
		
		$("td:nth-child(1)").css("color","blue");
		$("td:nth-child(2)").css("color","red");
		
	});
	
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
	
		<div class="page-header text-default">
			<h3>구매목록</h3>
	    </div>
	    
	    <div class="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-default">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		</div>
		
		<table class="table table-hover table-striped" >
      
	        <thead>
	          <tr>
	            <th align="center">상품명</th>
	            <th align="left" >회원 ID</th>
	            <th align="left">회원명</th>
	            <th align="left">전화번호</th>
	            <th align="left">배송현황</th>
	            <th align="left">정보수정</th>
	          </tr>
	        </thead>
       
			<tbody>
			
				<c:set var="i" value="0"/>
				<c:forEach var="purchase" items="${ list }">
					<c:set var="i" value="${ i+1 }"/>
					<tr>
						<td align="left" title="Click : 구매정보 확인">
							<input type="hidden" id="tranNo" value="${ purchase.tranNo }"/>
							${ purchase.purchaseProd.prodName }
						</td>
						<td align="left" title="Click : 회원정보 확인">
							${ buyerId }
						</td>
						<td align="left">${ purchase.receiverName }</td>
						<td align="left">${ purchase.receiverPhone }</td>
						<td align="left">현재 
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='1  ' }">
								구매완료
							</c:if>
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='2  ' }">
								배송중
							</c:if>
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='3  ' }">
								배송완료
							</c:if>
							상태입니다.</td>	
						<td align="left">
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='2  ' }">
								<a href="/purchase/updateTranCode?tranNo=${ purchase.tranNo }&tranCode=3">물건도착</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
	        
	        </tbody>
      
      	</table>
      	
      	<jsp:include page="../common/pageNavigator_new.jsp"/>
	
	</div>

</body>
</html>