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
	int mode			= 2;
	String kind 		= util.getParamStr(request, "kind", "1");
	String page2 		= util.getParamStr(request, "page", "1");
	String message 		= "";

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n mode:" + mode);
		DEBUG_LOG_STR.append("\r\n kind:" + kind);
		DEBUG_LOG_STR.append("\r\n page2:" + page2);
		DEBUG_LOG_STR.append("\r\n message:" + message);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1, '일반게시판광고', -1		-- 게시판글쓰기.
		query.append("{ call dbo.spu_UserBoard (?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setInt(idxColumn++, mode);
		cstmt.setString(idxColumn++, kind);
		cstmt.setString(idxColumn++, page2);
		cstmt.setString(idxColumn++, message);
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
		msg.append("		<code>");			msg.append(PTS_FBREAD); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

	    if(resultCode == 1){
	    	//2. 유저 보유 아이템 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<boardlist>\n");
					msg.append("		<kind>");			msg.append(result.getString("kind")); 		msg.append("</kind>\n");
					msg.append("		<page>");			msg.append(result.getString("page"));   	msg.append("</page>\n");
					msg.append("		<pagemax>");		msg.append(result.getString("pagemax"));   	msg.append("</pagemax>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx2")); 		msg.append("</idx>\n");
					msg.append("		<gameid>");			msg.append(result.getString("gameid")); 	msg.append("</gameid>\n");
					msg.append("		<message>");		msg.append(result.getString("message")); 	msg.append("</message>\n");
					msg.append("		<writedate>");		msg.append(result.getString("writedate").substring(0, 10));   	msg.append("</writedate>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode")); 	msg.append("</itemcode>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1")); 		msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2")); 		msg.append("</acc2>\n");
					msg.append("		<schoolidx>");		msg.append(result.getString("schoolidx")); 	msg.append("</schoolidx>\n");
					msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));msg.append("</kakaoprofile>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));msg.append("</kakaonickname>\n");
					msg.append("	</boardlist>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n mode:" + mode);
		DEBUG_LOG_STR.append("\r\n kind:" + kind);
		DEBUG_LOG_STR.append("\r\n page:" + page);
		DEBUG_LOG_STR.append("\r\n message:" + message);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
