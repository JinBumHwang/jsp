
<%@page import="hjb.ThumbDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("id") != null) {
		int board_num=Integer.parseInt(request.getParameter("num"));
		String id=session.getAttribute("id").toString();
		ThumbDAO tdao=new ThumbDAO();
		if(tdao.select(board_num, id)){ // 이미 추천 상태면 삭제!
			tdao.delete(board_num,id);
			%>
			<script>
			alert("추천을 취소하였습니다.");
			</script>
			<%
		}else{ // 추천 상태가 아니면 추천!
			tdao.insert(board_num,id);
			%>
			<script>
			alert("추천하였습니다.");
			</script>
			<%
		}
		session.setAttribute("refresh", true);
	} else { // sessionOut
		%>
		<script>
		alert("추천 처리가 되지 않았습니다.");
		</script>
		<%
	}
%>
