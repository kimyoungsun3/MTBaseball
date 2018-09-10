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
	String seedidx 		= util.getParamStr(request, "seedidx", "0");
	String mode 		= util.getParamStr(request, "mode", "1");
	String feeduse	 	= util.getParamStr(request, "feeduse", "0");

	//out.print("gameid:" + gameid
	//			+ " password:" + password
	//			+ " fieldidx:" + seedidx
	//			+ " mode:" + mode
	//			+ " feeduse:" + feeduse);
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n seedidx:" 	+ seedidx);
		DEBUG_LOG_STR.append("\r\n mode:" 		+ mode);
		DEBUG_LOG_STR.append("\r\n feeduse:" 	+ feeduse);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		//2. 데이타 조작
		//exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 1, -1	-- 건초 > 직접.
		//exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, -1	-- 건초 > 직접.
		query.append("{ call dbo.spu_SeedHarvest (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, seedidx);
		cstmt.setString(idxColumn++, mode);
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
		msg.append("		<code>");			msg.append(PTS_SEEDHARVEST); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    					msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());  msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    	msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    	msg.append("</gamecost>\n");
		msg.append("		<feed>");			msg.append(result.getInt("feed"));    		msg.append("</feed>\n");
		msg.append("		<heart>");			msg.append(result.getInt("heart"));    		msg.append("</heart>\n");
		msg.append("		<bresult>");		msg.append(result.getInt("bresult"));    	msg.append("</bresult>\n");

		//짜요쿠폰룰렛.
		msg.append("		<zcpchance>");		msg.append(result.getString("zcpchance"));	msg.append("</zcpchance>\n");
		msg.append("	</result>\n");

	    //.
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
		DEBUG_LOG_STR.append("\r\n seedidx:" 	+ seedidx);
		DEBUG_LOG_STR.append("\r\n mode:" 		+ mode);
		DEBUG_LOG_STR.append("\r\n feeduse:" 	+ feeduse);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
