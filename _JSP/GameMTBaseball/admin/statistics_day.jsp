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
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 21, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- �Ϻ����
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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

							<td>��������</td>
							<td>����ũ����<br>(����)</td>
							<td>�α���<br>(�ߺ�)</td>
							<td>�α���<br>(���ߺ�)</td>
							<td bgcolor=yellow>īī��<br>�ʴ�/��Ʈ����/������</td>

							<td>��Ʈ��뷮</td>
							<td>�����̱�<br>(��/��/��10)</td>
							<td>�����̱�<br>(��/��/��10)</td>
							<td>��ȭ<br>(����/������Ʈ/����ĳ��)</td>
							<td>�ռ�<br>(����/ĳ��)</td>
							<td>�±�</td>
							<td>��Ȱ<br>(��/���)</td>
							<td>Push<br>(A/I)</td>
							<td>�������</td>
							<td>����<br>��û/����</td>

							<td>�ŷ���/��Ʋ/Ƚ������/������Ʋ</td>
							<td>
								ĳ������<br>
								�Ϲ�/����
							</td>
							<td>
								�ڽ�����<br>
								�ð�/����/3��
							</td>
							<td>
								�귿<br>
								����/ĳ��/ĳ��
							</td>
							<td>
								¥����������<br>
								����/ĳ��
							</td>
							<td>
								¥��������������<br>
								�ŷ�/�ڽ�/����/��Ʈ
							</td>
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

							<td>
								<!--<%=result.getString("joinplayercnt")%>-->
								<%=result.getString("joinguestcnt")%>
							</td>
							<td><%=result.getString("joinukcnt")%></td>
							<td><%=result.getString("logincnt")%></td>
							<td><%=result.getString("logincnt2")%></td>
							<td bgcolor=yellow>
								<%=result.getString("invitekakao")%>
								/ <%=result.getString("kakaoheartcnt")%>
								/ <%=result.getString("kakaohelpcnt")%>
							</td>


							<td><%=result.getString("heartusecnt")%></td>
							<td>
								<%=result.getString("freeroulettcnt")%> / <%=result.getString("payroulettcnt")%> / <%=result.getString("payroulettcnt2")%>
							</td>
							<td>
								<%=result.getString("freetreasurecnt")%> / <%=result.getString("paytreasurecnt")%> / <%=result.getString("paytreasurecnt2")%>
							</td>
							<td>
								<%=result.getString("aniupgradecnt")%> / <%=result.getString("tsupgradenor")%> / <%=result.getString("tsupgradepre")%>
							</td>
							<td>
								<%=result.getString("freeanicomposecnt")%>
								/ <%=result.getString("payanicomposecnt")%>
							</td>
							<td>
								<%=result.getString("anipromotecnt")%>
							</td>
							<td>
								<%=result.getString("revivalcnt")%>
								/ <%=result.getString("revivalcntcash")%>
							</td>

							<td><%=result.getString("pushandroidcnt")%> / <%=result.getString("pushiphonecnt")%> </td>
							<td><%=result.getString("certnocnt")%></td>
							<td><%=result.getString("rtnrequest")%>/<%=result.getString("rtnrejoin")%></td>

							<td>
								<%=result.getString("tradecnt")%> /
								<%=result.getString("battlecnt")%> /
								<%=result.getString("playcntbuy")%> /
								<%=result.getString("userbattlecnt")%>
							</td>
							<td>
								<%=result.getString("cashcnt")%> /
								<%=result.getString("cashcnt2")%>
							</td>
							<td>
								<%=result.getString("boxopenopen")%> /
								<%=result.getString("boxopencash")%> /
								<%=result.getString("boxopentriple")%>
							</td>
							<td>
								<%=result.getString("wheelnor")%> /
								<%=result.getString("wheelpre")%> /
								<%=result.getString("wheelprefree")%>
							</td>
							<td>
								<%=result.getString("zcpcntfree")%> /
								<%=result.getString("zcpcntcash")%>
							</td>
							<td>
								<%=result.getString("zcpappeartradecnt")%> /
								<%=result.getString("zcpappearboxcnt")%> /
								<%=result.getString("zcpappearfeedcnt")%> /
								<%=result.getString("zcpappearheartcnt")%>
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