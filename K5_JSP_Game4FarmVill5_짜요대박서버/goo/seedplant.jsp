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
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	String seedidx 		= util.getParamStr(request, "seedidx", "-1");
	String seeditemcode = util.getParamStr(request, "seeditemcode", "-1");
	String feeduse	 	= util.getParamStr(request, "feeduse", "0");


	//out.print("gameid:" + gameid
	//			+ " password:" + password
	//			+ " fieldidx:" + seedidx
	//			+ " seeditemcode:" + seeditemcode
	//			+ " feeduse:" + feeduse);
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 		+ password);
		DEBUG_LOG_STR.append("\r\n seedidx:" 		+ seedidx);
		DEBUG_LOG_STR.append("\r\n seeditemcode:" 	+ seeditemcode);
		DEBUG_LOG_STR.append("\r\n feeduse:" 		+ feeduse);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		//2. 데이타 조작
		//exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 600, -1	-- 건초 > 직접.
		query.append("{ call dbo.spu_SeedPlant (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, seedidx);
		cstmt.setString(idxColumn++, seeditemcode);
		cstmt.setString(idxColumn++, feeduse);
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
		msg.append("		<code>");			msg.append(PTC_SEEDPLANT); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    					msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());  msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    	msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    	msg.append("</gamecost>\n");
		msg.append("		<feed>");			msg.append(result.getInt("feed"));    		msg.append("</feed>\n");
		msg.append("		<heart>");			msg.append(result.getInt("heart"));    		msg.append("</heart>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-3. 유저 경작지.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<seedfield>\n");
					msg.append("		<seedidx>");		msg.append(result.getString("seedidx"));   							msg.append("</seedidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   						msg.append("</itemcode>\n");
					msg.append("		<seedstartdate>");	msg.append(result.getString("seedstartdate").substring(0, 19));  	msg.append("</seedstartdate>\n");
					msg.append("		<seedenddate>");	msg.append(result.getString("seedenddate").substring(0, 19));  		msg.append("</seedenddate>\n");
					msg.append("	</seedfield>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 		+ password);
		DEBUG_LOG_STR.append("\r\n seedidx:" 		+ seedidx);
		DEBUG_LOG_STR.append("\r\n seeditemcode:" 	+ seeditemcode);
		DEBUG_LOG_STR.append("\r\n feeduse:" 		+ feeduse);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
