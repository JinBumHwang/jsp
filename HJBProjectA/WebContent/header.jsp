<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header style="padding-bottom: 8%">
	<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		<a class="navbar-brand mylarge" href="index.jsp"> Home </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarCollapse" aria-controls="navbarCollapse"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarCollapse">
			<ul class="navbar-nav mr-auto">
<!-- 				<li class="nav-item mymedium"><a class="nav-link" -->
<!-- 					href="info.jsp"> Info </a></li> -->
				<li class="nav-item mymedium"><a class="nav-link"
					href="board.jsp"> Board </a></li>
				<li class="nav-item mymedium"><a class="nav-link"
					href="gallery.jsp"> Gallery </a></li>
			</ul>
			<ul class="navbar-nav">
				<%
					if (session.getAttribute("id") == null) {
				%>
				<li class="nav-item mymedium"><a class="nav-link"
					href="login.jsp">Login</a></li>
				<li class="nav-item mymedium"><a class="nav-link"
					href="join.jsp">Join</a></li>
				<%
					} else {
				%>
				<li class="nav-item small my-auto text-white"><%=session.getAttribute("name")%>님
					로그인 중..</li>
				<li class="nav-item mymedium"><a class="nav-link"
					href="modify.jsp">Modify</a></li>
				<li class="nav-item mymedium"><a class="nav-link"
					href="logoutPro.jsp">Logout</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</nav>
</header>