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
		if (session.getAttribute("id") != null) {
	%>
	<form name="form" action="board_addPro.jsp" method="post"
		class="bg-light mx-auto p-5  rounded-lg mt-5 container">
		<div class="row mt-5 center">
			<input type="hidden" name=id
				value="<%=session.getAttribute("id").toString()%>">
			<div class="text-info col-md-2">Name</div>
			<div class="text-left col-md-9 border border-dark"><%=session.getAttribute("name").toString()%></div>
			<div class="w-100"></div>
			<!-- new Line -->
			<div class="text-info col-md-2 mt-5">Title</div>
			<input type="text" maxlength="40" 
				class="text-left col-md-9 mt-5 border border-primary" name="title" required>
			<div class="w-100"></div>
			<!-- new Line -->
			
			<div class="text-info col-md-2 mt-5">File</div>
			<input type="file"
				class="text-left col-md-9 mt-5" name="upfile" onchange="filechk(this.value)">
				<iframe width="0" height="0" name="ifrm"  style="border:0;"></iframe>
			<div class="w-100"></div>
			
			<div class="text-info col-md-2 mt-4">Content</div>
			<textarea class="text-left col-md-9 mt-4 border border-primary"
				name="content" cols="40" style="height: 398px"></textarea>
			<div class="col-md-5"></div>
			<input class="col-md-3 mt-5 btn btn-primary rounded-lg" id="modify"
				type="submit" onclick="add()" value="글 올리기"> <input
				class="col-md-3 mt-5 btn ml-1 btn-warning rounded-lg" type="button"
				value="돌아가기" onclick="history.back()">
		</div>
	</form>
	<%
		} else {
			response.addHeader("Refresh", "2;url=login.jsp");
	%>
	<div class="alert alert-warning mt-5 p-5" role="alert">세션이 만료되었거나
		로그인 정보가 없습니다. 로그인 화면으로 이동합니다..</div>
	<%
		}
	%>
</body>
<script>
function add(){
	document.form.action="board_addPro.jsp";
	document.form.enctype="";
	document.form.target="_self";
}
function filechk(val){
	if(val.length>0){
		document.form.action="uploadPro.jsp";
		document.form.enctype="multipart/form-data";
		document.form.target="ifrm";
		document.form.submit();
	}
}
</script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</html>