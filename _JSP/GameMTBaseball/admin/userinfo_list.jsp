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
	boolean bList;
	if(gameid.equals("") && phone.equals("")){
		bList = true;
	}else{
		bList = false;
	}

	int comreward				= -1;
	int num						= 0;
	int earncoin				= 0;
	int famelv					= 0;
	int kind					= 0;
	try{
%>
<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css" type="text/css">
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
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table align=center>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							���� ���̵� ��Ȯ�� �Է��ϼ���.<br>
							<font color=red>���� ��� ���� 2000���/100������ �̻� �̸� ������, ���ڵ���, ��ī��(�ڵ��̴ϱ� �����ϼ���.)</font>
							<a href=userinfo_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>���Ӿ��̵�(farmxx)</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>����ȣ�˻�(>���̵�˻�)</td>
						<td><input name="phone" type="text" value="<%=phone%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
					//exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'SangSang', '', '', '', '', '', '', '', '', ''
					//exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '01022223333', '', '', '', '', '', '', '', ''
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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
							<td>��ȣ</td>
							<td>gameid</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>

					<%
					while(result.next()){
						if(gameid.equals(result.getString("gameid"))){
						}
					%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td width=200>
								ID : <a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a><br>
								PW : <%=result.getString("password")%>	<br>
								������: <%=getDate(result.getString("regdate"))%><br>
								������:(<%=result.getString("concnt")%>ȸ)
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=6&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>>
										<!-- �߻����� , �Ʒ��� �⼮���� �ַ� ����Ѵ�.-->
										<%=getDate(result.getString("condate"))%>
									</a><br>
								<br>
								��:<a href=userinfo_list.jsp?phone=<%=result.getString("phone")%>><%=result.getString("phone")%></a><br><br>

								<!--SMS�߼� : <%=result.getString("smssendcnt")%> / <%=result.getString("smsjoincnt")%>	<br>-->
								<a href=usersetting_ok.jsp?p1=19&p2=4&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									<%=getCheckValue(result.getInt("kkopushallow"), 1, "Ǫ���߼۰���", "<font color=red>Ǫ���߼۰���</font>")%>
								</a>
								<br>
								<a href=usersetting_ok.jsp?p1=19&p2=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									<%=getBlockState(result.getInt("blockstate"))%>
								</a><br>

								<a href=usersetting_ok.jsp?p1=19&p2=10&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									<%=getDeleteState(result.getInt("deletestate"))%>
								</a><br>
								ĳ��ī��: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=13&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>><%=result.getString("cashcopy")%></a><br>
								���ī��: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=14&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>><%=result.getString("resultcopy")%></a><br>

								<br>
								<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>�ϰ���</a><br>
								<a href=usersetting_ok.jsp?p1=18&p2=1&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>������¥����</a><br>
								<a href=usersetting_ok.jsp?p1=18&p2=2&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>���߸ƽ��ʱ�ȭ</a><br>
								<a href=wgiftsend_form.jsp?gameid=<%=result.getString("gameid")%> target=_blank>����/����</a><br>
								<a href=push_list.jsp?gameid=<%=result.getString("gameid")%>&personal=1 target=_blank>Ǫ���߼�</a><br><br>

								������������ 	: <%=getRKStartState(result.getInt("rkstartstate"))%><br>
								��		 		: <%=getRKTeam(result.getInt("rkteam"))%><br>
								�Ǹż��� 		: <%=result.getString("rksalemoney")%><br>
								����跲 		: <%=result.getString("rksalebarrel")%><br>
								��Ʋ����Ʈ		: <%=result.getString("rkbattlecnt")%><br>
								��������,�����̱� : <%=result.getString("rkbogicnt")%><br>
								ģ������Ʈ 		: <%=result.getString("rkfriendpoint")%><br>
								�귿����Ʈ 		: <%=result.getString("rkroulettecnt")%><br>
								��������Ʈ		: <%=result.getString("rkwolfcnt")%><br>
								(
								<a href=usersetting_ok.jsp?p1=19&p2=86&p3=60&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									����:�������� ������
							  	</a>
								)
							</td>
							<td>
								<%=getTel(result.getInt("market"))%>
								<%=getBytType(result.getInt("buytype"))%>
								<%=getPlatform(result.getInt("platform"))%>
								<%=result.getString("ukey")%>,
								<%=result.getString("version")%><br>
								����ID:<%=result.getString("sid")%><br><br>
								�Խ���: <%=getMBoardState(result.getInt("mboardstate"))%><br><br>

								�⼮��:
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
										<%=getDate(result.getString("attenddate"))%>
									</a><br>
								�⼮Ƚ��:
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
										<%=result.getString("attendcnt")%>
									</a><br>
								���ʹܰ�:
										<a href=userminus_form3.jsp?p1=19&p2=89&p3=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>>
											<%=getRtnStep(result.getInt("rtnstep"))%>
										</a><br>
								���������:
										<a href=userminus_form3.jsp?p1=19&p2=89&p3=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>>
											<%=result.getString("rtnplaycnt")%>
										</a><br>
								���Ϳ�û���:
										<%=result.getString("rtngameid")%>(<%=getDate19(result.getString("rtndate"))%>)<br>
								<!--
								��ȸ����Ƚ�� : <%=result.getString("contestcnt")%>	<br>
								��Ī : <%=result.getString("nickname")%>	<br>
								-->

								�Ķ����(0 ~ 9):<br>
									<%for(int i = 0; i < 10; i++){
										out.print( result.getString("param" + i) + "/");
									}%><br>


								<br>
							</td>
							<td>
								ĳ�� : <a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=0><%=result.getString("cashcost")%></a><br>

								<br>


								�����κ�Max : <%=result.getString("invenanimalmax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=45><%=result.getString("invenanimalstep")%></a>)<br>
								�Һ��κ�Max : <%=result.getString("invencustommax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=46><%=result.getString("invencustomstep")%></a>)<br>
								�ٱ��κ�Max : <%=result.getString("invenstemcellmax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=47><%=result.getString("invenstemcellstep")%></a>)<br>
								�����κ�Max : <%=result.getString("inventreasuremax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=49><%=result.getString("inventreasurestep")%></a>)<br>
								<!--�ӽþ����� : <%=result.getString("tempitemcode")%> / <%=result.getString("tempcnt")%>	<br>-->
								�ʵ�0 : <%=getCheckValue(result.getInt("field0"), 1, "����", "����")%><br>
								�ʵ�1 : <%=getCheckValue(result.getInt("field1"), 1, "����", "����")%><br>
								�ʵ�2 : <%=getCheckValue(result.getInt("field2"), 1, "����", "����")%><br>
								�ʵ�3 : <%=getCheckValue(result.getInt("field3"), 1, "����", "����")%><br>
								�ʵ�4 : <%=getCheckValue(result.getInt("field4"), 1, "����", "����")%><br>
								�ʵ�5 : <%=getCheckValue(result.getInt("field5"), 1, "����", "����")%><br>
								�ʵ�6 : <%=getCheckValue(result.getInt("field6"), 1, "����", "����")%><br>
								�ʵ�7 : <%=getCheckValue(result.getInt("field7"), 1, "����", "����")%><br>
								�ʵ�8 : <%=getCheckValue(result.getInt("field8"), 1, "����", "����")%><br>
								��������Ʈ : <a href=userminus_form3.jsp?p1=19&p2=87&p3=60&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=cashpoint><%=result.getString("cashpoint")%></a>�� <br>
								(�Ǳ��űݾ� VIP)<br><br>

								����귿: <a href=usersetting_ok.jsp?p1=19&p2=86&p3=50&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getWheelToday(result.getInt("wheeltodaycnt"))%>
										  </a>
										  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=51&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getDate10(result.getString("wheeltodaydate"))%>
										  </a>)<br>
								Ȳ�ݷ귿: <a href=usersetting_ok.jsp?p1=19&p2=86&p3=52&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												������ : <%=result.getInt("wheelgauage")%> / 100
										  </a>
										  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=53&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getWheelFree(result.getInt("wheelfree"))%>
										  </a>)<br>
										  ��ü <%=result.getInt("bkwheelcnt")%>ȸ<br><br>

								¥�����������귿:
											<a href=usersetting_ok.jsp?p1=19&p2=86&p3=61&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getZCPChance(result.getInt("zcpchance"))%>
											</a><br>
											�귿���� : <%= getZCPSaleFresh(70, result.getInt("salefresh")) %><br>
											���ȿ��(<%=result.getInt("zcpplus")%>%)
											���ϵ���Ƚ�� : (
															<a href=usersetting_ok.jsp?p1=19&p2=86&p3=62&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
																<%=result.getInt("zcpappearcnt")%>ȸ����
															</a>)<br>
											����Ƚ��(<%=result.getInt("bkzcpcntfree")%>)
											����Ƚ��(<%=result.getInt("bkzcpcntcash")%>) <br><br>
								�Է��� : <%=result.getString("phone2")%><br>
								�Է��ּ� : <%=result.getString("address1")%> <%=result.getString("address1")%><br>
								           <%=result.getString("zipcode")%>

							</td>
							<td>
								���ӳ��:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Game Year(2013 ~ 2999)">
										<%=result.getString("gameyear")%>
									</a>��
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Game Month(1 ~ 12)">
										<%=result.getString("gamemonth")%>
									</a>��
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=3&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Game Day(0 ~ 70)">
										<%=result.getString("frametime")%>
									</a>frame
									<br>
								�ǹ� : <%=result.getString("fevergauge")%><br>
								�絿�� :
									<a href=userminus_form.jsp?mode=81&gameid=<%=result.getString("gameid")%>><%=result.getString("bottlelittle")%></a> �Ѹ��� (+<%=result.getInt("tsskillbottlelittle")%>)
									/
									<a href=userminus_form.jsp?mode=82&gameid=<%=result.getString("gameid")%>><%=result.getString("bottlefresh")%></a> �ѽż���
									<br>
								��ũ :
									<a href=userminus_form.jsp?mode=83&gameid=<%=result.getString("gameid")%>><%=result.getString("tanklittle")%></a> �Ѹ���
									/
									<a href=userminus_form.jsp?mode=84&gameid=<%=result.getString("gameid")%>><%=result.getString("tankfresh")%></a> �ѽż���
									<br><br>

								���Ӱŷ�����:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=6&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Trade Success(0 ~ )">
										<%=result.getString("tradecnt")%>(<%=result.getString("tradecntold")%>)
									</a><br>
								���ӻ���Ƚ��:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=7&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Prize Count(0 ~ )">
										<%=result.getString("prizecnt")%>(<%=result.getString("prizecntold")%>)
									</a><br>
								���Ӱŷ����м���:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=9&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Trade Fail(0 ~ )">
										<%=result.getString("tradefailcnt")%>
									</a><br><br>
								<!--(���Ӽ����� ���д� ��ȣ��Ÿ)-->

								<��å������:
									 <a href=usersetting_ok.jsp?p1=19&p2=64&p3=55&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%> alt="(�ٽú���)">
										<%=result.getInt("settlestep")%>
									</a>
								><br>
								������ �ΰ� �ʱ�ȭ��
								<br><br>

								<��������><br>
								�ŷ�����Ƚ��:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=10&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Trade Fail(0 ~ )">
										<%=result.getString("tradesuccesscnt")%>
									</a><br>
								�ŷ����ι�ȣ:
									<%=result.getInt("tradeclosedealer")%>(<%=getTradeState(result.getInt("tradestate"))%>)<br>
								<br>

								����(����) :
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=4&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Fame(0 ~ )">
										<%=result.getString("fame")%>
									</a><br>
								���� : <%=result.getString("famelv")%>(�ְ�:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=8&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Fame(0 ~ 50)">
										<%=result.getString("famelvbest")%>
									</a>
									)<br>

							</td>
							<td>
								[�б⺰����]<br>
								�ǸŹ跲(�б�) 		: <%=result.getString("qtsalebarrel")%><br>
								�Ǹż���(�б�) 		: <%=result.getString("qtsalecoin")%><br>
								ȹ���(�б�) 		: <%=result.getString("qtfame")%><br>
								������(�б�) 		: <%=result.getString("qtfeeduse")%><br>
								���Ӱŷ�Ƚ��(�б�): <%=result.getString("qttradecnt")%><br>
								�ְ�ŷ���(�б�): <%=result.getString("qtsalecoinbest")%><br><br>

								����� �ֻ���<br>
								��ȣ 		:
											<a href=usersetting_ok.jsp?p1=19&p2=64&p3=52&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=result.getString("yabauidx")%>
											</a>
											<br>
								��ü��� 	: <%
												famelv = result.getInt("famelv") / 10 + 1;
												famelv = famelv * famelv * 100;
												out.println(famelv);
											%><br>
								��ݵ����ֻ���: <%=result.getInt("yabaunum")%><br>
								�õ�Ƚ��	:
									         <a href=userminus_form3.jsp?p1=19&p2=64&p3=53&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Yabauistrycount>
												<%=result.getInt("yabaucount")%>
											</a>
											<br><br>
								�������ϱ��� : <a href=usersetting_ok.jsp?p1=19&p2=64&p3=57&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
													<%=result.getString("anibuycnt")%>
											   </a><br>
											   <a href=usersetting_ok.jsp?p1=19&p2=64&p3=58&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
											  	(<%=getDate10(result.getString("anibuydate"))%>)
											   </a><br><br>

								������Ʋ�ڽ�/�Ϸ�ð� <br>
								1�� : <%=result.getInt("boxslot1")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	���߻���
									  </a>
									  <br>
								2�� : <%=result.getInt("boxslot2")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	���߻���
									  </a><br>
								3�� : <%=result.getInt("boxslot3")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=3&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	���߻���
									  </a><br>
								4�� : <%=result.getInt("boxslot4")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=4&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	���߻���
									  </a><br>
								������:<%=result.getInt("boxslotidx")%>
									  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=41&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	<%=getDateShort2(result.getString("boxslottime"))%>
									  </a>)<br><br>

								Ʈ����(Ƽ��):
									<a href=userminus_form3.jsp?p1=19&p2=64&p3=59&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=trophy>
									  	<%=result.getInt("trophy")%>
									</a>(<%=result.getInt("tier")%>)<br>
								������Ʋ����:
									<%=getUserBattleFlag(result.getInt("userbattleflag"))%><br>
								�ڽ������̼ǹ�ȣ:
									<a href=userminus_form3.jsp?p1=19&p2=64&p3=60&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=boxrotidx>
									  	<%=result.getInt("boxrotidx")%>
									</a><br><br>

							</td>
							<td>


							</td>
							<td>
								������(
								<a href=userminus_form3.jsp?p1=19&p2=64&p3=45&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
								<%
									comreward = result.getInt("comreward");
									out.print(comreward);
								%>
								</a>)<br>
								�ӽô�������(1)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=1&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktwolfkillcnt><%=result.getString("bktwolfkillcnt")%></a><br>
								�ӽ��Ǹűݾ�(11)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=11&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsalecoin><%=result.getString("bktsalecoin")%></a><br>
								�ӽ���Ʈȹ��(12)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=12&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkheart><%=result.getString("bkheart")%></a><br>
								�ӽð���ȹ��(13)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=13&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkfeed><%=result.getString("bkfeed")%></a><br>
								�ӽÿ��Ӽ���Ƚ��(14): <a href=userminus_form3.jsp?p1=19&p2=87&p3=14&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsuccesscnt><%=result.getString("bktsuccesscnt")%></a><br>
								�ְ�ż���(15) 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=15&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestfresh><%=result.getString("bktbestfresh")%></a><br>
								�ְ�跲(16) 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=16&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestbarrel><%=result.getString("bktbestbarrel")%></a><br>
								�ְ��Ǹűݾ�(17)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=17&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestcoin><%=result.getString("bktbestcoin")%></a><br>
								�����跲(18) 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=18&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestbarrel><%=result.getString("bkbarrel")%></a><br>
								�ӽ��Ϲݱ���(21)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=21&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkcrossnormal><%=result.getString("bkcrossnormal")%></a><br>
								�ӽ������̾�����(22): <a href=userminus_form3.jsp?p1=19&p2=87&p3=22&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkcrosspremium><%=result.getString("bkcrosspremium")%></a><br><br>

								�ӽ��Ϲݺ����̱�(23)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=48&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsgrade1cnt><%=result.getString("bktsgrade1cnt")%></a><br>
								�ӽ����������̱�(24)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=49&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsgrade2cnt><%=result.getString("bktsgrade2cnt")%></a><br>
								�ӽú�����ȭȽ��(25)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=50&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=tsupcnt><%=result.getString("bktsupcnt")%></a><br>
								<br>
								�ӽù�Ʋ����Ƚ��(26)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=51&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkbattlecnt><%=result.getString("bkbattlecnt")%></a><br>
								�ӽõ�����ȭ(27)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=52&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkaniupcnt><%=result.getString("bkaniupcnt")%></a><br>
								�ӽõ�������(28)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=58&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkapartani><%=result.getString("bkapartani")%></a><br>
								�ӽú�������(29)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=59&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkapartts><%=result.getString("bkapartts")%></a><br>
								�ӽõ����ռ�(20)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=61&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkcomposecnt><%=result.getString("bkcomposecnt")%></a><br><br>


								ģ����ŷ����Ʈ		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=31&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=ttsalecoin><%=result.getString("ttsalecoin")%></a><br>
								���Ǽҵ�����Ʈ 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=32&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=etsalecoin><%=result.getString("etsalecoin")%></a>
								(<%=result.getString("etremain")%>)<br><br>


								���� ģ��������<br>
								<%=result.getInt("lmcnt")%>���� <%=result.getInt("lmrank")%>��(<%=result.getInt("lmsalecoin")%>��)<br>
								1�� <%=result.getString("l1kakaonickname")%>(<%=result.getString("l1gameid")%>) <%=result.getInt("l1salecoin")%>�� (<%=result.getInt("l1itemcode")%>, <%=result.getInt("l1acc1")%>, <%=result.getInt("l1acc2")%>)<br>
								2�� <%=result.getString("l2kakaonickname")%>(<%=result.getString("l2gameid")%>) <%=result.getInt("l2salecoin")%>�� (<%=result.getInt("l2itemcode")%>, <%=result.getInt("l2acc1")%>, <%=result.getInt("l2acc2")%>)<br>
								3�� <%=result.getString("l3kakaonickname")%>(<%=result.getString("l3gameid")%>) <%=result.getInt("l3salecoin")%>�� (<%=result.getInt("l3itemcode")%>, <%=result.getInt("l3acc1")%>, <%=result.getInt("l3acc2")%>)
							</td>
							<td>
								�ʵ嵿������(30)		<br>
								������(31)			<br>
								ģ���߰�(32)			<br>
								ģ����Ʈ����(33)		<br><br>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan=12>
								Ǫ��<%=checkPush(result.getInt("kkopushallow"))%>:<%=getPushData(result.getString("pushid"))%><br>
								profile : <%=result.getString("kakaoprofile")%>
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
							<td>listidx</td>
							<td>�̸�</td>
							<td>����</td>
							<td>�κ�����</td>
							<td>ȹ����</td>
							<td>ȹ����</td>
							<td>����������</td>

							<td>�ʵ��ȣ</td>
							<td>�ܰ�</td>
							<td>���������</td>
							<td>��������</td>
							<td>��������</td>
							<td>�ʿ䵵��</td>
							<td></td>
							<td>��/����(����)/����(������)</td>
							<td></td>
							<td>����</td>
							<td>�ٱ⼼��(��/��/Ÿ/��/HP)</td>
							<td>�����Ʈ/����</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("listidx")%></td>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td>
									<%if(result.getInt("invenkind") == 3){%>
										<a href=userminus_form2.jsp?p1=19&p2=71&p3=<%=result.getString("listidx")%>&p4=<%=result.getString("cnt")%>&gameid=<%=result.getString("gameid")%>>
											<%=result.getString("cnt")%>
										</a>
									<%}%>
								</td>
								<td><%=getInvenKind(result.getInt("invenkind"))%></td>
								<td><%=getGetHow(result.getInt("gethow"))%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
								<td><%=result.getString("randserial")%></td>
								<td><%=getDieMode(result.getInt("diemode"))%></td>
								<td><%=checkNeedHelpCNT(result.getInt("fieldidx"), result.getInt("needhelpcnt"))%></td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=11&p4=<%=result.getString("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
										<%=result.getString("diedate") == null?"":result.getString("diedate")%>
									</a>
								</td>
								<td>
									<%if( result.getInt("invenkind") == 1000 ){%>
										<a href="userminus_form3.jsp?p1=19&p2=67&p3=<%=result.getInt("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change PetUpgrade(1 ~ 6)">
											<%=result.getString("petupgrade")%> (��)
										</a>
									<%}else if( result.getInt("invenkind") == 1200 ){%>
										<a href="userminus_form3.jsp?p1=19&p2=69&p3=<%=result.getInt("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change TreasureUpgrade(0 ~ <%=result.getString("upstepmax")%>)">
											<%=result.getString("treasureupgrade")%>
										</a> /
										<a href="userminus_form3.jsp?p1=19&p2=70&p3=<%=result.getInt("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change TreasureUpgrade(7 ~ 99)">
											<%=result.getString("upstepmax")%>
										</a>
										(����)
									<%}else if( result.getInt("expirekind") == 1 ){%>
										<%=getDate19(result.getString("expiredate"))%>
										<a href=usersetting_ok.jsp?p1=19&p2=64&p3=110&p4=<%=result.getString("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
											(���߸����ϱ�)
										</a>
									<%}%>
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=31&p3=<%=result.getString("listidx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>���߻���</a>
								</td>

								<td>
									<%=getStemCellUpgrade( result.getInt("invenkind"), result.getInt("upcnt"), result.getInt("upstepmax") )%>
								</td>
								<td>
									<%=getStemCellInfo( result.getInt("invenkind"), result.getInt("freshstem100"), result.getInt("attstem100"), result.getInt("timestem100"), result.getInt("defstem100"), result.getInt("hpstem100") )%>
								</td>
								<td>
									<%=result.getString("usedheart")%> /
									<%=result.getString("usedgamecost")%>
								</td>


							</tr>
						<%}%>
					</table>
				<%}%>
				<br><br>���� ���� �˻��� �ʾ����� ��ũ�� �ű�<br>
				<a href=userdielog_list.jsp?gameid=<%=gameid%> target=_blank>���� ����</a><br><br>
				<a href=useralivelog_list.jsp?gameid=<%=gameid%> target=_blank>���� ��Ȱ</a><br><br>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userdellog_list.jsp?gameid=<%=gameid%> target=_blank>���� ��������/�Ǹŵȵ���/����(������)</a>
					<table border=1>
						<tr>
							<td>listidx[idx]</td>
							<td>�̸�</td>
							<td>����</td>
							<td>�κ�����</td>
							<td>ȹ����</td>
							<td>ȹ����</td>
							<td>����������</td>

							<td>�ʵ��ȣ</td>
							<td>�ܰ�</td>
							<td>���������</td>
							<td>��������</td>
							<td>��������</td>
							<td>�Ӹ��Ǽ�</td>
							<td>�����Ǽ�</td>
							<td>����</td>
							<td>�ٱ⼼��(��/��/Ÿ/��/HP)</td>
							<td>��������</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("listidx")%> [<%=result.getString("idx")%>]</td>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("cnt")%></td>
								<td><%=getInvenKind(result.getInt("invenkind"))%></td>
								<td><%=getGetHow(result.getInt("gethow"))%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
								<td><%=result.getString("randserial")%></td>
								<td><%=getFieldIdx(result.getInt("fieldidx"))%></td>
								<td><%=result.getString("anistep")%></td>
								<td><%=result.getString("manger")%></td>
								<td><%=getDiseasestate(result.getInt("diseasestate"))%></td>
								<td><%=getDieMode(result.getInt("diemode"))%></td>
								<td><%=result.getString("acc1")%></td>
								<td><%=result.getString("acc2")%></td>
								<td><%=getStemCellUpgrade( result.getInt("invenkind"), result.getInt("upcnt"), result.getInt("upstepmax") )%></td>
								<td><%=getStemCellInfo( result.getInt("invenkind"), result.getInt("freshstem100"), result.getInt("attstem100"), result.getInt("timestem100"), result.getInt("defstem100"), result.getInt("hpstem100") )%></td>
								<td><%=result.getString("idx2")%>(<%=getDate(result.getString("writedate2"))%>)</td>
								<td><%=getUserItemState(result.getInt("state"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>���� ������
					<table border=1>
						<tr>
							<td>�ʵ��ȣ</td>
							<td>�̸�</td>
							<td>
								�����ð� ->
								�Ϸ�ð�
							</td>
							<td>
								ȹ���ǰ
							</td>
							<td>��ÿϷ�ĳ��</td>
							<td></td>
						</tr>
						<%
						int _fs = -1;
						while(result.next()){
							_fs = result.getInt("itemcode");%>
							<tr>
							<%if(_fs >= 0){%>
								<td><%=result.getInt("seedidx")%></td>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td>
									<%=getDate19(result.getString("seedstartdate"))%>
									(<%=result.getString("param2")%>��) ->
									<%=getDate19(result.getString("seedenddate"))%>
								</td>
								<td>
									<%=getSeedItemcode(result.getInt("param6"))%>
									(<%=result.getString("param1")%>)��
								</td>
								<td><%=result.getString("param5")%></td>
							<%}else if(_fs == -1){%>
								<td><%=result.getInt("seedidx")%></td>
								<td colspan=4>���� or �����</td>
							<%}else if(_fs == -2){%>
								<td><%=result.getInt("seedidx")%></td>
								<td colspan=4>�̱���</td>
							<%}%>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=85&p3=1&p4=<%=result.getString("seedidx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���ߺ񱸸�</a>
									<a href=usersetting_ok.jsp?p1=19&p2=85&p3=2&p4=<%=result.getString("seedidx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߱���(���)</a>
									<a href=usersetting_ok.jsp?p1=19&p2=85&p3=3&p4=<%=result.getString("seedidx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߽ð��Ϸ�</a>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>���� ����
					<table border=1>
						<tr>
							<!--<td>gameid</td>-->
							<td></td>
							<td>����</td>
							<td>����(���簡)</td>
							<td>1�ð��� ����</td>
							<td>����</td>
							<td></td>
							<td>����</td>
							<td>��·�</td>
							<td>�Ⱦ�����Ѽ���</td>
							<td>����ȱ�</td>
							<td>����</td>
							<td>star</td>
							<td>����Ƚ��</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("farmidx")%></td>
								<td><%=result.getString("itemname")%> (<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("gamecost")%>(<%=result.getString("gamecost2")%>)</td>
								<td><%=result.getString("hourcoin")%>(Max:<%=result.getString("maxcoin")%>)</td>
								<%if(result.getInt("buystate") == 1){%>
									<td><%=result.getInt("hourcoin2") > result.getInt("maxcoin") ? result.getInt("maxcoin") : result.getInt("hourcoin2")%></td>
									<td>
										<a href=usersetting_ok.jsp?p1=19&p2=64&p3=21&p4=<%=result.getString("itemcode")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
											<%=getDate(result.getString("incomedate"))%>
										</a>
									</td>
									<td>
										<a href=usersetting_ok.jsp?p1=19&p2=64&p3=22&p4=<%=result.getString("itemcode")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
											<%=getFarmBuyState(result.getInt("buystate"))%>
										</a>
										(<%=result.getString("buydate")%>)
									</td>
								<%}else{%>
									<td colspan=3>
										<a href=usersetting_ok.jsp?p1=19&p2=64&p3=22&p4=<%=result.getString("itemcode")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
											<%=getFarmBuyState(result.getInt("buystate"))%>
										</a>
									</td>
								<%}%>
								<td><%=result.getString("raisepercent")%>% (<%=result.getString("raiseyear")%>)</td>
								<td><%=result.getString("incomett")%></td>
								<td><%=result.getString("buycount")%></td>
								<td><%=getCheckValue(result.getInt("buywhere"), 1, "��������", "���Ǽҵ庸��")%></td>
								<td><%=result.getString("star")%></td>
								<td><%=result.getString("playcnt")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>���� ���Ǽҵ� ���൵
					<table border=1>
						<tr>
							<td>�̸�</td>
							<td>����⵵</td>
							<td>ȹ������</td>
							<td>���</td>
							<td></td>
							<td>������</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("itemname")%> (<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("etyear")%></td>
								<td><%=result.getString("etsalecoin")%></td>
								<td><%=getETGrade(result.getInt("etgrade"))%></td>
								<td>
									<%=result.getString("etcheckvalue1")%>[<%=getEpiResult(result.getInt("etcheckresult1"))%>] /
									<%=result.getString("etcheckvalue2")%>[<%=getEpiResult(result.getInt("etcheckresult2"))%>] /
									<%=result.getString("etcheckvalue3")%>[<%=getEpiResult(result.getInt("etcheckresult3"))%>] /

								</td>
								<td><%=result.getString("etreward1")%> / <%=result.getString("etreward2")%> / <%=result.getString("etreward3")%> / <%=result.getString("etreward4")%></td>
								<td><%=getDate(result.getString("getdate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=usercomreward.jsp?gameid=<%=gameid%>>������ ����</a>(�����ȣ : <%=comreward%>)</a>
					<table border=1>
						<tr>
							<td></td>
							<td></td>
							<td>������(����)</td>
							<td>�̸�</td>
							<td>��������</td>
							<td>����/������</td>
							<td>üũ1</td>
							<td>üũ2</td>
							<td>������ȣ</td>
							<td>�ʱ�ȭ1</td>
							<td>�ʱ�ȭ2</td>
							<td></td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%>(<%=result.getString("idx2")%>)</td>
								<td><%=result.getString("gameyear")%>�� <%=result.getString("gamemonth")%>��(LV : <%=result.getString("famelv")%>)</td>
								<td><%=result.getString("itemcode")%>(<%=getComRewardCheckPass(result.getInt("ispass"))%>)</td>
								<td><%=result.getString("itemname")%></td>
								<td><%=getComRewardKind(result.getInt("param1"))%></td>
								<td><%=result.getString("param2")%></td>
								<td><%=getComRewardCheckPart(result.getInt("param3"), result.getInt("param4"))%></td>
								<td><%=getComRewardCheckPart(result.getInt("param5"), result.getInt("param6"))%></td>
								<td><%=result.getString("param8")%></td>
								<td><%=getComRewardInitPart(result.getInt("param9"))%></td>
								<td><%=getComRewardInitPart(result.getInt("param10"))%></td>
								<td><%=result.getString("getdate")%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=95&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߻���</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>Ʃ�丮�� ��� ����</a>
					<table border=1>
						<tr>
							<td></td>
							<td>Ʃ�丮����(����)</td>
							<td>�̸�</td>
							<td>��������</td>
							<td>����/������</td>
							<td>������ȣ</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("gameyear")%>�� <%=result.getString("gamemonth")%>��(LV : <%=result.getString("famelv")%>)</td>
								<td><%=result.getString("itemcode")%>(<%=getComRewardCheckPass(result.getInt("ispass"))%>)</td>
								<td><%=result.getString("itemname")%></td>
								<td><%=getComRewardKind(result.getInt("param1"))%></td>
								<td><%=result.getString("param2")%></td>
								<td><%=result.getString("param3")%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=96&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߻���</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=wgiftsend_list.jsp?gameid=<%=gameid%>  target=_blank>���� ���� ����Ʈ(������)</a>
					<table border=1>
						<tr>
							<td>�ε���</td>
							<td>����</td>
							<td></td>
							<td>����</td>
							<td>������</td>
							<td>���</td>
							<td>������</td>

							<td>����</td>
							<td>������</td>
							<td>������</td>
							<td></td>
							<td>����</td>
						</tr>
					<%while(result.next()){%>
						<tr <%=getGiftKindColor(result.getInt("giftkind"))%>>
							<td><%=result.getString("idxt")%></td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("idx2")%></td>
							<td><%=getGiftKind(result.getInt("giftkind"))%></td>

							<%if(result.getInt("giftkind") == 2 || result.getInt("giftkind") == -2  || result.getInt("giftkind") == -3  || result.getInt("giftkind") == -4  ){%>
								<td>
									<%=result.getString("itemname")%>
									(<%=result.getString("itemcode")%> / <%=getGiftCount(result.getInt("subcategory"), result.getInt("buyamount"), result.getInt("cnt"))%>��)
								</td>
								<td><%=getGrade(result.getInt("grade"))%></td>
								<td><%=getDate(result.getString("gaindate"))%></td>

								<td><%=getPrice(result.getInt("gamecost"), result.getInt("cashcost"))%></td>
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
								<td colspan=4>
									<%=result.getString("message")%>
								</td>
								<td><%=result.getString("giftid")%></td>
								<td colspan=2><%=getDate(result.getString("giftdate"))%></td>
							<%}%>
							<td>
								<a href=usersetting_ok.jsp?p1=27&p2=21&p4=<%=result.getInt("idxt")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>������ŷ</a>
								<a href=usersetting_ok.jsp?p1=27&p2=22&p4=<%=result.getInt("idxt")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>���߿���</a>
								<a href=usersetting_ok.jsp?p1=27&p2=23&p4=<%=result.getInt("idxt")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>���߻���</a>
							</td>
						</tr>
					<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=useritembuylog_list.jsp?gameid=<%=gameid%> target=_blank>���� �α�(������)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>itemname</td>
							<td>����</td>
							<td>���α��Ű�/����</td>
							<td>ĳ�����Ű�/����</td>
							<td>buydate</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("idx2")%></td>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("cnt")%></td>
								<td><%=result.getString("gamecost")%> / <%=result.getString("gamecost2")%></td>
								<td><%=result.getString("cashcost")%> / <%=result.getString("cashcost2")%></td>
								<td><%=getDate(result.getString("buydate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=cashbuy_list.jsp?gameid=<%=gameid%> target=_blank>ĳ���α�(������)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>ikind</td>
							<td>������(gameid)</td>
							<td>�����������(giftid)</td>
							<td>��Ż�����(acode)</td>
							<td>Ŭ������(ucode)</td>
							<td>���ŷ��(cashcost)</td>
							<td>����ĳ��(cash)</td>
							<td>kakaouk</td>
							<td>������</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("ikind")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=getIsNull(result.getString("giftid"), "")%></td>
								<td><%=result.getString("acode")%></td>
								<td><%=result.getString("ucode")%></td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("cash")%></td>
								<td><%=result.getString("kakaouk")%></td>
								<td><%=result.getString("writedate")%></td>
								<td><a href=usersetting_ok.jsp?p1=17&p2=1&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>�α׻���</a></td>
							</tr>
							<tr>
								<td colspan=12>
									<%=getXXX2(result.getString("idata"), 40)%><br>
									<%=getXXX2(result.getString("idata2"), 40)%><br>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=cashchange_list.jsp?gameid=<%=gameid%> target=_blank>ĳ��ȯ��(������ 1:100)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>���(ĳ��) -> ����ȯ��</td>
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
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>����ù���� ����</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>������(gameid)</td>
							<td>itemcode</td>
							<td>������</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td>
									<%=result.getString("itemname")%>
									( <%=result.getString("itemcode")%> )
								</td>
								<td><%=result.getString("writedate")%></td>
								<td><a href=usersetting_ok.jsp?p1=17&p2=11&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>�α׻���</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=unusual_list.jsp?gameid=<%=gameid%> target=_blank>�������ൿ(������)</a>
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
					<br><br><a href=unusual_list2.jsp?gameid=<%=gameid%> target=_blank>����������(������)</a>
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
					<br><br><a href=userblock_list.jsp?gameid=<%=gameid%> target=_blank>������(������)</a>
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
								<td><%=getDate(result.getString("writedate"))%></td>
								<td><%=result.getString("comment")%></td>

								<td><%=result.getString("adminid")%></td>
								<td><%=result.getString("adminip")%></td>
								<td><%=getDate(result.getString("releasedate"))%></td>
								<td><%=result.getString("comment2")%></td>
								<td><%=getBlockState(result.getInt("blockstate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userdelete_list.jsp?gameid=<%=gameid%>>��������(������)</a>
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
								<td><%=getDate(result.getString("writedate"))%></td>
								<td><%=result.getString("comment")%></td>

								<td><%=result.getString("adminid")%></td>
								<td><%=result.getString("adminip")%></td>
								<td><%=getDate(result.getString("releasedate"))%></td>
								<td><%=result.getString("comment2")%></td>
								<td><%=getDeleteState(result.getInt("deletestate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>ģ��<!--<a href=userfriend_list.jsp?gameid=<%=gameid%>>ģ�� 10�� ��µ�(������)</a>-->
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>ģ�����̵�</td>
							<td>ģ������</td>
							<td>ģ������</td>
							<td>��Ʈ������</td>
							<td>�������û��</td>
							<td>ģ������������</td>
							<td></td>
							<!--
							<td>ģ�е�</td>
							<td>ģ�������</td>
							-->
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("friendid")%></td>
								<td><%=getFriend(result.getInt("state"))%></td>
								<td><%=getFriendKind(result.getInt("kakaofriendkind"))%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=64&p3=3&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>><%=getDate(result.getString("senddate"))%></a>
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=4&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>><%=getDate(result.getString("helpdate"))%></a>
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=11&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>><%=getDate(result.getString("rentdate"))%></a>
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=97&p3=1&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>>���߰���</a>
									<a href=usersetting_ok.jsp?p1=19&p2=97&p3=2&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>>��ȣ����</a>
								</td>
								<!--
								<td><%=result.getString("familiar")%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
								-->
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=usertreasurelog_list.jsp?gameid=<%=gameid%> target=_blank>�����̱�(������)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>kind</td>
							<td></td>
							<td>����</td>
							<td></td>
							<td>���/����/��Ʈ</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=getCheckRoulMode2(result.getInt("kind"))%></td>
								<td><%=result.getString("gameyear")%>�� <%=result.getString("gamemonth")%>��</td>
								<td><%=result.getString("framelv")%></td>
								<td><%=result.getString("itemcodename")%>(<%=result.getString("itemcode")%>)</td>
								<td>
									<%=result.getString("cashcost")%>
									/ <%=result.getString("gamecost")%>
									/ <%=result.getString("heart")%>
								</td>
								<td><%=result.getString("itemcode0name")%>(<%=result.getString("itemcode0")%>)</td>
								<td><%=result.getString("itemcode1name")%>(<%=result.getString("itemcode1")%>)</td>
								<td><%=result.getString("itemcode2name")%>(<%=result.getString("itemcode2")%>)</td>
								<td><%=result.getString("itemcode3name")%>(<%=result.getString("itemcode3")%>)</td>
								<td><%=result.getString("itemcode4name")%>(<%=result.getString("itemcode4")%>)</td>
								<td><%=result.getString("itemcode5name")%>(<%=result.getString("itemcode5")%>)</td>
								<td><%=result.getString("itemcode6name")%>(<%=result.getString("itemcode6")%>)</td>
								<td><%=result.getString("itemcode7name")%>(<%=result.getString("itemcode7")%>)</td>
								<td><%=result.getString("itemcode8name")%>(<%=result.getString("itemcode8")%>)</td>
								<td><%=result.getString("itemcode9name")%>(<%=result.getString("itemcode9")%>)</td>
								<td><%=result.getString("itemcode10name")%>(<%=result.getString("itemcode10")%>)</td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=usercomplog_list.jsp?gameid=<%=gameid%> target=_blank>�ռ�(������)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>����</td>
							<td></td>
							<td></td>
							<td>���(ĳ��)</td>
							<td>����</td>
							<td>��Ʈ</td>
							<td>�ռ�Ƽ��</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameyear")%>�� <%=result.getString("gamemonth")%>��</td>
								<td><%=result.getString("famelv")%></td>
								<td><%=getComposeKind(result.getInt("kind"))%></td>
								<td><%=result.getString("itemcodename")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("gamecost")%></td>
								<td><%=result.getString("heart")%></td>
								<td><%=result.getString("ticket")%></td>
								<td><%=result.getString("itemcode0name")%>(<%=result.getString("itemcode0")%>/<%=result.getString("itemcode1")%>/<%=result.getString("itemcode2")%>/<%=result.getString("itemcode3")%>/<%=result.getString("itemcode4")%>)</td>
								<td>
									<%=result.getString("bgcomposename")%>
									([<%=result.getString("bgcomposeic")%>] <%=getComposeResult(result.getInt("bgcomposert"))%>)
								</td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>



				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userpromotelog_list.jsp?gameid=<%=gameid%> target=_blank>�±�(������)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>����</td>
							<td></td>
							<td></td>
							<td>���(ĳ��)</td>
							<td>����</td>
							<td>��Ʈ</td>
							<td>�±�Ƽ��</td>
							<td>�±�(��)</td>
							<td>�±�(����)</td>
							<td>�±�(���)</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameyear")%>�� <%=result.getString("gamemonth")%>��</td>
								<td><%=result.getString("famelv")%></td>
								<td><%=getPromoteKind(result.getInt("kind"))%></td>
								<td><%=result.getString("itemcodename")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("gamecost")%></td>
								<td><%=result.getString("heart")%></td>
								<td><%=result.getString("ticket")%></td>
								<td><%=result.getString("itemcode0")%>/<%=result.getString("itemcode1")%>/<%=result.getString("itemcode2")%>/<%=result.getString("itemcode3")%>/<%=result.getString("itemcode4")%></td>
								<td><%=result.getString("resultlist")%></td>
								<td>
									<%=result.getString("bgpromotename")%>
									(<%=result.getString("bgpromoteic")%>)
								</td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userroullog_list2.jsp?gameid=<%=gameid%> target=_blank>�Ǽ��̱�(������)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>framelv</td>
							<td>���(ĳ��)</td>
							<td>����</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("framelv")%></td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("gamecost")%></td>
								<td><%=result.getString("itemcode0name")%>(<%=result.getString("itemcode0")%>)</td>
								<td><%=result.getString("itemcode1name")%>(<%=result.getString("itemcode1")%>)</td>
								<td><%=result.getString("itemcode2name")%>(<%=result.getString("itemcode2")%>)</td>
								<td><%=result.getString("itemcode3name")%>(<%=result.getString("itemcode3")%>)</td>
								<td><%=result.getString("itemcode4name")%>(<%=result.getString("itemcode4")%>)</td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userroullog_list3.jsp?gameid=<%=gameid%> target=_blank>����� �ֻ���(������)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>framelv</td>
							<td>���(ĳ��)</td>
							<td>����</td>
							<td>�ܰ�1</td>
							<td>�ܰ�2</td>
							<td>�ܰ�3</td>
							<td>�ܰ�4</td>
							<td>�ܰ�5</td>
							<td>�ܰ�6</td>
							<td>�ֻ������/ȹ��ܰ�</td>
							<td>���</td>
							<td>����</td>
							<td>�ܰ�</td>
							<td>����Ʈ ����</td>
							<td>�õ�Ƚ��</td>
							<td>�����ݾ�(����)</td>
							<td>�����ݾ�(���)</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td>
									<a href=userroullog_list3.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>
								</td>
								<td><%=result.getString("framelv")%></td>
								<td><%=result.getString("itemcode")%></td>
								<td><%=getYabauCheck(result.getInt("kind"))%></td>
								<%
								kind = result.getInt("kind");
								if(kind == 1){%>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								<%}else if(kind == 4){%>
									<td><%=result.getString("pack11")%></td>
									<td><%=result.getString("pack21")%></td>
									<td><%=result.getString("pack31")%></td>
									<td><%=result.getString("pack41")%></td>
									<td><%=result.getString("pack51")%></td>
									<td><%=result.getString("pack61")%></td>
									<td></td>
									<td></td>
									<td></td>
								<%}else if(kind == 3 || kind == 2){%>
									<td><%=result.getString("pack11")%></td>
									<td><%=result.getString("pack21")%></td>
									<td><%=result.getString("pack31")%></td>
									<td><%=result.getString("pack41")%></td>
									<td><%=result.getString("pack51")%></td>
									<td><%=result.getString("pack61")%></td>
									<td><%=getYabauResult(result.getInt("result"))%></td>
									<td><%=result.getString("cashcost")%></td>
									<td><%=result.getString("gamecost")%></td>
								<%}%>
								<td><%=result.getString("yabauchange")%></td>
								<td><%=result.getString("yabaucount")%></td>
								<td><%=result.getString("remaingamecost")%></td>
								<td><%=result.getString("remaincashcost")%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>�굵��</a>
					<table border=1>
						<tr>
							<td>��(itemcode)</td>
							<td>ȹ����</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("getdate")%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=92&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߻���</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>��������:(���κ���)</a>
					<table border=1>
						<tr>
							<td>����(itemcode)</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=90&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߻���</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>��������(���κ���)</a>
					<table border=1>
						<tr>
							<td>������ȣ</td>
							<td>��������(�������ڵ�)</td>
							<td>��������</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("param1")%></td>
								<td>
									<%=result.getString("param2")%> /
									<%=result.getString("param3")%> /
									<%=result.getString("param4")%> /
									<%=result.getString("param5")%> /
									<%=result.getString("param6")%> /
									<%=result.getString("param7")%>
								</td>
								<td>
									<%=result.getString("param8")%>(<%=result.getString("param9")%>��)
								</td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=91&p3=<%=result.getString("param1")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߻���</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>



				<%if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();%>
					<br><br><a href=adminusersalelog_list.jsp?gameid=<%=gameid%> target=_blank>�ŷ�����(�ֱ�10���� ����) ������</a>
					<table border=1>
						<tr>
							<td></td>
							<td>�ŷ���</td>
							<td>����/����</td>
							<td>������</td>
							<td>�Ѽ���(0)</td>
							<td>�Ǹűݾ�(1)</td>
							<td>���ο䱸</td>
							<td>����ݾ�(2)</td>
							<td>������ȹ��ݾ�(3)</td>
							<td>������(�ʰ�������)</td>
							<td>���Ƽ��</td>
							<td></td>
							<td>�α�(�ҽ������)</td>
							<td>���/����/��Ʈ/����/����</td>
							<td>����ǰ</td>
						</tr>
						<%while(result.next()){
							earncoin += result.getInt("salecoin") + result.getInt("prizecoin"); %>
							<tr>
								<td><%=num++%></td>
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
								<td><a href=usersetting_ok.jsp?p1=19&p2=66&p3=1&p4=<%=result.getString("idx2")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߻���</a></td>
								<td>
									<%=getDate(result.getString("writedate"))%>
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
						<tr>
							<td colspan=14>
								�Ѽ��� : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>��������(������ �����մϴ�.)</a>
					<table border=1>
						<tr>
							<td></td>
							<td></td>
							<td>fevergauge</td>
							<td>bottlelittle/fresh</td>
							<td>tanklittle/fresh</td>
							<td>feeduse</td>
							<td>boosteruse</td>
							<td>albause</td>
							<td>wolfappear/killcnt</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx2")%></td>
								<td>
									<%=result.getString("gameyear")%>��
									<%=result.getString("gamemonth")%>��
									<%=result.getString("frametime")%>��
								</td>
								<td><%=result.getString("fevergauge")%></td>
								<td><%=result.getString("bottlelittle")%> 	/ <%=result.getString("bottlefresh")%></td>
								<td><%=result.getString("tanklittle")%>		/ <%=result.getString("tankfresh")%></td>
								<td><%=result.getString("feeduse")%></td>
								<td><%=result.getString("boosteruse")%></td>
								<td><%=result.getString("albause")%> / <%=result.getString("albausesecond")%> / <%=result.getString("albausethird")%></td>
								<td><%=result.getString("wolfappear")%>		/ <%=result.getString("wolfkillcnt")%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=66&p3=11&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>���߻���</a></td>
							</tr>
							<tr>
								<td colspan=10>
									userinfo 	: <%=getSubString(result.getString("userinfo"))%><br>
									aniitem		: <%=getSubString(result.getString("aniitem"))%><br>
									cusitem		: <%=getSubString(result.getString("cusitem"))%>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>



				<%if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();%>
					<br><br><a href=adminfarmbattlelog_list.jsp?gameid=<%=gameid%> target=_blank>�����Ʋ����(�ֱ�10���� ����) ������</a>
					<table border=1>
						<tr>
							<td>��Ʋ��ȣ</td>
							<!--<td>gameid</td>-->
							<td>�����ȣ</td>
							<td>���</td>
							<td>������</td>
							<td>����1</td>
							<td>����2</td>
							<td>����3</td>
							<td>����1</td>
							<td>����2</td>
							<td>����3</td>
							<td>����4</td>
							<td>����5</td>
							<td>������</td>
							<td>�÷���Ÿ��</td>
							<td>������</td>
							<td>��������</td>
							<td>star</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx2")%></td>
								<td><%=result.getString("farmidx")%></td>
								<td><%=getBattleResult(result.getInt("result"))%></td>
								<td><%=result.getString("enemydesc")%></td>
								<td><%=result.getString("anidesc1")%></td>
								<td><%=result.getString("anidesc2")%></td>
								<td><%=result.getString("anidesc3")%></td>
								<td><%=result.getString("ts1name")%></td>
								<td><%=result.getString("ts2name")%></td>
								<td><%=result.getString("ts3name")%></td>
								<td><%=result.getString("ts4name")%></td>
								<td><%=result.getString("ts5name")%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
								<td><%=result.getString("playtime")%></td>
								<td>
									<%=result.getString("reward1")%>
									/ <%=result.getString("reward2")%>
									/ <%=result.getString("reward3")%>
									/ <%=result.getString("reward4")%>
									/ <%=result.getString("reward5")%>
								</td>
								<td><%=result.getString("rewardgamecost")%></td>
								<td><%=result.getString("star")%></td>
							</tr>
						<%}%>
						<tr>
							<td colspan=14>
								�Ѽ��� : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();%>
					<br><br><a href=adminuserbattlelog_list.jsp?gameid=<%=gameid%> target=_blank>������Ʋ����(�ֱ�10���� ����) ������</a>
					<table border=1>
						<tr>
							<td>��Ʋ��ȣ</td>
							<td>���</td>
							<td>trophy(tier)</td>
							<td>����1</td>
							<td>����2</td>
							<td>����3</td>
							<td>����1</td>
							<td>����2</td>
							<td>����3</td>
							<td>����4</td>
							<td>����5</td>
							<td>����(gameid/nickname)</td>
							<td>����(trophy/tier)</td>
							<td>����(bankidx)</td>
							<td>������</td>
							<td>�÷���Ÿ��</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx2")%></td>
								<td><%=getBattleResult(result.getInt("result"))%></td>
								<td><%=result.getString("trophy")%>(<%=result.getString("tier")%>)</td>
								<td><%=result.getString("anidesc1")%></td>
								<td><%=result.getString("anidesc2")%></td>
								<td><%=result.getString("anidesc3")%></td>
								<td><%=result.getString("ts1name")%></td>
								<td><%=result.getString("ts2name")%></td>
								<td><%=result.getString("ts3name")%></td>
								<td><%=result.getString("ts4name")%></td>
								<td><%=result.getString("ts5name")%></td>
								<td><%=result.getString("othergameid")%>(<%=result.getString("othernickname")%>)</td>
								<td><%=result.getString("othertrophy")%>(<%=result.getString("othertier")%>)</td>
								<td>
									<a href=adminuserbattlebank_list.jsp?idx=<%=result.getString("otheridx")%> target=_blank><%=result.getString("otheridx")%></a>
								</td>
								<td><%=getDate(result.getString("writedate"))%></td>
								<td><%=result.getString("playtime")%></td>
							</tr>
						<%}%>
						<tr>
							<td colspan=14>
								�Ѽ��� : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();%>
					<br><br><a href=adminuserbattlebank_list.jsp?gameid=<%=gameid%> target=_blank>������Ʋ��ũ(�ֱ�10���� ����) ������</a>
					<table border=1>
						<tr>
							<td>��ũ��ȣ</td>
							<td>Ʈ����(Ƽ��)</td>
							<td>����1(�ڵ�/��ȭ/att/def/hp/time)</td>
							<td>����2</td>
							<td>����3</td>
							<td>����1(��ȭ)</td>
							<td>����2</td>
							<td>����3</td>
							<td>����4</td>
							<td>����5</td>
							<td>������</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx2")%></td>
								<td><%=result.getInt("trophy")%>(<%=result.getInt("tier")%>)</td>
								<td>
									<%=result.getString("aniitemcode1")%> /
									<%=result.getString("upcnt1")%> /
									<%=result.getString("attstem1")%> /
									<%=result.getString("defstem1")%> /
									<%=result.getString("hpstem1")%> /
									<%=result.getString("timestem1")%> /
								</td>
								<td>
									<%=result.getString("aniitemcode2")%> /
									<%=result.getString("upcnt2")%> /
									<%=result.getString("attstem2")%> /
									<%=result.getString("defstem2")%> /
									<%=result.getString("hpstem2")%> /
									<%=result.getString("timestem2")%> /
								</td>
								<td>
									<%=result.getString("aniitemcode3")%> /
									<%=result.getString("upcnt3")%> /
									<%=result.getString("attstem3")%> /
									<%=result.getString("defstem3")%> /
									<%=result.getString("hpstem3")%> /
									<%=result.getString("timestem3")%> /
								</td>
								<td><%=result.getString("treasure1")%>(<%=result.getString("treasureupgrade1")%>)</td>
								<td><%=result.getString("treasure2")%>(<%=result.getString("treasureupgrade2")%>)</td>
								<td><%=result.getString("treasure3")%>(<%=result.getString("treasureupgrade3")%>)</td>
								<td><%=result.getString("treasure4")%>(<%=result.getString("treasureupgrade4")%>)</td>
								<td><%=result.getString("treasure5")%>(<%=result.getString("treasureupgrade5")%>)</td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
						<tr>
							<td colspan=14>
								�Ѽ��� : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=zcplog_list.jsp?gameid=<%=gameid%> target=_blank>�α�(������)</a>
					<table border=1>
						<tr>
							<td></td>
							<td>����</td>
							<td>���ĳ��/����ĳ��</td>
							<td>buydate</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx2")%></td>
								<td><%=getZCPMode(result.getInt("mode"))%></td>
								<td><%=result.getString("usedcashcost")%> / <%=result.getString("ownercashcost")%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

			</div>
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
