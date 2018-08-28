<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
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
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;

	//if(bExpire){
	//	out.print("사용불가");
	//	return;
	//}
	//1-2. 데이타 받기
	int kind 			= util.getParamInt(request, "kind", 0);
	int sendkind 		= util.getParamInt(request, "sendkind", 1);
	int telkind 		= util.getParamInt(request, "telkind", -1);
	int personal 		= util.getParamInt(request, "personal", -1);
	int p5 				= util.getParamInt(request, "p5", -1);

	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String title 		= util.getParamStr(request, "title", "");
	String content 		= util.getParamStr(request, "content", "");
	String branchurl 	= util.getParamStr(request, "branchurl", "");
	String scheduleTime	= util.getParamStr(request, "scheduleTime", "2014-01-01");
	int cnt = 0;

	title = getDBCheckURL(title);
	content = getDBCheckURL(content);
	//branchurl = getDBCheckURL(branchurl);

	//out.println(
	//			"kind:" + kind + "<br>"
	//			+ "sendkind:" + sendkind + "<br>"
	//			+ "telkind:" + telkind + "<br>"
	//			+ "gameid:" + gameid + "<br>"
	//			+ "title:" + title + "<br>"
	//			+ "content:" + content + "<br>"
	//			+ "branchurl:" + branchurl + "<br>"
	//			);


	try{

		//2. 데이타 조작
		//유저세팅변경(19)
		//--exec spu_FVFarmD 30, 32,  1, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '', '', '', '', ''	-- Push 개별.
		//--exec spu_FVFarmD 30, 32,  3, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '', '', '', '', ''
		//--exec spu_FVFarmD 30, 33,  1,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '', '', '', '', ''		-- Push 전체.
		//--exec spu_FVFarmD 30, 33,  3,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '', '', '', '', ''
		query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, kind);
		cstmt.setInt(idxColumn++, sendkind);
		cstmt.setInt(idxColumn++, telkind);
		cstmt.setInt(idxColumn++, p5);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, adminid);
		cstmt.setString(idxColumn++, title);
		cstmt.setString(idxColumn++, content);
		cstmt.setString(idxColumn++, branchurl);
		cstmt.setString(idxColumn++, scheduleTime);
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
		}
  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

	if(resultCode == 1){
		response.sendRedirect("push_list.jsp?gameid="+gameid+"&personal="+personal);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('정보가 부정확합니다.'); history.back(-1);</script>");
	}
	/**/
%>
