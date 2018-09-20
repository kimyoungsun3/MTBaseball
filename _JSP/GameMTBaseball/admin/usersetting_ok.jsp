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
	String resultComment		= "";

	//1-2. 데이타 받기
	String gameid 			= util.getParamStr(request, "gameid", "");
	String branch			= util.getParamStr(request, "branch", "userinfo_list");
	int idx					= util.getParamInt(request, "idx", -1);

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

	ps3	 					= getDBCheckURL(ps3);
	ps10	 				= getDBCheckURL(ps10);

	//String msg2 = "branch:" + branch + " gameid:" + gameid + "<br>";
	//msg2 += "<table border=1>";
	//msg2 += "<tr>";
	//msg2 += "	<td>p1</td><td>p2</td><td>p3</td><td>p4</td><td>p5</td><td>p6</td><td>p7</td><td>p8</td><td>p9</td><td>p10</td>";
	//msg2 += "</tr>";
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
		//exec spu_GameMTBaseballD 27, 21, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 선물, 메세지 삭제
		query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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
			resultCode 		= result.getInt("rtn");
			resultComment	= result.getString("commentX");
		}

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}


    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

	if(resultCode == 1){
		if(gameid.equals("")){
			if(idx == -1){
				response.sendRedirect(branch + ".jsp");
			}else{
				response.sendRedirect(branch + ".jsp?idx=" + idx + "#" + idx);
			}
		}else{
			if(idx == -1){
				response.sendRedirect(branch + ".jsp?gameid=" + gameid);
			}else{
				response.sendRedirect(branch + ".jsp?gameid=" + gameid + "&idx=" + idx + "#" + idx);
			}
		}
	}else if(resultCode == -1){
		if(!resultComment.equals("")){
			out.print("<script language='javascript'>alert('"+resultComment+"'); history.back(-1);</script>");
		}else{
			out.print("<script language='javascript'>alert('정보가 부정확합니다.'); history.back(-1);</script>");
		}
	}else if(resultCode == -13){
		out.print("<script language='javascript'>alert('계정 정보가 존재하지 않습니다.'); history.back(-1);</script>");
	}else if(resultCode == -201){
		out.print("<script language='javascript'>alert('ip가 중복입니다.'); history.back(-1);</script>");
	}
	/**/
%>
