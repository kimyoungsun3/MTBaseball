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
	int idxColumn				= 1;

	String dateid 				= util.getParamStr(request, "dateid", "20140404");

	int list[][]				= new int[31][70];


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
	if(f_nul_chk(f.gameid, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							�������� <a href=statistics_main.jsp>���ư���</a>
						</td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 19, 98,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '20140404', '', '', '', '', '', '', ''				--         ��������, ������Ż�.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 98);
					cstmt.setInt(idxColumn++,  2);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");

					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();
					%>
						<tr>
							<td></td>
							<td></td>
							<td>����</td>
							<td>�ο�</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("dateid")%></td>
							<td><%=result.getString("famelv")%></td>
							<td><%=result.getString("cnt")%></td>
						</tr>
					<%}%>
				</table>
			</div>
		</td>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					��Ż纰.
					<table border=1>
						<tr>
							<td></td>
							<td>����</td>
							<td>�ο�</td>
						</tr>
						<%while(result.next()){%>
							<tr>
							<td><%=result.getString("dateid")%></td>
							<td><%=getTel(result.getInt("market"))%></td>
							<td><%=result.getString("cnt")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>
		</td>
	</tr>

</tbody></table>
</center>

<%

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}
    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
