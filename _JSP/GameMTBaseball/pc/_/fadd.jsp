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
	int mode 				= 2;
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
		//exec spu_Friend 'xxxx2','049000s1i0n7t8445289',  2, -1, 'xxxx3', -1		-- 신청 : 친구 추가(계속추가가능)
		query.append("{ call dbo.spu_Friend (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setInt(idxColumn++, mode);
		cstmt.setString(idxColumn++, friendid);
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
		msg.append("		<code>");			msg.append(PTS_FADD); 		msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    			msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

	    //행동력 데이타를 갱신해준다.
		if(resultCode == 1){
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<flist>\n");
					msg.append("		<friendid>");		msg.append(result.getString("friendid"));   	msg.append("</friendid>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));    	msg.append("</itemcode>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1"));    		msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2"));    		msg.append("</acc2>\n");
					msg.append("		<state>");			msg.append(result.getString("state"));   		msg.append("</state>\n");
					msg.append("		<senddate>");		msg.append(result.getString("senddate"));   	msg.append("</senddate>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   		msg.append("</famelv>\n");

					msg.append("		<kakaotalkid>");	msg.append(result.getString("kakaotalkid"));   	msg.append("</kakaotalkid>\n");
					msg.append("		<kakaouserid>");	msg.append(result.getString("kakaouserid"));   	msg.append("</kakaouserid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
					msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));   msg.append("</kakaoprofile>\n");
					msg.append("		<kakaomsgblocked>");msg.append(result.getString("kakaomsgblocked"));msg.append("</kakaomsgblocked>\n");
					msg.append("		<kakaofriendkind>");msg.append(result.getString("kakaofriendkind"));msg.append("</kakaofriendkind>\n");

					msg.append("		<rtnstate>");		msg.append(result.getString("rtnstate"));		msg.append("</rtnstate>\n");
					msg.append("		<rtndate>");		msg.append(result.getString("rtndate").substring(0, 19));msg.append("</rtndate>\n");

					msg.append("		<helpdate>");		msg.append(result.getString("helpdate").substring(0, 19));msg.append("</helpdate>\n");
					msg.append("		<rentdate>");		msg.append(result.getString("rentdate").substring(0, 19));msg.append("</rentdate>\n");
					msg.append("	</flist>\n");
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
