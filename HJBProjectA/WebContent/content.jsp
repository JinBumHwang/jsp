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
		// content와 contentModify 합체
		String num=request.getParameter("num");
		BoardDAO dao=new BoardDAO();
		dao.updateReadcount(Integer.parseInt(num));
		BoardDTO dto=dao.select(Integer.parseInt(num));
%>
	<form name="form" action="contentPro.jsp" method="post" class="bg-light mx-auto p-5  rounded-lg mt-5 container">
		<div class="row mt-5 center">
			<input type="hidden" name=id value="<%=dto.getId()%>">
			<input type="hidden" name=num value="<%=dto.getNum()%>">
			<div class="text-left text-info col-md-2">Name</div>
			<div class="text-left col-md-9 border"><%=dto.getName()%></div>
			<div class="w-100"></div><!-- new Line -->
			<div class="text-left text-info col-md-2 mt-5">Title</div>
			<div class="text-left col-md-9 mt-5 border" id="title"><%=dto.getTitle()%></div>
			<input type="text" class="text-left col-md-9 mt-5 border border-primary" name="titleRe"
			style="display:none;">
			<div class="w-100"></div><!-- new Line -->
			<div class="text-left text-info col-md-2 mt-5">Content</div>
			<pre class="text-left col-md-9 mt-5 form-control" id="content" style="height:158px"><%=dto.getContent() %></pre>
			<textarea class="text-left col-md-9 mt-5 form-control border-primary" name="contentRe"
			style="display:none;height:158px;"></textarea>
			<div class="col-md-5"></div>
			<input class="col-md-3 mt-5 btn btn-primary rounded-lg" id="modify" type="button" onclick="modifyMode(this)" value="수정하기">
			<input class="col-md-3 mt-5 btn ml-1 btn-warning rounded-lg" type="button" value="돌아가기" onclick="backContent()">
		</div>
	</form>
</body>
<script>
// window.onload=function(){
// 	alert(document.getElementById("content").innerHTML);
// }
function modifyMode(obj){
	// 비로그인 상태일때
	<%if (session.getAttribute("id") == null) {%>
		alert("게시글을 작성한 사람만 수정할 수 있습니다.");
	// 로그인 아이디와 게시글 작성한 아이디가 같을때
<%} else if (session.getAttribute("id").toString().equals(dto.getId())) {%>
		if(document.getElementById("title").style.display!='none'){	// 보기상태(수정하기)이면 수정상태로 전환
		document.getElementById("title").style.display = 'none';
		document.getElementsByName("titleRe")[0].style.display = 'inline';
		document.getElementsByName("titleRe")[0].value=document.getElementById("title").innerHTML; // 처음값으로 돌리기
		document.getElementById("content").style.display = 'none';
		document.getElementsByName("contentRe")[0].style.display = 'inline';
		document.getElementsByName("contentRe")[0].value=document.getElementById("content").innerHTML;
		document.getElementsByName("contentRe")[0].focus();
		obj.value = "수정완료";
		}else{ // 수정상태(적용하기)이면 contentPro로 이동
			document.form.submit();
		}
	// 로그인 상태이지만 작성한 아이디랑 다를때, 즉 다른 회원
<%} else {%>
	alert("게시글을 작성한 사람만 수정할 수 있습니다.");
<%}%>
}
function backContent(){
	if(document.getElementById("title").style.display!='none'){	//	보기상태면 이전 페이지로
		history.go(-1);
	}else{ // 수정상태면 보기모드로 전환
		document.getElementsByName("titleRe")[0].style.display = 'none';
		document.getElementById("title").style.display = 'inline';
		document.getElementsByName("contentRe")[0].style.display = 'none';
		document.getElementById("content").style.display = 'inline';
		document.getElementById("modify").value = "수정하기";
	}
}
</script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</html>