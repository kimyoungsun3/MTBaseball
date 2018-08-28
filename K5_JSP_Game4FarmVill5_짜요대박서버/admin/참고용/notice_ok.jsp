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
	int market 			= util.getParamInt(request, "market", SKT);
	int buytype 		= util.getParamInt(request, "buytype", 0);
	int version 		= util.getParamInt(request, "version", 0);
	int syscheck 		= util.getParamInt(request, "syscheck", 0);

	String comfile 		= util.getParamStr(request, "comfile", "");
	String comurl 		= util.getParamStr(request, "comurl", "");
	String comfile2 	= util.getParamStr(request, "comfile2", "");
	String comurl2 		= util.getParamStr(request, "comurl2", "");
	String comfile3 	= util.getParamStr(request, "comfile3", "");
	String comurl3		= util.getParamStr(request, "comurl3", "");
	String comfile4 	= util.getParamStr(request, "comfile4", "");
	String comurl4 		= util.getParamStr(request, "comurl4", "");
	String comfile5 	= util.getParamStr(request, "comfile5", "");
	String comurl5		= util.getParamStr(request, "comurl5", "");
	String patchurl 	= util.getParamStr(request, "patchurl", "");
	String recurl		= util.getParamStr(request, "recurl", "");
	int iteminfover		= util.getParamInt(request, "iteminfover", 100);	//현재 사용안함
	String iteminfourl	= util.getParamStr(request, "iteminfourl", "");
	String comment		= util.getParamStr(request, "comment", "");

	comfile 		= getDBCheckURL(comfile);
	comurl 			= getDBCheckURL(comurl);
	comfile2 		= getDBCheckURL(comfile2);
	comurl2 		= getDBCheckURL(comurl2);
	comfile3 		= getDBCheckURL(comfile3);
	comurl3 		= getDBCheckURL(comurl3);
	comfile4 		= getDBCheckURL(comfile4);
	comurl4 		= getDBCheckURL(comurl4);
	comfile5 		= getDBCheckURL(comfile5);
	comurl5 		= getDBCheckURL(comurl5);
	patchurl 		= getDBCheckURL(patchurl);
	recurl	 		= getDBCheckURL(recurl);
	iteminfourl	 	= getDBCheckURL(iteminfourl);
	comment	 		= getDBCheckURL(comment);
	//out.print("<br>iteminfourl:" + iteminfourl);
	//out.print("<br>comment:" + comment);

	try{
		//2. 데이타 조작
		//exec spu_FVFarmD2 20, 0, -1, 1, 0, 101, 0, -1, -1, -1, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr',	'http://www.ubx.co.kr', 'http://clien.career.co.kr', '', ''		-- 작성
		//exec spu_FVFarmD2 20, 1,  6, 1, 0, 101, 0, -1, -1, -1, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr',	'http://www.ubx.co.kr', 'http://clien.career.co.kr', '', ''		-- 수정
		query.append("{ call dbo.spu_FVFarmD2 (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");

		cstmt = conn.prepareCall(query.toString());

		cstmt.setInt(idxColumn++, KIND_NOTICE_SETTING);
		cstmt.setInt(idxColumn++, subkind);
		cstmt.setInt(idxColumn++, idx);
		cstmt.setInt(idxColumn++, market);
		cstmt.setInt(idxColumn++, buytype);
		cstmt.setInt(idxColumn++, version);
		cstmt.setInt(idxColumn++, syscheck);
		cstmt.setInt(idxColumn++, iteminfover);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, comfile);
		cstmt.setString(idxColumn++, comurl);
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
		cstmt.setString(idxColumn++, recurl);
		cstmt.setString(idxColumn++, iteminfourl);
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
