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
	int idxColumn						= 1;

	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	String sid 			= util.getParamStr(request, "sid", "-1");
	String listidx		= util.getParamStr(request, "listidx", "-1");
	String randserial	= util.getParamStr(request, "randserial", "-1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n sid=" 		+ sid);
		DEBUG_LOG_STR.append("\r\n listidx=" 	+ listidx);
		DEBUG_LOG_STR.append("\r\n randserial=" + randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  39, 7713, -1	-- 티타늄 헬멧
		query.append("{ call dbo.spu_ItemChange (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, sid);
		cstmt.setString(idxColumn++, listidx);
		cstmt.setString(idxColumn++, randserial);
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
		msg.append("		<code>");			msg.append(PTS_ITEMCHANGE); 			msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getString("cashcost")); msg.append("</cashcost>\n");		
		msg.append("		<gamecost>");		msg.append(result.getString("gamecost")); msg.append("</gamecost>\n");	
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-2. 유저 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<itemuserinfo>\n");
					
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

					//착용아이템 최종값.
					msg.append("		<wearplusexp>");	msg.append(result.getString("wearplusexp"));	msg.append("</wearplusexp>\n");
					msg.append("		<setplusexp>");		msg.append(result.getString("setplusexp"));		msg.append("</setplusexp>\n");
					
					//착용아이템 추가경험치값
					msg.append("		<helmetexp>");		msg.append(result.getString("helmetexp"));		msg.append("</helmetexp>\n");
					msg.append("		<shirtexp>");		msg.append(result.getString("shirtexp"));		msg.append("</shirtexp>\n");
					msg.append("		<pantsexp>");		msg.append(result.getString("pantsexp"));		msg.append("</pantsexp>\n");
					msg.append("		<glovesexp>");		msg.append(result.getString("glovesexp"));		msg.append("</glovesexp>\n");
					msg.append("		<shoesexp>");		msg.append(result.getString("shoesexp"));		msg.append("</shoesexp>\n");
					msg.append("		<batexp>");			msg.append(result.getString("batexp"));			msg.append("</batexp>\n");
					msg.append("		<ballexp>");		msg.append(result.getString("ballexp"));		msg.append("</ballexp>\n");
					msg.append("		<goggleexp>");		msg.append(result.getString("goggleexp"));		msg.append("</goggleexp>\n");
					msg.append("		<wristbandexp>");	msg.append(result.getString("wristbandexp"));	msg.append("</wristbandexp>\n");
					msg.append("		<elbowpadexp>");	msg.append(result.getString("elbowpadexp"));	msg.append("</elbowpadexp>\n");
					msg.append("		<beltexp>");		msg.append(result.getString("beltexp"));		msg.append("</beltexp>\n");
					msg.append("		<kneepadexp>");		msg.append(result.getString("kneepadexp"));		msg.append("</kneepadexp>\n");
					msg.append("		<socksexp>");		msg.append(result.getString("socksexp"));		msg.append("</socksexp>\n");
					
					
					//(게임변수 : 착용아이템 인덱스리스트)
					msg.append("		<helmetsetnum>");	msg.append(result.getString("helmetsetnum"));	msg.append("</helmetsetnum>\n");
					msg.append("		<shirtsetnum>");	msg.append(result.getString("shirtsetnum"));	msg.append("</shirtsetnum>\n");
					msg.append("		<pantssetnum>");	msg.append(result.getString("pantssetnum"));	msg.append("</pantssetnum>\n");
					msg.append("		<glovessetnum>");	msg.append(result.getString("glovessetnum"));	msg.append("</glovessetnum>\n");
					msg.append("		<shoessetnum>");	msg.append(result.getString("shoessetnum"));	msg.append("</shoessetnum>\n");
					msg.append("		<batsetnum>");		msg.append(result.getString("batsetnum"));		msg.append("</batsetnum>\n");
					msg.append("		<ballsetnum>");		msg.append(result.getString("ballsetnum"));	msg.append("</ballsetnum>\n");
					msg.append("		<gogglesetnum>");	msg.append(result.getString("gogglesetnum"));	msg.append("</gogglesetnum>\n");
					msg.append("		<wristbandsetnum>");msg.append(result.getString("wristbandsetnum"));msg.append("</wristbandsetnum>\n");
					msg.append("		<elbowpadsetnum>");	msg.append(result.getString("elbowpadsetnum"));msg.append("</elbowpadsetnum>\n");
					msg.append("		<beltsetnum>");		msg.append(result.getString("beltsetnum"));	msg.append("</beltsetnum>\n");
					msg.append("		<kneepadsetnum>");	msg.append(result.getString("kneepadsetnum"));	msg.append("</kneepadsetnum>\n");
					msg.append("		<sockssetnum>");	msg.append(result.getString("sockssetnum"));	msg.append("</sockssetnum>\n");

					msg.append("	</itemuserinfo>\n");
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
		DEBUG_LOG_STR.append("\r\n sid=" 		+ sid);
		DEBUG_LOG_STR.append("\r\n listidx=" 	+ listidx);
		DEBUG_LOG_STR.append("\r\n randserial=" + randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
