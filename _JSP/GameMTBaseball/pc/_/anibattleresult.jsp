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
	String battleidx2		= util.getParamStr(request, "battleidx2", "-1");
	String gresult			= util.getParamStr(request, "result", "0");
	String playtime			= util.getParamStr(request, "playtime", "0");
	String star				= util.getParamStr(request, "star", "1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &battleidx2:" 	+ battleidx2);
		DEBUG_LOG_STR.append("\r\n &result:" 		+ gresult);
		DEBUG_LOG_STR.append("\r\n &playtime:" 		+ playtime);
		DEBUG_LOG_STR.append("\r\n &star:" 			+ star);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////
	try{
		//2. 데이타 조작
		//exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 64,  1, 90, 3, -1
		query.append("{ call dbo.spu_AniBattleResult (?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, battleidx2);
		cstmt.setString(idxColumn++, gresult);
		cstmt.setString(idxColumn++, playtime);
		cstmt.setString(idxColumn++, star);
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
		msg.append("		<code>");			msg.append(PTS_ANIBATTLERESULT); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());				msg.append("</resultmsg>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    		msg.append("</gamecost>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    		msg.append("</cashcost>\n");
		msg.append("		<heart>");			msg.append(result.getInt("heart"));    			msg.append("</heart>\n");
		msg.append("		<feed>");			msg.append(result.getInt("feed"));    			msg.append("</feed>\n");
		msg.append("		<fpoint>");			msg.append(result.getInt("fpoint"));    		msg.append("</fpoint>\n");
		msg.append("		<goldticket>");		msg.append(result.getInt("goldticket"));    	msg.append("</goldticket>\n");
		msg.append("		<goldticketmax>");	msg.append(result.getInt("goldticketmax"));    	msg.append("</goldticketmax>\n");
		msg.append("		<goldtickettime>");	msg.append(result.getString("goldtickettime").substring(0, 19));msg.append("</goldtickettime>\n");
		msg.append("		<battleticket>");	msg.append(result.getInt("battleticket"));    	msg.append("</battleticket>\n");
		msg.append("		<battleticketmax>");msg.append(result.getInt("battleticketmax"));   msg.append("</battleticketmax>\n");
		msg.append("		<battletickettime>");msg.append(result.getString("battletickettime").substring(0, 19));msg.append("</battletickettime>\n");

		msg.append("		<reward1>");		msg.append(result.getInt("reward1"));    		msg.append("</reward1>\n");
		msg.append("		<reward2>");		msg.append(result.getInt("reward2"));    		msg.append("</reward2>\n");
		msg.append("		<reward3>");		msg.append(result.getInt("reward3"));    		msg.append("</reward3>\n");
		msg.append("		<reward4>");		msg.append(result.getInt("reward4"));    		msg.append("</reward4>\n");
		msg.append("		<reward5>");		msg.append(result.getInt("rewardgoldticket"));	msg.append("</reward5>\n");
		msg.append("		<rewardgamecost>");	msg.append(result.getInt("rewardgamecost"));   	msg.append("</rewardgamecost>\n");
		msg.append("		<totalstar>");		msg.append(result.getInt("star"));				msg.append("</totalstar>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-3. 유저 보유 아이템 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<itemowner>\n");
					msg.append("		<listidx>");		msg.append(result.getString("listidx"));   		msg.append("</listidx>\n");
					msg.append("		<invenkind>");		msg.append(result.getString("invenkind"));   	msg.append("</invenkind>\n");
					msg.append("		<fieldidx>");		msg.append(result.getString("fieldidx"));   	msg.append("</fieldidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));   			msg.append("</cnt>\n");
					msg.append("		<anistep>");		msg.append(result.getString("anistep"));   		msg.append("</anistep>\n");
					msg.append("		<manger>");			msg.append(result.getString("manger"));   		msg.append("</manger>\n");
					msg.append("		<diseasestate>");	msg.append(result.getString("diseasestate"));   msg.append("</diseasestate>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1"));   		msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2"));   		msg.append("</acc2>\n");
					msg.append("		<randserial>");		msg.append(result.getString("randserial"));   	msg.append("</randserial>\n");
					msg.append("		<petupgrade>");		msg.append(result.getString("petupgrade"));   	msg.append("</petupgrade>\n");
					msg.append("		<treasureupgrade>");msg.append(result.getString("treasureupgrade"));msg.append("</treasureupgrade>\n");
					msg.append("		<needhelpcnt>");	msg.append(result.getString("needhelpcnt"));   	msg.append("</needhelpcnt>\n");

					msg.append("		<upcnt>");			msg.append(result.getString("upcnt"));   		msg.append("</upcnt>\n");
					msg.append("		<upstepmax>");		msg.append(result.getString("upstepmax"));   	msg.append("</upstepmax>\n");
					msg.append("		<freshstem100>");	msg.append(result.getString("freshstem100"));  	msg.append("</freshstem100>\n");
					msg.append("		<attstem100>");		msg.append(result.getString("attstem100"));   	msg.append("</attstem100>\n");
					msg.append("		<timestem100>");	msg.append(result.getString("timestem100"));   	msg.append("</timestem100>\n");
					msg.append("		<defstem100>");		msg.append(result.getString("defstem100"));   	msg.append("</defstem100>\n");
					msg.append("		<hpstem100>");		msg.append(result.getString("hpstem100"));   	msg.append("</hpstem100>\n");

					//쿠폰만기일.
					msg.append("		<expirekind>");		msg.append(result.getString("expirekind"));   	msg.append("</expirekind>\n");
					msg.append("		<expiredate>");		msg.append(result.getString("expiredate").substring(0, 19));   	msg.append("</expiredate>\n");
					msg.append("	</itemowner>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n ?gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n &battleidx2:" 	+ battleidx2);
		DEBUG_LOG_STR.append("\r\n &gresult:" 		+ gresult);
		DEBUG_LOG_STR.append("\r\n &playtime:" 		+ playtime);
		DEBUG_LOG_STR.append("\r\n &star:" 			+ star);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/**/

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
