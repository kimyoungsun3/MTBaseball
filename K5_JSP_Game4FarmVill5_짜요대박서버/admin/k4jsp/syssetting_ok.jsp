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
	String branch				= util.getParamStr(request, "branch", "notice_list");


	//1-2. 데이타 받기
	int p1 			= util.getParamInt(request, "p1", KIND_NOTICE_SETTING);
	int p2 			= util.getParamInt(request, "p2", 0);
	int p3			= util.getParamInt(request, "p3", 0);
	int p4 			= util.getParamInt(request, "p4", 0);
	int p5 			= util.getParamInt(request, "p5", 0);
	int p6 			= util.getParamInt(request, "p6", 0);
	int p7 			= util.getParamInt(request, "p7", 0);
	int p8 			= util.getParamInt(request, "p8", 0);
	int p9 			= util.getParamInt(request, "p9", 0);
	int p10 		= util.getParamInt(request, "p10", 0);
	int p11 		= util.getParamInt(request, "p11", 0);
	int p12 		= util.getParamInt(request, "p12", 0);
	int p13			= util.getParamInt(request, "p13", 0);
	int p14 		= util.getParamInt(request, "p14", -1);
	int p15 		= util.getParamInt(request, "p15", -1);

	String ps1 		= util.getParamStr(request, "ps1", "");
	String ps2 		= util.getParamStr(request, "ps2", "");
	String ps3 		= util.getParamStr(request, "ps3", "");
	String ps4 		= util.getParamStr(request, "ps4", "");
	String ps5 		= util.getParamStr(request, "ps5", "");
	String ps6 		= util.getParamStr(request, "ps6", "");
	String ps7 		= util.getParamStr(request, "ps7", "");
	String ps8 		= util.getParamStr(request, "ps8", "");
	String ps9		= util.getParamStr(request, "ps9", "");
	String ps10 	= util.getParamStr(request, "ps10", "");
	String ps11 	= util.getParamStr(request, "ps11", "");
	String ps12 	= util.getParamStr(request, "ps12", "");
	String ps13		= util.getParamStr(request, "ps13", "");
	String ps14		= util.getParamStr(request, "ps14", "");
	String ps15		= util.getParamStr(request, "ps15", "");

	ps1 		= getDBCheckURL(ps1);
	ps2 		= getDBCheckURL(ps2);
	ps3 		= getDBCheckURL(ps3);
	ps4 		= getDBCheckURL(ps4);
	ps5 		= getDBCheckURL(ps5);
	ps6 		= getDBCheckURL(ps6);
	ps7 		= getDBCheckURL(ps7);
	ps8 		= getDBCheckURL(ps8);
	ps9 		= getDBCheckURL(ps9);
	ps10 		= getDBCheckURL(ps10);
	ps11 		= getDBCheckURL(ps11);
	ps12 		= getDBCheckURL(ps12);
	ps13 		= getDBCheckURL(ps13);
	ps14 		= getDBCheckURL(ps14);
	ps15 		= getDBCheckURL(ps15);

	//out.println(					"<br>p2:" + p2			+ "<br>p3:" + p3
    //
	//			+ "<br><br>p4:" + p4	+ "<br>p5:" + p5		+ "<br>ps4:" + ps4		+ "<br>ps5:" + ps5
	//	  	  	+ "<br>p6:" + p6		+ "<br>p7:" + p7		+ "<br>ps6:" + ps6		+ "<br>ps7:" + ps7
	//	  	  	+ "<br>p8:" + p8		+ "<br>p9:" + p9		+ "<br>ps8:" + ps8		+ "<br>ps9:" + ps9
	//	  	  	+ "<br>p10:" + p10		+ "<br>p11:" + p11		+ "<br>ps10:" + ps10 	+ "<br>ps11:" + ps11
	//	  	  	+ "<br>p12:" + p12		+ "<br>p13:" + p13		+ "<br>ps12:" + ps12	+ "<br>ps13:" + ps13
	//	  	  );

	try{
		//2. 데이타 조작
		//exec spu_FVFarmD2 20,10,  5, 100,  1, -1,  0, -1,  0, -1,  0, -1,  0, -1, -1, '', '', '', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.daum.com', '',	'', '', '', '', '', '', '', '', ''		-- 입력
		//exec spu_FVFarmD2 20,11,  1, 100,  2, -1,  0, -1,  0, -1,  0, -1,  0, -1, -1, '', '', '', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.daum.com', '',	'', '', '', '', '', '', '', '', ''		-- 수정
		query.append("{ call dbo.spu_FVFarmD2 (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");

		cstmt = conn.prepareCall(query.toString());

		cstmt.setInt(idxColumn++, p1);
		cstmt.setInt(idxColumn++, p2);
		cstmt.setInt(idxColumn++, p3);
		cstmt.setInt(idxColumn++, p4);
		cstmt.setInt(idxColumn++, p5);
		cstmt.setInt(idxColumn++, p6);
		cstmt.setInt(idxColumn++, p7);
		cstmt.setInt(idxColumn++, p8);
		cstmt.setInt(idxColumn++, p9);
		cstmt.setInt(idxColumn++, p10);
		cstmt.setInt(idxColumn++, p11);
		cstmt.setInt(idxColumn++, p12);
		cstmt.setInt(idxColumn++, p13);
		cstmt.setInt(idxColumn++, p14);
		cstmt.setInt(idxColumn++, p15);
		cstmt.setString(idxColumn++, ps1);
		cstmt.setString(idxColumn++, ps2);
		cstmt.setString(idxColumn++, ps3);
		cstmt.setString(idxColumn++, ps4);
		cstmt.setString(idxColumn++, ps5);
		cstmt.setString(idxColumn++, ps6);
		cstmt.setString(idxColumn++, ps7);
		cstmt.setString(idxColumn++, ps8);
		cstmt.setString(idxColumn++, ps9);
		cstmt.setString(idxColumn++, ps10);
		cstmt.setString(idxColumn++, ps11);
		cstmt.setString(idxColumn++, ps12);
		cstmt.setString(idxColumn++, ps13);
		cstmt.setString(idxColumn++, ps14);
		cstmt.setString(idxColumn++, ps15);

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
	/**/

    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

	if(resultCode == 1){
		response.sendRedirect(branch + ".jsp?idx="+p3+"#"+p3);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('사용하실수 없습니다.'); history.back(-1);</script>");
	}
	/**/
%>
