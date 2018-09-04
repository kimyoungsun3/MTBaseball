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
	int idxColumn						= 1;

	int market 					= util.getParamInt(request, "market", 1);
	int buytype 				= util.getParamInt(request, "buytype", 0);
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n market:" + market);
		DEBUG_LOG_STR.append("\r\n buytype:" + buytype);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_Notice 1, 0, -1
		query.append("{ call dbo.spu_Notice (?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, market);
		cstmt.setInt(idxColumn++, buytype);
		cstmt.registerOutParameter(idxColumn++, Types.INTEGER);

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
		msg.append("		<code>");			msg.append(PTS_NOTICE); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-2. 공지사항 받기(1개)
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<notice>\n");
					msg.append("		<version>");		msg.append((result.getString("version")));   				msg.append("</version>\n");
					msg.append("		<syscheck>");		msg.append((result.getString("syscheck")));   				msg.append("</syscheck>\n");

					msg.append("		<comfile>");		msg.append((result.getString("comfile")));   				msg.append("</comfile>\n");
					msg.append("		<comurl>");			msg.append((result.getString("comurl")));   				msg.append("</comurl>\n");
					msg.append("		<comfile2>");		msg.append((result.getString("comfile2")));   				msg.append("</comfile2>\n");
					msg.append("		<comurl2>");		msg.append((result.getString("comurl2")));   				msg.append("</comurl2>\n");
					msg.append("		<comfile3>");		msg.append((result.getString("comfile3")));   				msg.append("</comfile3>\n");
					msg.append("		<comurl3>");		msg.append((result.getString("comurl3")));   				msg.append("</comurl3>\n");
					msg.append("		<comfile4>");		msg.append((result.getString("comfile4")));   				msg.append("</comfile4>\n");
					msg.append("		<comurl4>");		msg.append((result.getString("comurl4")));   				msg.append("</comurl4>\n");
					msg.append("		<comfile5>");		msg.append((result.getString("comfile5")));   				msg.append("</comfile5>\n");
					msg.append("		<comurl5>");		msg.append((result.getString("comurl5")));   				msg.append("</comurl5>\n");

					msg.append("		<patchurl>");		msg.append((result.getString("patchurl")));   				msg.append("</patchurl>\n");
					msg.append("		<recurl>");			msg.append((result.getString("recurl")));   				msg.append("</recurl>\n");
					msg.append("		<smsurl>");			msg.append((result.getString("smsurl")));   				msg.append("</smsurl>\n");
					msg.append("		<smscom>");			msg.append((result.getString("smscom")));   				msg.append("</smscom>\n");
					msg.append("		<communityurl>");	msg.append((result.getString("communityurl")));   			msg.append("</communityurl>\n");
					msg.append("		<serviceurl>");		msg.append((result.getString("serviceurl")));   			msg.append("</serviceurl>\n");

					msg.append("		<comment>");		msg.append((result.getString("comment")));   				msg.append("</comment>\n");

					msg.append("		<iteminfover>");	msg.append((result.getString("iteminfover")));   			msg.append("</iteminfover>\n");
					msg.append("		<iteminfourl>");	msg.append((result.getString("iteminfourl")));   			msg.append("</iteminfourl>\n");

					msg.append("		<currentDate>");	msg.append(result.getString("currentDate")); 				msg.append("</currentDate>\n");
					msg.append("	</notice>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n market:" + market);
		DEBUG_LOG_STR.append("\r\n buytype:" + buytype);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
