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
	String sid 			= util.getParamStr(request, "sid", "-1");
	String listidxcloth	= util.getParamStr(request, "listidxcloth", "-1");
	String listidxcust	= util.getParamStr(request, "listidxcust", "-1");
	String randserial 	= util.getParamStr(request, "randserial", "-1");

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password:" 	+ password);
		DEBUG_LOG_STR.append("\r\n sid:" 		+ sid);
		DEBUG_LOG_STR.append("\r\n listidxcloth:"+ listidxcloth);
		DEBUG_LOG_STR.append("\r\n listidxcust:"+ listidxcust);
		DEBUG_LOG_STR.append("\r\n randserial:" + randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{

		//2. 데이타 조작
		//exec spu_ItemEvolve 'mtxxxx3', '049000s1i0n7t8445289', 333, 332, 15, 7711, -1	-- 돌 헬멧초월.
		query.append("{ call dbo.spu_ItemEvolve (?, ?, ?, ?, ?, 	?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, sid);
		cstmt.setString(idxColumn++, listidxcloth);
		cstmt.setString(idxColumn++, listidxcust);
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
		msg.append("		<code>");			msg.append(PTS_ITEMEVOLUE); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    		msg.append("</gamecost>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    		msg.append("</cashcost>\n");
		msg.append("		<evolvestate>");	msg.append(result.getInt("evolvestate"));    	msg.append("</evolvestate>\n");
		msg.append("		<evolveitemcode>");	msg.append(result.getInt("evolveitemcode"));    msg.append("</evolveitemcode>\n");
		msg.append("	</result>\n");
	    if(resultCode == 1){
	    	//2. 유저 보유 아이템 정보
			//2-3-3. 유저 보유 아이템 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<itemowner>\n");
					msg.append("		<listidx>");		msg.append(result.getString("listidx"));   		msg.append("</listidx>\n");
					msg.append("		<invenkind>");		msg.append(result.getString("invenkind"));   	msg.append("</invenkind>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));   			msg.append("</cnt>\n");
					msg.append("		<randserial>");		msg.append(result.getString("randserial"));   	msg.append("</randserial>\n");
					msg.append("	</itemowner>\n");
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
		DEBUG_LOG_STR.append("\r\n sid:" 		+ sid);
		DEBUG_LOG_STR.append("\r\n listidxcloth:" 	+ listidxcloth);
		DEBUG_LOG_STR.append("\r\n randserial:" + randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
