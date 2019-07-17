<%@page import="hjb.MemberDTO"%>
<%@page import="hjb.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");

	MemberDAO dao = new MemberDAO();
	MemberDTO dto = new MemberDTO();

	dto.setAddress(request.getParameter("address"));
	dto.setDetailAddr(request.getParameter("detailAddr"));
	dto.setBirth(request.getParameter("year")+request.getParameter("month")+request.getParameter("date"));
	dto.setEmail(request.getParameter("email"));
	dto.setGender(request.getParameter("gender"));
	dto.setId(request.getParameter("id"));
	dto.setName(request.getParameter("name"));
	dto.setPw(request.getParameter("pw"));
	dto.setTel(request.getParameter("tel"));

	int result = dao.insert(dto);

	if (result > 0) {
		response.addHeader("Refresh", "1;url=index.jsp");
		session.setAttribute("id", dto.getId());
		session.setAttribute("name", dto.getName());
		%>
		<div class="alert alert-success mt-5 p-5" role="alert"><%=dto.getName()%>님
			환영합니다.
		</div>
		<%
	} else {
		response.addHeader("Refresh", "1;url=join.jsp");
		%>
		<div class="alert alert-danger mt-5 p-5" role="alert">회원가입 오류!!</div>
		<%
	}
		%>
