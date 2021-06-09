<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
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
		$('#currentPage').val(currentPage);
		$('form').attr("method","POST").attr("action","/product/listProduct?menu=${menu}").submit();
	}
	
	function ajaxGetProduct(prodNo){
		$.ajax(
			{
				url:"/product/json/getProduct/"+prodNo,
				method:"GET",
				dataType:"json",
				headers:{
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success:function(JSONData, status){
					//alert(status);
							
					var displayValue = '<div class="row">'
						  					+'<div class="col-sm-6 col-md-10">'
					    						+'<div class="thumbnail">'
					      							+'<img src="/images/uploadFiles/'+JSONData.fileName+'" alt="no image">'
						      						+'<div class="caption">'
							        					+'<h3>'+JSONData.prodName+'</h3>'
							        					+'<p>'
							        					+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
							        					+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
														+"���� : "+JSONData.price+"<br/>"
							        					+'</p>'
							        					+'<p><a href="/product/getProduct?prodNo='+JSONData.prodNo+'&menu=${menu}" class="btn btn-primary" role="button">������</a>'
							        				+'</div>'
							        			+'</div>'
							        		+'</div>'
							        	+'</div>'
					
					//alert(displayValue);
					$(".thumbnail").remove();
					$("#"+prodNo).html(displayValue);
				}
			});
	}
	
	$(function(){
		
		$("input[name='searchKeyword'],input[name='searchPriceMin'],input[name='searchPriceMax']").on("keydown",function(){
			if(event.keyCode == 13){
				fncGetList(1);
			}
		})
		
		$(".btn.btn-default").on("click",function(){
			fncGetList(1);
		});
		
		$("td:nth-child(2)").on("click",function(){
			if(${ menu.equals('search') }){
				var prodNo = $(this).find('input').val();
				if(prodNo != null){
					self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${menu}";
				}else{
					alert("�ǸŰ� �Ϸ�Ǿ����ϴ�.");
				}
			}else if(${ menu.equals('manage') }){
				var prodNo = $(this).find('input').val();
				self.location = "/product/updateProduct?prodNo="+prodNo;
			}
		})
		
		$("td:nth-child(5) > i").on("mouseover", function(){
			
			var prodNo = $(this).next().val();
			ajaxGetProduct(prodNo);
		});
		
		$(document).on("click",function(){
			$('.thumbnail').remove();
		})
		
		
		$("td:nth-child(2)").css("color","blue");
		
	});
	
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
	
		<div class="page-header text-info">
			<c:if test="${ !empty menu && menu=='manage' }">
				<h3>��ǰ�����ȸ</h3>
			</c:if>
			<c:if test="${ !empty menu && menu=='search' }">
				<h3>��ǰ�˻�</h3>
			</c:if>
	    </div>
	    
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition ==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition ==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2" ${ !empty search.searchCondition && search.searchCondition ==2 ? "selected" : "" }>���ݳ�����</option>
						<option value="3" ${ !empty search.searchCondition && search.searchCondition ==3 ? "selected" : "" }>���ݳ�����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
					<div class="form-group">
				  		<input type="text" class="form-control" id="searchPriceMin" name="searchPriceMin"  placeholder="�ּұݾ�"
				    			 	size="5" value="${! empty search.searchPriceMin ? search.searchPriceMin : '' }"  >
				  		~ <input type="text" class="form-control" id="searchPriceMax" name="searchPriceMax"  placeholder="�ִ�ݾ�"
				    			 	size="5" value="${! empty search.searchPriceMax ? search.searchPriceMax : '' }"  >
						��
					</div>
				</form>
	    	</div>
	    	
		</div>
		
		<table class="table table-bordered table-hover table-striped" >
      
	        <thead>
	          <tr>
	            <th align="center">No</th>
	            <th align="left">��ǰ��</th>
	            <th align="left">����</th>
	            <c:if test="${ menu == 'manage' }">
				<th class="left">�����</th>	
				</c:if>
	            <th align="left">�������</th>
	            <th align="left">����</th>
	          </tr>
	        </thead>
       
			<tbody>
			
			  <c:set var="i" value="0" />
			  <c:forEach var="product" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="center">${ i }</td>
				  <td align="left"  title="Click : ��ǰ���� Ȯ��">
				  	<c:if test="${ product.proTranCode == null }">
				  		<input type="hidden" value="${product.prodNo}">
				  	</c:if>
				  	${product.prodName}
				  </td>
				  <td align="left">${product.price}</td>
				  <c:if test="${ menu == 'manage' }">
					<td align="left">${ product.regDate }</td>
				  </c:if>
				  <td align="left">
				  	<c:if test="${ user.role == 'admin' }">
						<c:choose>
							<c:when test="${ product.proTranCode.equals('1  ') }">
								���ſϷ� 
								<c:if test="${ menu == 'manage' }">
									<a href="/purchase/updateTranCodeByProd?prodNo=${ product.prodNo }&tranCode=2">����ϱ�</a>
								</c:if>
							</c:when>
							<c:when test="${ product.proTranCode.equals('2  ') }">
								�����
							</c:when>
							<c:when test="${ product.proTranCode.equals('3  ') }">
								��ۿϷ�
							</c:when>
							<c:otherwise>
								�Ǹ���
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<c:if test="${ user.role == 'user' }">
						<c:choose>
							<c:when test="${ product.proTranCode == null }">
								�Ǹ���
							</c:when>
							<c:otherwise>
								������
							</c:otherwise>
						</c:choose>
					</c:if>
				  </td>
				  <td align="left" >
				  	<i class="glyphicon glyphicon-zoom-in"></i>
				  	<input type="hidden" value="${product.prodNo}">
				  </td>
				  <td id="${product.prodNo}"></td>
				</tr>
	          </c:forEach>
	        
	        </tbody>
      
      	</table>
		
		<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp"/>
		<!-- PageNavigation End... -->
	</div>
		
	
	
</body>
</html>

