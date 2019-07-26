<%@page import="hjb.MemberDTO"%>
<%@page import="hjb.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("id") != null
			&& session.getAttribute("id").toString().equals(request.getParameter("id"))) { // session
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();
		//  한 번 더 아이디와 비밀번호 확인
		int result = dao.select(request.getParameter("id"), request.getParameter("pwold"));
		// 변경할 비밀번호(pw)와 반복입력(pwr)은 modify.jsp에서 같아서 여기로 넘어옴
		if (result == MemberDAO.LOGIN) { // id,pw 맞으면
			dto.setId(request.getParameter("id"));
			dto.setAddress(request.getParameter("address"));
			dto.setDetailAddr(request.getParameter("detailAddr"));
			dto.setBirth(request.getParameter("year") + request.getParameter("month")
					+ request.getParameter("date"));
			dto.setEmail(request.getParameter("email"));
			dto.setGender(request.getParameter("gender"));
			dto.setName(request.getParameter("name"));
			dto.setPw(request.getParameter((request.getParameter("pw") == "" ? "pwold" : "pw")));
			dto.setTel(request.getParameter("tel"));
			result = dao.update(dto);
			if (result > 0) { // update
				session.setAttribute("name", dto.getName());
				%>
				<div class="alert alert-success mt-5 p-5" role="alert"><%=dto.getName()%>님
					정보가 수정되었습니다.
				</div>
				<%
			} else { // update Error
				%>
				<div class="alert alert-warning mt-5 p-5" role="alert"><%=request.getParameter("name")%>님
					정보 수정 오류!
				</div>
				<%
			} // update Error
			response.addHeader("Refresh", "0.5;url=index.jsp");
		} else { // wrong password
			%>
			<script>
				setTimeout(function() {
					history.back();
				}, 500);
			</script>
			<div class="alert alert-danger mt-5 p-5" role="alert"><%=request.getParameter("name")%>님
				기존의 비밀번호가 틀립니다!
			</div>
			<%
		} // wrong password
	} else { // sessionOut
		response.sendRedirect("sessionOut.jsp");
	}
%>