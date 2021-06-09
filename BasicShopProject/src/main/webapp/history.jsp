<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.net.URLDecoder" %>

<html>
<head>
<title>열어본 상품 보기</title>
</head>

<body>
	당신이 열어본 상품을 알고 있다
<br>
<br>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	
	String historyName = null;
	String historyNo = null;
	
	Cookie[] cookies = request.getCookies();

	if (cookies!=null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals("historyName")) {
				historyName = URLDecoder.decode(cookie.getValue(),"UTF-8");
			}else if(cookie.getName().equals("historyNo")) {
				historyNo = cookie.getValue();
			}
		}
		System.out.println("historyName : "+historyName);
		System.out.println("historyNo : "+historyNo);
		if (historyName != null) {
			String[] name = historyName.split(",");
			String[] no = historyNo.split(",");
			for (int i = 0; i < name.length; i++) {
				if (!name[i].equals("null")) {
%>
	<a href="/product/getProduct?prodNo=<%=no[i]%>&menu=search"	target="rightFrame"><%=name[i]%></a>
<br>
<%
				}
			}
		}
	}
%>

</body>
</html>