<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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


	String dateid 				= util.getParamStr(request, "dateid", "");
	String dateid2 				= "" + format.format(now);
	boolean bMain 				= true;
	if(!dateid.equals("")){
		bMain = false;
	}

%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.dateid, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.dateid.focus();">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="statistics_rank.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							����躰 ��ŷ ����
						</td>
					</tr>
					<tr>
						<td> ��ŷ�˻���[<%=dateid2%>]</td>
						<td> �˻�</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 21, -1, -1, 20, -1, -1, -1, -1, -1, -1, '', '', '', '', ''			-- ����躰 ��ŷ
					//exec spu_FarmD 21, -1, -1, 20, -1, -1, -1, -1, -1, -1, '', '20130117', '', '', ''	-- ����躰 ��ŷ
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					//2-2. ������� ���ν��� �����ϱ�
					%>

					<%result = cstmt.executeQuery();%>
						<tr>
							<%if(bMain){%>
								<td>����</td>
								<td>�ۼ���</td>
							<%}else{%>
								<td>����</td>
								<td>��ŷ����</td>
								<td>��ŷ</td>
								<td>���̵�</td>
								<td>�ӽ�����</td>
								<td>�ϱ�����</td>
								<td>��Ʋ/�̼�</td>
								<td>�ۼ���</td>
							<%}%>
						</tr>
					<%while(result.next()){%>
						<tr>
							<%if(bMain){%>
								<td><a href=statistics_rank.jsp?dateid=<%=result.getString("dateid")%>><%=result.getString("dateid")%></a></td>
								<td><%=result.getString("writedate")%></td>
							<%}else{%>
								<td><%=result.getString("dateid")%></td>
								<td><%=getGMode2(result.getInt("gamemode"))%></td>
								<td><%=result.getString("rank")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("btwin")%> <%=result.getString("bttotal")%></td>
								<td><%=result.getString("writedate")%></td>
							<%}%>
						</tr>
					<%}%>
				</table>

		</td>
	</tr>

</tbody></table>
</center>

<%
    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
