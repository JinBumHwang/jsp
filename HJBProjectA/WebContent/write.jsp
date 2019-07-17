<%@page import="hjb.BoardDTO"%>
<%@page import="hjb.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html style="width: 100%; height: 100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" type="text/css" href="my/my.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<title>untitled</title>
</head>
<body class="text-center mybody">
<%
		if(session.getAttribute("id")!=null){
%>
	<form name="form" action="writePro.jsp" method="post" class="bg-light mx-auto p-5  rounded-lg mt-5 container">
		<div class="row mt-5 center">
			<input type="hidden" name=id value="<%=session.getAttribute("id").toString() %>">
			<div class="text-left text-info col-md-2">Name</div>
			<div class="text-left col-md-9 border border-dark"><%=session.getAttribute("name").toString() %></div>
			<div class="w-100"></div><!-- new Line -->
			<div class="text-left text-info col-md-2 mt-5">Title</div>
			<input type="text" class="text-left col-md-9 mt-5 border border-primary" name="title">
			<div class="w-100"></div><!-- new Line -->
			<div class="text-left text-info col-md-2 mt-5">Content</div>
			<textarea class="text-left col-md-9 mt-5 border border-primary" name="content" rows="6"></textarea>
			<div class="col-md-5"></div>
			<input class="col-md-3 mt-5 btn btn-primary rounded-lg" id="modify" type="submit" value="글 올리기">
			<input class="col-md-3 mt-5 btn ml-1 btn-warning rounded-lg" type="button" value="돌아가기" onclick="history.back()">
		</div>
	</form>
	<%}else{response.addHeader("Refresh", "2;url=login.jsp");%>
			<div class="alert alert-warning mt-5 p-5" role="alert">
			세션이 만료되었거나 로그인 정보가 없습니다.
			로그인 화면으로 이동합니다..
			</div>
	<% }%>
	
</body>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</html>