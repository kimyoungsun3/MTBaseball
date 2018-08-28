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
	
	//if(bExpire){
	//	out.print("���Ұ�");
	//	return;
	//}
	
	//1-2. ����Ÿ �ޱ�
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	int mode 			= util.getParamInt(request, "mode", 0);
	int value			= util.getParamInt(request, "value", 0);
	int minusgoldball 	= 0;
	int minussilverball = 0;
	if(value < 0)value = -value;
	if(mode == 0){
		minusgoldball = value;
	}else{
		minussilverball = value;
	}
		
	//2. ����Ÿ ����
	//exec spu_FarmD 23, -1, -1, 123, 123, -1, -1, -1, -1, -1, 'SangSang', '', '', '', ''
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 23);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, minusgoldball);
	cstmt.setInt(idxColumn++, minussilverball);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);					
	cstmt.setString(idxColumn++, gameid);
	cstmt.setString(idxColumn++, adminid);
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
		out.print("<script language='javascript'>alert('����ϽǼ� �����ϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
