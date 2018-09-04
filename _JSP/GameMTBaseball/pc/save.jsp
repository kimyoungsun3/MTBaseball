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
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idx						= 1;
	//DEBUG_LOG_PARAM = true;


	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	String userinfo		= util.getParamStr(request, "userinfo", "");
	String aniitem		= util.getParamStr(request, "aniitem", "");
	String cusitem		= util.getParamStr(request, "cusitem", "");
	String paraminfo	= util.getParamStr(request, "paraminfo", "");
	int crypt			= util.getParamInt(request, "crypt", -1);

	if(crypt == 2){
		crypt 		= 1;

		userinfo 	= getDencode32(crypt, userinfo, "");	//999까지만 허용한다.
		aniitem 	= aniitem;
		cusitem 	= getDencode32(crypt, cusitem, "");
		paraminfo 	= getDencode32(crypt, paraminfo, "");
	}else{
		userinfo 	= getDencode32(crypt, userinfo, "");	//999까지만 허용한다.
		aniitem 	= getDencode32(crypt, aniitem, "");
		cusitem 	= getDencode32(crypt, cusitem, "");
		paraminfo 	= getDencode32(crypt, paraminfo, "");
	}
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n userinfo:" 	+ userinfo);
		DEBUG_LOG_STR.append("\r\n aniitem:" 	+ aniitem);
		DEBUG_LOG_STR.append("\r\n cusitem:" 	+ cusitem);
		DEBUG_LOG_STR.append("\r\n paraminfo:" 	+ paraminfo);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		//2. 데이타 조작
		//exec spu_GameSave 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:3;      2:12;      4:-5;       10:11;       11:101;     12:21;     13:201;   30:16;',
		//													'1:5,1,1;3:5,23,0;4:5,25,-1;',
		//													'14:1;15:1;16:1;',
		//													-1										-- 필드없음.

		query.append("{ call dbo.spu_GameSave (?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, userinfo);
		cstmt.setString(idx++, aniitem);
		cstmt.setString(idx++, cusitem);
		cstmt.setString(idx++, paraminfo);
		cstmt.registerOutParameter(idx++, Types.INTEGER);

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3. xml형태로 데이타 출력
		msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
		msg.append("<rows>\n");

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			resultMsg.append(result.getString(2));
		}
		msg.append("	<result>\n");
		msg.append("		<code>");			msg.append(PTS_SAVE); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));   	msg.append("</gamecost>\n");
		msg.append("		<feed>");			msg.append(result.getString("feed"));   		msg.append("</feed>\n");
		msg.append("		<heart>");			msg.append(result.getString("heart"));   		msg.append("</heart>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n userinfo:" 	+ userinfo);
		DEBUG_LOG_STR.append("\r\n aniitem:" 	+ aniitem);
		DEBUG_LOG_STR.append("\r\n cusitem:" 	+ cusitem);
		DEBUG_LOG_STR.append("\r\n paraminfo:" 	+ paraminfo);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
