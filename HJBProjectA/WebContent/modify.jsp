<%@page import="hjb.MemberDTO"%>
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
		if (session.getAttribute("id") != null) {
			MemberDTO dto = new MemberDAO().select(session.getAttribute("id").toString());
	%>
	
<!-- 	<form method="post" action="joinPro.jsp" -->
<!-- 		class="form-signin bg-light mx-auto p-5  rounded-lg mt-5 needs-validation" -->
<!-- 		novalidate style="width: 40%; min-width: 600px"> -->
	
	<form method="post" action="modifyPro.jsp" name="form"
		class="form-signin bg-light mx-auto p-5  rounded-lg mt-5 needs-validation"
		novalidate style="width: 40%; min-width: 600px">

		<div class="mb-2">
			<label class="ml-3" for="id">ID</label> <input type="text"
				class="form-control" id="id" name="id" placeholder="ID" required
				readonly value="<%=dto.getId()%>">
		</div>

		<div class="mb-1">
			<label class="ml-3" for="pwold">Password</label> 
			<input
				type="password" class="form-control" id="pwold" name="pwold"
				placeholder="Password" required>
		</div>

		<div class="mb-1">
			<label class="ml-3" for="pw">Change Password</label> <input
				type="password" class="form-control" id="pw" onchange="checkPwr()"
				name="pw" placeholder="Change Password">
		</div>
		<div class="mb-2">
			<label class="ml-3" for="pwr">Change Password repeat</label> <input
				type="password" class="form-control" id="pwr" onchange="checkPwr()"
				name="pwr" placeholder="Change Password repeat">
			<p class="text-danger ml-2 mb-1" id="msgPwr"></p>
		</div>

		<div class="mb-3">
			<label class="ml-3" for="name">Name</label> <input type="text"
				class="form-control" id="name" name="name" placeholder="Name"
				onkeyup="checkText(this)" onkeydown="checkText(this)" required
				value="<%=dto.getName()%>">

			<div class="invalid-feedback">이름을 입력하세요.</div>
		</div>
		<input type="hidden" id="hiddenYear"
			value="<%=dto.getBirth().substring(0, 4)%>"> <input
			type="hidden" id="hiddenMonth"
			value="<%=dto.getBirth().substring(4, 6)%>"> <input
			type="hidden" id="hiddenDate"
			value="<%=dto.getBirth().substring(6, 8)%>">
		<div class="row">
			<div class="col-md-3 mb-3 fr-0" style="min-width: 110px">
				<label class="ml-3" for="year">Year</label> <select
					onchange="checkDateFromYear();" class="custom-select d-block w-100"
					id="year" name="year" required>
				</select>
			</div>
			<div class="col-md-2 mb-3" style="min-width: 90px">
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
			<div class="col-md-2 mb-3" style="min-width: 90px">
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
			<input type="hidden" id="hiddenGender" value="<%=dto.getGender()%>">
			<div class="col-md-3 mb-3" style="min-width: 127px">
				<label class="ml-3" for="date">Gender</label> <select
					class="custom-select d-block w-100" id="gender" name="gender"
					required>
					<option value="male">Male</option>
					<option value="female">Female</option>
				</select>
			</div>
		</div>

		<div class="mb-3">
			<label class="ml-3" for="email">Email <span
				class="text-muted">(Optional)</span></label> <input type="email"
				class="form-control" id="email" name="email"
				placeholder="you@abc.com" value="<%=dto.getEmail()%>">
			<div class="invalid-feedback">올바른 이메일 주소를 입력해주세요</div>
		</div>

		<div class="mb-3">
			<label class="ml-3" for="tel">Tel</label> <input type="tel"
				class="form-control" id="tel" name="tel" placeholder="010-0000-0000"
				value="<%=dto.getTel()%>">
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
			<input class="form-control mb-1" type="text" id="address"
				name="address" placeholder="Address" readonly
				value="<%=dto.getAddress()%>"> <input class="form-control"
				type="text" name="detailAddr" id="detailAddress"
				placeholder="Detail Address" value="<%=dto.getDetailAddr()%>">
		</div>

		<button class="btn btn-lg btn-primary btn-block" type="submit"
			onclick="checkCpwr()">Modify</button>
		<button class="btn btn-sm btn-danger btn-block" type="button"
			onclick="checkPw()">Withdraw</button>
			
		<p class="mt-5 mb-3 text-muted text-center">© 2017-2019</p>
		<div class="text-center">
			<a href="index.jsp">Home</a>
		</div>
	</form>
	<%
		} else {// 세션이 없을 경우
			response.addHeader("Refresh", "2;url=login.jsp");
	%>
	<div class="alert alert-warning mt-5 p-5" role="alert">세션이 만료되었거나
		로그인 정보가 없습니다. 로그인 화면으로 이동합니다..</div>
	<%
		}
	%>


</body>
<script>
	function checkCpwr() {
		
	if (document.getElementById('pw').value == document
				.getElementById('pwr').value) { // 변경할 비밀번호==반복
			if (document.getElementById("pwold").value == 0) {
				alert("비밀번호를 입력하세요");
			} else if (document.getElementById("pw").value == "") // 변경할 비밀번호란이 공백일때, 비밀번호 변경하지 않음
				document.form.submit();
			else if (document.getElementById("pw").checkValidity()) // 공백이 아닐때, 6자이상 문자,숫자 확인
				document.form.submit(); // 폼 액션으로 보냄
			else
				// 확인시 불량이면
				location.href = "#pw";
		} else { // 변경할 비밀번호!=반복
			location.href = "#pw";
		}
	}
	// 정보 수정시 기존 비밀번호 입력은 필수!
	function checkPw() {
		if (document.getElementById("pwold").value.length < 1) {
			alert("비밀번호를 입력해주세요");
			location.href = "#pwold";
		} else {
			document.form.action = "withdrawPro.jsp";
		}
	}
</script>
<script src="my/searchAddress.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="my/func_member.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</body>
</html>