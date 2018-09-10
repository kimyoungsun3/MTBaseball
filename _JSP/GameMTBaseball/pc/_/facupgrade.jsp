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
	String gameid 		= util.getParamStr(request, "gameid", "");
	String password 	= util.getParamStr(request, "password", "");
	String subcategory 	= util.getParamStr(request, "subcategory", "-1");
	String kind 		= util.getParamStr(request, "kind", "-1");

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n subcategory:" + subcategory);
		DEBUG_LOG_STR.append("\r\n kind:" 		+ kind);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_FacUpgrade 'xxxx2', '049000s1i0n7t8445289', 61, 1, -1		-- 탱크(시작).
		//exec spu_FacUpgrade 'xxxx2', '049000s1i0n7t8445289', 61, 2, -1		--
		query.append("{ call dbo.spu_FacUpgrade (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, subcategory);
		cstmt.setString(idxColumn++, kind);
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
		msg.append("		<code>");			msg.append(PTS_FACUPGRADE); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    					msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());  msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    	msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    	msg.append("</gamecost>\n");
		msg.append("		<feedmax>");		msg.append(result.getInt("feedmax"));    	msg.append("</feedmax>\n");
		msg.append("		<heartmax>");		msg.append(result.getInt("heartmax"));    	msg.append("</heartmax>\n");
		msg.append("		<fpointmax>");		msg.append(result.getInt("fpointmax"));    	msg.append("</fpointmax>\n");
		msg.append("		<housestep>");		msg.append(result.getInt("housestep"));    				msg.append("</housestep>\n");
		msg.append("		<housestate>");		msg.append(result.getInt("housestate"));    			msg.append("</housestate>\n");
		msg.append("		<housetime>");		msg.append(result.getString("housetime").substring(0, 19));msg.append("</housetime>\n");
		msg.append("		<tankstep>");		msg.append(result.getInt("tankstep"));    				msg.append("</tankstep>\n");
		msg.append("		<tankstate>");		msg.append(result.getInt("tankstate"));    				msg.append("</tankstate>\n");
		msg.append("		<tanktime>");		msg.append(result.getString("tanktime").substring(0, 19));	msg.append("</tanktime>\n");
		msg.append("		<bottlestep>");		msg.append(result.getInt("bottlestep"));    			msg.append("</bottlestep>\n");
		msg.append("		<bottlestate>");	msg.append(result.getInt("bottlestate"));    		msg.append("</bottlestate>\n");
		msg.append("		<bottletime>");		msg.append(result.getString("bottletime").substring(0, 19));msg.append("</bottletime>\n");
		msg.append("		<pumpstep>");		msg.append(result.getInt("pumpstep"));    				msg.append("</pumpstep>\n");
		msg.append("		<pumpstate>");		msg.append(result.getInt("pumpstate"));    				msg.append("</pumpstate>\n");
		msg.append("		<pumptime>");		msg.append(result.getString("pumptime").substring(0, 19));	msg.append("</pumptime>\n");
		msg.append("		<transferstep>");	msg.append(result.getInt("transferstep"));    			msg.append("</transferstep>\n");
		msg.append("		<transferstate>");	msg.append(result.getInt("transferstate"));    			msg.append("</transferstate>\n");
		msg.append("		<transfertime>");	msg.append(result.getString("transfertime").substring(0, 19));msg.append("</transfertime>\n");
		msg.append("		<purestep>");		msg.append(result.getInt("purestep"));    				msg.append("</purestep>\n");
		msg.append("		<purestate>");		msg.append(result.getInt("purestate"));    				msg.append("</purestate>\n");
		msg.append("		<puretime>");		msg.append(result.getString("puretime").substring(0, 19));	msg.append("</puretime>\n");
		msg.append("		<freshcoolstep>");	msg.append(result.getInt("freshcoolstep"));    			msg.append("</freshcoolstep>\n");
		msg.append("		<freshcoolstate>");	msg.append(result.getInt("freshcoolstate"));    		msg.append("</freshcoolstate>\n");
		msg.append("		<freshcooltime>");	msg.append(result.getString("freshcooltime").substring(0, 19));msg.append("</freshcooltime>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n subcategory:" + subcategory);
		DEBUG_LOG_STR.append("\r\n kind:" 		+ kind);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
