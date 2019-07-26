<%@page import="hjb.MemberDTO"%>
<%@page import="hjb.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<%
	response.addHeader("Refresh", "0.5;url=index.jsp");
%>
<div class="alert alert-warning mt-5 p-5" role="alert">
	세션이 만료되었거나 잘못된 접근입니다.<br>
	<br> 메인화면으로 이동합니다..
</div>
