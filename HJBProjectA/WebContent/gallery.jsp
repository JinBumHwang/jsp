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
<script>
    function galleryPage(num){
    	location.href="gallery.jsp?pageNum="+num;
    }
    </script>
</head>
<body class="mybody">
	<%@include file="header.jsp"%>

	<div class="container">
		<div class="row">
			<%
				request.setCharacterEncoding("UTF-8");
				int pageNum = 1;
				if (request.getParameter("pageNum") != null) {
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}

				int pageSize = 6; // 한 페이지 글 수

				String[] row = new String[200]; // 임시 게시글

				int pageCount = row.length / 10; // 페이지 조회했을때 갯수
				for (int i = 0; i < pageSize; i++) {
					// 게시글 불러오기
			%>


			<div class="col-md-4">
				<div class="card mb-4 shadow-sm">
					<img class="bd-placeholder-img card-img-top" src="images/b1.jpg" />
					<div class="card-body">
						<p class="card-text">This is a winter.A</p>
						<small class="text-muted">9 mins</small>
					</div>
				</div>
			</div>
			<%
				}
			%>

		</div>
	</div>
	<!-- container -->

	<div class="container">
		<div class="input-group mb-3 ">
			<div class="input-group-prepend mx-auto">
				<input type="button" class="btn-white btn-outline-black"
					name="pagePrev" value="Prev"
					onclick="galleryPage(<%=(pageNum > 1 ? pageNum - 1 : pageNum)%>)">
				<%
					int start = 1;
					int end = 0;
					if (pageCount < 10) {
						start = 1;
						end = pageCount + 1;
					} else {
						start = (pageNum > 4 ? pageNum - 4 : 1);
						end = (pageNum < pageCount - 3 ? pageNum + 4 : pageCount) + 1;
					}
					for (int i = start; i < end; i++) {
				%>
				<input type="button"
					class="btn-white btn-outline-black <%=(pageNum == i ? "text-primary" : "")%>"
					name="pageNum" value="<%=i%>" onclick="galleryPage(<%=i%>)">
				<%
					}
				%>
				<input type="button" class="btn-white btn-outline-black"
					name="pageNext" value="Next"
					onclick="galleryPage(<%=(pageNum < pageCount ? pageNum + 1 : pageNum)%>)">
			</div>
		</div>
	</div>

	<form action="#">
		<div style="width: 36%; margin: auto;">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<select class="custom-select" id="inputGroupSelect02">
						<option value="1" selected>Title</option>
						<option value="2">Content</option>
						<option value="3">Title+Content</option>
					</select>
				</div>
				<input type="text" class="form-control" placeholder="Search..">
				<input type="submit" class="btn-white btn-outline-black">
			</div>
		</div>
	</form>

	<%@include file="footer.jsp"%>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</body>
</html>