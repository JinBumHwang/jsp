<%@page import="hjb.ThumbDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hjb.ReplyDTO"%>
<%@page import="hjb.ReplyDAO"%>
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
<%
	request.setCharacterEncoding("UTF-8");
	// content와 contentModify 합체
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = dao.select(num);
	// 댓글 달기, 댓글 삭제, 게시글 수정시 새로고침이 발생하는데..
	// 이 때는 조회수가 올라가지 않게 설정
	if(session.getAttribute("refresh")==null){
		dao.updateReadcount(num);
	}else{
		session.removeAttribute("refresh");
	}
%>
</head>

<body class="text-center mybody">

	<form name="form" action="board_modiPro.jsp" method="post" target="ifrm"
		class="bg-light mx-auto p-4  rounded-lg mt-4 container">
		<!-- and "board_delPro.jsp" -->
		<div class="row mt-5 center">
			<input type="hidden" name="history"
				value="<%=request.getParameter("history")%>"> <input
				type="hidden" name="id" value="<%=dto.getId()%>">
				<input type="hidden" name="num" value="<%=dto.getNum()%>">
			<div class="text-info col-md-2">Name</div>
			<div class="text-left col-md-9 border"><%=dto.getName()%></div>
			<div class="w-100 mb-5"></div>
			<!-- new Line -->
			<div class="text-info col-md-2">Title</div>
			<div class="text-left col-md-9 border" id="title"><%=dto.getTitle()%></div>
			<input type="text" maxlength="40"
				class="text-left col-md-9 border border-primary" name="titleRe"
				style="display: none;">
			<div class="w-100 mb-5"></div>
			<!-- new Line --> <!-- FILE -->
			<div class="text-info col-md-2">File</div>
			<%if(dto.getFileAddr()!=null && dto.getFileAddr().length()>0){ %>
					<%if(dto.getFileAddr().indexOf(".jpg")>0 || dto.getFileAddr().indexOf(".png")>0){ %>
							<img src="<%=dto.getFileAddr() %>" style="max-width:500px;" id="upfile1">
					<%}else{%>
						<a href="<%=dto.getFileAddr() %>" id="upfile2"><%=dto.getFileAddr().substring(7) %></a>
					<%}%>
			<span id="upfile3" style="display: none;"><%=dto.getFileAddr().substring(7) %> &nbsp;&nbsp;수정 ▶▷&nbsp;</span>
			<%} %>
					
			<input type="file"
				class="text-left" name="upfile"  onchange="filechk(this.value)" style="display: none;">
				<iframe width="0" height="0" name="ifrmUpfile"  style="border:0;"></iframe>
			<div class="w-100 mb-4"></div>
			<!-- FILE END -->			
			<div class="text-info col-md-2">Content</div>
			<textarea class="text-left col-md-9 form-control" id="content" cols="40"
				style="height: 398px" disabled="disabled"><%=dto.getContent()%></textarea>
			<textarea class="text-left col-md-9 form-control border-primary" cols="40"
				name="contentRe" style="display: none;height: 398px;"></textarea>
			<div class="col-md-4"></div>
			<%
				// 로그인 상태: 수정, 삭제	
				if (session.getAttribute("id") != null && session.getAttribute("id").toString().equals(dto.getId())) {
			%>
			<input class="col-md-1 mt-5 btn btn-danger rounded-lg" type="button"
				onclick="delBoard()" value="삭제하기"> <input
				class="col-md-3 mt-5 btn btn-primary rounded-lg ml-1" id="modify"
				type="button" onclick="modifyMode()" value="수정하기">
			<%
				}
			%>
			<input class="col-md-3 mt-5 btn btn-warning rounded-lg ml-1"
				type="button" value="돌아가기" onclick="backContent()">
		</div>
	</form>


	<form name="form3" action="reply_delPro.jsp" class="bg-light mx-auto rounded-lg container"
		style="overflow: auto; max-height: 392px;" target="ifrm">
		<input type="hidden" name="rnum">
		<input type="hidden" name="bnum">
		<%
			ReplyDAO rdao = new ReplyDAO();
			ArrayList<ReplyDTO> list = rdao.select(num);
			for (ReplyDTO rdto : list) {
		%>
		<div class="text-left pt-2 pb-2 border-bottom ml-5">
			<p style="margin-left: 6%;" class="text-primary"><%=rdto.getName()%>
				<span class="small text-muted" style="margin-left: 2%;"><%=rdto.getReg_date()%></span>
				<%
					if (session.getAttribute("id") != null && session.getAttribute("id").toString().equals(rdto.getId())) {
				%>
				<input
					type="button" class="small btn btn-danger" onclick="deleteReply('<%=rdto.getReply_num() %>','<%=num %>')"
					value="DEL">
				<%
					}
				%>
			</p>
			<pre style="margin-left: 4%; font-size: 100%"><%=rdto.getReply()%></pre>
		</div>
		<%
			}
		%>
