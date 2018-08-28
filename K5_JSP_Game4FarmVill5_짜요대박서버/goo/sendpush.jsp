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
	int idxColumn				= 1;

	//1. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "");
	String password		= util.getParamStr(request, "password", "");
	String receid		= util.getParamStr(request, "receid", "");
	String kind			= util.getParamStr(request, "kind", "1");
	String msgtitle		= util.getParamStr(request, "msgtitle", "");
	String msgmsg		= util.getParamStr(request, "msgmsg", "");
	String gmode		= util.getParamStr(request, "gmode", "5");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n receid:" 	+ receid);
		DEBUG_LOG_STR.append("\r\n kind:" 		+ kind);
		DEBUG_LOG_STR.append("\r\n msgtitle:" 	+ msgtitle);
		DEBUG_LOG_STR.append("\r\n msgmsg:" 	+ msgmsg);
		DEBUG_LOG_STR.append("\r\n gmode:" 		+ gmode);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		//2. 데이타 조작
		//exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 1, '단순제목', '단순내용', -1, -1
		//exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 2, '자랑제목', '자랑내용', 5, -1
		//exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 3, 'URL제목', 'http://m.naver.com', -1, -1
		query.append("{ call dbo.spu_UserPushMsgAndroid (?, ?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, receid);
		cstmt.setString(idxColumn++, kind);
		cstmt.setString(idxColumn++, msgtitle);
		cstmt.setString(idxColumn++, msgmsg);
		cstmt.setString(idxColumn++, gmode);
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
		msg.append("		<code>");			msg.append(PTS_PUSHMSG); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    					msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());			msg.append("</resultmsg>\n");
		msg.append("		<feed>");			msg.append(result.getInt("feed"));			msg.append("</feed>\n");
		msg.append("		<heart>");			msg.append(result.getInt("heart"));			msg.append("</heart>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n receid:" 	+ receid);
		DEBUG_LOG_STR.append("\r\n kind:" 		+ kind);
		DEBUG_LOG_STR.append("\r\n msgtitle:" 	+ msgtitle);
		DEBUG_LOG_STR.append("\r\n msgmsg:" 	+ msgmsg);
		DEBUG_LOG_STR.append("\r\n gmode:" 		+ gmode);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
