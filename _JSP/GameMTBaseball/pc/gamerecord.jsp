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
	String sid		 	= util.getParamStr(request, "sid", "-1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n sid:" 		+ sid);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작		
		//exec spu_GameRecord 'mtxxxx3', '049000s1i0n7t8445289', 333, -1
		query.append("{ call dbo.spu_SGRecord (?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, sid);
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
		msg.append("		<code>");			msg.append(PTS_GAMERECORD); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    			msg.append("</resultmsg>\n");		
		msg.append("		<cashcost>");		msg.append(result.getString("cashcost")); 		msg.append("</cashcost>\n");		
		msg.append("		<gamecost>");		msg.append(result.getString("gamecost")); 		msg.append("</gamecost>\n");		
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-5. 선물정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<gamerecord>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));   			msg.append("</idx>\n");
					msg.append("		<curturntime>");	msg.append(result.getString("curturntime"));   	msg.append("</curturntime>\n");
					msg.append("		<curturndate>");	msg.append(result.getString("curturndate").substring(0, 10));msg.append("</curturndate>\n");
					msg.append("		<gamemode>");		msg.append(result.getString("gamemode"));   	msg.append("</gamemode>\n");
					
					msg.append("		<select1>");		msg.append(result.getString("select1"));   		msg.append("</select1>\n");
					msg.append("		<select2>");		msg.append(result.getString("select2"));   		msg.append("</select2>\n");
					msg.append("		<select3>");		msg.append(result.getString("select3"));   		msg.append("</select3>\n");
					msg.append("		<select4>");		msg.append(result.getString("select4"));   		msg.append("</select4>\n");
					msg.append("		<rselect1>");		msg.append(result.getString("rselect1"));   	msg.append("</rselect1>\n");
					msg.append("		<rselect2>");		msg.append(result.getString("rselect2"));  	 	msg.append("</rselect2>\n");
					msg.append("		<rselect3>");		msg.append(result.getString("rselect3"));   	msg.append("</rselect3>\n");
					msg.append("		<rselect4>");		msg.append(result.getString("rselect4"));   	msg.append("</rselect4>\n");
					msg.append("		<gameresult>");		msg.append(result.getString("gameresult"));   	msg.append("</gameresult>\n");
					msg.append("	</gamerecord>\n");
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
		DEBUG_LOG_STR.append("\r\n sid:" 		+ sid);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
