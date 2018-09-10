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
	String phone 	= util.getParamStr(request, "phone", "");
	String comment 	= util.getParamStr(request, "comment", "");

	try{
		//2. ����Ÿ ����
		//exec spu_GameMTBaseballD 20, -1, -1, 31, -1, -1, -1, -1, -1, -1, '', '', '', '01011112222', '������ī��'		--��ó��.
		query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 20);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, 31);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, phone);
		cstmt.setString(idxColumn++, comment);

		//2-2. ������� ���ν��� �����ϱ�
		result = cstmt.executeQuery();

		//2-3-1. �ڵ����� �ޱ�(1��)
		if(result.next()){
			//resultCode = result.getInt("rtn");
			resultCode = 1;
		}
  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);



	if(resultCode == 1){
		response.sendRedirect("blockphone_list.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('����ϽǼ� �����ϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
