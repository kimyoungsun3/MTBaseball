<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>
<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int rtn = -1;
	int idxColumn				= 1;

	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "guest");
	String password 	= util.getParamStr(request, "password", "");
	String market		= util.getParamStr(request, "market", "1");
	String buytype 		= util.getParamStr(request, "buytype", "0");
	String platform 	= util.getParamStr(request, "platform", "1");
	String ukey 		= util.getParamStr(request, "ukey", "ukey");
	String version 		= util.getParamStr(request, "version", "101");
	String phone 		= util.getParamStr(request, "phone", "");
	String pushid 		= util.getParamStr(request, "pushid", "");

	String kakaotalkid 		= util.getParamStr(request, "kakaotalkid", "");
	String kakaouserid 		= util.getParamStr(request, "kakaouserid", "");
	String kakaogameid 		= util.getParamStr(request, "kakaogameid", "");
	String kakaonickname 	= util.getParamStr(request, "kakaonickname", "");
	String kakaoprofile 	= util.getParamStr(request, "kakaoprofile", "");
	String kakaomsgblocked	= util.getParamStr(request, "kakaomsgblocked", "-1");
	String kakaofriendlist	= util.getParamStr(request, "kakaofriendlist", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n market=" 		+ market);
		DEBUG_LOG_STR.append("\r\n buytype=" 		+ buytype);
		DEBUG_LOG_STR.append("\r\n platform=" 		+ platform);
		DEBUG_LOG_STR.append("\r\n ukey=" 			+ ukey);
		DEBUG_LOG_STR.append("\r\n version=" 		+ version);
		DEBUG_LOG_STR.append("\r\n phone=" 			+ getDencode4(phone, 14+14, "-1"));
		DEBUG_LOG_STR.append("\r\n pushid=" 		+ pushid);
		DEBUG_LOG_STR.append("\r\n kakaotalkid=" 	+ kakaotalkid);
		DEBUG_LOG_STR.append("\r\n kakaouserid=" 	+ kakaouserid);
		DEBUG_LOG_STR.append("\r\n kakaogameid=" 	+ kakaogameid);
		DEBUG_LOG_STR.append("\r\n kakaonickname=" 	+ kakaonickname);
		DEBUG_LOG_STR.append("\r\n kakaoprofile=" 	+ kakaoprofile);
		DEBUG_LOG_STR.append("\r\n kakaomsgblocked="+ kakaomsgblocked);
		DEBUG_LOG_STR.append("\r\n kakaofriendlist="+ kakaofriendlist);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		phone 	= getDencode4(phone, 14+14, "-1");

		//2. 데이타 조작
		//exec spu_UserCreate 'superman',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '', -1
		query.append("{ call dbo.spu_UserCreate (?, ?, ?, ?, ?,  	?, ?, ?, ?, ?,	?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, market);
		cstmt.setString(idxColumn++, buytype);
		cstmt.setString(idxColumn++, platform);
		cstmt.setString(idxColumn++, ukey);
		cstmt.setString(idxColumn++, version);
		cstmt.setString(idxColumn++, phone);
		cstmt.setString(idxColumn++, pushid);

		cstmt.setString(idxColumn++, kakaotalkid);
		cstmt.setString(idxColumn++, kakaouserid);
		cstmt.setString(idxColumn++, kakaogameid);
		cstmt.setString(idxColumn++, kakaonickname);
		cstmt.setString(idxColumn++, kakaoprofile);
		cstmt.setString(idxColumn++, kakaomsgblocked);
		cstmt.setString(idxColumn++, kakaofriendlist);
		cstmt.registerOutParameter(idxColumn++, java.sql.Types.INTEGER);

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3. xml형태로 데이타 출력
		msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
		msg.append("<rows>\n");
		msg.append("	<result>\n");
	    if(result.next()){
			msg.append("		<code>");			msg.append(PTS_CREATEGUEST); 				msg.append("</code>\n");
	        msg.append("		<resultcode>");		msg.append(result.getString("rtn"));    	msg.append("</resultcode>\n");
			msg.append("		<resultmsg>");		msg.append(result.getString(2));    		msg.append("</resultmsg>\n");
	        msg.append("		<gameid>");			msg.append(result.getString("gameid"));		msg.append("</gameid>\n");
	        msg.append("		<password>");		msg.append(result.getString("password"));	msg.append("</password>\n");
			msg.append("		<waittime>");		msg.append(result.getString("waittime").substring(0, 16));	msg.append("</waittime>\n");
	    }
	    msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n market:" 	+ market);
		DEBUG_LOG_STR.append("\r\n buytype:" 	+ buytype);
		DEBUG_LOG_STR.append("\r\n platform:" 	+ platform);
		DEBUG_LOG_STR.append("\r\n ukey:" 		+ ukey);
		DEBUG_LOG_STR.append("\r\n version:" 	+ version);
		DEBUG_LOG_STR.append("\r\n phone:" 		+ phone);
		DEBUG_LOG_STR.append("\r\n pushid:" 	+ pushid);

		DEBUG_LOG_STR.append("\r\n kakaotalkid=" 	+ kakaotalkid);
		DEBUG_LOG_STR.append("\r\n kakaouserid=" 	+ kakaouserid);
		DEBUG_LOG_STR.append("\r\n kakaogameid=" 	+ kakaogameid);
		DEBUG_LOG_STR.append("\r\n kakaonickname=" 	+ kakaonickname);
		DEBUG_LOG_STR.append("\r\n kakaoprofile=" 	+ kakaoprofile);
		DEBUG_LOG_STR.append("\r\n kakaomsgblocked="+ kakaomsgblocked);
		DEBUG_LOG_STR.append("\r\n kakaofriendlist="+ kakaofriendlist);
		System.out.println(DEBUG_LOG_STR.toString());
	}
    /**/

    //3. 송출, 데이타 반납
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

    out.print(msg);
%>
