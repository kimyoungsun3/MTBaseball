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

	String gameid 				= util.getParamStr(request, "gameid", "");

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
			<form name="GIFTFORM" method="post" action="adminusersalelog_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							�������� �ϴ� �������� ������ �� ����
							<a href=adminusersalelog_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<tr>
						<td>��������������</td>
						<td>�˻�</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%

					//2. ����Ÿ ����
					//exec spu_FarmD 19, 66,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 			   ����Ʈ.
					//exec spu_FarmD 19, 66,  2, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 				�˻�.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 66);
					cstmt.setInt(idxColumn++,  2);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
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
							<td>���̵�</td>
							<td>�ŷ���</td>
							<td>������/����</td>
							<td>������</td>
							<td>�Ѽ���(0)</td>
							<td>�Ǹűݾ�(1)</td>
							<td>���ο䱸(���ι�ȣ�� +1)</td>
							<td>����ݾ�(2)</td>
							<td>������ȹ��ݾ�(3)</td>
							<td>������(�ʰ�������)</td>
							<td>���Ƽ��</td>
							<td></td>
							<td>�α�(�ҽ������)</td>
							<td>���/����/��Ʈ/����/����</td>
							<td>����ǰ</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><a href=adminusersalelog_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td>
								<%=result.getString("gameyear")%>��
								<%=result.getString("gamemonth")%>��
							</td>
							<td><%=result.getString("fame")%>/<%=result.getString("famelv")%></td>
							<td><%=result.getString("feeduse")%>��</td>
							<td>
								<%=result.getInt("salebarrel")*(result.getInt("saledanga") + result.getInt("saleplusdanga"))%>
								+ <%=result.getInt("prizecoin")%>
								+ <%=result.getInt("playcoin")%>
							</td>
							<td>
								<%=result.getString("saletrader")%>������
								(�ܰ�:<%=result.getString("saledanga")%>���� + �߰�:<%=result.getString("saleplusdanga")%>����)
								x <%=result.getString("salebarrel")%>�跲(<%=result.getString("salefresh")%>�ż���) =
								�Ǹű�:<%=result.getString("salecoin")%>
							</td>
							<td>
								<%=result.getString("saletrader")%>������
								�跲:<%=result.getString("orderbarrel")%>
								�ż�:<%=result.getString("orderfresh")%>
							</td>
							<td>
								����:<%=result.getString("tradecnt")%>ȸ
								����:<%=result.getString("prizecnt")%>ȸ
								���ͱ�:<%=result.getString("prizecoin")%>
							</td>
							<td>
								���ͱ�:<%=result.getString("playcoin")%>
								(�ִ�Max:<%=result.getString("playcoinmax")%>)
							</td>
							<td><%=result.getString("saleitemcode")%></td>
								<td>
									<%=result.getString("goldticket")%>���� /
									<%=getGoldTicketUsed(result.getInt("goldticketused"))%>
								</td>
							<td>
								<%=result.getString("writedate")%>
								<a href=usersetting_ok.jsp?p1=19&p2=66&p3=1&p4=<%=result.getString("idx2")%>&ps1=<%=result.getString("gameid")%>&branch=adminusersalelog_list&gameid=<%=result.getString("gameid")%>>���߻���</a>
							</td>
							<td>
								<!--
								userinfo 	: <%=result.getString("userinfo")%>
								aniitem		: <%=result.getString("aniitem")%>
								cusitem		: <%=result.getString("cusitem")%>
								tradeinfo 	: <%=result.getString("tradeinfo")%>
								-->
							</td>
							<td>
								<%=result.getString("cashcost")%>/
								<%=result.getString("gamecost")%>/
								<%=result.getString("heart")%>/
								<%=result.getString("feed")%>/
								<%=result.getString("fpoint")%>
							</td>
							<td><%=result.getString("milkproduct")%></td>
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