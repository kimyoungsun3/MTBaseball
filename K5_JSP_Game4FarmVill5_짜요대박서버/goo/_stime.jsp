<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8");%>
<%
	//1. 생성자 위치
	StringBuffer msg 			= new StringBuffer();
	java.text.SimpleDateFormat format19 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date now 			= new java.util.Date();
	String dateid 				= "" + format19.format(now);

	//2-2. 스토어즈 프로시져 실행하기

	//2-3. xml형태로 데이타 출력
	msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
	msg.append("<rows>\n");
	msg.append("	<result>\n");
	msg.append("		<code>");			msg.append(999); 					msg.append("</code>\n");
    msg.append("		<resultcode>");		msg.append(1);    					msg.append("</resultcode>\n");
	msg.append("		<resultmsg>");		msg.append("current time");    		msg.append("</resultmsg>\n");
    msg.append("		<dateid>");			msg.append(dateid); 				msg.append("</dateid>\n");
	msg.append("	</result>\n");
    msg.append("</rows>\n");


    out.print(msg);
%>