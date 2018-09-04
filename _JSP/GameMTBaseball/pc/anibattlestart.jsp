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
	String farmidx			= util.getParamStr(request, "farmidx", "6900");
	String listset			= util.getParamStr(request, "listset", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &farmidx:" 		+ farmidx);
		DEBUG_LOG_STR.append("\r\n &listset:" 		+ listset);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_AniBattleStart 'xxxx2', '049000s1i0n7t8445289', 6900, '0:2;1:39;1:38;', -1
		query.append("{ call dbo.spu_AniBattleStart (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, farmidx);
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
		msg.append("		<code>");			msg.append(PTS_ANIBATTLESTART); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());				msg.append("</resultmsg>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    		msg.append("</gamecost>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    		msg.append("</cashcost>\n");
		msg.append("		<heart>");			msg.append(result.getInt("heart"));    			msg.append("</heart>\n");
		msg.append("		<feed>");			msg.append(result.getInt("feed"));    			msg.append("</feed>\n");
		msg.append("		<fpoint>");			msg.append(result.getInt("fpoint"));    		msg.append("</fpoint>\n");
		msg.append("		<goldticket>");		msg.append(result.getInt("goldticket"));    	msg.append("</goldticket>\n");
		msg.append("		<goldticketmax>");	msg.append(result.getInt("goldticketmax"));    	msg.append("</goldticketmax>\n");
		msg.append("		<goldtickettime>");	msg.append(result.getString("goldtickettime").substring(0, 19));msg.append("</goldtickettime>\n");
		msg.append("		<battleticket>");	msg.append(result.getInt("battleticket"));    	msg.append("</battleticket>\n");
		msg.append("		<battleticketmax>");msg.append(result.getInt("battleticketmax"));   msg.append("</battleticketmax>\n");
		msg.append("		<battletickettime>");msg.append(result.getString("battletickettime").substring(0, 19));msg.append("</battletickettime>\n");
		msg.append("		<battleidx2>");		msg.append(result.getInt("battleidx2"));    	msg.append("</battleidx2>\n");

		msg.append("		<enemylv>");		msg.append(result.getInt("enemylv"));    		msg.append("</enemylv>\n");
		msg.append("		<enemycnt>");		msg.append(result.getInt("enemycnt"));    		msg.append("</enemycnt>\n");
		msg.append("		<stagecnt>");		msg.append(result.getInt("stagecnt"));    		msg.append("</stagecnt>\n");
		msg.append("		<enemyani>");		msg.append(result.getInt("enemyani"));    		msg.append("</enemyani>\n");
		msg.append("		<enemyboss>");		msg.append(result.getInt("enemyboss"));    		msg.append("</enemyboss>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &farmidx:" 		+ farmidx);
		DEBUG_LOG_STR.append("\r\n &listset:" 		+ listset);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
