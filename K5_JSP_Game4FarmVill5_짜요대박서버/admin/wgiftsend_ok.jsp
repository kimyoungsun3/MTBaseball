<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>
<%

	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer query2			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	StringBuffer resultMsg		= new StringBuffer();
	int	idxColumn 				= 1;
	int resultCode				= -1;


	//1-2. 데이타 받기
	int subkind				= util.getParamInt(request, "subkind", 11);
	int itemcode 			= util.getParamInt(request, "itemcode", -1);
	String strcnt	 		= util.getParamStr(request, "cnt", "1");
	String gameid 			= util.getParamStr(request, "gameid", "");
	String message 			= util.getParamStr(request, "message", "");
	message	 				= getDBCheckURL(message);
	//out.print(subkind + ":" + itemcode + ":" + adminid + ":" + gameid + ":" + message);


	try{
		//2. 데이타 조작
		//exec spu_FarmD 27, 11,  1, -1, -1, -1, -1, -1, -1, -1, 'adminid', 'xxxx', '', '', '', '', '', '', '', ''				-- 선물하기
		//exec spu_FarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'adminid', 'xxxx', '메세지내용', '', '', '', '', '', '', ''	-- 메세지보내기
		query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 27);
		cstmt.setInt(idxColumn++, subkind);
		cstmt.setInt(idxColumn++, itemcode);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, adminid);
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, message);
		cstmt.setString(idxColumn++, strcnt);
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");
		cstmt.setString(idxColumn++, "");

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
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
		response.sendRedirect("wgiftsend_list.jsp?gameid=" + gameid);
	}else if(resultCode == -13){
		out.print("<script language='javascript'>alert('아이디가 없습니다.'); history.back(-1);</script>");
	}else if(resultCode == -50){
		out.print("<script language='javascript'>alert('아이템이 존재하지 않습니다.'); history.back(-1);</script>");
	}
	/**/
%>
