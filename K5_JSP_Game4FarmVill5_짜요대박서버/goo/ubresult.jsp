<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;


	//1. 데이타 받기
	String gameid 			= util.getParamStr(request, "gameid", "");
	String password			= util.getParamStr(request, "password", "");
	String userbattleidx2	= util.getParamStr(request, "userbattleidx2", "-1");
	String gresult			= util.getParamStr(request, "result", "0");
	String playtime			= util.getParamStr(request, "playtime", "0");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &userbattleidx2="+ userbattleidx2);
		DEBUG_LOG_STR.append("\r\n &gresult="		+ gresult);
		DEBUG_LOG_STR.append("\r\n &playtime="		+ playtime);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_UserBattleResult 'xxxx2', '049000s1i0n7t8445289', 123,  1, 90, -1
		//exec spu_UserBattleResult 'xxxx2', '049000s1i0n7t8445289', 123,  -1, 90, -1
		query.append("{ call dbo.spu_UserBattleResult (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, userbattleidx2);
		cstmt.setString(idxColumn++, gresult);
		cstmt.setString(idxColumn++, playtime);
		cstmt.registerOutParameter(idxColumn++, Types.INTEGER);

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			resultMsg.append(result.getString(2));
		}

		msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
		msg.append("<rows>\n");
		msg.append("	<result>\n");
		msg.append("		<code>");			msg.append(PTS_UBRESULT); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());				msg.append("</resultmsg>\n");

		msg.append("		<trophy>");			msg.append(result.getInt("trophy"));    		msg.append("</trophy>\n");
		msg.append("		<tier>");			msg.append(result.getInt("tier"));    			msg.append("</tier>\n");
		msg.append("		<gettrophy>");		msg.append(result.getInt("gettrophy"));    		msg.append("</gettrophy>\n");

		msg.append("		<rewardbox>");		msg.append(result.getInt("rewardbox"));    		msg.append("</rewardbox>\n");
		msg.append("		<boxslot1>");		msg.append(result.getInt("boxslot1"));    		msg.append("</boxslot1>\n");
		msg.append("		<boxslot2>");		msg.append(result.getInt("boxslot2"));    		msg.append("</boxslot2>\n");
		msg.append("		<boxslot3>");		msg.append(result.getInt("boxslot3"));    		msg.append("</boxslot3>\n");
		msg.append("		<boxslot4>");		msg.append(result.getInt("boxslot4"));    		msg.append("</boxslot4>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &userbattleidx2="+ userbattleidx2);
		DEBUG_LOG_STR.append("\r\n &gresult="		+ gresult);
		DEBUG_LOG_STR.append("\r\n &playtime="		+ playtime);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
