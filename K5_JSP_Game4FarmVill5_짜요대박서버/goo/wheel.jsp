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
	String mode			= util.getParamStr(request, "mode", "20");
	String usedcashcost	= util.getParamStr(request, "usedcashcost", "300");
	String randserial 	= util.getParamStr(request, "randserial", "-1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n mode="		+ mode);
		DEBUG_LOG_STR.append("\r\n usedcashcost="+ usedcashcost);
		DEBUG_LOG_STR.append("\r\n randserial="	+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 20,   0, 7776, -1			-- 일일회전판(20)    MODE_WHEEL_NORMAL
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 300, 7777, -1			-- 결정회전판(21)    MODE_WHEEL_PREMINUM
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 270, 7779, -1			-- 결정회전판(21)    MODE_WHEEL_PREMINUM
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 22,   0, 7778, -1			-- 황금무료(22)  	 MODE_WHEEL_PREMINUMFREE
		query.append("{ call dbo.spu_Wheel (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, mode);
		cstmt.setString(idx++, usedcashcost);
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
		msg.append("		<code>");			msg.append(PTS_WHEEL); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));  msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));  msg.append("</gamecost>\n");

		msg.append("		<rewardidx>");		msg.append(result.getInt("rewardidx"));  msg.append("</rewardidx>\n");
		msg.append("		<rewarditemcode>");	msg.append(result.getInt("rewarditemcode"));msg.append("</rewarditemcode>\n");
		msg.append("		<rewardcnt>");		msg.append(result.getInt("rewardcnt"));  msg.append("</rewardcnt>\n");

		msg.append("		<wheeltodaycnt>");	msg.append(result.getInt("wheeltodaycnt")); msg.append("</wheeltodaycnt>\n");
		msg.append("		<wheelgauage>");	msg.append(result.getInt("wheelgauage"));msg.append("</wheelgauage>\n");
		msg.append("		<wheelfree>");		msg.append(result.getInt("wheelfree"));  msg.append("</wheelfree>\n");

		msg.append("		<wheelgauageflag>");msg.append(result.getInt("wheelgauageflag")); msg.append("</wheelgauageflag>\n");
		msg.append("		<wheelgauagepoint>");msg.append(result.getInt("wheelgauagepoint"));msg.append("</wheelgauagepoint>\n");
		msg.append("		<wheelgauagemax>");	msg.append(result.getInt("wheelgauagemax"));  msg.append("</wheelgauagemax>\n");

		msg.append("		<rkteam>");			msg.append(result.getInt("rkteam"));  		msg.append("</rkteam>\n");
		msg.append("		<rkstartstate>");	msg.append(result.getInt("rkstartstate"));  msg.append("</rkstartstate>\n");

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

			//무료룰렛.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<wheelfreeinfo>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));			msg.append("</idx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));		msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));			msg.append("</cnt>\n");
					msg.append("	</wheelfreeinfo>\n");
				}
			}

			//유료룰렛.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<wheelcashinfo>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));			msg.append("</idx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));		msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));			msg.append("</cnt>\n");
					msg.append("	</wheelcashinfo>\n");
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
		DEBUG_LOG_STR.append("\r\n mode="		+ mode);
		DEBUG_LOG_STR.append("\r\n usedcashcost="+ usedcashcost);
		DEBUG_LOG_STR.append("\r\n randserial="	+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
