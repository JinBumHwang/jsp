<%@page import="hjb.BoardDTO"%>
<%@page import="hjb.BoardDAO"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");
	
	if (session.getAttribute("id") != null &&
			session.getAttribute("id").toString().equals(request.getParameter("id"))) { // session
		BoardDTO dto=new BoardDTO();
		dto.setId(request.getParameter("id"));
		dto.setName(session.getAttribute("name").toString());
		dto.setTitle(request.getParameter("title"));
		dto.setContent(request.getParameter("content"));
		BoardDAO dao=new BoardDAO();
		if(dao.insert(dto)>0){
			%>
			<div class="alert alert-success mt-5 p-5" role="alert">
			게시글을 등록하였습니다.</div>
			<%
		}else{
			%>
			<div class="alert alert-danger mt-5 p-5" role="alert">
			정보 수정 오류!</div>
			<%
		}
		response.addHeader("Refresh", "1;url=board.jsp");
	} else { // sessionOut
		response.sendRedirect("sessionOut.jsp");
	}
%>