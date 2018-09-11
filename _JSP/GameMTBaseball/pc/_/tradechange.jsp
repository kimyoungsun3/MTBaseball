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
	String tradeinfo		= util.getParamStr(request, "tradeinfo", "");

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n tradeinfo:" + tradeinfo);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		//2. 데이타 조작
		//exec spu_TradeChange 'xxxx2', '049000s1i0n7t8445289', '0:0;1:1;2:2;3:3;4:4;5:5;6:6;', -1		-- 기본
		query.append("{ call dbo.spu_TradeChange (?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, tradeinfo);
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
		msg.append("		<code>");			msg.append(PTS_TRADECHANGE); 			msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());		msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-5. 랭킹.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<tradeinfo>\n");
					msg.append("		<trade0>");	msg.append(result.getString("trade0"));   	msg.append("</trade0>\n");
					msg.append("		<trade1>");	msg.append(result.getString("trade1"));   	msg.append("</trade1>\n");
					msg.append("		<trade2>");	msg.append(result.getString("trade2"));   	msg.append("</trade2>\n");
					msg.append("		<trade3>");	msg.append(result.getString("trade3"));   	msg.append("</trade3>\n");
					msg.append("		<trade4>");	msg.append(result.getString("trade4"));   	msg.append("</trade4>\n");
					msg.append("		<trade5>");	msg.append(result.getString("trade5"));   	msg.append("</trade5>\n");
					msg.append("		<trade6>");	msg.append(result.getString("trade6"));   	msg.append("</trade6>\n");
					msg.append("	</tradeinfo>\n");
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
		DEBUG_LOG_STR.append("\r\n tradeinfo:" + tradeinfo);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>