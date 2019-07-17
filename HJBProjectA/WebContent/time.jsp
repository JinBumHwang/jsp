<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
window.onload=function(){
	setInterval(timer, 1000);
}
function timer(){
	var d = new Date();
    document.getElementById('time').innerHTML=d.getFullYear()+
    "-"+( d.getMonth() + 1 )+"-"+d.getDate()
    + (d.getHours()<12?" 오전 ":" 오후 ")+
    + (d.getHours()==0?"12":d.getHours()>12?d.getHours()-12:d.getHours())
    + ":"+d.getMinutes() + " " + d.getSeconds();
}
</script>
<div id="time" style="color: #00ddff;text-align:right;"></div>
