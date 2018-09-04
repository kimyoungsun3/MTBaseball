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
	String comreward 	= util.getParamStr(request, "comreward", "-1");
	String paraminfo 	= util.getParamStr(request, "paraminfo", "");
	String ispass	 	= util.getParamStr(request, "ispass", "-1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n comreward:" 	+ comreward);
		DEBUG_LOG_STR.append("\r\n paraminfo:" 	+ paraminfo);
		DEBUG_LOG_STR.append("\r\n ispass:" 	+ ispass);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;', -1, -1	-- 코인 > 다음퀘로 자동진행(완료).
		//exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;',  1, -1	-- 코인 > 다음퀘로 자동진행(패스).
		query.append("{ call dbo.spu_ComReward (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, comreward);
		cstmt.setString(idxColumn++, paraminfo);
		cstmt.setString(idxColumn++, ispass);
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
		msg.append("		<code>");			msg.append(PTS_COMPETITION); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-2. 유저 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<userinfo>\n");
					msg.append("		<rewardkind>");		msg.append(result.getString("rewardkind"));   	msg.append("</rewardkind>\n");
					msg.append("		<rewardvalue>");	msg.append(result.getString("rewardvalue"));   	msg.append("</rewardvalue>\n");

					msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));   	msg.append("</cashcost>\n");
					msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));   	msg.append("</gamecost>\n");
					msg.append("		<heart>");			msg.append(result.getString("heart"));   		msg.append("</heart>\n");
					msg.append("		<feed>");			msg.append(result.getString("feed"));   		msg.append("</feed>\n");
					msg.append("		<fpoint>");			msg.append(result.getString("fpoint"));   		msg.append("</fpoint>\n");
					msg.append("		<comreward>");		msg.append(result.getString("comreward"));   	msg.append("</comreward>\n");

					//클라이언트정보저장.
					msg.append("		<param0>");			msg.append(result.getString("param0"));   		msg.append("</param0>\n");
					msg.append("		<param1>");			msg.append(result.getString("param1"));   		msg.append("</param1>\n");
					msg.append("		<param2>");			msg.append(result.getString("param2"));   		msg.append("</param2>\n");
					msg.append("		<param3>");			msg.append(result.getString("param3"));   		msg.append("</param3>\n");
					msg.append("		<param4>");			msg.append(result.getString("param4"));   		msg.append("</param4>\n");
					msg.append("		<param5>");			msg.append(result.getString("param5"));   		msg.append("</param5>\n");
					msg.append("		<param6>");			msg.append(result.getString("param6"));   		msg.append("</param6>\n");
					msg.append("		<param7>");			msg.append(result.getString("param7"));   		msg.append("</param7>\n");
					msg.append("		<param8>");			msg.append(result.getString("param8"));   		msg.append("</param8>\n");
					msg.append("		<param9>");			msg.append(result.getString("param9"));   		msg.append("</param9>\n");

					//경쟁모드.
					msg.append("		<bktwolfkillcnt>");	msg.append(result.getString("bktwolfkillcnt")); msg.append("</bktwolfkillcnt>\n");
					msg.append("		<bktsalecoin>");	msg.append(result.getString("bktsalecoin"));   	msg.append("</bktsalecoin>\n");
					msg.append("		<bkheart>");		msg.append(result.getString("bkheart"));   		msg.append("</bkheart>\n");
					msg.append("		<bkfeed>");			msg.append(result.getString("bkfeed"));   		msg.append("</bkfeed>\n");
					msg.append("		<bktsuccesscnt>");	msg.append(result.getString("bktsuccesscnt"));  msg.append("</bktsuccesscnt>\n");
					msg.append("		<bktbestfresh>");	msg.append(result.getString("bktbestfresh"));   msg.append("</bktbestfresh>\n");
					msg.append("		<bktbestbarrel>");	msg.append(result.getString("bktbestbarrel"));  msg.append("</bktbestbarrel>\n");
					msg.append("		<bktbestcoin>");	msg.append(result.getString("bktbestcoin"));   	msg.append("</bktbestcoin>\n");
					msg.append("		<bkbarrel>");		msg.append(result.getString("bkbarrel"));   	msg.append("</bkbarrel>\n");
					msg.append("		<bkcrossnormal>");	msg.append(result.getString("bkcrossnormal"));  msg.append("</bkcrossnormal>\n");
					msg.append("		<bkcrosspremium>");	msg.append(result.getString("bkcrosspremium")); msg.append("</bkcrosspremium>\n");
					msg.append("		<bktsgrade1cnt>");	msg.append(result.getString("bktsgrade1cnt"));	msg.append("</bktsgrade1cnt>\n");
					msg.append("		<bktsgrade2cnt>");	msg.append(result.getString("bktsgrade2cnt"));	msg.append("</bktsgrade2cnt>\n");
					msg.append("		<bktsupcnt>");		msg.append(result.getString("bktsupcnt"));		msg.append("</bktsupcnt>\n");
					msg.append("		<bkbattlecnt>");	msg.append(result.getString("bkbattlecnt"));	msg.append("</bkbattlecnt>\n");
					msg.append("		<bkaniupcnt>");		msg.append(result.getString("bkaniupcnt")); 	msg.append("</bkaniupcnt>\n");
					msg.append("		<bkapartani>");		msg.append(result.getString("bkapartani")); 	msg.append("</bkapartani>\n");
					msg.append("		<bkapartts>");		msg.append(result.getString("bkapartts")); 		msg.append("</bkapartts>\n");
					msg.append("		<bkcomposecnt>");	msg.append(result.getString("bkcomposecnt")); 	msg.append("</bkcomposecnt>\n");

					msg.append("	</userinfo>\n");
				}
			}

			//2-3-5. 선물정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<giftitem>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));   			msg.append("</idx>\n");
					msg.append("		<giftkind>");		msg.append(result.getString("giftkind"));   	msg.append("</giftkind>\n");
					msg.append("		<message>");		msg.append(result.getString("message"));   		msg.append("</message>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<giftdate>");		msg.append(result.getString("giftdate").substring(0, 10));   	msg.append("</giftdate>\n");
					msg.append("		<giftid>");			msg.append(result.getString("giftid"));   		msg.append("</giftid>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));   			msg.append("</cnt>\n");
					msg.append("	</giftitem>\n");
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
		DEBUG_LOG_STR.append("\r\n comreward:" 	+ comreward);
		DEBUG_LOG_STR.append("\r\n paraminfo:" 	+ paraminfo);
		DEBUG_LOG_STR.append("\r\n ispass:" 	+ ispass);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
