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
			<form name="GIFTFORM" method="post" action="unusual_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							1. ȯ���� �ؾ������� ��ŷ�� ��ϵ˴ϴ�.(��, ��, ȭ, ��, ��, ��, ��) -> ���<br>
							2. ������ ������� ������ ȯ���ϸ� ��ŷ�� ��� �ȵ˴ϴ�.<br>
							100�� ��ŷ <a href=userrank_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FVFarmD 19, 94, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- ������ŷ 100��
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 94);
					cstmt.setInt(idxColumn++, -1);
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
							<td>rank</td>
							<td>bestani</td>
							<td>salemoney</td>
							<td>gameid</td>
							<td>��ĳ��</td>
							<td>nickname</td>
							<td>cashpoint/cashcost/vippoint/�ʴ�(�ʴ�bg)</td>
							<td>cashcost2/vippoint2</td>
							<td></td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("rank")%></td>
							<td><%=result.getString("bestani")%></td>
							<td><%=displayMoney(result.getString("salemoney"))%></td>
							<td><%=result.getString("gameid")%></td>
							<td><%=displayMoney(result.getString("ownercashcost"))%></td>
							<td><%=result.getString("nickname")%></td>
							<td>
								<%=result.getString("cashpoint")%> /
								<%=result.getString("cashcost")%> /
								<%=result.getString("vippoint")%> /
								<%=result.getString("kakaomsginvitecnt")%>(<%=result.getString("kakaomsginvitecntbg")%>)
							</td>
							<td>
								<%=result.getString("cashcost2")%> /
								<%=result.getString("vippoint2")%>
							</td>
							<td>
								<%
									String _src = result.getString("savedata");
									String _rtn = "";

									_rtn  = getPart4(_src, "%6:", "�⵵");
									_rtn += getPart4(_src, "%21:", "����(���)");
									_rtn += getPart4(_src, "%22:", "�˹�(���)");
									_rtn += getPart4(_src, "%2:",  "�˹�(�ܰ�)");
									_rtn += getPart4(_src, "%23:", "����(���)");
									_rtn += getPart4(_src, "%25:", "����(�ܰ�)");
									_rtn += getPart4(_src, "%260:","���(���)");
									_rtn += getPart4(_src, "%250:","���(�ܰ�)");
									_rtn += getPart4(_src, "%70:", "�����(�ܰ�)");
									out.print(_rtn);

								%>
							</td>
							<td>
								<a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>����</a>
								<%=getBlockState(result.getInt("blockstate"))%>
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
