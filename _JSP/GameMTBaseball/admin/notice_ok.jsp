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


	//1-2. 데이타 받기
	int subkind 		= util.getParamInt(request, "subkind", 0);
	int idx				= util.getParamInt(request, "idx", 0);
	int version 		= util.getParamInt(request, "version", 0);
	int syscheck 		= util.getParamInt(request, "syscheck", 0);

	String comfile1 	= util.getParamStr(request, "comfile1", "");
	String comurl1 		= util.getParamStr(request, "comurl1", "");
	String comfile2 	= util.getParamStr(request, "comfile2", "");
	String comurl2 		= util.getParamStr(request, "comurl2", "");
	String comfile3 	= util.getParamStr(request, "comfile3", "");
	String comurl3		= util.getParamStr(request, "comurl3", "");
	String comfile4 	= util.getParamStr(request, "comfile4", "");
	String comurl4 		= util.getParamStr(request, "comurl4", "");
	String comfile5 	= util.getParamStr(request, "comfile5", "");
	String comurl5		= util.getParamStr(request, "comurl5", "");
	String patchurl 	= util.getParamStr(request, "patchurl", "");
	String comment		= util.getParamStr(request, "comment", "");

	comfile1 		= getDBCheckURL(comfile1);
	comurl1 			= getDBCheckURL(comurl1);
	comfile2 		= getDBCheckURL(comfile2);
	comurl2 		= getDBCheckURL(comurl2);
	comfile3 		= getDBCheckURL(comfile3);
	comurl3 		= getDBCheckURL(comurl3);
	comfile4 		= getDBCheckURL(comfile4);
	comurl4 		= getDBCheckURL(comurl4);
	comfile5 		= getDBCheckURL(comfile5);
	comurl5 		= getDBCheckURL(comurl5);
	patchurl 		= getDBCheckURL(patchurl);
	comment	 		= getDBCheckURL(comment);
	//out.print("<br>comment:" + comment);

	try{
		//2. 데이타 조작
		query.append("{ call dbo.spu_GameMTBaseballD2 (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");

		cstmt = conn.prepareCall(query.toString());

		cstmt.setInt(idxColumn++, KIND_NOTICE_SETTING);
		cstmt.setInt(idxColumn++, subkind);
		cstmt.setInt(idxColumn++, idx);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, version);
		cstmt.setInt(idxColumn++, syscheck);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, comfile1);
		cstmt.setString(idxColumn++, comurl1);
		cstmt.setString(idxColumn++, comfile2);
		cstmt.setString(idxColumn++, comurl2);
		cstmt.setString(idxColumn++, comfile3);
		cstmt.setString(idxColumn++, comurl3);
		cstmt.setString(idxColumn++, comfile4);
		cstmt.setString(idxColumn++, comurl4);
		cstmt.setString(idxColumn++, comfile5);
		cstmt.setString(idxColumn++, comurl5);
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, patchurl);
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, comment);

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			//resultCode = result.getInt("rtn");
			resultCode = 1;
		}

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

	if(resultCode == 1){
		response.sendRedirect("notice_list.jsp?idx="+idx+"#"+idx);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('사용하실수 없습니다.'); history.back(-1);</script>");
	}
	/**/
%>
