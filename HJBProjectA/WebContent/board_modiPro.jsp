<%@page import="hjb.BoardDTO"%>
<%@page import="hjb.BoardDAO"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("id") != null
			&& session.getAttribute("id").toString().equals(request.getParameter("id"))) {
		BoardDTO dto = new BoardDTO();
		
		if(request.getParameter("upfile").length()>0){
			String upfile=request.getParameter("upfile");
			String upfile2=session.getAttribute("upfile").toString();
			if(upfile2.indexOf(upfile.substring(0,upfile.lastIndexOf('.')))>-1){
				dto.setFileAddr("upload/"+session.getAttribute("upfile").toString());
			}
			session.removeAttribute("upfile");
		}
		dto.setNum(Integer.parseInt(request.getParameter("num")));
		dto.setId(request.getParameter("id"));
		dto.setTitle(request.getParameter("titleRe"));
		dto.setContent(request.getParameter("contentRe"));
		BoardDAO dao = new BoardDAO();
		if (dao.update(dto) > 0) {
			session.setAttribute("refresh", true);
%>
			<script>
				alert("게시글이 성공적으로 수정되었습니다.");
			</script>
<%
		} else {
%>
			<script>
				alert("게시글 수정 실패하였습니다");
			</script>
<%
		}

	} else {
%>
			<script>
				alert("세션이 만료되었거나 잘못된 접근입니다.");
			</script>
<%
	}
%>