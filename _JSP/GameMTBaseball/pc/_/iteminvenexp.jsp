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
	String invenkind	= util.getParamStr(request, "invenkind", "-1");

	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n invenkind:" + invenkind);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	//out.print("gameid:" + gameid
	//			+ " password:" + password
	//			+ " invenkind:" + invenkind);

	try{

		//2. 데이타 조작
		//exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- 동물 인벤확장.
		query.append("{ call dbo.spu_ItemInvenExp (?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, invenkind);
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
		msg.append("		<code>");			msg.append(PTS_ITEMINVENEXP); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    		msg.append("</gamecost>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    		msg.append("</cashcost>\n");
		msg.append("		<invenanimalmax>");	msg.append(result.getInt("invenanimalmax"));    msg.append("</invenanimalmax>\n");
		msg.append("		<invenanimalstep>");msg.append(result.getInt("invenanimalstep"));   msg.append("</invenanimalstep>\n");
		msg.append("		<invencustommax>");	msg.append(result.getInt("invencustommax"));    msg.append("</invencustommax>\n");
		msg.append("		<invencustomstep>");msg.append(result.getInt("invencustomstep"));   msg.append("</invencustomstep>\n");
		msg.append("		<invenaccmax>");	msg.append(result.getInt("invenaccmax"));    	msg.append("</invenaccmax>\n");
		msg.append("		<invenaccstep>");	msg.append(result.getInt("invenaccstep"));    	msg.append("</invenaccstep>\n");
		msg.append("		<invenstemcellmax>");msg.append(result.getInt("invenstemcellmax")); msg.append("</invenstemcellmax>\n");
		msg.append("		<invenstemcellstep>");msg.append(result.getInt("invenstemcellstep"));msg.append("</invenstemcellstep>\n");
		msg.append("		<inventreasuremax>");msg.append(result.getInt("inventreasuremax")); msg.append("</inventreasuremax>\n");
		msg.append("		<inventreasurestep>");msg.append(result.getInt("inventreasurestep"));msg.append("</inventreasurestep>\n");
		msg.append("	</result>\n");
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid:" + gameid);
		DEBUG_LOG_STR.append("\r\n password:" + password);
		DEBUG_LOG_STR.append("\r\n invenkind:" + invenkind);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
	/**/
%>
