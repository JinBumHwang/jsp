<%@page import="hjb.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("id") != null) {
		
		ReplyDAO dao=new ReplyDAO();
		
		dao.delete(Integer.parseInt(request.getParameter("rnum")),
				Integer.parseInt(request.getParameter("bnum")),
			session.getAttribute("id").toString());
		session.setAttribute("refresh", true);
		%>
		<script>
		alert("댓글이 성공적으로 삭제되었습니다.");
		</script>
		<%
	} else { // sessionOut
		%>
		<script>
		alert("세션이 만료되었거나 잘못된 접근입니다.");
		</script>
		<%
	}
%>
