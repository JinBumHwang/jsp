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
<%
	MemberDAO dao=new MemberDAO();
%>
	<form method="post" action="joinPro.jsp"
		class="form-signin bg-light mx-auto p-5  rounded-lg mt-5 needs-validation"
		novalidate style="width: 40%;min-width:600px">

		<div class="mb-2">
			<label class="ml-3" for="id">ID</label> <input type="text" onkeydown="checkText(this)"
			onkeyup="checkText(this)" onchange="selectId('<%=dao.selectAll() %>')"
				class="form-control" id="id" name="id" placeholder="ID" required>
		<p class="text-danger ml-2 mb-1" id="msgId"></p>
		</div>

		<div class="mb-1">
			<label class="ml-3" for="pw">Password</label> <input type="password"
				class="form-control" id="pw" onchange="checkPwr()" name="pw"
				placeholder="Password" required>
		</div>
		<div class="mb-2">
			<label class="ml-3" for="pwr">Password repeat</label> <input
				type="password" class="form-control" id="pwr" onchange="checkPwr()"
				name="pwr" placeholder="Password repeat" required>
		<p class="text-danger ml-2 mb-1" id="msgPwr"></p>
		</div>
		
		<div class="mb-3">
			<label class="ml-3" for="name">Name</label> <input type="text"
				class="form-control" id="name" name="name" placeholder="Name" onkeyup="checkText(this)"
				onkeydown="checkText(this)"
				required>
			<div class="invalid-feedback">이름을 입력하세요.</div>
		</div>

		<div class="row">
			<div class="col-md-3 mb-3 fr-0">
				<label class="ml-3" for="year">Year</label> <select
					onchange="checkDateFromYear();" class="custom-select d-block w-100"
					id="year" name="year" required>
				</select>
			</div>
			<div class="col-md-2 mb-3">
				<label class="ml-3" for="month">Month</label> <select
					onchange="checkDate(this.value)"
					class="custom-select d-block w-100" id="month" name="month"
					required>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
			</div>
			<div class="col-md-2 mb-3">
				<label class="ml-3" for="date">Date</label> <select
					class="custom-select d-block w-100" id="date" name="date" required>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29" id="d29">29</option>
					<option value="30" id="d30">30</option>
					<option value="31" id="d31">31</option>
				</select>
			</div>
			<div class="col-md-3 mb-3">
				<label class="ml-3" for="date">Gender</label> <select
					class="custom-select d-block w-100" id="gender" name="gender" required>
					<option value="male">Male</option>
					<option value="female">Female</option>
				</select>
			</div>
		</div>

		<div class="mb-3">
			<label class="ml-3" for="email">Email <span
				class="text-muted">(Optional)</span></label> <input type="email"
				class="form-control" id="email" name="email"
				placeholder="you@abc.com">
			<div class="invalid-feedback">올바른 이메일 주소를 입력해주세요</div>
		</div>

		<div class="mb-3">
			<label class="ml-3" for="tel">Tel</label> <input type="tel"
				class="form-control" id="tel" name="tel" placeholder="010-0000-0000">
		</div>

		<div class="row">
			<div class="col-md-4 mb-2">
				<input type="text" class="form-control" id="postcode"
					placeholder="Postcode" readonly>
			</div>
			<div class="col-md-3 mb-2">
				<input type="button" class="btn btn-info" onclick="daumPostcode()"
					value="Search">
			</div>
		</div>
		<div class="mb-3">
			<input class="form-control mb-1" type="text" id="address" name="address"
				placeholder="Address" readonly> <input class="form-control"
				type="text" id="detailAddr" name="detailAddr" placeholder="Detail Address">
		</div>

		<button class="btn btn-lg btn-primary btn-block" type="submit">Sign
			in</button>
		<p class="mt-5 mb-3 text-muted text-center">© 2017-2019</p>
		<div class="text-center">
			<ul class="list-inline">
				<li class="list-inline-item"><a href="index.jsp">Home</a></li>
				<li class="list-inline-item">|</li>
				<li class="list-inline-item"><a href="login.jsp">Login</a></li>
			</ul>
		</div>
	</form>

<script src="my/searchAddress.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="my/func_member.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</body>
</html>