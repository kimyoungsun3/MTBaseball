<%@ page language="java" contentType="text/html; charset=utf-8"%><%@ page import="java.sql.*"%><%request.setCharacterEncoding("utf-8");%><%
	//1. 생성자 위치
	StringBuffer msg 			= new StringBuffer();
	java.text.SimpleDateFormat format19 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date now 			= new java.util.Date();
	String dateid 				= "" + format19.format(now);


	msg.append(dateid);

    out.print(msg);
%>