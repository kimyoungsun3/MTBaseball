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

	String gameid				= util.getParamStr(request, "gameid", "");
	String kakaouserid 			= util.getParamStr(request, "kakaouserid", "");

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
	if(f_nul_chk(f.kakaouserid, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.kakaouserid.focus();">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="userkakaouserid_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							�������� Ż���ϰ� �簡�� ���ð�
							<a href=userkakaouserid_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<tr>
						<td>kakaouserid</td></td>
						<td>�˻�</td>
						<td><input name="kakaouserid" type="text" value="<%=kakaouserid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%

					//2. ����Ÿ ����
					//exec spu_FarmD 19, 66,  3, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- ����kakaouserid �˻�.
					//exec spu_FarmD 19, 66,  3, -1, -1, -1, -1, -1, -1, -1, '', '', 'kakaouserid', '', '', '', '', '', '', ''						--
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 66);
					cstmt.setInt(idxColumn++,  3);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, kakaouserid);
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
							<td>kakaouserid</td>
							<td>kakaotalkid</td>
							<td>gameid</td>
							<td></td>
							<td>kakaodata</td>
							<td>������</td>
							<td>Ŭ���� �簡���ʱ�ȭ</td>
						</tr>

					<%while(result.next()){%>
						<tr>
								<td><%=result.getString("idx")%></td>
								<td>
									<a href=userkakaouserid_list.jsp?kakaouserid=<%=result.getString("kakaouserid")%>>
										<%=result.getString("kakaouserid")%>
									</a>
								</td>
								<td><%=result.getString("kakaotalkid")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("cnt")%> / <%=result.getString("cnt2")%></td>
								<td><%=result.getString("kakaodata")%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=41&p4=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userkakaouserid_list&gameid=<%=result.getString("gameid")%>>
										<%=getDate(result.getString("deldate"))%>
									</a>
								</td>
						</tr>
					<%}%>
				</table>
			</div>
			</form>
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