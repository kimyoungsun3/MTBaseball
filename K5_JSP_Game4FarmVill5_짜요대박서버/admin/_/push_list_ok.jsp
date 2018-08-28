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
	
	//if(bExpire){
	//	out.print("���Ұ�");
	//	return;
	//}
	//1-2. ����Ÿ �ޱ�
	int kind 			= util.getParamInt(request, "kind", 0);
	int pushkind 		= util.getParamInt(request, "pushkind", 1);
	int telkind 		= util.getParamInt(request, "telkind", -1);
	
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String title 		= util.getParamStr(request, "title", "");
	String content 		= util.getParamStr(request, "content", "");
	String branchurl 	= util.getParamStr(request, "branchurl", "");
	int cnt = 0;
	
	title = getDBCheckURL(title);
	content = getDBCheckURL(content);
	//branchurl = getDBCheckURL(branchurl);
	
	//out.println(
	//			"kind:" + kind + "<br>"
	//			+ "pushkind:" + pushkind + "<br>"
	//			+ "telkind:" + telkind + "<br>"
	//			+ "gameid:" + gameid + "<br>"
	//			+ "title:" + title + "<br>"
	//			+ "content:" + content + "<br>"
	//			+ "branchurl:" + branchurl + "<br>"
	//			);
	
	
	//2. ����Ÿ ����
	//�������ú���(19)
	//--exec spu_FarmD 19, -1, -1, 400, 1, -1, -1, -1, -1, -1, 'guest74019', '������ID', '[Ǫ������]', '[Ǫ������]', 'LANUCH'
	//--exec spu_FarmD 19, -1, -1, 400, 3, -1, -1, -1, -1, -1, 'guest74019', '������ID', '[Ǫ������URL]', '[Ǫ������URL]', 'http://m.tstore.co.kr/userpoc/mp.jsp?pid=0000278756'
	//--exec spu_FarmD 19, -1, -1, 401, 1, 1, -1, -1, -1, -1, '������ID', '������ID', '[Ǫ������]', '[Ǫ������]', 'LANUCH'
	//--exec spu_FarmD 19, -1, -1, 401, 3, 1, -1, -1, -1, -1, '������ID', '������ID', '[Ǫ������URL]', '[Ǫ������URL]', 'http://m.tstore.co.kr'
	query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 19);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, kind);
	cstmt.setInt(idxColumn++, pushkind);
	cstmt.setInt(idxColumn++, telkind);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);					
	cstmt.setString(idxColumn++, gameid);
	cstmt.setString(idxColumn++, adminid);
	cstmt.setString(idxColumn++, title);
	cstmt.setString(idxColumn++, content);
	cstmt.setString(idxColumn++, branchurl);
	
	//2-2. ������� ���ν��� �����ϱ�
	result = cstmt.executeQuery();	
			 
	//2-3-1. �ڵ����� �ޱ�(1��)
	if(result.next()){
		resultCode = result.getInt("rtn");
	}
  
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);	

	if(resultCode == 1){
		response.sendRedirect("push_list.jsp?gameid="+gameid);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('������ ����Ȯ�մϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
