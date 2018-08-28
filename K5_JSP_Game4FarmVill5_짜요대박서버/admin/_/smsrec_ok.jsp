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
	int subkind 		= util.getParamInt(request, "subkind", 20);
	int idx 			= util.getParamInt(request, "idx", -1);
	int gamekind		= util.getParamInt(request, "gamekind", 1);
	String comment 		= util.getParamStr(request, "comment", "");
	String url 			= util.getParamStr(request, "url", "");
	comment = getDBCheckURL(comment);
	url = getDBCheckURL(url);
	//out.println(branchurl + ":" + mboardurl);
		
	//2. 데이타 조작
	//exec spu_FarmD 20, -1, -1, 20, -1, 1, -1, -1, -1, -1, '', '', '', 'http://m.naver.com', '짜릿한 홈런리그한판 어떤가요?!!!'		--SMS URL 입력
	//exec spu_FarmD 20, -1, -1, 21, 1, 1, -1, -1, -1, -1, '', '', '', 'http://m.naver.com', '1짜릿한 홈런리그한판 어떤가요?!!!'		--SMS URL 수정
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 20);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, subkind);
	cstmt.setInt(idxColumn++, idx);
	cstmt.setInt(idxColumn++, gamekind);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);					
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, url);
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
		response.sendRedirect("smsrec_list.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('사용하실수 없습니다.'); history.back(-1);</script>");
	}
	/**/
%>
