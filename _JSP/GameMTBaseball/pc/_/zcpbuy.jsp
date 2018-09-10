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
	String zcpidx		= util.getParamStr(request, "idx", "1");
	String randserial 	= util.getParamStr(request, "randserial", "-1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n idx="		+ zcpidx);
		DEBUG_LOG_STR.append("\r\n randserial="	+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_ZCPBuy 'xxxx2', '049000s1i0n7t8445289', 3, 7715, -1				-- 정상구매.
		query.append("{ call dbo.spu_ZCPBuy (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, zcpidx);
		cstmt.setString(idx++, randserial);
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
		msg.append("		<code>");			msg.append(PTS_ZCPBUY); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
	    	//2. 삭제리스트.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<itemdellist>\n");
					msg.append("		<listidx>");		msg.append(result.getString("listidx"));   		msg.append("</listidx>\n");
					msg.append("	</itemdellist>\n");
				}
			}

	    	//2. 유저 보유 선물리스트
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

			//짜요장터 템정보..
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<zcpmarket>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));			msg.append("</idx>\n");
					msg.append("		<kind>");			msg.append(result.getString("kind"));			msg.append("</kind>\n");
					msg.append("		<title>");			msg.append(result.getString("title"));			msg.append("</title>\n");
					msg.append("		<zcpfile>");		msg.append(result.getString("zcpfile"));		msg.append("</zcpfile>\n");
					msg.append("		<zcpurl>");			msg.append(result.getString("zcpurl"));			msg.append("</zcpurl>\n");
					msg.append("		<bestmark>");		msg.append(result.getString("bestmark"));		msg.append("</bestmark>\n");
					msg.append("		<newmark>");		msg.append(result.getString("newmark"));		msg.append("</newmark>\n");
					msg.append("		<needcnt>");		msg.append(result.getString("needcnt"));		msg.append("</needcnt>\n");
					msg.append("		<firstcnt>");		msg.append(result.getString("firstcnt"));		msg.append("</firstcnt>\n");
					msg.append("		<balancecnt>");		msg.append(result.getString("balancecnt"));		msg.append("</balancecnt>\n");
					msg.append("		<commentsimple>");	msg.append(result.getString("commentsimple"));	msg.append("</commentsimple>\n");
					msg.append("		<commentdesc>");	msg.append(result.getString("commentdesc"));	msg.append("</commentdesc>\n");
					msg.append("		<expiredate>");		msg.append(result.getString("expiredate"));		msg.append("</expiredate>\n");
					msg.append("	</zcpmarket>\n");
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
		DEBUG_LOG_STR.append("\r\n idx="		+ zcpidx);
		DEBUG_LOG_STR.append("\r\n randserial="	+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
