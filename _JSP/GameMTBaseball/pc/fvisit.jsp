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
	String gameid 			= util.getParamStr(request, "gameid", "");
	String password			= util.getParamStr(request, "password", "");
	int mode 				= 5;
	String friendid			= util.getParamStr(request, "friendid", "");

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n mode:" 		+ mode);
		DEBUG_LOG_STR.append("\r\n friendid:" 	+ friendid);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_Friend 'xxxx', '049000s1i0n7t8445289', 5, 'xxxx2', -1		-- 친구방문.
		query.append("{ call dbo.spu_Friend (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setInt(idxColumn++, mode);
		cstmt.setString(idxColumn++, friendid);
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
		msg.append("		<code>");			msg.append(PTS_FVISIT); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-2. 유저 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<friendinfo>\n");
					msg.append("		<gameyear>");		msg.append(result.getString("gameyear"));   	msg.append("</gameyear>\n");
					msg.append("		<gamemonth>");		msg.append(result.getString("gamemonth"));   	msg.append("</gamemonth>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   		msg.append("</famelv>\n");

					msg.append("		<housestep>");		msg.append(result.getString("housestep"));   	msg.append("</housestep>\n");
					msg.append("		<tankstep>");		msg.append(result.getString("tankstep"));   	msg.append("</tankstep>\n");
					msg.append("		<bottlestep>");		msg.append(result.getString("bottlestep"));   	msg.append("</bottlestep>\n");
					msg.append("		<pumpstep>");		msg.append(result.getString("pumpstep"));   	msg.append("</pumpstep>\n");
					msg.append("		<transferstep>");	msg.append(result.getString("transferstep"));  msg.append("</transferstep>\n");
					msg.append("		<purestep>");		msg.append(result.getString("purestep"));   	msg.append("</purestep>\n");
					msg.append("		<freshcoolstep>");	msg.append(result.getString("freshcoolstep")); msg.append("</freshcoolstep>\n");
					msg.append("	</friendinfo>\n");
				}
			}

			//2-3-3. 유저 보유 아이템 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<friendani>\n");
					msg.append("		<invenkind>");		msg.append(result.getString("invenkind"));   	msg.append("</invenkind>\n");
					msg.append("		<fieldidx>");		msg.append(result.getString("fieldidx"));   	msg.append("</fieldidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<anistep>");		msg.append(result.getString("anistep"));   		msg.append("</anistep>\n");
					msg.append("		<manger>");			msg.append(result.getString("manger"));   		msg.append("</manger>\n");
					msg.append("		<diseasestate>");	msg.append(result.getString("diseasestate"));   msg.append("</diseasestate>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1"));   		msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2"));   		msg.append("</acc2>\n");
					msg.append("	</friendani>\n");
				}
			}

			//2-3-3. 유저 경작지.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<friendseed>\n");
					msg.append("		<seedidx>");		msg.append(result.getString("seedidx"));   		msg.append("</seedidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<seedstartdate>");	msg.append(result.getString("seedstartdate").substring(0, 19));  	msg.append("</seedstartdate>\n");
					msg.append("		<seedenddate>");	msg.append(result.getString("seedenddate").substring(0, 19));  		msg.append("</seedenddate>\n");
					msg.append("	</friendseed>\n");
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
		DEBUG_LOG_STR.append("\r\n friendid:" 	+ friendid);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
