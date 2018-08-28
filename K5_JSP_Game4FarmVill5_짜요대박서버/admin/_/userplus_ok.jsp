<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
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
	
	if(bExpire){
		out.print("사용불가");
		return;
	}
	
	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	int mode 			= util.getParamInt(request, "mode", 0);
	int value			= util.getParamInt(request, "value", 0);	
	int plusgoldball	= 0;
	int plussilverball	= 0;
	int plusactioncount = util.getParamInt(request, "plusactioncount", 0);
	if(mode==0){
		plusgoldball = value;
		if(plusgoldball > 1000){
			plusgoldball = 1000;
		}else if(plusgoldball < 0){
			plusgoldball = -plusgoldball;
		}
	}else{
		plussilverball = value;
		if(plussilverball > 100000){
			plussilverball = 100000;
		}else if(plussilverball < 0){
			plussilverball = -plussilverball;
		}
	}
	
	
	
	//2. 데이타 조작
	//exec spu_FarmD 16, -1, -1, 123, 123, -1, -1, -1, -1, -1, 'SangSang', '', '', '', ''
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 16);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, plusgoldball);
	cstmt.setInt(idxColumn++, plussilverball);
	cstmt.setInt(idxColumn++, plusactioncount);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);					
	cstmt.setString(idxColumn++, gameid);
	cstmt.setString(idxColumn++, adminid);
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	
	//2-2. 스토어즈 프로시져 실행하기
	result = cstmt.executeQuery();	
		 
	//2-3-1. 코드결과값 받기(1개)
	if(result.next()){
		resultCode = result.getInt("rtn");
	}
  
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);	



	if(resultCode == 1){
		response.sendRedirect("userinfo_list.jsp?gameid="+gameid);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('사용하실수 없습니다.'); history.back(-1);</script>");
	}
	/**/
%>
