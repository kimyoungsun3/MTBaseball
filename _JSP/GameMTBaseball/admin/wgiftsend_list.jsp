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
	StringBuffer query2			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	StringBuffer resultMsg		= new StringBuffer();
	int	idxColumn 				= 1;

	String gameid 				= util.getParamStr(request, "gameid", "");
	String giftid 				= util.getParamStr(request, "giftid", "");
	int idx 					= util.getParamInt(request, "idx", -1);

	try{
%>

<html><head>
<title>�����ϱ�</title>
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
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="wgiftsend_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td>�˻� ����ID</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td>������<input name="giftid" type="text" value="<%=giftid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						<td rowspan="2" style="padding-left:5px;"><a href="wgiftsend_form.jsp?gameid=<%=gameid%>">�����ϱ�</a></td>
					</tr>
					<tr>
						<td colspan=5>
							<a href=wgiftsend_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
							 ĳ������, ��������, ��������, ����Ʈ����, ��ŷ����, �α��κ���, �⼮����, ������Ʈ����, ��������<br>
							 Ʃ�丮�󺸻�, �����Ȯ��, ��ȸ����, ���κ���, ��Ű������, �ʴ� ����, ģ������, ģ�����򺸻�<br>
							 �׼������̱�, �����̺�Ʈ, �������̺�Ʈ, ��̳�����, ����ź�ź���<br>
						</td>
					</td>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 27, 2,  -1, -1, -1, -1, -1, -1, -1, -1, '', 'xxxx', '', '', '', '', '', '', '', ''						-- ���� ���� ����Ʈ( ��ü, ����)
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 27);
					cstmt.setInt(idxColumn++,  2);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, giftid);
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
							<td>�ε���</td>
							<td>����</td>
							<td></td>
							<td>����</td>
							<td>������</td>
							<td>��������</td>
							<td>���</td>
							<td>������</td>

							<td>�ܰ�</td>
							<td>������</td>
							<td>������</td>
							<td></td>
							<td>����</td>
						</tr>

					<%while(result.next()){%>
						<tr <%=getGiftKindColor(result.getInt("giftkind"))%> <%=getCheckValueOri(result.getInt("idxt"), idx, "bgcolor=#ffe020", "")%>>
							<td><%=result.getString("idxt")%></td>
							<td><a href=wgiftsend_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("idx2")%></td>
							<td><%=getGiftKind(result.getInt("giftkind"))%></td>

							<%if(result.getInt("giftkind") == 2 || result.getInt("giftkind") == -2  || result.getInt("giftkind") == -3  || result.getInt("giftkind") == -4  ){%>
								<td>
									<%=result.getString("itemname")%>
									(<%=result.getString("itemcode")%> / <%=getGiftCount(result.getInt("subcategory"), result.getInt("buyamount"), result.getInt("cnt"))%>��)
								</td>
								<td>
									<%=getGiftCount(result.getInt("subcategory"), result.getInt("buyamount"), result.getInt("cnt"))%>
									<%=getCategoryUnit(result.getInt("category"))%>
								</td>
								<td><%=getGrade(result.getInt("grade"))%></td>
								<td><%=getDate(result.getString("gaindate"))%></td>

								<td>
									<%=getPrice(result.getInt("gamecost"), result.getInt("cashcost"))%>
								</td>
								<td><%=result.getString("giftid")%></td>
								<td><%=getDate(result.getString("giftdate"))%></td>
								<!--
								<td>
									<%if(result.getInt("gainstate") == 0){%>
										<a href=/Game4/hlskt/giftgain.jsp?idx=<%=result.getString("idxt")%>>���������ޱ�</a>
									<%}else{%>
										<%=getGainState(result.getInt("gainstate"))%>
									<%}%>
								</td>
								-->
								<td><%=result.getString("message")%></td>
							<%}else{%>
								<td colspan=5>
									<%=result.getString("message")%>
								</td>
								<td><%=result.getString("giftid")%></td>
								<td colspan=2><%=getDate(result.getString("giftdate"))%></td>
							<%}%>
							<td>
								<a href=usersetting_ok.jsp?p1=27&p2=21&p4=<%=result.getInt("idxt")%>&branch=wgiftsend_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>������ŷ</a>
								<a href=usersetting_ok.jsp?p1=27&p2=22&p4=<%=result.getInt("idxt")%>&branch=wgiftsend_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>���߿���</a>
							</td>

						</tr>
					<%}%>
				</table>
			</div>
			</form>
		</td>
	</tr>

</tbody></table>


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