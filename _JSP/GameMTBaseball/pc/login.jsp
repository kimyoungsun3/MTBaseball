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
	int idx						= 1;

	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	String market		= util.getParamStr(request, "market", "1");
	String version 		= util.getParamStr(request, "version", "100");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n market=" 	+ market);
		DEBUG_LOG_STR.append("\r\n version=" 	+ version);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 1, 101, '', '', -1			-- 정상유저
		query.append("{ call dbo.spu_Login (?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, market);
		cstmt.setString(idx++, version);
		cstmt.registerOutParameter(idx++, Types.INTEGER);

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
		msg.append("		<code>");			msg.append(PTS_LOGIN); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-2. 유저 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<userinfo>\n");

					//유저기본정보
					msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
					msg.append("		<tutorial>");		msg.append(result.getString("tutorial"));   	msg.append("</tutorial>\n");
					msg.append("		<tutostep>");		msg.append(result.getString("tutostep"));   	msg.append("</tutostep>\n");
					msg.append("		<sid>");			msg.append(result.getString("sid"));			msg.append("</sid>\n");

					//게임정보(소모)
					msg.append("		<bulletlistidx>");	msg.append(result.getString("bulletlistidx"));  msg.append("</bulletlistidx>\n");
					msg.append("		<vaccinelistidx>");	msg.append(result.getString("vaccinelistidx")); msg.append("</vaccinelistidx>\n");
					msg.append("		<boosterlistidx>");	msg.append(result.getString("boosterlistidx")); msg.append("</boosterlistidx>\n");
					msg.append("		<albalistidx>");	msg.append(result.getString("albalistidx"));   	msg.append("</albalistidx>\n");


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

					msg.append("	</userinfo>\n");
				}
			}

			//2-3-3. 유저 보유 아이템 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<itemowner>\n");
					msg.append("		<listidx>");		msg.append(result.getString("listidx"));   		msg.append("</listidx>\n");
					msg.append("		<invenkind>");		msg.append(result.getString("invenkind"));   	msg.append("</invenkind>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));   			msg.append("</cnt>\n");
					msg.append("		<randserial>");		msg.append(result.getString("randserial"));   	msg.append("</randserial>\n");
					msg.append("	</itemowner>\n");
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
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n market=" 	+ market);
		DEBUG_LOG_STR.append("\r\n version=" 	+ version);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
