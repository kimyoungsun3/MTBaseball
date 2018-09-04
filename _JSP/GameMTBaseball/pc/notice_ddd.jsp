<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%
	//1. 생성자 위치
	StringBuffer msg 			= new StringBuffer();

	msg.append("<?xml version='1.0' encoding='utf-8'?>");
	msg.append("<rows>");
	msg.append("<result>");
	msg.append("<code>28</code>");
	msg.append("<resultcode>1</resultcode>");
	msg.append("<resultmsg>공지사항</resultmsg>");
	msg.append("</result>");
	msg.append("<notice>");
	msg.append("<version>101</version>");
	msg.append("<syscheck>0</syscheck>");
	msg.append("<comfile>http://175.117.144.244:8881/Game4Farm/etc/_ad/event01_20140425.png</comfile>");
	msg.append("<comurl>http://m.pictosoft.co.kr/link/farmtycoon/event2/</comurl>");
	msg.append("<comfile2>http://175.117.144.244:8881/Game4Farm/etc/_ad/event02_20140425.png</comfile2>");
	msg.append("<comurl2>http://m.pictosoft.co.kr/link/farmtycoon/event2/</comurl2>");
	msg.append("<comfile3>http://175.117.144.244:40009//Game4Farm/etc/_ad/school.png</comfile3>");
	msg.append("<comurl3>http://www.hungryapp.co.kr/bbs/list.php?bcode=jjayo</comurl3>");
	msg.append("<patchurl>market://details?id=com.sangsangdigital.farmgg</patchurl>");
	msg.append("<recurl>http://m.pictosoft.co.kr/link/review/index.php?gid=farmtycoon&amp;market=5&amp;apptype=43</recurl>");
	msg.append("<smsurl></smsurl>");
	msg.append("<smscom></smscom>");
	msg.append("<communityurl>http://www.hungryapp.co.kr/bbs/list.php?bcode=jjayo</communityurl>");
	msg.append("<comment>[e41800][정기 점검 공지][-]");
	msg.append("5월 7일(수) 11:00~12:30 -> 서버 증설");
	msg.append("해당 시간 동안 게임 접속을 자제해 주시기 바랍니다.</comment>");
	msg.append("<iteminfover>100</iteminfover>");
	msg.append("<iteminfourl>http://175.117.144.244:8881/Game4Farm/etc/_ad/iteminfo_007_ad.dat</iteminfourl>");
	msg.append("<currentDate>2014-05-07 12:10:49</currentDate>");
	msg.append("</notice>");
	msg.append("</rows>");

	out.print(msg);
	/**/
%>