</form>
		<%
			if (session.getAttribute("id") != null) {
		%>
	
	<div class="bg-light mx-auto rounded-lg container">
		<form action="reply_addPro.jsp" method="post" name="form2"
			target="ifrm">
			<!-- and thumbs Up & Down -->
			<input type="hidden" name="num"
				value="<%=request.getParameter("num")%>">
			<div class="row center pb-2 ml-5">
				<input type="text"
					class="text-left col-md-9 form-control border-primary ml-5"
					name="reply" style="height: 78px;"> <input type="submit"
					class="col-md-1 btn btn-success my-auto ml-2" value="댓글등록"
					onclick="addReply()">
					<% ThumbDAO tdao=new ThumbDAO();
					boolean isDown=tdao.select(Integer.parseInt(request.getParameter("num")),session.getAttribute("id").toString());%>
					<img class="rounded-lg <%=(isDown?"btn-secondary":"btn-primary") %> my-auto ml-2" onclick="thumbAction()"
					alt="Thumb Up" src="images/thumbUp.png" width="45px" height="45px">
			</div>
		</form>
	</div>
	<iframe name="ifrm" width="0" height="0" style="border:0;"></iframe>
	<%
		}
	%>

</body>
<script>
function filechk(val){
	if(val.length>0){
		if(document.getElementById("upfile3")!=null){document.getElementById("upfile3").style.display = 'none';}
		document.form.action="uploadPro.jsp";
		document.form.enctype="multipart/form-data";
		document.form.target="ifrm";
		document.form.submit();
	}
}
	function deleteReply(rnum,bnum) {
		if (confirm("정말로 삭제하시겠습니까?")) {
			document.form3.rnum.value=rnum;
			document.form3.bnum.value=bnum;
			document.form3.submit();
			setTimeout(function() {
				history.go(0);
			}, 300);
		}
	}
	function thumbAction(){
		document.form2.action="thumbPro.jsp"
		document.form2.submit();
		setTimeout(function() {
			history.go(0);
		}, 300);
	}
	function addReply() {
		document.form2.submit();
		setTimeout(function() {
			history.go(0);
		}, 300);
	}
	function modifyMode() {
		if (document.getElementById("title").style.display != 'none') { // 보기상태(수정하기)이면 수정상태로 전환
			document.getElementById("title").style.display = 'none';
			document.getElementsByName("titleRe")[0].style.display = 'inline';
			document.getElementsByName("titleRe")[0].value = document
					.getElementById("title").innerHTML; // 처음값으로 돌리기
			document.getElementById("content").style.display = 'none';
			document.getElementsByName("contentRe")[0].style.display = 'inline';
			document.getElementsByName("contentRe")[0].value = document
					.getElementById("content").innerHTML;
			document.getElementsByName("contentRe")[0].focus();
			document.getElementById("modify").value = "수정완료";
			if(document.getElementById("upfile1")!=null){document.getElementById("upfile1").style.display = 'none';}
			if(document.getElementById("upfile2")!=null){document.getElementById("upfile2").style.display = 'none';}
			if(document.getElementById("upfile3")!=null){document.getElementById("upfile3").style.display = 'inline';}
			document.getElementsByName("upfile")[0].style.display = 'inline';
		} else { // 수정상태(적용하기)이면 contentPro로 이동
			document.form.action = "board_modiPro.jsp";
			document.form.enctype="";
			document.form.target="ifrm";
			document.form.submit();
			setTimeout(function() {
				history.go(0);
			}, 300);
		}
	}
	function delBoard() {
		if (confirm("정말로 삭제하시겠습니까?")) {
			document.form.action = "board_delPro.jsp";
			document.form.enctype="";
			document.form.target="_self";
			document.form.submit();
		}
	}
	function backContent() {
		if (document.getElementById("title").style.display != 'none') { //	보기상태면 이전 페이지로
			location.href = document.form.history.value;
		} else { // 수정상태면 보기모드로 전환
			document.getElementsByName("titleRe")[0].style.display = 'none';
			document.getElementById("title").style.display = 'inline';
			document.getElementsByName("contentRe")[0].style.display = 'none';
			document.getElementById("content").style.display = 'inline';
			document.getElementById("modify").value = "수정하기";
			if(document.getElementById("upfile1")!=null){document.getElementById("upfile1").style.display = 'inline';}
			if(document.getElementById("upfile2")!=null){document.getElementById("upfile2").style.display = 'inline';}
			if(document.getElementById("upfile3")!=null){document.getElementById("upfile3").style.display = 'none';}
			document.getElementsByName("upfile")[0].style.display = 'none';
		}
	}
</script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</html>