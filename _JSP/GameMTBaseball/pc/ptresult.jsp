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
	String gmode		= util.getParamStr(request, "gmode", "1");
	String curturntime	= util.getParamStr(request, "curturntime", "-1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n sid:" 		+ sid);
		DEBUG_LOG_STR.append("\r\n gmode:" 		+ gmode);
		DEBUG_LOG_STR.append("\r\n curturntime:"+ curturntime);	
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{  
		//2. 데이타 조작
		//exec spu_PTResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 0, 831844, -1	-- 1개배팅 -> 1개성공
		query.append("{ call dbo.spu_PTResult (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, sid);
		cstmt.setString(idxColumn++, gmode);
		cstmt.setString(idxColumn++, curturntime);
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
		msg.append("		<code>");			msg.append(PTS_PTRESULT); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    			msg.append("</resultmsg>\n");		
		msg.append("		<curdate>");		msg.append(result.getString("curdate").substring(0, 19));msg.append("</curdate>\n");
		msg.append("		<curturntime>");	msg.append(result.getString("curturntime"));	msg.append("</curturntime>\n");
		msg.append("		<curturndate>");	msg.append(result.getString("curturndate").substring(0, 19));msg.append("</curturndate>\n");
		msg.append("		<nextturntime>");	msg.append(result.getString("nextturntime"));	msg.append("</nextturntime>\n");
		msg.append("		<nextturndate>");	msg.append(result.getString("nextturndate").substring(0, 19));msg.append("</nextturndate>\n");
		msg.append("		<cashcost>");		msg.append(result.getString("cashcost")); msg.append("</cashcost>\n");		
		msg.append("		<gamecost>");		msg.append(result.getString("gamecost")); msg.append("</gamecost>\n");		
		
		msg.append("		<ltselect1>");		msg.append(result.getString("ltselect1")); 	msg.append("</ltselect1>\n");
		msg.append("		<ltselect2>");		msg.append(result.getString("ltselect2")); 	msg.append("</ltselect2>\n");
		msg.append("		<ltselect3>");		msg.append(result.getString("ltselect3")); 	msg.append("</ltselect3>\n");
		msg.append("		<ltselect4>");		msg.append(result.getString("ltselect4")); 	msg.append("</ltselect4>\n");
		
		msg.append("		<rselect1>");		msg.append(result.getString("rselect1")); 	msg.append("</rselect1>\n");
		msg.append("		<rselect2>");		msg.append(result.getString("rselect2")); 	msg.append("</rselect2>\n");
		msg.append("		<rselect3>");		msg.append(result.getString("rselect3")); 	msg.append("</rselect3>\n");
		msg.append("		<rselect4>");		msg.append(result.getString("rselect4")); 	msg.append("</rselect4>\n");
		
		msg.append("		<gameresult>");		msg.append(result.getString("gameresult")); msg.append("</gameresult>\n");
		
		msg.append("		<exp>");			msg.append(result.getString("exp")); 		msg.append("</exp>\n");
		msg.append("		<level>");			msg.append(result.getString("level")); 		msg.append("</level>\n");
		msg.append("		<levelup>");		msg.append(result.getString("levelup")); 	msg.append("</levelup>\n");
		
		msg.append("	</result>\n");

		if(resultCode == 1){
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
		DEBUG_LOG_STR.append("\r\n sid:" 		+ sid);
		DEBUG_LOG_STR.append("\r\n gmode:" 		+ gmode);
		DEBUG_LOG_STR.append("\r\n curturntime:"+ curturntime);	
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
