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


	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;
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
	if(f_nul_chk(f.dateid, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.dateid.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<a href=statistics_day.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FVFarmD 21, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- �Ϻ����
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
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
							<td>��¥</td>
							<td>����</td>

							<td>����ũ����(����)</td>
							<td>īī�� �ʴ�.</td>
							<td>īī�� ��Ʈ.</td>
							<td>�α���</td>
							<td>�α���(����ũ)</td>
							<td>ȯ����</td>
							<td>���Ϳ�û��</td>
							<td>���ͼ�</td>
							<td>����</td>
							<td>�ȵ���̵�Ǫ��</td>
							<td>������Ǫ��</td>
							<td>���Ϸ귿/�����귿/Ȳ�ݹ���</td>
							<td>��������(�ѱݾ�/Ƚ��)</td>
							<td>�̱�(��Ʈ/��2/��3/��4)</td>
							<td>�̱⹫��(��2/��3/��4)</td>
							<td>�Ϲݰ�ȭ/�����̾���ȭ</td>
							<td>��õ���Ӵٿ�</td>
							<td>��������</td>
						</tr>

					<%
					String _str = "", _str2 = "";
					while(result.next()){
						if(_str.equals(result.getString("dateid8"))){
							_str2 = "";
						}else{
							_str = result.getString("dateid8");
							_str2 = result.getString("dateid8");
						}
						%>
						<tr>
							<td><%=_str2%></td>
							<td><%=getTel(result.getInt("market"))%></td>
							<td><%=result.getString("joinukcnt")%></td>
							<td><%=result.getString("invitekakao")%></td>
							<td><%=result.getString("kakaoheartcnt")%></td>
							<td><%=result.getString("logincnt")%></td>
							<td><%=result.getString("logincnt2")%></td>
							<td><%=result.getString("rebirthcnt")%></td>
							<td><%=result.getString("rtnrequest")%></td>
							<td><%=result.getString("rtnrejoin")%></td>
							<td><%=result.getString("certnocnt")%></td>
							<td><%=result.getString("pushandroidcnt")%></td>
							<td><%=result.getString("pushiphonecnt")%></td>
							<td>
								<%=result.getString("roulettefreecnt")%> /
								<%=result.getString("roulettepaycnt")%> /
								<%=result.getString("roulettegoldcnt")%>
							</td>
							<td>
								<%=result.getString("freecashcost")%> /
								<%=result.getString("freecnt")%>
							</td>
							<td>
								<%=result.getString("tsgrade1cnt")%> /
								<%=result.getString("tsgrade2cnt")%> /
								<%=result.getString("tsgrade3cnt")%> /
								<%=result.getString("tsgrade4cnt")%>
							</td>
							<td>
								<%=result.getString("tsgrade2cntfree")%> /
								<%=result.getString("tsgrade3cntfree")%> /
								<%=result.getString("tsgrade4cntfree")%>
							</td>
							<td>
								<%=result.getString("tsupgradenormal")%> /
								<%=result.getString("tsupgradepremium")%>
							</td>
							<td>
								<%=result.getString("gamerewardcnt")%>
							</td>
							<td>
								<%=result.getString("rtnrejoin")%> /
								<%=result.getString("rtnrequest")%>
							</td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=18 align=center>
								<a href=statistics_day.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=statistics_day.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
						</td>
					</tr>
				</table>

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
