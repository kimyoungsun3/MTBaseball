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
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	//String password 	= util.getParamStr(request, "password", "");
	
	//2. ����Ÿ ����
	//�������ú���(19)
	//exec spu_FarmD 19, -1, -1, 3, -1, -1, -1, -1, -1, -1, 'SangSang', '', '', '', ''	--��Ʋ��+1 (3, 4, 5, 6, 7)
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
		response.sendRedirect("userinfo_list.jsp?gameid="+gameid);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('������ ����Ȯ�մϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
