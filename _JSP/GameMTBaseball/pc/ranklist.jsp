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
	int idx						= 1;


	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_RankList 'xxxx2', '049000s1i0n7t8445289', -1
		query.append("{ call dbo.spu_RankList (?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
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
		msg.append("		<code>");			msg.append(PTS_RANKLIST); 			msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//유저판매랭킹.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<ranksale>\n");
					msg.append("		<rank>");			msg.append(result.getString("rank"));   			msg.append("</rank>\n");
					msg.append("		<anirepitemcode>");	msg.append(result.getString("anirepitemcode"));  	msg.append("</anirepitemcode>\n");
					msg.append("		<ttsalecoin>");		msg.append(result.getString("ttsalecoin"));   		msg.append("</ttsalecoin>\n");
					msg.append("		<gameid>");			msg.append(result.getString("gameid"));   			msg.append("</gameid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));		msg.append("</kakaonickname>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   			msg.append("</famelv>\n");
					msg.append("	</ranksale>\n");
				}
			}

			//유저배틀랭킹.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<rankbattle>\n");
					msg.append("		<rank>");			msg.append(result.getString("rank"));   			msg.append("</rank>\n");
					msg.append("		<anirepitemcode>");	msg.append(result.getString("anirepitemcode"));  	msg.append("</anirepitemcode>\n");
					msg.append("		<trophy>");			msg.append(result.getString("trophy"));   			msg.append("</trophy>\n");
					msg.append("		<tier>");			msg.append(result.getString("tier"));   			msg.append("</tier>\n");
					msg.append("		<gameid>");			msg.append(result.getString("gameid"));   			msg.append("</gameid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));		msg.append("</kakaonickname>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   			msg.append("</famelv>\n");
					msg.append("	</rankbattle>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		System.out.println(DEBUG_LOG_STR.toString());
	}
    /**/


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
