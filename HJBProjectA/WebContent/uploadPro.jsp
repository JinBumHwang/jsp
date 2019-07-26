<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");

	String realFolder = getServletContext().getRealPath("upload");

	int max = 1024 * 1024 * 20;

	MultipartRequest multi = new MultipartRequest(request, realFolder, max, "UTF-8",
			new DefaultFileRenamePolicy());
	
	Enumeration e = multi.getFileNames();
	String fileName=multi.getFilesystemName(e.nextElement().toString());
	session.setAttribute("upfile", fileName);
	// src="upload/fileName"
%>