<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="hjb.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
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
<body class="mybody">
	<%@include file="header.jsp"%>
	<%
		BoardDAO dao = new BoardDAO();
	%>

	<form action="board.jsp" method="get" name="form">

		<div class="container">
			<input type="hidden" name="num">
			<input type="hidden" name="history">
			<input type="hidden" name="search"
				value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>">
				<%if(request.getParameter("search") != null && request.getParameter("search").length()>0){ 
						String str=request.getParameter("searchOption");
						if(str.equals("1")){
							str="Title: ";
						}else if(str.equals("2")){
							str="Content: ";
						}else{
							str="Title&Content: ";
						}
				%>
					<h2 class="text-white-50 mx-auto text-center"><%=str%><span class="text-light"><%=request.getParameter("search").replaceAll(" ", ",") %></span>로 검색한 결과</h2>
				<%} %>
			
		</div>

		<div class="container">
			<div class="row border-bottom py-2 bg-primary rounded-top">
				<div class="col-1 text-center text-light">번호</div>
				<div class="col-5 text-center text-light">제목</div>
				<div class="col-2 text-center text-light">글쓴이</div>
				<div class="col-2 text-center text-light">등록일</div>
				<div class="col-1 text-center text-light">조회</div>
				<div class="col-1 text-center text-light">추천</div>
			</div>
			<%
				request.setCharacterEncoding("UTF-8");
			
				int pageNum = 1; // 기본 페이지
				// 페이지 이동시
				if (request.getParameter("pageNum") != null && request.getParameter("pageNum").length() > 0) {
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}
				int pageSize = 10; // 한 페이지 글 수
				ArrayList<BoardDTO> list = null;
				int pageTotal=0;
				int count=0;
				// 검색어 찾기 search, searchOption
				if(request.getParameter("search")!=null && request.getParameter("search").length()>0){
					String[] str=request.getParameter("search").split(" ");
					count = dao.countAll(str,Integer.parseInt(request.getParameter("searchOption"))); // 갯수(검색)
					pageTotal = count / pageSize + (count % pageSize > 0 ? 1 : 0); // 총 페이지 수
					list = dao.select(pageNum, pageSize, str, Integer.parseInt(request.getParameter("searchOption")));
				}else{
					count = dao.countAll(); // 갯수
					pageTotal = count / pageSize + (count % pageSize > 0 ? 1 : 0); // 총 페이지 수
					list = dao.select(pageNum, pageSize);
				}
				// 게시글 불러오기
				for (BoardDTO dto : list) {
			%>
			<div class="row border-bottom py-2 bg-light">
				<div class="col-1 text-center my-auto"><%=dto.getNum()%></div>
				<a href="javascript:clickContent(<%=dto.getNum()%>)"
					class="col-5 text-dark text-decoration-none"><%=dto.getTitle()%>
					<%if(dto.getReplycount()>0){ %><span class="font-weight-bold">
					  [<%=dto.getReplycount()%>]</span><%} %>
					 <%if(dto.getFileAddr()!=null && dto.getFileAddr().length()>0){ %><span class="font-weight-bold">
					   ▤</span><%} %> 
				</a>
				<div class="col-2 text-center my-auto"><%=dto.getName()%></div>
				<div class="col-2 small text-center my-auto"><%=dto.getReg_date().toString().substring(0, 16)%></div>
				<div class="col-1 text-center my-auto"><%=dto.getReadcount()%></div>
				<div class="col-1 text-center my-auto"><%=dto.getThumbcount()%></div>
			</div>
			<%
				}
			%>
		</div>

		<div class="container">
			<div class="input-group mb-3 my-3">
				<input type="hidden" name="pageNum">
				<div class="input-group-prepend mx-auto">
					<input type="button" class="btn btn-light rounded-pill"
						value="Prev"
						onclick="boardPage(<%=(pageNum > 1 ? pageNum - 1 : pageNum)%>)">
					<%
						int start = 1; // 1부터 시작
						int end = 0; // 총 페이지 + 1
						if (pageTotal < 5) { // 총 페이지 수가 5개 미만
							start = 1;
							end = pageTotal + 1;
						} else { // 총 페이지 수가 5개 이상
							start = (pageNum > 4 ? pageNum - 4 : 1);
							end = (pageNum < pageTotal - 4 ? pageNum + 4 : pageTotal) + 1;
						}
						for (int i = start; i < end; i++) {
					%>
					<input type="button"
						class="ml-1 btn rounded-pill <%=(pageNum == i ? "btn-primary" : "btn-light")%>"
						value="<%=i%>" onclick="boardPage(<%=i%>)">
					<%
						}
					%>
					<input type="button" class="ml-1 btn btn-light rounded-pill"
						value="Next"
						onclick="boardPage(<%=(pageNum < pageTotal ? pageNum + 1 : pageNum)%>)">
				</div>
			</div>
		</div>


		<div style="width: 36%; margin: auto;">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<input type="hidden" name="searchOption"
						value="<%=request.getParameter("searchOption") != null ? request.getParameter("searchOption") : ""%>">
					<select class="custom-select" id="searchOptionSelect">
						<option value="1" selected>Title</option>
						<option value="2">Content</option>
						<option value="3">Title+Content</option>
					</select>
				</div>
				<input type="text" class="form-control ml-1" placeholder="Search.."
					id="searchInput" maxlength="24"> <input type="submit"
					class="btn btn-light rounded-lg ml-1" value="Search"
					onclick="searchPage()">
				<%
					if (session.getAttribute("id") != null) { // 로그인 상태: 글쓰기
				%>
				<input type="button" class="btn btn-light rounded-lg ml-1"
					value="Write" onclick="location.href='board_add.jsp'">
				<%
					}
				%>
			</div>

		</div>
	</form>
	<script>
		// ★★★form안의 input_hidden은 name속성필수
		// hidden : pageNum, search, searchOption
		// : 재요청할 경우 form안에 name속성있는 값들 다 확인해야함, 
	    function boardPage(num){ // 페이지 이동, 검색어 유지
			document.form.pageNum.value=num;
	    	document.form.submit();
	    }
	    function searchPage(){ // 검색어 찾기, 페이지 1로 이동
	    	var sVal=document.getElementById("searchInput").value;
	    	var soVal=document.getElementById("searchOptionSelect").value;
	   		document.form.searchOption.value=soVal
	   		document.form.search.value=sVal;
	    	document.form.pageNum.value=1;
	    	document.form.submit();
	    }
	    function clickContent(val){
	    	document.form.num.value=val;
	    	document.form.history.value=location.href;
	    	document.form.method="post";
	    	document.form.action="content.jsp";
	    	document.form.submit();
	    }
	</script>
	<%@include file="footer.jsp"%>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</body>

</html>