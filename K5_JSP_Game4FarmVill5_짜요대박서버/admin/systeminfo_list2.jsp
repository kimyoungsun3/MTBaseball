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

	String itemdesc[], itemdesc2[];
	String packs[] = new String[5];
	int itemcode[], gamecosts[], cashcosts[];
	int cnt = 0, pack = 0, gamecost = 0, cashcost = 0;
	int view	 		= util.getParamInt(request, "view", 0);
	String market[] = {
			""+SKT, 		"SKT(" + SKT + ")",
			""+GOOGLE, 		"GOOGLE(" + GOOGLE + ")",
			""+IPHONE,		"IPHONE(" + IPHONE + ")"
			//""+NHN,		"NHN(" + NHN + ")"
	};

	try{
		//2. ����Ÿ ����
		//exec spu_FarmD 30, 7, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
		query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 7);
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

		if(result.next()){
			cnt = result.getInt("cnt");
		}
		itemdesc = new String[cnt + 1];
		itemdesc2 = new String[cnt + 1];
		itemcode = new int[cnt + 1];
		gamecosts = new int[cnt + 1];
		cashcosts = new int[cnt + 1];

		int k = 1;
		itemdesc[0] = "����";
		itemdesc2[0] = "����";
		itemcode[0] = -1;
		gamecosts[0] = 0;
		cashcosts[0] = 0;

		if(cstmt.getMoreResults()){
			result = cstmt.getResultSet();
			while(result.next()){
				itemdesc[k] = result.getString("itemname") + "x" + result.getString("buyamount") + "��"
									+ "(" + result.getString("gamecost") + " ����, "
									+ result.getString("cashcost") + " ���"
									+ "[" + result.getString("itemcode") + "]"
									+ ")";
				itemdesc2[k] = result.getString("itemname") + "x" + result.getString("buyamount") + "��";
				gamecosts[k] = result.getInt("gamecost");
				cashcosts[k] = result.getInt("cashcost");
				itemcode[k] = result.getInt("itemcode");
				k++;
			}
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
	var ps9 = '1:' + f.d1.value + ';'
		    + '2:' + f.d2.value + ';'
		    + '3:' + f.d3.value + ';'
		    + '4:' + f.d4.value + ';'
		    + '5:' + f.d5.value + ';'
		    + '6:' + f.d6.value + ';'
		    + '7:' + f.d7.value + ';'
		    + '15:' + f.d15.value + ';'
		    + '16:' + f.d16.value + ';'
		    + '17:' + f.d17.value + ';'
		    + '10:' + f.d10.value + ';'
		    + '11:' + f.d11.value + ';'
		    + '12:' + f.d12.value + ';'
		    + '13:' + f.d13.value + ';'
		    + '14:' + f.d14.value + ';'
		    + '20:' + f.d20.value + ';'
		    + '21:' + f.d21.value + ';'
		    + '22:' + f.d22.value + ';'
		    + '23:' + f.d23.value + ';'
		    + '24:' + f.d24.value + ';'
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

				<a href=systeminfo_list2.jsp?view=1>�Էº���</a><a href=systeminfo_list2.jsp?view=0>�׳ɺ���</a>
				<%if(view == 1){%>
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="5">
					<input type="hidden" name="ps9" value="">
					<input type="hidden" name="branch" value="systeminfo_list2">
					<tr>
						<td>����</td>
						<td>
							SKT(1), GOOGLE(5), IPHONE(7)�� ���еȴ�.<br>
							SKT�� �Ҷ� (1)���ϸ�ǰ� NHN�� Google�� �Ҷ��� (5, 6)<br>

							<select name="ps1" >
								<%for(int i = 0; i < market.length; i+=2){%>
									<option value="<%=market[i]%>"><%=market[i+1]%></option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>�Ⱓ</td>
						<td>
							<font color=blue>
								2014-01-01 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~ 2014-05-24 18:00 (����1)<br>
								2014-05-24 18:00 ~ 2014-05-24 23:59 (����2)(24:00���� ������)
							</font><br>
							<input name="ps2" type="text" value="2014-01-01" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="ps3" type="text" value="2024-01-01 23:59" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>����</td>
						<td>
							<select name="d23" >
								<option value="1">Ȱ��(1)</option>
								<option value="-1">��Ȱ��(-1)</option>
							</select>
							<select name="d24" >
								<%for(int i = 0; i <= 10; i++){%>
									<option value="<%=i*5%>"><%=i*5%>����Ʈ</option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>����Ȱ��ȭ</td>
						<td>���� ������ ������� Ȱ��ȭ.
							<select name="d1" >
								<option value="1">Ȱ��(1)</option>
								<option value="-1">��Ȱ��(-1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>����/����</t1d>
						<td>
							�ݵ�� 1���� ������ ���� ���� �����ϼ���.<br>
							1. ������ ����, 2. �� ������ ������ ����Ǵ� �� 3. �׶� ������� �޴� �޼���(�� �Է��ϼ���)<br>
							��)��¯ ���(213) 2. 90���(5017) 3.��¯ ��纸��<br>
							��)��¯ ��(112) 2. 20���(5010) 3.��¯ �纸��<br>
							��)��¯ ����(14) 2. 10���(5009) 3.��¯ ���Һ���<br>
							����1<select name="d2" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							����1<select name="d5" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							<input name="ps4" type="text" value="��������1" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<br>
							����2<select name="d3" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							����2<select name="d6" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							<input name="ps5" type="text" value="��������2" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>

							����3<select name="d4" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							����3<select name="d7" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							<input name="ps6" type="text" value="��������3" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>PMȮ��Ȱ��ȭ</td>
						<td>�����̾� �̱��� Ȯ�� ��� Ȱ��ȭ
							<select name="d10" >
								<option value="1">Ȱ��(1)</option>
								<option value="-1">��Ȱ��(-1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>PMȮ���ð�</t1d>
						<td>
							-1:�ð��� ���ٴ� �ǹ�<br>
							14: ���� 2:00 ~ 2:59���� �۵��Ѵٴ� �ǹ�<br>
							<select name="d11" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>��</option>
								<%}%>
							</select>
							<select name="d12" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>��</option>
								<%}%>
							</select>
							<select name="d13" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>��</option>
								<%}%>
							</select><br>
							<select name="d14" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>��</option>
								<%}%>
							</select><br>

						</td>
					</tr>
					<tr>
						<td>PM����</td>
						<td>�����̾� ����Ƚ�� ���� ����̱�
							<select name="d20" >
								<option value="1">Ȱ��(1)</option>
								<option value="-1">��Ȱ��(-1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>PM���Ἴ�ð�</t1d>
						<td>
							10����Ʈ�� 100Max�� 10ȸ�� �ϸ� 1ȸ ����� �����̾��� ���� �� �ִ�.
							<select name="d21" >
								<%for(int i = 1; i <= 10; i++){%>
									<option value="<%=i%>"><%=i%>����Ʈ</option>
								<%}%>
							</select>
							<select name="d22" >
								<%for(int i = 10; i <= 20; i++){%>
									<option value="<%=i%>"><%=i%>Max</option>
								<%}%>
							</select><br>

						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input name="ps10" type="text" value="�ڸ�Ʈ" size="40" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>
				<%}%>
				<table border=1>
					<tr>
						<td colspan=13>
							<font color=red>
							��Ģ1. �� ���� �͸� ����Ǵ°� �˾��ּ���. ��Ż��� �����ϸ� ��Ż� ���п� ���� ����˴ϴ�.<br>
							��Ģ3. �������󿡼��� �켱������ �־ �� �տ����� ���� ���� �����ϼ���.<br>
							��Ģ4. SKT(1), GOOGLE(5), NHN(6), IPHONE(7)</font><br>
							���� �̱⿡ ���� ������ �ϴ� ���Դϴ�.
						</td>
					</tr>
					<tr>
						<td></td>
						<td>����</td>
						<td></td>
						<td>���� ����</td>
						<td colspan=4>����(�켱����1/2/3)</td>
						<td>Ȯ�����</td>
						<td>���ᱳ��</td>
						<td>������ȭ����</td>
						<td colspan=2></td>
					</tr>
					<%if(cstmt.getMoreResults()){
						result = cstmt.getResultSet();
						while(result.next()){%>
						<tr>
								<form name="GIFTFORM<%=result.getString("idx")%>" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
								<input type="hidden" name="p1" value="30">
								<input type="hidden" name="p2" value="6">
								<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
								<input type="hidden" name="ps1" value="<%=result.getString("roulmarket")%>">
								<input type="hidden" name="ps9" value="">
								<input type="hidden" name="branch" value="systeminfo_list2">
								<td>
									<%=result.getString("idx")%>
								</td>
								<td>
									<%=getTel(result.getInt("roulmarket"))%>
								</td>
								<td>
									<input name="ps2" type="text" value="<%=getDate(result.getString("roulstart"))%>" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps3" type="text" value="<%=getDate(result.getString("roulend"))%>" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									<br><font color=red>(������ �ð��� �������� �����ּ���!!!)</font>
								</td>
								<td <%=getCheckValueOri(result.getInt("roulsaleflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d23" >
										<option value="-1" <%=getSelect(result.getInt("roulsaleflag"), -1)%>>��Ȱ��(-1)</option>
										<option value="1" <%=getSelect(result.getInt("roulsaleflag"),  1)%>>Ȱ��(1)</option>
									</select><br>
									<input name="d24" type="text" value="<%=result.getInt("roulsalevalue")%>" size="3" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">%<br>
								</td>
								<td <%=getCheckValueOri(result.getInt("roulflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d1" >
										<option value="-1" <%=getSelect(result.getInt("roulflag"), -1)%>>��Ȱ��(-1)</option>
										<option value="1" <%=getSelect(result.getInt("roulflag"),  1)%>>Ȱ��(1)</option>
									</select>
								</td>
								<td>
									<input name="d2" type="text" value="<%=result.getInt("roulani1")%>" size="4" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> -> <br>

									<input name="d5" type="text" value="<%=result.getInt("roulreward1")%>" size="4" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> X
									<input name="d15" type="text" value="<%=result.getInt("roulrewardcnt1")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps4" type="text" value="<%=result.getString("roulname1")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br><br><br>
									<img src=<%=imgroot%>/<%=result.getInt("roulani1")%>.png> -> <img src=<%=imgroot%>/<%=result.getInt("roulreward1")%>.png> x <%=result.getInt("roulrewardcnt1")%>
								</td>
								<td>
									<input name="d3" type="text" value="<%=result.getInt("roulani2")%>" size="4" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> -> <br>
									<input name="d6" type="text" value="<%=result.getInt("roulreward2")%>" size="4" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> X
									<input name="d16" type="text" value="<%=result.getInt("roulrewardcnt2")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps5" type="text" value="<%=result.getString("roulname2")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br><br><br>
									<img src=<%=imgroot%>/<%=result.getInt("roulani2")%>.png> -> <img src=<%=imgroot%>/<%=result.getInt("roulreward2")%>.png> x <%=result.getInt("roulrewardcnt2")%>
								</td>
								<td>
									<input name="d4" type="text" value="<%=result.getInt("roulani3")%>" size="4" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> -> <br>
									<input name="d7" type="text" value="<%=result.getInt("roulreward3")%>" size="4" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> X
									<input name="d17" type="text" value="<%=result.getInt("roulrewardcnt3")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps6" type="text" value="<%=result.getString("roulname3")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br><br><br>
									<img src=<%=imgroot%>/<%=result.getInt("roulani3")%>.png> -> <img src=<%=imgroot%>/<%=result.getInt("roulreward3")%>.png> x <%=result.getInt("roulrewardcnt3")%>
								</td>
								<td <%=getCheckValueOri(result.getInt("roultimeflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d10" >
										<option value="-1" <%=getSelect(result.getInt("roultimeflag"), -1)%>>��Ȱ��(-1)</option>
										<option value="1" <%=getSelect(result.getInt("roultimeflag"),  1)%>>Ȱ��(1)</option>
									</select>
									<br>
									�ð�1:<input name="d11" type="text" value="<%=result.getInt("roultimetime1")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									�ð�2:<input name="d12" type="text" value="<%=result.getInt("roultimetime2")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									�ð�3:<input name="d13" type="text" value="<%=result.getInt("roultimetime3")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									�ð�4:<input name="d14" type="text" value="<%=result.getInt("roultimetime4")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
								</td>
								<td <%=getCheckValueOri(result.getInt("pmgauageflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d20" >
										<option value="-1" <%=getSelect(result.getInt("pmgauageflag"), -1)%>>��Ȱ��(-1)</option>
										<option value="1" <%=getSelect(result.getInt("pmgauageflag"),  1)%>>Ȱ��(1)</option>
									</select><br>
									point:<input name="d21" type="text" value="<%=result.getInt("pmgauagepoint")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									max:<input name="d22" type="text" value="<%=result.getInt("pmgauagemax")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
								</td>
								<td>
									<input name="ps10" type="text" value="<%=result.getString("comment")%>" size="40" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
								</td>
								<td>
									<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
								</td>
								</form>
							</tr>
						<%}
				}%>
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
