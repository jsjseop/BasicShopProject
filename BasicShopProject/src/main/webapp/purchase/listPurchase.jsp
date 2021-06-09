<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<!-- ���� : http://getbootstrap.com/css/   ���� -->
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

<!-- jQuery UI toolTip ��� CSS-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip ��� JS-->
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
			<h3>���Ÿ��</h3>
	    </div>
	    
	    <div class="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-default">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		</div>
		
		<table class="table table-hover table-striped" >
      
	        <thead>
	          <tr>
	            <th align="center">��ǰ��</th>
	            <th align="left" >ȸ�� ID</th>
	            <th align="left">ȸ����</th>
	            <th align="left">��ȭ��ȣ</th>
	            <th align="left">�����Ȳ</th>
	            <th align="left">��������</th>
	          </tr>
	        </thead>
       
			<tbody>
			
				<c:set var="i" value="0"/>
				<c:forEach var="purchase" items="${ list }">
					<c:set var="i" value="${ i+1 }"/>
					<tr>
						<td align="left" title="Click : �������� Ȯ��">
							<input type="hidden" id="tranNo" value="${ purchase.tranNo }"/>
							${ purchase.purchaseProd.prodName }
						</td>
						<td align="left" title="Click : ȸ������ Ȯ��">
							${ buyerId }
						</td>
						<td align="left">${ purchase.receiverName }</td>
						<td align="left">${ purchase.receiverPhone }</td>
						<td align="left">���� 
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='1  ' }">
								���ſϷ�
							</c:if>
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='2  ' }">
								�����
							</c:if>
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='3  ' }">
								��ۿϷ�
							</c:if>
							�����Դϴ�.</td>	
						<td align="left">
							<c:if test="${ !empty purchase.tranCode && purchase.tranCode=='2  ' }">
								<a href="/purchase/updateTranCode?tranNo=${ purchase.tranNo }&tranCode=3">���ǵ���</a>
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