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
	int sendkind 		= util.getParamInt(request, "sendkind", 1);
	int telkind 		= util.getParamInt(request, "telkind", -1);
	int personal 		= util.getParamInt(request, "personal", -1);
	int p5 				= util.getParamInt(request, "p5", -1);

	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String title 		= util.getParamStr(request, "title", "");
	String content 		= util.getParamStr(request, "content", "");
	String branchurl 	= util.getParamStr(request, "branchurl", "");
	String scheduleTime	= util.getParamStr(request, "scheduleTime", "2014-01-01");
	int cnt = 0;

	title = getDBCheckURL(title);
	content = getDBCheckURL(content);
	//branchurl = getDBCheckURL(branchurl);

	//out.println(
	//			"kind:" + kind + "<br>"
	//			+ "sendkind:" + sendkind + "<br>"
	//			+ "telkind:" + telkind + "<br>"
	//			+ "gameid:" + gameid + "<br>"
	//			+ "title:" + title + "<br>"
	//			+ "content:" + content + "<br>"
	//			+ "branchurl:" + branchurl + "<br>"
	//			);


	try{

		//2. ����Ÿ ����
		//�������ú���(19)
		//--exec spu_FVFarmD 30, 32,  1, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[Ǫ������]', '[Ǫ������]', 'LANUCH', '', '', '', '', ''	-- Push ����.
		//--exec spu_FVFarmD 30, 32,  3, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[Ǫ������URL]', '[Ǫ������URL]', 'http://m.tstore.co.kr', '', '', '', '', ''
		//--exec spu_FVFarmD 30, 33,  1,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[Ǫ������]', '[Ǫ������]', 'LANUCH', '', '', '', '', ''		-- Push ��ü.
		//--exec spu_FVFarmD 30, 33,  3,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[Ǫ������URL]', '[Ǫ������URL]', 'http://m.tstore.co.kr', '', '', '', '', ''
		query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, kind);
		cstmt.setInt(idxColumn++, sendkind);
		cstmt.setInt(idxColumn++, telkind);
		cstmt.setInt(idxColumn++, p5);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, adminid);
		cstmt.setString(idxColumn++, title);
		cstmt.setString(idxColumn++, content);
		cstmt.setString(idxColumn++, branchurl);
		cstmt.setString(idxColumn++, scheduleTime);
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
  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

	if(resultCode == 1){
		response.sendRedirect("push_list.jsp?gameid="+gameid+"&personal="+personal);
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('������ ����Ȯ�մϴ�.'); history.back(-1);</script>");
	}
	/**/
%>
