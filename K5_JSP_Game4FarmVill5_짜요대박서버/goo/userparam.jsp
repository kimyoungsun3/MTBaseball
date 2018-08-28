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
	String mode				= util.getParamStr(request, "mode", "1");
	String listset			= util.getParamStr(request, "listset", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n mode:" + mode);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_UserParam 'xxxx2', '049000s1i0n7t8445289', 1, '0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;', -1	-- 저장.
		//exec spu_UserParam 'xxxx2', '049000s1i0n7t8445289', 2, '', -1											-- 읽기.
		query.append("{ call dbo.spu_UserParam (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, mode);
		cstmt.setString(idxColumn++, listset);
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
		msg.append("		<code>");			msg.append(PTS_USERPARAM); 			msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    			msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());	msg.append("</resultmsg>\n");
		msg.append("		<param0>");			msg.append(result.getInt("param0"));msg.append("</param0>\n");
		msg.append("		<param1>");			msg.append(result.getInt("param1"));msg.append("</param1>\n");
		msg.append("		<param2>");			msg.append(result.getInt("param2"));msg.append("</param2>\n");
		msg.append("		<param3>");			msg.append(result.getInt("param3"));msg.append("</param3>\n");
		msg.append("		<param4>");			msg.append(result.getInt("param4"));msg.append("</param4>\n");
		msg.append("		<param5>");			msg.append(result.getInt("param5"));msg.append("</param5>\n");
		msg.append("		<param6>");			msg.append(result.getInt("param6"));msg.append("</param6>\n");
		msg.append("		<param7>");			msg.append(result.getInt("param7"));msg.append("</param7>\n");
		msg.append("		<param8>");			msg.append(result.getInt("param8"));msg.append("</param8>\n");
		msg.append("		<param9>");			msg.append(result.getInt("param9"));msg.append("</param9>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n mode:" + mode);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
