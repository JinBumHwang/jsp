<%@page import="hjb.BoardDAO"%>
<%@page import="hjb.ReplyDTO"%>
<%@page import="hjb.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("id") != null) {
		
		ReplyDTO dto=new ReplyDTO();
		ReplyDAO dao=new ReplyDAO();
		BoardDAO bdao=new BoardDAO();
		
		dto.setBoard_num(Integer.parseInt(request.getParameter("num")));
		dto.setId(session.getAttribute("id").toString());
		dto.setName(session.getAttribute("name").toString());
		dto.setReply(request.getParameter("reply"));
		dao.insert(dto);
		session.setAttribute("refresh", true);
		%>
		<script>
		alert("댓글이 등록되었습니다.");
		</script>
		<%
	} else { // sessionOut
		%>
		<script>
		alert("댓글이 등록되지 않았습니다.");
		</script>
		<%
	}
%>
