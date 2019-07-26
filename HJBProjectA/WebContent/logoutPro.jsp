<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	if (session.getAttribute("id") != null) {
		request.setCharacterEncoding("UTF-8");
		Object name = session.getAttribute("name");
		session.removeAttribute("id");
		session.removeAttribute("name");
		response.addHeader("Refresh", "0.5;url=index.jsp");
%>
<div class="alert alert-success mt-5 p-5" role="alert"><%=name.toString()%>님
	로그아웃 되었습니다.
</div>
<%
	} else { // sessionOut
		response.sendRedirect("sessionOut.jsp");
	}
%>
