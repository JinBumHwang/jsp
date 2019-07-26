<%@page import="hjb.BoardDTO"%>
<%@page import="hjb.BoardDAO"%>
<%@page import="hjb.MemberDAO"%>
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
<body class="mybody">
	<%@include file="header.jsp"%>
	<form  action="content.jsp" method="post" name="form" class="container">
		<div class="row">
		<input type="hidden" name="history" value="index.jsp">
		<input type="hidden" name="num">
			<div class="text-white mb-3" style="width: 100%;">
				<h3 class="card-header bg-primary">Most recent</h3>
				<div class="card-body bg-primary">
				<%BoardDAO dao=new BoardDAO();
					BoardDTO dto=dao.selectRecnt();
				%>
					<h5 class="card-title"><%if(dto==null){ %>Primary card title<%}else{ %><%=dto.getTitle()%><%} %></h5>
					<p class="card-text">
					<%if(dto==null){ %>Some quick example text to build on the
						card title and make up the bulk of the card's content<%}else{ %><%=dto.getContent()%><%} %>. . .</p>
					<p>
					<%if(dto!=null){ %>
						<a class="btn btn-light" href="javascript:clickContent('<%=dto.getNum() %>')" role="button">View details »</a>
						<%} %>
					</p>
				</div>
			</div>

			<div class="text-white mb-3"
				style="width: 49%; margin-right: 1%;">
				<h3 class="card-header bg-success">Most recommended</h3>
				<div class="card-body bg-success">
				<%
					dto=dao.selectrecommended();
				%>
					<h5 class="card-title"><%if(dto==null){ %>Primary card title<%}else{ %><%=dto.getTitle()%><%} %></h5>
					<p class="card-text"><%if(dto==null){ %>Some quick example text to build on the
						card title and make up the bulk of the card's content.<%}else{ %><%=dto.getContent()%><%} %>. . .</p>
					<p>
						<%if(dto!=null){ %>
						<a class="btn btn-light" href="javascript:clickContent('<%=dto.getNum() %>')" role="button">View details »</a>
						<%} %>
					</p>
				</div>
			</div>

			<div class="text-white mb-3"
				style="width: 49%; margin-left: 1%;">
				<h3 class="card-header bg-info">Most viewed</h3>
				<div class="card-body bg-info">
				<%
					dto=dao.selectviewed();
				%>
					<h5 class="card-title"><%if(dto==null){ %>Primary card title<%}else{ %><%=dto.getTitle()%><%} %></h5>
					<p class="card-text"><%if(dto==null){ %>Some quick example text to build on the
						card title and make up the bulk of the card's content.<%}else{ %><%=dto.getContent()%><%} %>. . .</p>
					<p>
						<%if(dto!=null){ %>
						<a class="btn btn-light" href="javascript:clickContent('<%=dto.getNum() %>')" role="button">View details »</a>
						<%} %>
					</p>
				</div>
			</div>

		</div>
	</form>
<script>
function clickContent(val){
	document.form.num.value=val;
	document.form.submit();
}
</script>
	<%@include file="footer.jsp"%>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</body>
</html>