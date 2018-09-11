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

	int schoolidx 				= util.getParamInt(request, "schoolidx", -1);
	String dateid 				= util.getParamStr(request, "dateid", "20131217");

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
							1. �귿�� ������������ ��ŷ�� ��ϵ˴ϴ�.(
							<font color=red>��</font>, ��, <font color=red>ȭ</font>, ��, ��, <font color=red>��</font>, <font color=blue>��</font>) -> ���<br>
							��ŷ�� ��� <a href=userrk_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_GameMTBaseballD 19, 3002,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- ��ŷ�������.
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 3002);
					cstmt.setInt(idxColumn++, 1);
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
					cstmt.setString(idxColumn++, "");

					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();
					%>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td>�Ǹż���</td>
							<td>����跲</td>
							<td>��Ʋ ����Ʈ</td>
							<td>����,��������Ʈ</td>
							<td>ģ������Ʈ</td>
							<td>�귿����Ʈ</td>
							<td>��������Ʈ</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("rkdateid8")%></td>
							<td><%=getRTReward(result.getInt("rkreward"))%></td>
							<td><%=getCheckRKTeam(result.getInt("rkteam1"), result.getInt("rkteam0"))%></td>

							<td><%=getCheckRKTeam2(result.getLong("rksalemoney"), result.getLong("rksalemoney2"))%></td>
							<td><%=getCheckRKTeam2(result.getLong("rksalebarrel"), result.getLong("rksalebarrel2"))%></td>
							<td><%=getCheckRKTeam2(result.getLong("rkbattlecnt"), result.getLong("rkbattlecnt2"))%></td>
							<td><%=getCheckRKTeam2(result.getLong("rkbogicnt"), result.getLong("rkbogicnt2"))%></td>
							<td><%=getCheckRKTeam2(result.getLong("rkfriendpoint"), result.getLong("rkfriendpoint2"))%></td>
							<td><%=getCheckRKTeam2(result.getLong("rkroulettecnt"), result.getLong("rkroulettecnt2"))%></td>
							<td><%=getCheckRKTeam2(result.getLong("rkwolfcnt"), result.getLong("rkwolfcnt2"))%></td>
						</tr>
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