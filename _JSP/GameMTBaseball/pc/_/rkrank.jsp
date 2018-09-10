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
	int idx						= 1;

	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "");
	String password 	= util.getParamStr(request, "password", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////
	try{
		//2. 데이타 조작
		//exec spu_RKRank 'xxxx2', '049000s1i0n7t8445289', -1
		query.append("{ call dbo.spu_RKRank (?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.registerOutParameter(idx++, Types.INTEGER);

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
		msg.append("		<code>");			msg.append(PTS_RKRANK); 						msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    			msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-4. 내정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<userinfo>\n");
					//랭킹대전참여팀.
					msg.append("		<rkstartstate>");	msg.append(result.getString("rkstartstate"));	msg.append("</rkstartstate>\n");
					msg.append("		<rkteam>");			msg.append(result.getString("rkteam")); 		msg.append("</rkteam>\n");
					msg.append("		<rksalemoney>");	msg.append(result.getString("rksalemoney")); 	msg.append("</rksalemoney>\n");
					msg.append("		<rksalebarrel>");	msg.append(result.getString("rksalebarrel")); 	msg.append("</rksalebarrel>\n");
					msg.append("		<rkbattlecnt>");	msg.append(result.getString("rkbattlecnt")); 	msg.append("</rkbattlecnt>\n");
					msg.append("		<rkbogicnt>");		msg.append(result.getString("rkbogicnt")); 		msg.append("</rkbogicnt>\n");
					msg.append("		<rkfriendpoint>");	msg.append(result.getString("rkfriendpoint")); 	msg.append("</rkfriendpoint>\n");
					msg.append("		<rkroulettecnt>");	msg.append(result.getString("rkroulettecnt")); 	msg.append("</rkroulettecnt>\n");
					msg.append("		<rkwolfcnt>");		msg.append(result.getString("rkwolfcnt")); 		msg.append("</rkwolfcnt>\n");
					msg.append("	</userinfo>\n");
				}
			}

			//2-3-4. 홀짝랭킹(현재)
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<rkcurrank>\n");
					msg.append("		<rkdateid8>");		msg.append(result.getString("rkdateid8"));   	msg.append("</rkdateid8>\n");
					msg.append("		<rkteam1>");		msg.append(result.getString("rkteam1"));   		msg.append("</rkteam1>\n");
					msg.append("		<rkteam0>");		msg.append(result.getString("rkteam0"));   		msg.append("</rkteam0>\n");
					msg.append("		<rksalemoney>");	msg.append(result.getString("rksalemoney"));   	msg.append("</rksalemoney>\n");
					msg.append("		<rksalebarrel>");	msg.append(result.getString("rksalebarrel"));   msg.append("</rksalebarrel>\n");
					msg.append("		<rkbattlecnt>");	msg.append(result.getString("rkbattlecnt"));   	msg.append("</rkbattlecnt>\n");
					msg.append("		<rkbogicnt>");		msg.append(result.getString("rkbogicnt"));   	msg.append("</rkbogicnt>\n");
					msg.append("		<rkfriendpoint>");	msg.append(result.getString("rkfriendpoint"));  msg.append("</rkfriendpoint>\n");
					msg.append("		<rkroulettecnt>");	msg.append(result.getString("rkroulettecnt"));  msg.append("</rkroulettecnt>\n");
					msg.append("		<rkwolfcnt>");		msg.append(result.getString("rkwolfcnt"));   	msg.append("</rkwolfcnt>\n");

					msg.append("		<rksalemoney2>");	msg.append(result.getString("rksalemoney2"));   msg.append("</rksalemoney2>\n");
					msg.append("		<rksalebarrel2>");	msg.append(result.getString("rksalebarrel2"));  msg.append("</rksalebarrel2>\n");
					msg.append("		<rkbattlecnt2>");	msg.append(result.getString("rkbattlecnt2"));   	msg.append("</rkbattlecnt2>\n");
					msg.append("		<rkbogicnt2>");		msg.append(result.getString("rkbogicnt2"));   	msg.append("</rkbogicnt2>\n");
					msg.append("		<rkfriendpoint2>");	msg.append(result.getString("rkfriendpoint2")); msg.append("</rkfriendpoint2>\n");
					msg.append("		<rkroulettecnt2>");	msg.append(result.getString("rkroulettecnt2")); msg.append("</rkroulettecnt2>\n");
					msg.append("		<rkwolfcnt2>");		msg.append(result.getString("rkwolfcnt2"));   	msg.append("</rkwolfcnt2>\n");
					msg.append("	</rkcurrank>\n");
				}
			}

			//2-3-4. 홀짝랭킹(지난)
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<rklaterank>\n");
					msg.append("		<rkdateid8>");		msg.append(result.getString("rkdateid8"));   	msg.append("</rkdateid8>\n");
					msg.append("		<rkteam1>");		msg.append(result.getString("rkteam1"));   		msg.append("</rkteam1>\n");
					msg.append("		<rkteam0>");		msg.append(result.getString("rkteam0"));   		msg.append("</rkteam0>\n");
					msg.append("		<rksalemoney>");	msg.append(result.getString("rksalemoney"));   	msg.append("</rksalemoney>\n");
					msg.append("		<rksalebarrel>");	msg.append(result.getString("rksalebarrel"));   msg.append("</rksalebarrel>\n");
					msg.append("		<rkbattlecnt>");		msg.append(result.getString("rkbattlecnt"));   	msg.append("</rkbattlecnt>\n");
					msg.append("		<rkbogicnt>");		msg.append(result.getString("rkbogicnt"));   	msg.append("</rkbogicnt>\n");
					msg.append("		<rkfriendpoint>");	msg.append(result.getString("rkfriendpoint"));  msg.append("</rkfriendpoint>\n");
					msg.append("		<rkroulettecnt>");	msg.append(result.getString("rkroulettecnt"));  msg.append("</rkroulettecnt>\n");
					msg.append("		<rkwolfcnt>");		msg.append(result.getString("rkwolfcnt"));   	msg.append("</rkwolfcnt>\n");

					msg.append("		<rksalemoney2>");	msg.append(result.getString("rksalemoney2"));   msg.append("</rksalemoney2>\n");
					msg.append("		<rksalebarrel2>");	msg.append(result.getString("rksalebarrel2"));  msg.append("</rksalebarrel2>\n");
					msg.append("		<rkbattlecnt2>");	msg.append(result.getString("rkbattlecnt2"));   	msg.append("</rkbattlecnt2>\n");
					msg.append("		<rkbogicnt2>");		msg.append(result.getString("rkbogicnt2"));   	msg.append("</rkbogicnt2>\n");
					msg.append("		<rkfriendpoint2>");	msg.append(result.getString("rkfriendpoint2")); msg.append("</rkfriendpoint2>\n");
					msg.append("		<rkroulettecnt2>");	msg.append(result.getString("rkroulettecnt2")); msg.append("</rkroulettecnt2>\n");
					msg.append("		<rkwolfcnt2>");		msg.append(result.getString("rkwolfcnt2"));   	msg.append("</rkwolfcnt2>\n");
					msg.append("	</rklaterank>\n");
				}
			}
		}
		/**/
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/**/

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
