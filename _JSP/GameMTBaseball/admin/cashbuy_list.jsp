<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
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

	String gameid 				= util.getParamStr(request, "gameid", "");
	String acode 				= util.getParamStr(request, "acode", "");
	int cashcosttotal 			= 0;
	int cashtotal				= 0;

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
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							���(ĳ��)���� ����(�������� �˻�) > �˻��� �ϸ� ��ü ������ ���ɴϴ�.<br>
							(*�����߻�(-444):�Խ�Ʈ ������ ī�� ���̵� ��� ī�� ������ ���۸� �Ұ��� ���Դϴ�. ������ ���� ó���Ȱ��Դϴ�.)<br>
							(* iPhone ���Ŵ� �޷��̸� ��� ���ǻ� ������ ȯ��Ȱ��Դϴ�.)
							<a href=cashbuy_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
							<a href=userinfo_list.jsp?gameid=<%=gameid%> target=_blank><%=gameid%></a><br>
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="cashbuy_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td> ���(ĳ��)������ ���� ����</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:304px;"></td>
						<td style="padding-left:5px;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="cashbuy_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td> ��������ȣ(TX_xxx(SKT), 19xx.xx(Google), xxxx(iPhone))</td>
						<td><input name="acode" type="text" value="<%=acode%>" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:304px;"></td>
						<td style="padding-left:5px;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>

					<tr>
						<td colspan=4>
							<%if(!gameid.equals("")){%>
								<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=cashbuy_list&gameid=<%=gameid%>>��(����,�ڵ���)</a>
							<%}%>
						</td>
					</tr>
				</table>
			</div>

				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_GameMTBaseballD 21, 11,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- ���(ĳ��)�Ǹŷα�
					//exec spu_GameMTBaseballD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
					//exec spu_GameMTBaseballD 21, 11,10, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
					//exec spu_GameMTBaseballD 21, 11,10, -1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''					--
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, 11);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, acode);
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
							<td>��ȣ</td>
							<td>ȯ��(ikind)</td>
							<td>������(gameid)</td>
							<td>�����������(giftid)</td>
							<td>���ι�ȣ1(acode)</td>
							<td>���ι�ȣ2(ucode)</td>
							<td>���ι�ȣ3(kakaouk)</td>

							<td>���(cashcost)</td>
							<td>����(cash)</td>
							<td>������</td>
							<td>market</td>
							<td>ī�弭������</td>
							<!--
							<td>���ۿ���(�ҽ�����)</td>
							<td>�����ؼ�(�ҽ�����)</td>
							-->
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=getTel(result.getInt("market"))%>(<%=result.getString("ikind")%>)</td>
							<td>
								<a href=cashbuy_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>
								(<%=result.getString("gameyear")%>��<%=result.getString("gamemonth")%>�� <%=result.getString("famelv")%>LV)
							</td>
							<td><%=getIsNull(result.getString("giftid"), "")%></td>
							<td>
								<a href=cashbuy_list.jsp?acode=<%=result.getString("acode")%>><%=result.getString("acode")%>
							</td>
							<td><%=result.getString("ucode")%></td>
							<td><%=result.getString("kakaouk")%></td>


							<td><%=result.getString("cashcost")%></td>
							<td>
								<%=String.format("%,d", result.getInt("cash"))%>
								(<%=result.getString("productid")%>)
							</td>
							<td><%=result.getString("writedate")%></td>
							<td>

								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=cashbuy_list&gameid=<%=result.getString("gameid")%>>��(����,�ڵ���)</a>
									/
									<a href=usersetting_ok.jsp?p1=17&p2=1&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=cashbuy_list&gameid=<%=result.getString("gameid")%>>�α׻���</a>
									/
									<a href=usersetting_ok.jsp?p1=17&p2=2&ps1=<%=result.getString("gameid")%>&branch=cashbuy_list&gameid=<%=result.getString("gameid")%>>�α��ϰ�����</a>
								<%}%>
							</td>
							<td><%=getKakaoSend(result.getInt("kakaosend"))%></td>
							<!--
							<td><%=result.getString("idata")%></td>
							<td><%=result.getString("idata2")%></td>
							-->
							<%
								maxPage = result.getInt("maxPage");
								cashcosttotal += result.getInt("cashcost");
								cashtotal += result.getInt("cash");
							%>
						</tr>
					<%}%>
					<tr>
						<td colspan=13>�ѷ��:<%=cashcosttotal%>,  ��ĳ��:<%=String.format("%,d", cashtotal)%></td>
					</tr>

					<%if(gameid.equals("")){%>
						<tr>
							<td colspan=13 align=center>
									<a href=cashbuy_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
									<%=idxPage%> / <%=maxPage%>
									<a href=cashbuy_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
							</td>
						</tr>
					<%}%>
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
