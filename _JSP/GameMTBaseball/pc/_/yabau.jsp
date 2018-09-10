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
	String mode			= util.getParamStr(request, "mode", "2");
	String randserial 	= util.getParamStr(request, "randserial", "-1");

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n mode=" 		+ mode);
		DEBUG_LOG_STR.append("\r\n randserial=" + randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_RoulYabau 'xxxx2', '049000s1i0n7t8445289', 1,     -1, -1	-- 리스트 갱신
		query.append("{ call dbo.spu_RoulYabau (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, mode);
		cstmt.setString(idxColumn++, randserial);
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
		msg.append("		<code>");			msg.append(PTS_YABAUREWARD); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");

		msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));   	msg.append("</gamecost>\n");

		//야바위 정보.
		msg.append("		<yabauidx>");		msg.append(result.getString("yabauidx"));   msg.append("</yabauidx>\n");
		msg.append("		<yabaustep>");		msg.append(result.getString("yabaustep"));  msg.append("</yabaustep>\n");
		msg.append("		<yabaunum>");		msg.append(result.getString("yabaunum"));	msg.append("</yabaunum>\n");
		msg.append("		<yabauresult>");	msg.append(result.getString("yabauresult"));msg.append("</yabauresult>\n");
		msg.append("		<yabauchange>");	msg.append(result.getString("yabauchange"));msg.append("</yabauchange>\n");
		msg.append("	</result>\n");

	    if(resultCode == 1){
			//야바위.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<sysyabau>\n");
					msg.append("		<idx>");				msg.append(result.getString("idx"));  			msg.append("</idx>\n");
					msg.append("		<packname>");			msg.append(result.getString("packname"));  		msg.append("</packname>\n");
					msg.append("		<saleper>");			msg.append(result.getString("saleper")); 		msg.append("</saleper>\n");
					msg.append("		<pack11>");				msg.append(result.getString("pack11"));  		msg.append("</pack11>\n");
					msg.append("		<pack12>");				msg.append(result.getString("pack12"));  		msg.append("</pack12>\n");
					msg.append("		<pack13>");				msg.append(result.getString("pack13"));  		msg.append("</pack13>\n");
					msg.append("		<pack14>");				msg.append(result.getString("pack14"));  		msg.append("</pack14>\n");
					msg.append("		<pack21>");				msg.append(result.getString("pack21"));  		msg.append("</pack21>\n");
					msg.append("		<pack22>");				msg.append(result.getString("pack22"));  		msg.append("</pack22>\n");
					msg.append("		<pack23>");				msg.append(result.getString("pack23"));  		msg.append("</pack23>\n");
					msg.append("		<pack24>");				msg.append(result.getString("pack24"));  		msg.append("</pack24>\n");
					msg.append("		<pack31>");				msg.append(result.getString("pack31"));  		msg.append("</pack31>\n");
					msg.append("		<pack32>");				msg.append(result.getString("pack32"));  		msg.append("</pack32>\n");
					msg.append("		<pack33>");				msg.append(result.getString("pack33"));  		msg.append("</pack33>\n");
					msg.append("		<pack34>");				msg.append(result.getString("pack34"));  		msg.append("</pack34>\n");
					msg.append("		<pack41>");				msg.append(result.getString("pack41"));  		msg.append("</pack41>\n");
					msg.append("		<pack42>");				msg.append(result.getString("pack42"));  		msg.append("</pack42>\n");
					msg.append("		<pack43>");				msg.append(result.getString("pack43"));  		msg.append("</pack43>\n");
					msg.append("		<pack44>");				msg.append(result.getString("pack44"));  		msg.append("</pack44>\n");
					msg.append("		<pack51>");				msg.append(result.getString("pack51"));  		msg.append("</pack51>\n");
					msg.append("		<pack52>");				msg.append(result.getString("pack52"));  		msg.append("</pack52>\n");
					msg.append("		<pack53>");				msg.append(result.getString("pack53"));  		msg.append("</pack53>\n");
					msg.append("		<pack54>");				msg.append(result.getString("pack54"));  		msg.append("</pack54>\n");
					msg.append("		<pack61>");				msg.append(result.getString("pack61"));  		msg.append("</pack61>\n");
					msg.append("		<pack62>");				msg.append(result.getString("pack62"));  		msg.append("</pack62>\n");
					msg.append("		<pack63>");				msg.append(result.getString("pack63"));  		msg.append("</pack63>\n");
					msg.append("		<pack64>");				msg.append(result.getString("pack64"));  		msg.append("</pack64>\n");
					msg.append("	</sysyabau>\n");
				}
			}

			//선물정보
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
		DEBUG_LOG_STR.append("\r\n mode=" 		+ mode);
		DEBUG_LOG_STR.append("\r\n randserial=" + randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
