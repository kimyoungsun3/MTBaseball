<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="formutil.FormUtil"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_sysagreement.jsp"%>
<%
	//1. 생성자 위치
	StringBuffer msg 			= new StringBuffer();
	int lang 					= util.getParamInt(request, "lang", 0);
	int idx						= lang;
	if(lang >= strAgreement.length){
		idx = 0;
	}

	//2-3. xml형태로 데이타 출력
	msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
	msg.append("<rows>\n");
	msg.append("	<result>\n");
	msg.append("		<code>");			msg.append(PTS_AGREEMENT); 				msg.append("</code>\n");
	msg.append("		<resultcode>");		msg.append(1);    						msg.append("</resultcode>\n");
	msg.append("		<resultmsg>");		msg.append("약관동의("+lang+")");		msg.append("</resultmsg>\n");
	msg.append("		<resultagreement>");msg.append(strAgreement[idx*2    ]);  	msg.append("</resultagreement>\n");
	msg.append("		<resultsms>");		msg.append(strAgreement[idx*2 + 1]);  	msg.append("</resultsms>\n");
	msg.append("	</result>\n");
    msg.append("</rows>\n");
	out.print(msg);
%>
