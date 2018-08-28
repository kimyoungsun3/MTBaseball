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
	String mode			= util.getParamStr(request, "mode", "1");
	String paramint 	= util.getParamStr(request, "paramint", "-1");
	String paramstr 	= util.getParamStr(request, "paramstr", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n mode:" 		+ mode);
		DEBUG_LOG_STR.append("\r\n paramint:" 	+ paramint);
		DEBUG_LOG_STR.append("\r\n paramstr:" 	+ paramstr);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_ChangeInfo 'xxxx2', '049000s1i0n7t8445289',  1, -1, '', -1		-- 게시판글쓰기
		//exec spu_ChangeInfo 'xxxx2', '049000s1i0n7t8445289', 11, -1, '', -1		-- 푸쉬승인/거절
		//exec spu_ChangeInfo 'xxxx2', '049000s1i0n7t8445289', 12, -1, '', -1		-- 카카오 메세지 자기것 거부
		query.append("{ call dbo.spu_ChangeInfo (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, mode);
		cstmt.setString(idx++, paramint);
		cstmt.setString(idx++, paramstr);
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
		msg.append("		<code>");			msg.append(PTS_CHANGEINFO); 			msg.append("</code>\n");
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
					msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));   	msg.append("</gamecost>\n");
					msg.append("		<feed>");			msg.append(result.getString("feed"));   		msg.append("</feed>\n");
					msg.append("		<feedmax>");		msg.append(result.getString("feedmax"));   		msg.append("</feedmax>\n");
					msg.append("		<heart>");			msg.append(result.getString("heart"));   		msg.append("</heart>\n");
					msg.append("		<heartmax>");		msg.append(result.getString("heartmax"));   	msg.append("</heartmax>\n");
					msg.append("		<fevergauge>");		msg.append(result.getString("fevergauge"));   	msg.append("</fevergauge>\n");
					msg.append("		<tutorial>");		msg.append(result.getString("tutorial"));   	msg.append("</tutorial>\n");
					msg.append("		<fpoint>");			msg.append(result.getString("fpoint"));   		msg.append("</fpoint>\n");
					msg.append("		<comreward>");		msg.append(result.getString("comreward"));   	msg.append("</comreward>\n");
					msg.append("		<mboardstate>");	msg.append(result.getString("mboardstate"));   	msg.append("</mboardstate>\n");
					msg.append("		<mboardreward>");	msg.append(result.getString("mboardreward"));   msg.append("</mboardreward>\n");
					msg.append("		<kkopushallow>");	msg.append(result.getString("kkopushallow"));   msg.append("</kkopushallow>\n");
					msg.append("		<kakaomsgblocked>");msg.append(result.getString("kakaomsgblocked"));msg.append("</kakaomsgblocked>\n");
					msg.append("	</userinfo>\n");
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
		DEBUG_LOG_STR.append("\r\n mode:" 		+ mode);
		DEBUG_LOG_STR.append("\r\n paramint:" 	+ paramint);
		DEBUG_LOG_STR.append("\r\n paramstr:" 	+ paramstr);
		System.out.println(DEBUG_LOG_STR.toString());
	}
    /**/


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
