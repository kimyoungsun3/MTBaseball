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

	int mode	 				= util.getParamInt(request, "mode", 1);
	String certno 				= util.getParamStr(request, "certno", "");
	String gameid 				= util.getParamStr(request, "gameid", "");
	if(certno.equals("")){
		mode = 1;
	}


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

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<a href=certno_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
			<form name="GIFTFORM" method="post" action="certno_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<input type="hidden" name="mode" value="2">
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<table>
					<tr>
						<td colspan=4>
							<font color=blue><%=gameid%> ����Ȯ����</font><br>
							���� ��ȣ�� �Է��Ͻø� (�̻��) / (����) ������ ������ ���ݴϴ�.<br>
	        				������ ������ ���� ���޵Ȱ��� 1�� 1���� ��Ģ���� �մϴ�.<br>
	        				A���� B����Ʈ > 1�� 2�� ������������ > 1�常 ����ϰ� 1���� �����<br>
	        				A���� A����Ʈ > 1�� 2�� ������������ > 1�常 ����ϰ� 1���� �����<br>
	        				A�� ������Ʈ 1������ 2�� ����ϰ� 2���� �������
						</td>
					</tr>
					<tr>
						<td>�����˻�</td>
						<td>�˻�</td>
						<td><input name="certno" type="text" value="<%=certno%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</form>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FVFarmD 19, 1004,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''					-- ��������Ʈ.
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1004);
					cstmt.setInt(idxColumn++, mode);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
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
					cstmt.setString(idxColumn++, certno);

					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>��ȣ</td>
							<td>������ȣ(<font color=blue>�̻��</font>)</td>
							<td>����</td>
							<td>�з��ڵ�</td>
							<td colspan=2></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("certno")%></a></td>
							<td>
								<%=result.getString("itemcode1")%> (<%=result.getString("cnt1")%>��)
								/ <%=result.getString("itemcode2")%> (<%=result.getString("cnt2")%>��)
								/ <%=result.getString("itemcode3")%> (<%=result.getString("cnt3")%>��)
							</td>
							<td colspan=2><%=result.getString("kind")%></a></td>
							<td></td>
						</tr>
					<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<tr><td colspan=6><br><br> </td></tr>
					<tr>
						<td>��ȣ</td>
						<td>������ȣ(<font color=red>���Ȱ�</font>)</td>
						<td>����</td>
						<td>�з��ڵ�</td>
						<td>��Ż�</td>
						<td></td>
					</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("certno")%> / <a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank><%=result.getString("gameid")%></a></td>

							<td>
								<%=result.getString("itemcode1")%> <%=result.getString("cnt1")%>
								/ <%=result.getString("itemcode2")%> <%=result.getString("cnt2")%>
								/ <%=result.getString("itemcode3")%> <%=result.getString("cnt3")%><br>
								<%=result.getString("usedtime")%>
							</td>
							<td><%=result.getString("kind")%></td>
							<td><%=getTel(result.getInt("market"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=1004&p3=4&p4=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=certno_list&gameid=<%=result.getString("gameid")%>>����</a>
							</td>
						</tr>
					<%}%>
				<%}%>
				</table>
			</div>
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
