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
	String url 			= util.getParamStr(request, "url", "userinfo_list");
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	int kind 			= util.getParamInt(request, "kind", 0);
	String btidx 		= util.getParamStr(request, "btidx", "1");
	
	out.print(url  +":"+gameid+":"+kind+":"+btidx);
	
	//2. 데이타 조작
	//유저세팅변경(19)
	//exec spu_FarmD 19, -1, -1, 40, -1, -1, -1, -1, -1, -1, 'SangSang', '', '', '2117896039', ''	--로그삭제
	//exec spu_FarmD 19, -1, -1, 40, -1, -1, -1, -1, -1, -1, 'xxxaaa', '', '', '1118944419', ''	--로그삭제
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 19);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, kind);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);					
	cstmt.setString(idxColumn++, gameid);
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, btidx);
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
		response.sendRedirect(url + ".jsp?gameid="+gameid);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('정보가 부정확합니다.'); history.back(-1);</script>");
	}
	/**/
%>
