<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test</title>
</head>
<body>
	<%
		Object obj=session.getAttribute("mySession");
		if(obj==null){
			System.out.println("SESSION NULL");
			session.setAttribute("mySession", "myValue");
			response.sendRedirect("test.jsp");
		}else{
			System.out.println("SESSION "+obj.toString());
		}
	%>
	<select name="select" id="hidden">
	</select>
	<form name="form">
	<input type="button" name="hihi" value="HH">
	</form>
	<script>
	alert(document.form.hihi.value+"!@!");
		alert(document.getElementById('hidden'));
		if(document.getElementById('hidden')==null){
			alert("HIDDEN NULL")
		}else{
			alert("HIDDEN NOT NULL");
		}
	</script>
</body>
</html>