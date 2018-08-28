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
	int subkind 		= util.getParamInt(request, "subkind", 60);	
	int btrevitemcode	= util.getParamInt(request, "btrevitemcode", 7020);
	int btrevprice		= util.getParamInt(request, "btrevprice", 5);
	int msrevitemcode4	= util.getParamInt(request, "msrevitemcode4", 7021);
	int msrevprice4		= util.getParamInt(request, "msrevprice4", 5);
	int msrevitemcode7	= util.getParamInt(request, "msrevitemcode7", 7022);
	int msrevprice7		= util.getParamInt(request, "msrevprice7", 7);
	int msrevitemcode8	= util.getParamInt(request, "msrevitemcode8", 7023);
	int msrevprice8		= util.getParamInt(request, "msrevprice8", 20);
	int msrevitemcode9	= util.getParamInt(request, "msrevitemcode9", 7024);
	int msrevprice9		= util.getParamInt(request, "msrevprice9", 50);
	String comment 		= util.getParamStr(request, "comment", "내용없음");
	
	comment = getDBCheckURL(comment);
	
		
	//2. 데이타 조작
	//exec spu_FarmD 20, -1, -1, 60, 7020, 5, 7021, 5, 7022, 7, '7023', '20', '7024', '50', '내용'	--업그레이드 세팅
	//exec spu_FarmD 20, -1,  1, 61, 7020, 15, 7021, 15, 7022, 17, '7023', '120', '7024', '150', '내용'	--업그레이드 세팅
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 20);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, idx);
	cstmt.setInt(idxColumn++, subkind);
	cstmt.setInt(idxColumn++, btrevitemcode);
	cstmt.setInt(idxColumn++, btrevprice);
	cstmt.setInt(idxColumn++, msrevitemcode4);
	cstmt.setInt(idxColumn++, msrevprice4);
	cstmt.setInt(idxColumn++, msrevitemcode7);
	cstmt.setInt(idxColumn++, msrevprice7);					
	cstmt.setString(idxColumn++, ""+msrevitemcode8);
	cstmt.setString(idxColumn++, ""+msrevprice8);
	cstmt.setString(idxColumn++, ""+msrevitemcode9);
	cstmt.setString(idxColumn++, ""+msrevprice9);
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
		response.sendRedirect("revmode_list.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('사용하실수 없습니다.'); history.back(-1);</script>");
	}
	/**/
%>
