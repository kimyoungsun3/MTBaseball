<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;

	String gameid 				= util.getParamStr(request, "gameid", "");
	String phone 				= util.getParamStr(request, "phone", "");
	int questing = 0, questwait = 0, questend = 0, total = 0;
	boolean bList;
	if(gameid.equals("") && phone.equals("")){
		bList = true;
	}else{
		bList = false;
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
	if(f_nul_chk(f.gameid, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<!--<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">-->
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							���� ���̵� ��Ȯ�� �Է��ϼ���.<br>
							(���� ���������� ��Ʈ�� �����մϴ�.)
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>ID�˻�</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>����ȣ�˻�(>���̵�˻�)</td>
						<td><input name="phone" type="text" value="<%=phone%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'SangSang', '', '', '', '', '', '', '', '', ''
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '01022223333', '', '', '', '', '', '', '', ''
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 7);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, phone);
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");

					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>��ȣ</td>
							<td>gameid</td>
							<td>����</td>
							<td>���</td>
							<td>�ƹ�Ÿ����</td>
							<td>��纼</td>
							<td>�ǹ���</td>
							<td>ĳ������</td>
							<td>ĳ���;���������</td>
							<td>���׹̳�</td>
							<td>�÷���</td>
							<td>��Ʋ����</td>
						</tr>

					<%while(result.next()){%>
						<tr>

							<td><%=result.getString("idx")%></td>
							<td width=200>
								ID : <a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>	<br>
								PW : <%=result.getString("password")%>	<br>
								������:<br>
								<%=result.getString("regdate").substring(0, 19)%><br>
								�ֱ�������:(<%=result.getString("concnt")%>ȸ)<br>
								<%=result.getString("condate").substring(0, 19)%><br>
								��:<%=result.getString("phone")%><br>

								<%if(bAdmin && !bExpire){%>
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=10>-1��</a>)
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=11>+1��</a>)
								<%}%>
								<br>
								���׹̳�������:<br><%=result.getString("actionfreedate").substring(0, 19)%><br>
								<%if(bAdmin && !bExpire){%>
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=12>-1��</a>)
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=13>+1��</a>)
								<%}%>
								<br>
								��Ż�Խ�����õ:
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=26><%=getMBoardState(result.getInt("mboardstate"))%> </a>
								<%}else{%>
									<%=getMBoardState(result.getInt("mboardstate"))%>
								<%}%><br>
								�¸���Push����:
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=27><%=result.getInt("resultwinpush")%> </a>
								<%}else{%>
									<%=getMBoardState(result.getInt("resultwinpush"))%>
								<%}%><br>

								<%if(!bExpire2){%>
									<br><a href=userdeletereal_ok.jsp?gameid=<%=result.getString("gameid")%>>������¥����</a>
								<%}%>
								<br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=0>
										<%if(result.getInt("blockstate") == 0){%>
											���ƴ�
										<%}else{%>
											������
										<%}%>
									</a>
								<br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=1>
										<%if(result.getInt("deletestate") == 0){%>
											�����ƴ�
										<%}else{%>
											��������
										<%}%>
									</a>
							</td>
							<td>
								����:<%=result.getString("lv")%><br>
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=35>UP</a><br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=36>DOWN</a><br>
								<%}%>
								����ġ:<%=result.getString("lvexp")%>
							</td>
							<td>
								���:<%=result.getString("grade")%><br>
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=30>UP</a><br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=31>DOWN</a><br>
								<%}%>
								���� : <%=result.getString("coin")%><br>
								��Ÿ : <%=result.getString("gradestar")%><br>
								����ġ : <%=result.getString("gradeexp")%>
							</td>
							<td>
								<%=result.getString("picture")%>,
								<%=getTel(result.getInt("market"))%>,
								<%=getPlatform(result.getInt("platform"))%>,
								<%=result.getString("ukey")%>,
								<%=result.getString("version")%>,
								<%=getBytType(result.getInt("buytype"))%>
							</td>
							<td>
								<%=result.getString("cashcost")%><br>
								<%if(bAdmin && !bExpire){%>
									<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=0&view=0>
										UP
									</a>
								<%}%><br>

								<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=0&view=1>
									DOWN
								</a><br>
							</td>
							<td>
								<%=result.getString("gamecost")%><br>
								<%if(bAdmin && !bExpire){%>
									<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=1&view=0>
										UP
									</a>
								<%}%><br>
								<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=1&view=1>
									DOWN
								</a><br>
							</td>
							<td>
								����: <%=getDeleteState(result.getInt("deletestate"))%><br>
								��: <%=getBlockState(result.getInt("blockstate"))%><br>
								ĳ��ī��: <%=result.getString("cashcopy")%><br>
								���ī��: <%=result.getString("resultcopy")%>
							</td>

							<td>
								[���ϰ������]<br>
								(<%=result.getString("dayplusdate").substring(5, 19)%>)<br>
								[���׹̳�]<br>
								<%if(bAdmin && !bExpire){%>
									<a href=userplus_ok.jsp?gameid=<%=result.getString("gameid")%>&plusactioncount=100>
										<%=result.getString("actionCount")%>
									</a>
								<%}else{%>
									<%=result.getString("actionCount")%>
								<%}%>

								/ <%=result.getString("actionMax")%>

								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=90>
										(<%=result.getString("actionTime").substring(5, 19)%>)
									</a>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=91>
										(-1)
									</a>
								<%}else{%>
									(<%=result.getString("actionTime").substring(5, 19)%>)
								<%}%>




								<br>
								[SMS] :
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=300>
										<%=result.getString("smsCount")%>
									</a>
								<%}else{%>
									<%=result.getString("smsCount")%>
								<%}%>
								/ <%=result.getString("smsMax")%>
								<br>
								(<%=result.getString("smsTime").substring(5, 19)%>)<br>
								[SMS��õ�İ���]:<%=result.getString("smsjoincnt")%>��<br>
								<br>

								[��Ŀ������]<br>
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=2>
										<%=result.getString("coin")%>
									</a>
								<%}else{%>
									<%=result.getString("coin")%>
								<%}%>
								[��Ŀ��ǹ�]<br>

								[��Ŀ��ǹ�]<br>
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=8>
										<%=result.getString("friendLSCount")%>
									</a>
								<%}else{%>
									<%=result.getString("friendLSCount")%>
								<%}%>

								/ <%=result.getString("friendLSMax")%>
								(<%=result.getString("friendLSTime").substring(5, 19)%>)

							</td>

							<td>
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan=12>
								Ǫ��:<%=result.getString("pushid")%>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan=12>
								<table>
									<tr>
										<td>����</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												�ְ� : <%=result.getString("petmatingbest")%>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=111>U</a>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=111>D</a>
												Ƚ�� : <%=result.getString("petmatingcnt")%>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=110>U</a>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=110>D</a>
											<%}else{%>
												�ְ� : <%=result.getString("petmatingbest")%>
												Ƚ�� : <%=result.getString("petmatingcnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>ģ��</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												�߰�		:
													<%=result.getString("friendaddcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=140>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=140>D</a>
												�湮Ƚ��	:
													<%=result.getString("friendvisitcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=141>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=141>D</a>
											<%}else{%>
												�߰�		: <%=result.getString("friendaddcnt")%>
												�湮Ƚ��	: <%=result.getString("friendvisitcnt")%>
											<%}%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					<%
						if(bList){
							maxPage = result.getInt("maxPage");
						}
					}%>
					<%if(bList){%>
						<tr>
							<td colspan=12 align=center>
									<a href=userinfo_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
									<%=idxPage%> / <%=maxPage%>
									<a href=userinfo_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
							</td>
						</tr>
					<%}%>
				</table>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>����������
					<table border=1>
						<tr>
							<td>idx</td>
							<td>������</td>
							<td>������</td>
							<td>������</td>
							<td>���۴ܰ�</td>
							<td>�������</td>
							<td>�������ں�</td>
							<td>��������</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("buydate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=itembuylog_list.jsp>���ŷα�(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>itemname</td>
							<td>cashcost</td>
							<td>gamecost</td>
							<td>�Ⱓ��?</td>
							<td>������</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<!--
								<td><a href=itembuylog_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
								<td><%=result.getString("itemcode")%></td>
								-->
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("cashcost")%> / <%=result.getString("cashcost2")%></td>
								<td><%=result.getString("gamecost")%> / <%=result.getString("gamecost2")%></td>
								<td><%=result.getString("buydate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/cashbuy_list.jsp>ĳ���α�(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>������</td>
							<td>�����������</td>
							<td>��Ż�����</td>
							<td>Ŭ������</td>
							<td>���Ű�纼</td>
							<td>����ĳ��</td>
							<td>������</td>
							<!--
							<%if(bAdmin && !bExpire){%>
								<td>���߻���</td>
							<%}%>
							-->
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=getIsNull(result.getString("giftid"), "")%></td>
								<td><%=result.getString("acode")%></td>
								<td><%=getXXX(result.getString("ucode"), 10)%></td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("cash")%></td>
								<td><%=result.getString("writedate")%></td>
								<%if(bAdmin && !bExpire){%>
									<td><a href=usercashlogd_ok.jsp?idx=<%=result.getString("idx")%>&gameid=<%=result.getString("gameid")%>>���߻���</a></td>
								<%}%>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/cashchange_list.jsp>ĳ��ȯ��(�ִ�10�� 1:100)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>��纼 -> �ǹ���ȯ��</td>
							<td>ȯ����</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td>
									<%=result.getString("cashcost")%>
									->
									<%=result.getString("gamecost")%>
								</td>
								<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/wgiftsend_list.jsp>��������Ʈ(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>�ε���</td>
							<td>��������</td>
							<td>�̸�(itemcode)</td>
							<td>����������</td>
							<td>��������¥</td>
							<td>������</td>
							<td>������</td>
							<td>�Ⱓ</td>
							<td>����</td>
							<td>����</td>
							<td>����(GB,SB)</td>
							<td>�����ޱ�</td>
						</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx2")%></td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
							<td><%=getGainState(result.getInt("gainstate"))%></td>
							<td><%=getDate(result.getString("gaindate"))%></td>
							<td><%=result.getString("giftid")%></td>
							<td><%=getDate(result.getString("giftdate"))%></td>
							<td><%=getKind(result.getInt("kind"))%></td>
							<td><%=getSex(result.getInt("sex"))%></td>
							<td><%=getPrice(result.getInt("gamecost"), result.getInt("cashcost"))%></td>
							<td><%=getGainState(result.getInt("gainstate"))%></td>
						</tr>
					<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/unusual_list.jsp>�������ص�(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>��ȣ</td>
							<td>����������</td>
							<td>�����󳻿�</td>
							<td>������¥</td>
							<!--
							<td>������Ȯ�λ���</td>
							<td>������Ȯ�γ�¥</td>
							<td>������Ȯ�γ���</td>
							-->
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("comment")%></td>
								<td><%=result.getString("writedate")%></td>
								<!--
								<td><%=result.getString("chkstate")%></td>
								<td><%=result.getString("chkdate")%></td>
								<td><%=result.getString("chkcomment")%></td>
								-->
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/userblock_list.jsp>������(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>��ȣ</td>
							<td>������</td>
							<td>����¥</td>
							<td>������</td>

							<td>������</td>
							<td>IP</td>
							<td>����������</td>
							<td>�����ڸ�Ʈ</td>
							<td>�����ϱ�</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("writedate")%></td>
								<td><%=result.getString("comment")%></td>

								<td><%=result.getString("adminid")%></td>
								<td><%=result.getString("adminip")%></td>
								<td><%=result.getString("releasedate")%></td>
								<td><%=result.getString("comment2")%></td>
								<td><%=getBlockState(result.getInt("blockstate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/userdelete_list.jsp>��������(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>��ȣ</td>
							<td>��������</td>
							<td>������¥</td>
							<td>��������</td>

							<td>������</td>
							<td>IP</td>
							<td>����������</td>
							<td>�����ڸ�Ʈ</td>
							<td>�����ϱ�</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("writedate")%></td>
								<td><%=result.getString("comment")%></td>

								<td><%=result.getString("adminid")%></td>
								<td><%=result.getString("adminip")%></td>
								<td><%=result.getString("releasedate")%></td>
								<td><%=result.getString("comment2")%></td>
								<td><%=getDeleteState(result.getInt("deletestate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>ģ��(�ִ�10��)
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>ģ�����̵�</td>
							<td>ģ�е�(�湮Ƚ��)</td>
							<td>ģ�������</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("friendid")%></td>
								<td><%=result.getString("familiar")%></td>
								<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=roulettetotal_list.jsp>�귿(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>cashcost</td>
							<td>gamecost</td>
							<td>itemcode</td>
							<td>writedate</td>
							<td>comment</td>

						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("gamecost")%></td>
								<td><%=result.getString("itemcode")%></td>
								<td><%=result.getString("writedate")%></td>
								<td><%=result.getString("comment")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>



				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/useretc_sms.jsp>��õ�α�(�ִ�10��)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>��õ��</td>
							<td>sendkey</td>
							<td>��õ�������</td>
							<td>��õ��</td>
							<td>.</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("sendkey")%></td>
								<td><%=result.getString("recphone")%></td>
								<td><%=result.getString("senddate")%></td>
								<%if(bAdmin && !bExpire){%>
									<td><a href=usersetting_ok.jsp?kind=302&idx=<%=result.getString("idx")%>&gameid=<%=result.getString("gameid")%>>���߻���</a></td>
								<%}%>
							</tr>
						<%}%>
					</table>
				<%}%>
			</div>
		</td>
	</tr>

</tbody></table>


<%
    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
