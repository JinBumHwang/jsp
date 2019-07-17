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
	<%@include file="time.jsp"%>
	<div class="container">
		<div class="row">

			<div class="card text-white bg-primary mb-3" style="width: 100%;">
				<div class="card-header">Header</div>
				<div class="card-body">
					<h5 class="card-title">Primary card title</h5>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<p>
						<a class="btn btn-light" href="#" role="button">View details »</a>
					</p>
				</div>
			</div>

			<div class="card text-white bg-success mb-3"
				style="width: 49%; margin-right: 1%;">
				<div class="card-header">Header</div>
				<div class="card-body">
					<h5 class="card-title">Success card title</h5>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<p>
						<a class="btn btn-dark" href="#" role="button">View details »</a>
					</p>
				</div>
			</div>

			<div class="card text-white bg-info mb-3" style="width: 49%;margin-left:1%;">
				<div class="card-header">Header</div>
				<div class="card-body">
					<h5 class="card-title">Success card title</h5>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<p>
						<a class="btn btn-secondary" href="#" role="button">View
							details »</a>
					</p>
				</div>
			</div>

		</div>
	</div>

	<%@include file="footer.jsp"%>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</body>
</html>