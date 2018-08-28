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
	int questcode 		= util.getParamInt(request, "questcode", 0);
	int questkind 		= util.getParamInt(request, "questkind", 0);
	int questsubkind 	= util.getParamInt(request, "questsubkind", 0);
	int questvalue 		= util.getParamInt(request, "questvalue", 0);
	int rewardsb 		= util.getParamInt(request, "rewardsb", 0);
	int rewarditem 		= util.getParamInt(request, "rewarditem", 0);
	int questtime 		= util.getParamInt(request, "questtime", 0);
	int questinit 		= util.getParamInt(request, "questinit", 0);
	int questclear 		= util.getParamInt(request, "questclear", 0);
	int questorder 		= util.getParamInt(request, "questorder", 0);
	String content		= util.getParamStr(request, "content", "내용무");
	int questlv 		= util.getParamInt(request, "questlv", 1);
	
	//2. 데이타 조작
	//exec spu_FarmD 24, 2, 100, 100, 2, 20, 750, -1, 0, 1, '0', '100', '', '', 'xxxx'		--퀘스트 수정
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 24);
	cstmt.setInt(idxColumn++, 2);
	cstmt.setInt(idxColumn++, questcode);
	cstmt.setInt(idxColumn++, questkind);
	cstmt.setInt(idxColumn++, questsubkind);
	cstmt.setInt(idxColumn++, questvalue);
	cstmt.setInt(idxColumn++, rewardsb);
	cstmt.setInt(idxColumn++, rewarditem);	
	cstmt.setInt(idxColumn++, questtime);	
	cstmt.setInt(idxColumn++, questinit);
	cstmt.setString(idxColumn++, "" + questclear);
	cstmt.setString(idxColumn++, "" + questorder);		
	cstmt.setString(idxColumn++, "" + questlv);	
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, content);
	
	//2-2. 스토어즈 프로시져 실행하기
	result = cstmt.executeQuery();	
			 
	//2-3-1. 코드결과값 받기(1개)
	if(result.next()){
		resultCode = result.getInt("rtn");
	}
  
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);	

	if(resultCode == 1){
		response.sendRedirect("questinfo_list.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('정보가 부정확합니다.'); history.back(-1);</script>");
	}
	/**/
%>
