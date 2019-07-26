<%@page import="hjb.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	if (session.getAttribute("id") != null) {
		request.setCharacterEncoding("UTF-8");
		BoardDAO dao = new BoardDAO();
		String name = session.getAttribute("name").toString();
		if (dao.delete(request.getParameter("num"), request.getParameter("id")) > 0) {
			response.addHeader("Refresh", "1;url=board.jsp");
%>
<div class="alert alert-success mt-5 p-5" role="alert"><%=name%>님
	게시글이 삭제되었습니다.
</div>
<%
		} else {
			response.addHeader("Refresh", "1;url=index.jsp");
%>
<div class="alert alert-warning mt-5 p-5" role="alert"><%=name%>님
	게시글 삭제 오류!
</div>
<%
		}
	} else { // sessionOut
		response.sendRedirect("sessionOut.jsp");
	}
%>
