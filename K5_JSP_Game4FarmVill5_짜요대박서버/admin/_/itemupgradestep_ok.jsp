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
	int subkind 		= util.getParamInt(request, "subkind", 51);
	int idx 			= util.getParamInt(request, "idx", -1);
	String comment 		= util.getParamStr(request, "comment", "�������");
	
	int petitemupgradebase		= util.getParamInt(request, "petitemupgradebase", -1);
	int petitemupgradestep		= util.getParamInt(request, "petitemupgradestep", -1);
	int normalitemupgradebase	= util.getParamInt(request, "normalitemupgradebase", -1);
	int normalitemupgradestep	= util.getParamInt(request, "normalitemupgradestep", -1);
	int permanentstep			= util.getParamInt(request, "permanentstep", -1);
	
	comment = getDBCheckURL(comment);
	
		
	//2. ����Ÿ ����
	//exec spu_FarmD 20, -1, -1, 40, -1, 3, 50, 50, 20, -1, '', '', '', '', '����'		--�����Ŀ������� ����
	//exec spu_FarmD 20, -1, -1, 41,  1, 1, 52, 53, 24, -1, '', '', '', '', '����'		--�����Ŀ������� ����
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 20);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, subkind);
	cstmt.setInt(idxColumn++, idx);
	cstmt.setInt(idxColumn++, petitemupgradebase);
	cstmt.setInt(idxColumn++, petitemupgradestep);
	cstmt.setInt(idxColumn++, normalitemupgradebase);
	cstmt.setInt(idxColumn++, normalitemupgradestep);
	cstmt.setInt(idxColumn++, permanentstep);					
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
		response.sendRedirect("itemupgradestep_list.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('����ϽǼ� �����ϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
