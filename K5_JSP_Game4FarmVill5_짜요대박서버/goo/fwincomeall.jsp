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
	int mode				= 22;
	String itemcode			= "-1";

	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n itemcode:" + itemcode);
		System.out.println(DEBUG_LOG_STR.toString());
	}

	try{
		//2. 데이타 조작
		//exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  2, 6900, -1		-- 수입
		query.append("{ call dbo.spu_UserFarm (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setInt(idxColumn++, mode);
		cstmt.setString(idxColumn++, itemcode);
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
		msg.append("		<code>");			msg.append(PTS_FWINCOMEALL); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());				msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));  		msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getString("gamecost")); 		msg.append("</gamecost>\n");
		msg.append("		<heart>");			msg.append(result.getString("heart"));  		msg.append("</heart>\n");
		msg.append("		<feed>");			msg.append(result.getString("feed"));  			msg.append("</feed>\n");
		msg.append("		<fpoint>");			msg.append(result.getString("fpoint"));  		msg.append("</fpoint>\n");
		msg.append("		<incomegamecost>");	msg.append(result.getString("incomegamecost")); msg.append("</incomegamecost>\n");
		msg.append("	</result>\n");

	    //친구 정보 리스트.
		if(resultCode == 1){
			//농장정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<myfarm>\n");
					msg.append("		<star>");			msg.append(result.getString("star"));   			msg.append("</star>\n");
					msg.append("		<farmidx>");		msg.append(result.getString("farmidx"));   			msg.append("</farmidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   		msg.append("</itemcode>\n");
					msg.append("		<buystate>");		msg.append(result.getString("buystate"));   		msg.append("</buystate>\n");
					msg.append("		<incomedate>");		msg.append(result.getString("incomedate").substring(0, 19)); msg.append("</incomedate>\n");
					msg.append("		<playcnt>");		msg.append(result.getString("playcnt"));   			msg.append("</playcnt>\n");
					msg.append("	</myfarm>\n");
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
		DEBUG_LOG_STR.append("\r\n itemcode:" + itemcode);
		System.out.println(DEBUG_LOG_STR.toString());
	}





    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
