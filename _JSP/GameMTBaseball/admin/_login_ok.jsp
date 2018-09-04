<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_constant.jsp"%>
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
	String adminId 		= util.getParamStr(request, "adminId", "");
	String adminPW		= util.getParamStr(request, "adminPW", "");
	int adminGradeDB			= 0;

	try{
		//2. 데이타 조작
		//exec spu_FarmD 25, 2, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'a1s2d3f4', '', '', '', '', '', '', '', ''			-- 관리자 로그인
		query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");

		cstmt = conn.prepareCall(query.toString());
		
		cstmt.setInt(idxColumn++, KIND_ADMIN_LOGIN);
		cstmt.setInt(idxColumn++, 2);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, adminId);
		cstmt.setString(idxColumn++, adminPW);
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			adminGradeDB = result.getInt("grade");
		}
		
  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	
	if(resultCode == 1){
		session.setAttribute("adminId", adminId.trim());
		session.setAttribute("adminGrade", adminGradeDB);
		response.sendRedirect("_admin.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('아이디나 패스워드가 일치하지 않습니다.'); history.back(-1);</script>");
	}
	/**/
%>
