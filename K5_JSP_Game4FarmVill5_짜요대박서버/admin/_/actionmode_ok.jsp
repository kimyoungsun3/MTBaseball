<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%> 
<%@include file="_checkfun.jsp"%> 
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
	
	
	//1-2. ����Ÿ �ޱ�
	int idx 			= util.getParamInt(request, "idx", 1);	
	int subkind 		= util.getParamInt(request, "subkind", 70);	
	int halfmodeprice	= util.getParamInt(request, "halfmodeprice", 6);
	int fullmodeprice	= util.getParamInt(request, "fullmodeprice", 10);
	int freemodeprice	= util.getParamInt(request, "freemodeprice", 50);
	int freemodeperiod	= util.getParamInt(request, "freemodeperiod", 1);
	int plusgoldball	= util.getParamInt(request, "plusgoldball", 0);
	int plussilverball	= util.getParamInt(request, "plussilverball", 0);
	String comment 		= util.getParamStr(request, "comment", "�������");
	
	comment = getDBCheckURL(comment);
	
		
	//2. ����Ÿ ����
	//exec spu_FarmD 20, -1, -1, 70, 6, 10, 50, 1, -1, -1, '', '', '', '', '����'		-- ���׹̳� > �Է�
	//exec spu_FarmD 20, -1,  1, 71, 6, 10, 50, 1, -1, -1, '', '', '', '', '����'		-- > ����
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
	
	//2-2. ������� ���ν��� �����ϱ�
	result = cstmt.executeQuery();	
		 
	//2-3-1. �ڵ����� �ޱ�(1��)
	if(result.next()){
		//resultCode = result.getInt("rtn");
		resultCode = 1;
	}
  
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);	



	if(resultCode == 1){
		response.sendRedirect("actionmode_list.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('����ϽǼ� �����ϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
