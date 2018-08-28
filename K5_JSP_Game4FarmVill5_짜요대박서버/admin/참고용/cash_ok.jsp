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
	int idxColumn				= 1;
	String resultMsg			= "";

	//1-2. 데이타 받기
	int p1		 			= util.getParamInt(request, "p1", -1);
	int p2		 			= util.getParamInt(request, "p2", -1);
	int p3 					= util.getParamInt(request, "p3", -1);
	int p4 					= util.getParamInt(request, "p4", -1);
	int p5 					= util.getParamInt(request, "p5", -1);
	int p6 					= util.getParamInt(request, "p6", -1);
	int p7 					= util.getParamInt(request, "p7", -1);
	int p8 					= util.getParamInt(request, "p8", -1);
	int p9 					= util.getParamInt(request, "p9", -1);
	int p10					= util.getParamInt(request, "p10", -1);
	String ps1 				= util.getParamStr(request, "ps1", "");
	String ps2 				= util.getParamStr(request, "ps2", "");
	String ps3 				= util.getParamStr(request, "ps3", "");
	String ps4 				= util.getParamStr(request, "ps4", "");
	String ps5 				= util.getParamStr(request, "ps5", "");
	String ps6 				= util.getParamStr(request, "ps6", "");
	String ps7 				= util.getParamStr(request, "ps7", "");
	String ps8 				= util.getParamStr(request, "ps8", "");
	String ps9 				= util.getParamStr(request, "ps9", "");
	String ps10				= util.getParamStr(request, "ps10", "");

	//String msg2 = "";
	//msg2 += "<table border=1>";
	//msg2 += "<tr>";
	//msg2 += "	<td>" + p1 + "</td><td>" + p2 + "</td><td>" + p3 + "</td><td>" + p4 + "</td><td>" + p5 + "</td><td>" + p6 + "</td><td>" + p7 + "</td><td>" + p8 + "</td><td>" + p9 + "</td><td>" + p10 + "</td>";
	//msg2 += "</tr>";
	//msg2 += "<tr>";
	//msg2 += "	<td>" + ps1 + "</td><td>" + ps2 + "</td><td>" + ps3 + "</td><td>" + ps4 + "</td><td>" + ps5 + "</td><td>" + ps6 + "</td><td>" + ps7 + "</td><td>" + ps8 + "</td><td>" + ps9 + "</td><td>" + ps10 + "</td>";
	//msg2 += "</tr>";
	//msg2 += "</table>";
	//out.print(msg2);

	try{
		//2. 데이타 조작
		query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			resultMsg = result.getString(2);
		}

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}


    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

	if(resultCode == 1){
		response.sendRedirect("cashbuy_list.jsp?gameid="+ps1);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('"+resultMsg+"'); history.back(-1);</script>");
	}
	/**/
%>
