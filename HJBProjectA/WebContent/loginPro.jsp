<%@page import="hjb.MemberDTO"%>
<%@page import="hjb.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	request.setCharacterEncoding("UTF-8");

	if(request.getParameterValues("remeber")==null){
		Cookie cook=new Cookie("remeber",null);
		cook.setMaxAge(0);
		response.addCookie(cook);
	}

	MemberDAO dao = new MemberDAO();
	String id=request.getParameter("id");
	int result=dao.select(id, request.getParameter("pw"));
	
	
	switch(result){
	case MemberDAO.NO_ID:
		response.addHeader("Refresh", "1;url=login.jsp?id=");
		%>
		<div class="alert alert-danger mt-5 p-5" role="alert">해당 아이디가 없습니다!</div>
		<%
		break;
	case MemberDAO.WRONG_PW:
		response.addHeader("Refresh", "1;url=login.jsp?id="+id);
		%>
		<div class="alert alert-danger mt-5 p-5" role="alert">비밀번호가 틀립니다!</div>
		<%
		break;
	case MemberDAO.LOGIN:
		if(request.getParameterValues("remember")!=null){ // 체크박스
			response.addCookie(new Cookie("remember",id));
// 			String cook="ADD COOKIE ";
// 			if (request.getHeader("Cookie") != null) {
// 				Cookie cookList[] = request.getCookies();
// 				for (int i = 0; i < cookList.length; i++) {
// 					if (cookList[i].getName().equals("remember")) {
// 						cook += cookList[i].getValue();
// 						break;
// 					}
// 				}
// 			}
// 			System.out.println(cook);
		}
		
		response.addHeader("Refresh", "1;url=index.jsp");
		session.setAttribute("id", id);
		session.setAttribute("name", dao.getName());
		%>
		<div class="alert alert-success mt-5 p-5" role="alert"><%=dao.getName()%>님
			환영합니다.
		</div>
		<%
		break;
		}
%>

