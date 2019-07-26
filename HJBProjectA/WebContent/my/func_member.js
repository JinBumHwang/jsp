// join.jsp, modify.jsp 에서 참고
function dateDisable(date) { // 데이터 검은색, 선택불가
	document.getElementById("d" + date).disabled = true;
	document.getElementById("d" + date).classList.add("bg-dark");
}
function dateAble(date) { // 선택가능
	document.getElementById("d" + date).disabled = false;
	document.getElementById("d" + date).classList.remove("bg-dark");
}

function checkDateFromYear() { // "년"이동시 2월이면 변경될 수 있음
	if (document.getElementById("month").value == 2) {
		checkDate('2');
	}
}

function checkDate(val) { // 28일 29일 30일 31일 결정
	switch (val) {
	case '1':
	case '3':
	case '5':
	case '7':
	case '8':
	case '10':
	case '12':
		dateAble(29);
		dateAble(30);
		dateAble(31);
		break;
	case '2':
		var year = document.getElementById("year").value;
		var maxDay;
		if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
			maxDay = 29;
			dateAble(29);
		} else {
			maxDay = 28;
			dateDisable(29);
		}
		dateDisable(30);
		dateDisable(31);
		if (document.getElementById("date").value > maxDay) {
			document.getElementById("date").value = maxDay;
		}
		break;
	default:
		dateAble(29);
		dateAble(30);
		dateDisable(31);
		if (document.getElementById("date").value > 30) {
			document.getElementById("date").value = 30;
		}
		break;
	}

}

function checkText(obj) { // 특수문자 막기
	var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-+┼<>@\#$%&\'\"\\\(\=]/gi;// 정규식
	if (RegExp.test(obj.value)) {
		obj.value = obj.value.substring(0, obj.value.length - 1);// 최신 한 글자
		// 지우기
	}
}

function selectId(all) { // all은 db로 모든 아이디로 조회한 값들을 ,로 연결한 문자열
	var arr = all.split(',');
	var id = document.getElementById('id');
	var out = document.getElementById('msgId');
	if (id.value.length == 0) {
		out.innerHTML = "";
		id.setCustomValidity("N");
		return;
	}

	for (var i = 0; i < arr.length; i++)
		if (id.value == arr[i]) {
			out.innerHTML = "이미 사용중인 아이디입니다.";
			id.setCustomValidity("N");
			return;
		}
	out.innerHTML = "<span class='text-success'>사용할 수 있는 아이디입니다.</span>";
	id.setCustomValidity("");
}

// 비밀번호 조건: 6자 이상 문자,숫자 1개씩 포함
function checkPwr() { // passwordRepeat
	var pw = document.getElementById('pw');
	var pwr = document.getElementById('pwr');
	var out = document.getElementById('msgPwr');

	// case pw.Validity pwr.validity out.innerHTMl
	// pw<6 F F O
	// no num eng F F O
	// pwr len 0 T F O
	// pw==pwr T T O
	// pw!=pwr T F O
	if (pw.value.length > 5) { // pw > 5
		pw.setCustomValidity("N"); // false : "" 이면 false, "내용있으면"는 true
		pwr.setCustomValidity("N");
		var pNum = false;
		var pEng = false; // hasNum, hasEng
		for (var i = 0; i < pw.value.length; i++) { //영어,숫자 검색
			var cha = pw.value.charAt(i);
			if (cha >= 0 && cha <= 9) {
				pNum = true;
			} else if ((cha >= 'a' && cha <= 'z') || (cha >= 'A' && cha <= 'Z')) {
				pEng = true;
			}
			if (pNum && pEng) {
				pw.setCustomValidity(""); // true
				break;
			}
		}
		if (!pw.checkValidity()) {
			out.innerHTML = "숫자, 영어를 반드시 포함해야 합니다.";
			// end hasNum, hasEng : pw.validity 확정됨
		} else if (pwr.value.length == 0) { // pwr length 0
			out.innerHTML = "";
		} else if (pw.value == pwr.value) { // pw == pwr
			out.innerHTML = "<span class='text-success'>사용할 수 있는 비밀번호입니다.</span>";
			pwr.setCustomValidity("");
		} else { // pw != pwr
			out.innerHTML = "입력한 비밀번호와 일치하지 않습니다.";
		}
	} else { // pw <6
		out.innerHTML = pw.value.length > 0 ? "비밀번호는 6자 이상이어야 합니다." : "";
		pw.setCustomValidity("N");
		pwr.setCustomValidity("N");
	}
}

window.onload = function() {
	// "년" 출력
	var date = new Date().getFullYear();
	var str = "";
	for (var i = date; i > date - 91; i--) {
		str += "<option value='" + i + "'>" + i + "</option>";
	} // "년" 출력
	document.getElementById("year").innerHTML = str;

	if (document.getElementById("hiddenYear") != null) { // when:modify.jsp
		var hiddenVal = document.getElementById("hiddenYear").value;
		var arrOption = document.getElementById("year").options;
		for (var i = 0; i < arrOption.length; i++) {
			if (arrOption[i].value == hiddenVal) {
				arrOption[i].selected = true;
				break;
			}
		}
		hiddenVal = document.getElementById("hiddenMonth").value;
		arrOption = document.getElementById("month").options;
		for (var i = 0; i < arrOption.length; i++) {
			if (arrOption[i].value == hiddenVal) {
				arrOption[i].selected = true;
				break;
			}
		}
		hiddenVal = document.getElementById("hiddenDate").value;
		arrOption = document.getElementById("date").options;
		for (var i = 0; i < arrOption.length; i++) {
			if (arrOption[i].value == hiddenVal) {
				arrOption[i].selected = true;
				break;
			}
		}
		hiddenVal = document.getElementById("hiddenGender").value;
		arrOption = document.getElementById("gender").options;
		for (var i = 0; i < arrOption.length; i++) {
			if (arrOption[i].value == hiddenVal) {
				arrOption[i].selected = true;
				break;
			}
		}
	} // when:modify.jsp

	var form = document.getElementsByClassName('needs-validation')[0];
	form.addEventListener('submit', function(event) {
		if (form.checkValidity() === false) {
			event.preventDefault();
			event.stopPropagation();
		}
		form.classList.add('was-validated');
	}, false);
}