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
	String listidx 		= util.getParamStr(request, "listidx", "-1");
	String quickkind 		= util.getParamStr(request, "quickkind", "1");

	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n listidx:" + listidx);
		DEBUG_LOG_STR.append("\r\n quickkind:" + quickkind);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	//out.print("gameid:" + gameid
	//			+ " password:" + password
	//			+ " listidx:" + listidx
	//			+ " fieldidx:" + quickkind);

	try{
		//2. 데이타 조작
		//exec spu_ItemQuick 'xxxx9', '049000s1i0n7t8445289',  7, 1, -1	-- 총알
		query.append("{ call dbo.spu_ItemQuick (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, listidx);
		cstmt.setString(idxColumn++, quickkind);
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
		msg.append("		<code>");			msg.append(PTS_ITEMQUICK); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");
		msg.append("		<bulletlistidx>");	msg.append(result.getInt("bulletlistidx"));    	msg.append("</bulletlistidx>\n");
		msg.append("		<vaccinelistidx>");	msg.append(result.getInt("vaccinelistidx"));    msg.append("</vaccinelistidx>\n");
		msg.append("		<boosterlistidx>");	msg.append(result.getInt("boosterlistidx"));    msg.append("</boosterlistidx>\n");
		msg.append("		<albalistidx>");	msg.append(result.getInt("albalistidx"));    	msg.append("</albalistidx>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n listidx:" + listidx);
		DEBUG_LOG_STR.append("\r\n quickkind:" + quickkind);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
