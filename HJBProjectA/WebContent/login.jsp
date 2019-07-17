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
<%
	String id = null;
	if (request.getHeader("Cookie") != null) {
		Cookie cookList[] = request.getCookies();
		for (int i = 0; i < cookList.length; i++) {
			if (cookList[i].getName().equals("remember")) {
				id = cookList[i].getValue();
				break;
			}
		}
	}
	id = request.getParameter("id") == null ? id : request.getParameter("id");
%>
<body class="text-center mybody">
	<form class="form-signin bg-light mx-auto p-5  rounded-lg mt-5"
		action="loginPro.jsp" method="POST" style="width: 40%;min-width:600px">
		<img class="mb-4 rounded-lg" src="images/b1.jpg" width="80%">
		<h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
		<label for="id" class="sr-only">ID</label> <input type="text"
			onkeydown="checkText(this)" onkeyup="checkText(this)" id="id"
			name="id" class="form-control" placeholder="ID" required
			<%if(id==null){%>autofocus<%}%>
			value="<%=id==null?"":id%>">
		<label for="pw" class="sr-only">Password</label> <input
			type="password" id="pw" name="pw" class="form-control"
			placeholder="Password" required
			<%if(id!=null){%>autofocus<%}%>>
		<div class="checkbox m-3">
			<label> <input type="checkbox" name="remember"
			<%if(id!=null){%>checked<%}%>>
				Remember me
			</label>
		</div>
		<button class="btn btn-lg btn-primary btn-block" type="submit">Sign
			in</button>
	<p class="mt-5 mb-3 text-muted">© 2017-2019</p>
	<ul class="list-inline">
		<li class="list-inline-item"><a href="index.jsp">Home</a></li>
		<li class="list-inline-item">|</li>
		<li class="list-inline-item"><a href="join.jsp">Join</a></li>
	</ul>
	</form>


</body>
<script>
function checkText(obj) {
    var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식
    if (RegExp.test(obj.value)) {
        obj.value = obj.value.substring(0, obj.value.length - 1);//최신 한 글자 지우기
    }
}
</script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</body>
</html>