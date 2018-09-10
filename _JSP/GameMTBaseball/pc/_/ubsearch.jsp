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
	String listset			= util.getParamStr(request, "listset", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &listset:" 		+ listset);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_UserBattleStart 'xxxx2', '049000s1i0n7t8445289', '0:14;', 				-1
		query.append("{ call dbo.spu_UserBattleStart (?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
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
		msg.append("		<code>");			msg.append(PTS_UBSEARCH); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());				msg.append("</resultmsg>\n");
		msg.append("		<userbattleidx2>");	msg.append(result.getInt("userbattleidx2"));    msg.append("</userbattleidx2>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//동물.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<rivaluser>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
					msg.append("		<trophy>");			msg.append(result.getString("trophy"));   		msg.append("</trophy>\n");
					msg.append("		<tier>");			msg.append(result.getString("tier"));   		msg.append("</tier>\n");

					msg.append("		<aniitemcode1>");	msg.append(result.getString("aniitemcode1"));   msg.append("</aniitemcode1>\n");
					msg.append("		<upcnt1>");			msg.append(result.getString("upcnt1"));   		msg.append("</upcnt1>\n");
					msg.append("		<attstem1>");		msg.append(result.getString("attstem1"));   	msg.append("</attstem1>\n");
					msg.append("		<defstem1>");		msg.append(result.getString("defstem1"));   	msg.append("</defstem1>\n");
					msg.append("		<hpstem1>");		msg.append(result.getString("hpstem1"));   		msg.append("</hpstem1>\n");
					msg.append("		<timestem1>");		msg.append(result.getString("timestem1"));   	msg.append("</timestem1>\n");

					msg.append("		<aniitemcode2>");	msg.append(result.getString("aniitemcode2"));   msg.append("</aniitemcode2>\n");
					msg.append("		<upcnt2>");			msg.append(result.getString("upcnt2"));   		msg.append("</upcnt2>\n");
					msg.append("		<attstem2>");		msg.append(result.getString("attstem2"));   	msg.append("</attstem2>\n");
					msg.append("		<defstem2>");		msg.append(result.getString("defstem2"));   	msg.append("</defstem2>\n");
					msg.append("		<hpstem2>");		msg.append(result.getString("hpstem2"));   		msg.append("</hpstem2>\n");
					msg.append("		<timestem2>");		msg.append(result.getString("timestem2"));   	msg.append("</timestem2>\n");

					msg.append("		<aniitemcode3>");	msg.append(result.getString("aniitemcode3"));   msg.append("</aniitemcode3>\n");
					msg.append("		<upcnt3>");			msg.append(result.getString("upcnt3"));   		msg.append("</upcnt3>\n");
					msg.append("		<attstem3>");		msg.append(result.getString("attstem3"));   	msg.append("</attstem3>\n");
					msg.append("		<defstem3>");		msg.append(result.getString("defstem3"));   	msg.append("</defstem3>\n");
					msg.append("		<hpstem3>");		msg.append(result.getString("hpstem3"));   		msg.append("</hpstem3>\n");
					msg.append("		<timestem3>");		msg.append(result.getString("timestem3"));   	msg.append("</timestem3>\n");

					msg.append("		<treasure1>");		msg.append(result.getString("treasure1"));  	msg.append("</treasure1>\n");
					msg.append("		<treasure2>");		msg.append(result.getString("treasure2"));  	msg.append("</treasure2>\n");
					msg.append("		<treasure3>");		msg.append(result.getString("treasure3"));  	msg.append("</treasure3>\n");
					msg.append("		<treasure4>");		msg.append(result.getString("treasure4"));  	msg.append("</treasure4>\n");
					msg.append("		<treasure5>");		msg.append(result.getString("treasure5"));  	msg.append("</treasure5>\n");

					msg.append("		<treasureupgrade1>");msg.append(result.getString("treasureupgrade1"));msg.append("</treasureupgrade1>\n");
					msg.append("		<treasureupgrade2>");msg.append(result.getString("treasureupgrade2"));msg.append("</treasureupgrade2>\n");
					msg.append("		<treasureupgrade3>");msg.append(result.getString("treasureupgrade3"));msg.append("</treasureupgrade3>\n");
					msg.append("		<treasureupgrade4>");msg.append(result.getString("treasureupgrade4"));msg.append("</treasureupgrade4>\n");
					msg.append("		<treasureupgrade5>");msg.append(result.getString("treasureupgrade5"));msg.append("</treasureupgrade5>\n");
					msg.append("	</rivaluser>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &listset:" 		+ listset);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
