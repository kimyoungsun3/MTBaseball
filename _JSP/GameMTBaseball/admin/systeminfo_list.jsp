<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.io.*"%>
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

	String pluscashcosts[] = {
			"0", 		"���(ĳ��)�߰�(0%)",
			"5", 		"���(ĳ��)�߰�(5%)",
			"10", 		"���(ĳ��)�߰�(10%)",
			"15", 		"���(ĳ��)�߰�(15%)",
			"20", 		"���(ĳ��)�߰�(20%)",
			"25", 		"���(ĳ��)�߰�(25%)",
			"30", 		"���(ĳ��)�߰�(30%)",
			"35", 		"���(ĳ��)�߰�(35%)",
			"40", 		"���(ĳ��)�߰�(40%)",
			"45", 		"���(ĳ��)�߰�(45%)",
			"50", 		"���(ĳ��)�߰�(50%)",
			"60", 		"���(ĳ��)�߰�(60%)",
			"70", 		"���(ĳ��)�߰�(70%)",
			"80", 		"���(ĳ��)�߰�(80%)",
			"90", 		"���(ĳ��)�߰�(90%)",
			"100", 		"���(ĳ��)�߰�(100%)",
	};

	String plusgamecosts[] = {
			"0", 		"�����߰�(0%)",
			"5", 		"�����߰�(5%)",
			"10", 		"�����߰�(10%)",
			"15", 		"�����߰�(15%)",
			"20", 		"�����߰�(20%)",
			"30", 		"�����߰�(30%)",
			"40", 		"�����߰�(40%)",
			"50", 		"�����߰�(50%)",
			"60", 		"�����߰�(60%)",
			"70", 		"�����߰�(70%)",
			"80", 		"�����߰�(80%)",
			"90", 		"�����߰�(90%)",
			"100", 		"�����߰�(100%)",
			"150", 		"�����߰�(150%)",
			"200", 		"�����߰�(200%)"
	};

	String plushearts[] = {
			"0", 		"��Ʈ�߰�(0%)",
			"5", 		"��Ʈ�߰�(5%)",
			"10", 		"��Ʈ�߰�(10%)",
			"15", 		"��Ʈ�߰�(15%)",
			"20", 		"��Ʈ�߰�(20%)",
			"30", 		"��Ʈ�߰�(30%)",
			"40", 		"��Ʈ�߰�(40%)",
			"50", 		"��Ʈ�߰�(50%)",
			"60", 		"��Ʈ�߰�(60%)",
			"70", 		"��Ʈ�߰�(70%)",
			"80", 		"��Ʈ�߰�(80%)",
			"90", 		"��Ʈ�߰�(90%)",
			"100", 		"��Ʈ�߰�(100%)"
	};


	String plusfeeds[] = {
			"0", 		"�����߰�(0%)",
			"5", 		"�����߰�(5%)",
			"10", 		"�����߰�(10%)",
			"15", 		"�����߰�(15%)",
			"20", 		"�����߰�(20%)",
			"30", 		"�����߰�(30%)",
			"40", 		"�����߰�(40%)",
			"50", 		"�����߰�(50%)",
			"60", 		"�����߰�(60%)",
			"70", 		"�����߰�(70%)",
			"80", 		"�����߰�(80%)",
			"90", 		"�����߰�(90%)",
			"100", 		"�����߰�(100%)"
	};

	String plusgoldtickets[] = {
			"0", 		"���Ƽ���߰�(0%)",
			"5", 		"���Ƽ���߰�(5%)",
			"10", 		"���Ƽ���߰�(10%)",
			"15", 		"���Ƽ���߰�(15%)",
			"20", 		"���Ƽ���߰�(20%)",
			"30", 		"���Ƽ���߰�(30%)",
			"40", 		"���Ƽ���߰�(40%)",
			"50", 		"���Ƽ���߰�(50%)",
			"60", 		"���Ƽ���߰�(60%)",
			"70", 		"���Ƽ���߰�(70%)",
			"80", 		"���Ƽ���߰�(80%)",
			"90", 		"���Ƽ���߰�(90%)",
			"100", 		"���Ƽ���߰�(100%)"
	};

	String plusbattletickets[] = {
			"0", 		"��ƲƼ���߰�(0%)",
			"5", 		"��ƲƼ���߰�(5%)",
			"10", 		"��ƲƼ���߰�(10%)",
			"15", 		"��ƲƼ���߰�(15%)",
			"20", 		"��ƲƼ���߰�(20%)",
			"30", 		"��ƲƼ���߰�(30%)",
			"40", 		"��ƲƼ���߰�(40%)",
			"50", 		"��ƲƼ���߰�(50%)",
			"60", 		"��ƲƼ���߰�(60%)",
			"70", 		"��ƲƼ���߰�(70%)",
			"80", 		"��ƲƼ���߰�(80%)",
			"90", 		"��ƲƼ���߰�(90%)",
			"100", 		"��ƲƼ���߰�(100%)"
	};

	int accprice[] 	= {	  10};//,	11,	12,	13,	14};
	int accsale[] 	= {	  10,	20,	30,	40,	50, 60, 70, 0};
	int composesale[]= {  0,	5, 10,	15,	20,	25, 30, 35};

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
	var ps9 = '1:' + f.ps9_1.value + ';'
		    + '2:' + f.ps9_2.value + ';'
		    + '3:' + f.ps9_3.value + ';'
		    + '4:' + f.ps9_4.value + ';'
		    + '10:' + f.ps9_10.value + ';'
		    + '11:' + f.ps9_11.value + ';'
		    + '12:' + f.ps9_12.value + ';'
		    + '13:' + f.ps9_13.value + ';'
		    + '14:' + f.ps9_14.value + ';'
		    + '15:' + f.ps9_15.value + ';'
		    + '16:' + f.ps9_16.value + ';'
		    + '20:' + f.ps9_20.value + ';'
		    + '21:' + f.ps9_21.value + ';'
		    + '22:' + f.ps9_22.value + ';'

	f.ps9.value = ps9;

	if(f_nul_chk(f.itemcode, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.itemcode.focus();">
<table align=center>
	<tbody>
	<tr>
		<td align="center">

			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="1">
					<input type="hidden" name="ps9" value="">
					<input type="hidden" name="branch" value="systeminfo_list">
					<tr>
						<td>
							���(ĳ��) ���Ž� �߰� :
							<select name="ps9_10" >
								<%for(int i = 0; i < pluscashcosts.length; i+=2){%>
									<option value="<%=pluscashcosts[i]%>" ><%=pluscashcosts[i+1]%></option>
								<%}%>
							</select>

							���� ȯ���� �߰� :
							<select name="ps9_11" >
								<%for(int i = 0; i < plusgamecosts.length; i+=2){%>
									<option value="<%=plusgamecosts[i]%>" ><%=plusgamecosts[i+1]%></option>
								<%}%>
							</select>

							��Ʈ ���Ž� �߰� :
							<select name="ps9_12" >
								<%for(int i = 0; i < plushearts.length; i+=2){%>
									<option value="<%=plushearts[i]%>" ><%=plushearts[i+1]%></option>
								<%}%>
							</select>

							���� ���Ž� �߰� :
							<select name="ps9_13" >
								<%for(int i = 0; i < plusfeeds.length; i+=2){%>
									<option value="<%=plusfeeds[i]%>" ><%=plusfeeds[i+1]%></option>
								<%}%>
							</select><br>

							���Ƽ�� ���Ž� �߰� :
							<select name="ps9_14" >
								<%for(int i = 0; i < plusgoldtickets.length; i+=2){%>
									<option value="<%=plusgoldtickets[i]%>" ><%=plusgoldtickets[i+1]%></option>
								<%}%>
							</select>

							�ο�Ƽ�� ���Ž� �߰� :
							<select name="ps9_15" >
								<%for(int i = 0; i < plusbattletickets.length; i+=2){%>
									<option value="<%=plusbattletickets[i]%>" ><%=plusbattletickets[i+1]%></option>
								<%}%>
							</select>
							<!--
							�Ǽ��̱�(����) :
							<select name="ps3" >
								<%for(int i = 0; i < accprice.length; i++){%>
									<option value="<%=accprice[i]%>" <%=getSelect(0, i)%> ><%=accprice[i]%>���</option>
								<%}%>
							</select>

							�Ǽ��̱�(����) :
							<select name="ps4" >
								<%for(int i = 0; i < accsale.length; i++){%>
									<option value="<%=accsale[i]%>" <%=getSelect(4, i)%> ><%=accsale[i]%>%����</option>
								<%}%>
							</select>
							-->

							�ռ�(����) :
							<select name="ps9_16" >
								<%for(int i = 0; i < composesale.length; i++){%>
									<option value="<%=composesale[i]%>" <%=getSelect(0, i)%> ><%=composesale[i]%>%����</option>
								<%}%>
							</select>
							<!--
							iPhone����â :
							<select name="ps6" >
								<option value="0">�Ⱥ��̰� �ϱ�(0)</option>
								<option value="1">���̰� �ϱ�(1)</option>
							</select>
							-->
							<br>

							���ƽ� :
							<select name="ps7" >
								<%for(int i = 6; i <= 8; i++){%>
									<option value="<%=i%>" <%=getSelect(8, i)%> ><%=i%>Max</option>
								<%}%>
							</select>

							��ũ, ǰ��,���, �絿��, ������, ���Ա�Max :
							<select name="ps8" >
								<%for(int i = 20; i <= 28; i++){%>
									<option value="<%=i%>" <%=getSelect(28, i)%> ><%=i%>Max</option>
								<%}%>
							</select><br>
							�ʴ�10�� : <input name="ps9_1" type="text" value="2000" 	size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							�ʴ�20�� : <input name="ps9_2" type="text" value="100009" 	size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							�ʴ�30�� : <input name="ps9_3" type="text" value="6" 		size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							�ʴ�40�� : <input name="ps9_4" type="text" value="100004" 	size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<br>

							Ȳ�ݷ귿���� :
							<select name="ps9_20" >
								<option value="1" >Ȱ��(1)</option>
								<option value="-1">��Ȱ��(-1)</option>
							</select>
							point:<input name="ps9_21" type="text" value="10" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							max:<input name="ps9_22" type="text" value="100" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<font color=red>Max�� 100����</font>

						</td>
					</tr>
					<td>
						<br>
						�ڸ�Ʈ : <input name="ps10" type="text" value="�ڸ�Ʈ" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
					</td>
					<tr>
						<td>
							iteminfo -> system info��м�(�Ǽ��̱� ������ �α��ΰ� �Ǽ��̱� SPU�� ����Ǿ� �ֽ��ϴ�.)<br>
							���ʹ� �������� �̾ �۵��մϴ�. ������忡���� ������ �����մϴ�.<br>
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>

				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_GameMTBaseballD 30, 2, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- �ü� ���� ����Ʈ
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 30);
					cstmt.setInt(idxColumn++, 2);
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
							<td>idx</td>
							<td>��Max</td>
							<td>��ũ, ǰ��,���, �絿��, ������, ���Ա�Max</td>
							<td>�κ��ܰ�, Ȯ��ƽ�, ������</td>
							<td>�ʵ�</td>
							<td>plus���(ĳ��)</td>
							<td>plus����</td>
							<td>plus��Ʈ</td>
							<td>plus����</td>
							<td>plus���Ƽ��</td>
							<td>plus��ƲƼ��</td>
							<td>Ȳ�ݷ귿(������)</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="p1" value="30">
							<input type="hidden" name="p2" value="3">
							<input type="hidden" name="p3" value="<%=result.getString("idx")%>">
							<input type="hidden" name="branch" value="systeminfo_list">
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("housestepmax")%></td>
							<td>
								<%=result.getString("bottlestepmax")%>,
								<%=result.getString("tankstepmax")%>,
								<%=result.getString("pumpstepmax")%>,
								<%=result.getString("transferstepmax")%>,
								<%=result.getString("purestepmax")%>,
								<%=result.getString("freshcoolstepmax")%>
							</td>
							<td>
								<%=result.getString("invenstepmax")%>,
								<%=result.getString("invencountmax")%>,
								<%=result.getString("seedfieldmax")%>
							</td>
							<td>
								5[<%=result.getString("field5lv")%>],
								6[<%=result.getString("field6lv")%>],
								7[<%=result.getString("field7lv")%>],
								8[<%=result.getString("field8lv")%>]
							</td>
							<td>
								<%for(int i = 0; i < pluscashcosts.length; i+=2){
									if(result.getString("pluscashcost").equals(pluscashcosts[i])){
										out.println(pluscashcosts[i+1]);
										break;
									}
								}%>
							</td>
							<td>
								<%for(int i = 0; i < plusgamecosts.length; i+=2){
									if(result.getString("plusgamecost").equals(plusgamecosts[i])){
										out.println(plusgamecosts[i+1]);
										break;
									}
								}%>
							</td>
							<td>
								<%for(int i = 0; i < plushearts.length; i+=2){
									if(result.getString("plusheart").equals(plushearts[i])){
										out.println(plushearts[i+1]);
										break;
									}
								}%>
							</td>
							<td>
								<%for(int i = 0; i < plusfeeds.length; i+=2){
									if(result.getString("plusfeed").equals(plusfeeds[i])){
										out.println(plusfeeds[i+1]);
										break;
									}
								}%>
							</td>
							<td>
								<%for(int i = 0; i < plusgoldtickets.length; i+=2){
									if(result.getString("plusgoldticket").equals(plusgoldtickets[i])){
										out.println(plusgoldtickets[i+1]);
										break;
									}
								}%>
							</td>
							<td>
								<%for(int i = 0; i < plusbattletickets.length; i+=2){
									if(result.getString("plusbattleticket").equals(plusbattletickets[i])){
										out.println(plusbattletickets[i+1]);
										break;
									}
								}%>
							</td>
							<!--
							<td>
								<%=result.getInt("roulaccprice")%>���
								<%=result.getInt("roulaccsale")%>%�Ǽ�����
								> <%=(result.getInt("roulaccprice") - result.getInt("roulaccprice") * result.getInt("roulaccsale")/100)%> ���
							</td>
							<td>
								<%=result.getInt("composesale")%>% ����
							</td>
							<td>
								iPhone�����Է� <%=getIPhoneCoupon(result.getInt("iphonecoupon"))%>
							</td>
							-->
							<td <%=getCheckValueOri(result.getInt("wheelgauageflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="p4" >
										<option value="1" <%=getSelect(result.getInt("wheelgauageflag"),  1)%>>Ȱ��(1)</option>
										<option value="-1" <%=getSelect(result.getInt("wheelgauageflag"), -1)%>>��Ȱ��(-1)</option>
									</select><br>
									point:<input name="p5" type="text" value="<%=result.getInt("wheelgauagepoint")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									max:<input name="p6" type="text" value="<%=result.getInt("wheelgauagemax")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<font color=red>Max�� 100����</font>
								</td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
						<tr>
							<td></td>
							<td colspan=2>
								<a href=usersetting_ok.jsp?p1=30&p2=4&p3=<%=result.getString("idx")%>&branch=systeminfo_list>
									<%=getReturnState(result.getInt("rtnflag"))%>
								</a>
							</td>
							<td colspan=8>
								<img src=<%=imgroot%>/<%=result.getInt("kakaoinvite01")%>.png>
								<img src=<%=imgroot%>/<%=result.getInt("kakaoinvite02")%>.png>
								<img src=<%=imgroot%>/<%=result.getInt("kakaoinvite03")%>.png>
								<img src=<%=imgroot%>/<%=result.getInt("kakaoinvite04")%>.png>
							</td>
							<td>
								<input name="ps10" type="text" value="<%=result.getString("comment")%>" size="40" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
								<%=getDate(result.getString("writedate"))%>
							</td>
						</tr>
						</form>
					<%}%>
				</table>
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
