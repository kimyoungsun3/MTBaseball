<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.io.*"%>
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
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;

	int itemcode 		= util.getParamInt(request, "itemcode", -1);
	int category 		= util.getParamInt(request, "category", 818);
	int subcategory 	= util.getParamInt(request, "subcategory", -1);
	int view	 		= util.getParamInt(request, "view", 1);

	try{
%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.itemcode, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.itemcode.focus();">
<table align=center>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				

				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 5, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--전체
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 5);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, itemcode);
					cstmt.setInt(idxColumn++, category);
					cstmt.setInt(idxColumn++, subcategory);
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
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>labelname</td>
							<td>itemcode</td>
							<td>itemname</td>
							<td>param2</td>
							<td>param3</td>
							<td>param4</td>
							<td>param10</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td>
								<%=result.getString("labelname")%>								
							</td>
							<td><a href=iteminfo_list.jsp?itemcode=<%=result.getString("itemcode")%>&view=<%=view%>><%=result.getString("itemcode")%></a></td>

							<td><%=result.getString("itemname")%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 2, result.getString("param2"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 3, result.getString("param3"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 4, result.getString("param4"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 10, result.getString("param10"), imgroot)%></td>
						</tr>
					<%}%>
				</table>
			</div>
		</td>
	</tr>
</table>


<%
  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
