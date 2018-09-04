<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>
<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int rtn = -1;
	int idxColumn				= 1;


	//1-2. 데이타 받기
	String serial 		= util.getParamStr(request, "serial", "-1");
	
	//2. 데이타 조작

	//2-2. 스토어즈 프로시져 실행하기

	//2-3. xml형태로 데이타 출력
	msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
	msg.append("<rows>\n");
	msg.append("	<result>\n");
	msg.append("		<code>");			msg.append(PTS_XXXXX); 				msg.append("</code>\n");
    msg.append("		<resultcode>");		msg.append(1);    					msg.append("</resultcode>\n");
	msg.append("		<resultmsg>");		msg.append("송공했습니다.");    	msg.append("</resultmsg>\n");
    msg.append("		<serial>");			msg.append(serial); 				msg.append("</serial>\n");
	msg.append("	</result>\n");
    msg.append("</rows>\n");
    /**/

    //3. 송출, 데이타 반납
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

    out.print(msg);
%>