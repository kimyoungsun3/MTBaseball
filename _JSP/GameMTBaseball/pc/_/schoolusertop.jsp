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
	int mode 				= 4;
	int schoolidx			= util.getParamInt(request, "schoolidx", -1);
	String schoolname		= "";
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n mode:" 		+ mode);
		DEBUG_LOG_STR.append("\r\n schoolidx:" 	+ schoolidx);
		DEBUG_LOG_STR.append("\r\n schoolname:" + schoolname);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 4, -1, '', -1
		query.append("{ call dbo.spu_SchoolInfo (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setInt(idxColumn++, mode);
		cstmt.setInt(idxColumn++, schoolidx);
		cstmt.setString(idxColumn++, schoolname);
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
		msg.append("		<code>");			msg.append(PTS_SCHOOLUSERTOP); 		msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    			msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

	    //학교내 랭킹.
		if(resultCode == 1){
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<schoolusertop>\n");
					msg.append("		<userrank>");	msg.append(result.getString("userrank"));   msg.append("</userrank>\n");
					msg.append("		<cnt>");		msg.append(result.getString("cnt"));  		msg.append("</cnt>\n");
					msg.append("		<gameid>");		msg.append(result.getString("gameid"));   	msg.append("</gameid>\n");
					msg.append("		<point>");		msg.append(result.getString("point"));   	msg.append("</point>\n");
					msg.append("		<schoolname>");	msg.append(result.getString("schoolname")); msg.append("</schoolname>\n");
					msg.append("		<schoolidx>");	msg.append(result.getString("schoolidx"));  msg.append("</schoolidx>\n");
					msg.append("		<itemcode>");	msg.append(result.getString("itemcode"));  	msg.append("</itemcode>\n");
					msg.append("		<acc1>");		msg.append(result.getString("acc1"));  		msg.append("</acc1>\n");
					msg.append("		<acc2>");		msg.append(result.getString("acc2"));  		msg.append("</acc2>\n");

					msg.append("		<kakaotalkid>");	msg.append(result.getString("kakaotalkid"));   	msg.append("</kakaotalkid>\n");
					msg.append("		<kakaouserid>");	msg.append(result.getString("kakaouserid"));   	msg.append("</kakaouserid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
					msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));   msg.append("</kakaoprofile>\n");
					msg.append("		<kakaomsgblocked>");msg.append(result.getString("kakaomsgblocked"));msg.append("</kakaomsgblocked>\n");
					msg.append("		<kakaofriendkind>");msg.append(result.getString("kakaofriendkind"));msg.append("</kakaofriendkind>\n");
					msg.append("	</schoolusertop>\n");
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
		DEBUG_LOG_STR.append("\r\n schoolidx:" 	+ schoolidx);
		DEBUG_LOG_STR.append("\r\n schoolname:" + schoolname);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
