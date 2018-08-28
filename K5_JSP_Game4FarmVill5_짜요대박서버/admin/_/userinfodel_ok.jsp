<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%> 
<%
	//1. ������ ��ġ
	Connection conn				= DbUtil.getConnection();	
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null; 
	StringBuffer query 			= new StringBuffer();		 			
	StringBuffer msg 			= new StringBuffer();	
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;
	
	
	if(bExpire){
		out.print("���Ұ�");
		return;
	}
	//1-2. ����Ÿ �ޱ�
	String pagebranch	= util.getParamStr(request, "pagebranch", "statistics_pay");
	int kind 			= util.getParamInt(request, "kind", 61);
	int idx 			= util.getParamInt(request, "idx", 1);
	
	//2. ����Ÿ ����
	//exec spu_FarmD 21, -1, -1, 61, 1, -1, -1, -1, -1, -1, '', '', '', '', ''				-- ���� ������ �������� ����
	//exec spu_FarmD 21, -1, -1, 71, 1, -1, -1, -1, -1, -1, '', '', '', '', ''				-- ���� ������ �������� ����
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 21);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, kind);
	cstmt.setInt(idxColumn++, idx);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	
	//2-2. ������� ���ν��� �����ϱ�
	result = cstmt.executeQuery();	
		 
	//2-3-1. �ڵ����� �ޱ�(1��)
	if(result.next()){
		resultCode = result.getInt("rtn");
	}
  
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);	



	if(resultCode == 1){
		response.sendRedirect(pagebranch + ".jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('����ϽǼ� �����ϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
