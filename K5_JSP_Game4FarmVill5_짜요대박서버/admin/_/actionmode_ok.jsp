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
	int idx 			= util.getParamInt(request, "idx", 1);	
	int subkind 		= util.getParamInt(request, "subkind", 70);	
	int halfmodeprice	= util.getParamInt(request, "halfmodeprice", 6);
	int fullmodeprice	= util.getParamInt(request, "fullmodeprice", 10);
	int freemodeprice	= util.getParamInt(request, "freemodeprice", 50);
	int freemodeperiod	= util.getParamInt(request, "freemodeperiod", 1);
	int plusgoldball	= util.getParamInt(request, "plusgoldball", 0);
	int plussilverball	= util.getParamInt(request, "plussilverball", 0);
	String comment 		= util.getParamStr(request, "comment", "내용없음");
	
	comment = getDBCheckURL(comment);
	
		
	//2. 데이타 조작
	//exec spu_FarmD 20, -1, -1, 70, 6, 10, 50, 1, -1, -1, '', '', '', '', '내용'		-- 스테미너 > 입력
	//exec spu_FarmD 20, -1,  1, 71, 6, 10, 50, 1, -1, -1, '', '', '', '', '내용'		-- > 수정
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 20);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, idx);
	cstmt.setInt(idxColumn++, subkind);
	cstmt.setInt(idxColumn++, halfmodeprice);
	cstmt.setInt(idxColumn++, fullmodeprice);
	cstmt.setInt(idxColumn++, freemodeprice);
	cstmt.setInt(idxColumn++, freemodeperiod);
	cstmt.setInt(idxColumn++, plusgoldball);
	cstmt.setInt(idxColumn++, plussilverball);					
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
  
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);	



	if(resultCode == 1){
		response.sendRedirect("actionmode_list.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('사용하실수 없습니다.'); history.back(-1);</script>");
	}
	/**/
%>
