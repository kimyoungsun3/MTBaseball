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
	String anilistidx 	= util.getParamStr(request, "anilistidx", "-1");
	String acclistidx 	= util.getParamStr(request, "acclistidx", "-1");
	String acc2listidx 	= util.getParamStr(request, "acc2listidx", "-1");
	String randserial 	= util.getParamStr(request, "randserial", "-1");

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n anilistidx=" 	+ anilistidx);
		DEBUG_LOG_STR.append("\r\n acclistidx=" 	+ acclistidx);
		DEBUG_LOG_STR.append("\r\n acc2listidx=" 	+ acc2listidx);
		DEBUG_LOG_STR.append("\r\n randserial=" 	+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		//2. 데이타 조작
		//exec spu_ItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 27, -1, 7777, -1
		query.append("{ call dbo.spu_ItemAccNew (?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, anilistidx);
		cstmt.setString(idxColumn++, acclistidx);
		cstmt.setString(idxColumn++, acc2listidx);
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
		msg.append("		<code>");			msg.append(PTS_ITEMACCNEW); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");
		msg.append("		<anilistidx>");		msg.append(result.getInt("anilistidx"));    	msg.append("</anilistidx>\n");
		msg.append("		<acc1>");			msg.append(result.getInt("acc1"));  		 	msg.append("</acc1>\n");
		msg.append("		<acc2>");			msg.append(result.getInt("acc2"));   			msg.append("</acc2>\n");
		msg.append("		<bgacc1listidxdel>");msg.append(result.getInt("bgacc1listidxdel")); msg.append("</bgacc1listidxdel>\n");
		msg.append("		<bgacc2listidxdel>");msg.append(result.getInt("bgacc2listidxdel")); msg.append("</bgacc2listidxdel>\n");
		msg.append("	</result>\n");

	    if(resultCode == 1){
	    	////2. 유저 보유 아이템 정보
			//if(cstmt.getMoreResults()){
			//	result = cstmt.getResultSet();
			//	while(result.next()){
			//		msg.append("	<aniitemowner>\n");
			//		msg.append("		<listidx>");		msg.append(result.getString("listidx"));   	msg.append("</listidx>\n");
			//		msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   msg.append("</itemcode>\n");
			//		msg.append("		<cnt>");			msg.append(result.getString("cnt"));   		msg.append("</cnt>\n");
			//		msg.append("		<farmnum>");		msg.append(result.getString("farmnum"));   	msg.append("</farmnum>\n");
			//		msg.append("		<fieldidx>");		msg.append(result.getString("fieldidx"));   msg.append("</fieldidx>\n");
			//		msg.append("		<anistep>");		msg.append(result.getString("anistep"));   	msg.append("</anistep>\n");
			//		msg.append("		<manger>");			msg.append(result.getString("manger"));   	msg.append("</manger>\n");
			//		msg.append("		<diseasestate>");	msg.append(result.getString("diseasestate"));   	msg.append("</diseasestate>\n");
			//		msg.append("		<diedate>");		msg.append(result.getString("diedate"));   	msg.append("</diedate>\n");
			//		msg.append("		<acc1>");			msg.append(result.getString("acc1"));   	msg.append("</acc1>\n");
			//		msg.append("		<acc2>");			msg.append(result.getString("acc2"));   	msg.append("</acc2>\n");
			//		msg.append("		<invenkind>");		msg.append(result.getString("invenkind"));  msg.append("</invenkind>\n");
			//		msg.append("		<randserial>");		msg.append(result.getString("randserial")); msg.append("</randserial>\n");
			//		msg.append("	</aniitemowner>\n");
			//	}
			//}

	    	//2. 유저 보유 아이템 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<accitemowner>\n");
					msg.append("		<listidx>");		msg.append(result.getString("listidx"));   	msg.append("</listidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));   		msg.append("</cnt>\n");
					msg.append("		<farmnum>");		msg.append(result.getString("farmnum"));   	msg.append("</farmnum>\n");
					msg.append("		<fieldidx>");		msg.append(result.getString("fieldidx"));   msg.append("</fieldidx>\n");
					msg.append("		<anistep>");		msg.append(result.getString("anistep"));   	msg.append("</anistep>\n");
					msg.append("		<manger>");			msg.append(result.getString("manger"));   	msg.append("</manger>\n");
					msg.append("		<diseasestate>");	msg.append(result.getString("diseasestate")); 	msg.append("</diseasestate>\n");
					msg.append("		<diedate>");		msg.append(result.getString("diedate"));   	msg.append("</diedate>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1"));   	msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2"));   	msg.append("</acc2>\n");
					msg.append("		<invenkind>");		msg.append(result.getString("invenkind"));  msg.append("</invenkind>\n");
					msg.append("		<randserial>");		msg.append(result.getString("randserial")); msg.append("</randserial>\n");
					msg.append("	</accitemowner>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e=" + e);
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n anilistidx=" 	+ anilistidx);
		DEBUG_LOG_STR.append("\r\n acclistidx=" 	+ acclistidx);
		DEBUG_LOG_STR.append("\r\n acc2listidx=" 	+ acc2listidx);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
