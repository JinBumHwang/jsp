<%@page import="hjb.MemberDTO"%>
<%@page import="hjb.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	if (session.getAttribute("id") != null) {
		request.setCharacterEncoding("UTF-8");
		MemberDAO dao = new MemberDAO();
		Object name = session.getAttribute("name").toString();
		if (dao.delete(session.getAttribute("id").toString(), request.getParameter("pwold")) > 0) {
			session.removeAttribute("id");
			session.removeAttribute("name");
			response.addHeader("Refresh", "0.5;url=index.jsp");
%>
<div class="alert alert-success mt-5 p-5" role="alert"><%=name%>님
	탈퇴되셨습니다.
</div>
<%
		} else {
			response.addHeader("Refresh", "0.5;url=index.jsp");
%>
<div class="alert alert-warning mt-5 p-5" role="alert"><%=name%>님
	비밀번호가 틀립니다. 메인 화면으로 이동합니다.
</div>
<%
		}
	} else { // sessionOut
		response.sendRedirect("sessionOut.jsp");
	}
%>
