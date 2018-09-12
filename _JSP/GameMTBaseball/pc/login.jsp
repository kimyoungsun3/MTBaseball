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
	String version 		= util.getParamStr(request, "version", "100");
	String connectip	= util.getParamStr(request, "connectip", "1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n version=" 	+ version);
		DEBUG_LOG_STR.append("\r\n connectip=" 	+ connectip);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_Login 'mtxxxx3', '049000s1i0n7t8445289', 100, '192.168.0.8', -1	-- 정상유저
		query.append("{ call dbo.spu_Login (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, version);
		cstmt.setString(idx++, connectip);
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
					msg.append("		<curdate>");		msg.append(result.getString("curdate"));		msg.append("</curdate>\n");
					msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
					msg.append("		<sid>");			msg.append(result.getString("sid"));			msg.append("</sid>\n");
					msg.append("		<level>");			msg.append(result.getString("level"));			msg.append("</level>\n");
					msg.append("		<exp>");			msg.append(result.getString("exp"));			msg.append("</exp>\n");
					msg.append("		<commission>");		msg.append(result.getString("commission"));		msg.append("</commission>\n");
					msg.append("		<tutorial>");		msg.append(result.getString("tutorial"));		msg.append("</tutorial>\n");
					
					//개인정보.
					msg.append("		<username>");		msg.append(result.getString("username"));		msg.append("</username>\n");
					msg.append("		<birthday>");		msg.append(result.getString("birthday"));		msg.append("</birthday>\n");
					msg.append("		<email>");			msg.append(result.getString("email"));			msg.append("</email>\n");
					msg.append("		<nickname>");		msg.append(result.getString("nickname"));		msg.append("</nickname>\n");
					msg.append("		<phone>");			msg.append(result.getString("phone"));			msg.append("</phone>\n");

					//(게임변수 : 착용아이템 인덱스리스트)
					msg.append("		<helmetlistidx>");	msg.append(result.getString("helmetlistidx"));	msg.append("</helmetlistidx>\n");
					msg.append("		<shirtlistidx>");	msg.append(result.getString("shirtlistidx"));	msg.append("</shirtlistidx>\n");
					msg.append("		<pantslistidx>");	msg.append(result.getString("pantslistidx"));	msg.append("</pantslistidx>\n");
					msg.append("		<gloveslistidx>");	msg.append(result.getString("gloveslistidx"));	msg.append("</gloveslistidx>\n");
					msg.append("		<shoeslistidx>");	msg.append(result.getString("shoeslistidx"));	msg.append("</shoeslistidx>\n");
					msg.append("		<batlistidx>");		msg.append(result.getString("batlistidx"));		msg.append("</batlistidx>\n");
					msg.append("		<balllistidx>");	msg.append(result.getString("balllistidx"));	msg.append("</balllistidx>\n");
					msg.append("		<gogglelistidx>");	msg.append(result.getString("gogglelistidx"));	msg.append("</gogglelistidx>\n");
					msg.append("		<wristbandlistidx>");msg.append(result.getString("wristbandlistidx"));msg.append("</wristbandlistidx>\n");
					msg.append("		<elbowpadlistidx>");msg.append(result.getString("elbowpadlistidx"));msg.append("</elbowpadlistidx>\n");
					msg.append("		<beltlistidx>");	msg.append(result.getString("beltlistidx"));	msg.append("</beltlistidx>\n");
					msg.append("		<kneepadlistidx>");	msg.append(result.getString("kneepadlistidx"));	msg.append("</kneepadlistidx>\n");
					msg.append("		<sockslistidx>");	msg.append(result.getString("sockslistidx"));	msg.append("</sockslistidx>\n");

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
			
			//2-3-2. 공지사항 받기(1개)
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<notice>\n");
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
	
					msg.append("		<comment>");		msg.append((result.getString("comment")));   				msg.append("</comment>\n");
					msg.append("		<patchurl>");		msg.append((result.getString("patchurl")));   				msg.append("</patchurl>\n");
					msg.append("	</notice>\n");
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
		DEBUG_LOG_STR.append("\r\n connectip=" 	+ connectip);
		DEBUG_LOG_STR.append("\r\n version=" 	+ version);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
