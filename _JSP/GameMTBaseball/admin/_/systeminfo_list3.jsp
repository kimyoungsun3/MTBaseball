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
	//1. 생성자 위치
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
	};

	try{
		//2. 데이타 조작
		//exec spu_GameMTBaseballD 30, 8, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
		query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 8);
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

		//2-2. 스토어즈 프로시져 실행하기
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
		itemdesc[0] = "없음";
		itemdesc2[0] = "없음";
		itemcode[0] = -1;
		gamecosts[0] = 0;
		cashcosts[0] = 0;

		if(cstmt.getMoreResults()){
			result = cstmt.getResultSet();
			while(result.next()){
				itemdesc[k] = result.getString("itemname")
									+ "[" + result.getString("itemcode") + "]"
									+ ")";
				itemdesc2[k] = result.getString("itemname") ;
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
		    + '25:' + f.d25.value + ';'
		    + '26:' + f.d26.value + ';'
	f.ps9.value = ps9;
	//alert(ps9);

	if(f_nul_chk(f.itemcode, '아이디를')) return false;
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

				<a href=systeminfo_list3.jsp?view=1>입력보기</a><a href=systeminfo_list3.jsp?view=0>그냥보기</a>
				<%if(view == 1){%>
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="9">
					<input type="hidden" name="ps9" value="">
					<input type="hidden" name="branch" value="systeminfo_list3">
					<tr>
						<td>마켓</td>
						<td>
							SKT(1), GOOGLE(5), IPHONE(7)은 구분된다.<br>
							SKT만 할때 (1)만하면되고 NHN과 Google만 할때는 (5, 6)<br>

							<select name="ps1" >
								<%for(int i = 0; i < market.length; i+=2){%>
									<option value="<%=market[i]%>"><%=market[i+1]%></option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>기간</td>
						<td>
							<font color=blue>
								2014-01-01 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~ 2014-05-24 18:00 (형식1)<br>
								2014-05-24 18:00 ~ 2014-05-24 23:59 (형식2)(24:00쓰면 오류남)
							</font><br>
							<input name="ps2" type="text" value="2014-01-01" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="ps3" type="text" value="2024-01-01 23:59" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>할인</td>
						<td>
							<select name="d23" >
								<option value="1">활성(1)</option>
								<option value="-1">비활성(-1)</option>
							</select>
							<select name="d24" >
								<%for(int i = 0; i <= 10; i++){%>
									<option value="<%=i*5%>"><%=i*5%>%</option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>보물활성화</td>
						<td>보물 뽑으면 수정지급 활성화.
							<select name="d1" >
								<option value="1">활성(1)</option>
								<option value="-1">비활성(-1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>보물/보상</t1d>
						<td>
							반드시 1번이 보상이 높은 것을 선택하세요.<br>
							1. 선택한 보물, 2. 그 보물이 나오면 보상되는 템 3.수량 4. 그때 사람들이 받는 메세지(꼭 입력하세요)<br>
							예)보물1(80000) 2. 1000결정(3015)<br>
							보물1<select name="d2" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							보상1<select name="d5" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							보상수량:<input name="d15" type="text" value="1" size="10" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<input name="ps4" type="text" value="보상제목1" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

							<br>
							보물2<select name="d3" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							보상2<select name="d6" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							보상수량:<input name="d16" type="text" value="1" size="10" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<input name="ps5" type="text" value="보상제목2" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>

							보물3<select name="d4" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							보상3<select name="d7" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							보상수량:<input name="d17" type="text" value="1" size="10" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<input name="ps6" type="text" value="보상제목3" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>PM확률활성화</td>
						<td>프리미엄 뽑기의 확률 상승 활성화
							<select name="d10" >
								<option value="1">활성(1)</option>
								<option value="-1">비활성(-1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>PM확률시간</t1d>
						<td>
							-1:시간이 없다는 의미<br>
							14: 오후 2:00 ~ 2:59까지 작동한다는 의미<br>
							<select name="d11" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>시</option>
								<%}%>
							</select>
							<select name="d12" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>시</option>
								<%}%>
							</select>
							<select name="d13" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>시</option>
								<%}%>
							</select><br>
							<select name="d14" >
								<%for(int i = -1; i < 24; i++){%>
									<option value="<%=i%>"><%=i%>시</option>
								<%}%>
							</select><br>

						</td>
					</tr>
					<tr>
						<td>PM무료</td>
						<td>프리미엄 일정횟수 이후 무료뽑기
							<select name="d20" >
								<option value="1">활성(1)</option>
								<option value="-1">비활성(-1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>PM무료세팅값</t1d>
						<td>
							10포인트에 100Max는 10회를 하면 1회 무료로 프리미엄을 뽑을 수 있다.
							<select name="d21" >
								<%for(int i = 10; i <= 10; i++){%>
									<option value="<%=i%>"><%=i%>포인트</option>
								<%}%>
							</select>
							<select name="d22" >
								<%for(int i = 100; i <= 100; i++){%>
									<option value="<%=i%>"><%=i%>Max</option>
								<%}%>
							</select><br>
						</td>
					</tr>
					<tr>
						<td>강화할인</t1d>
						<td>
							<select name="d25" >
								<option value="1">활성(1)</option>
								<option value="-1">비활성(-1)</option>
							</select>
							<select name="d26" >
								<%for(int i = 0; i <= 40; i+=5){%>
									<option value="<%=i%>"><%=i%>%</option>
								<%}%>
							</select><br>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input name="ps10" type="text" value="코멘트" size="40" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
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
						<td colspan=15>
							<font color=red>
							원칙1. 젤 위에 것만 적용되는것 알아주세요. 통신사을 구분하면 통신사 구분에 따라서 적용됩니다.<br>
							원칙2. 리스트 2번 마켓(1,2,3,4,5,6)이러면 7번 마켓은 적용안됨 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								   리스트 1번 마켓(7) 7번 마켓 전용입니다.<br>
							원칙3. 보물보상에서는 우선순위가 있어서 젤 앞에것을 높은 놈을 설정하세요.<br>
							원칙4. SKT(1), GOOGLE(5), NHN(6), IPHONE(7)</font><br>
							보물 뽑기에 대한 설정을 하는 곳입니다.
						</td>
					</tr>
					<tr>
						<td></td>
						<td>마켓</td>
						<td></td>
						<td>할인</td>
						<td colspan=4>
							보상 (보물우선순위1/2/3)
						</td>
						<td>보물확률상승</td>
						<td>보물무료뽑기</td>
						<td bgcolor=rosered>보물강화할인</td>
						<td colspan=2></td>
					</tr>
					<%if(cstmt.getMoreResults()){
						result = cstmt.getResultSet();
						while(result.next()){%>
						<tr>
								<form name="GIFTFORM<%=result.getString("idx")%>" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
								<input type="hidden" name="p1" value="30">
								<input type="hidden" name="p2" value="10">
								<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
								<input type="hidden" name="ps1" value="<%=result.getString("roulmarket")%>">
								<input type="hidden" name="ps9" value="">
								<input type="hidden" name="branch" value="systeminfo_list3">
								<td>
									<%=result.getString("idx")%>
								</td>
								<td>
									<%=getTel(result.getInt("roulmarket"))%>
								</td>
								<td>
									<input name="ps2" type="text" value="<%=getDate(result.getString("roulstart"))%>" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps3" type="text" value="<%=getDate(result.getString("roulend"))%>" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									<br><font color=red>(끝나는 시간은 수정하지 말아주세요!!!)</font>
								</td>
								<td <%=getCheckValueOri(result.getInt("roulsaleflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d23" >
										<option value="-1" <%=getSelect(result.getInt("roulsaleflag"), -1)%>>비활성(-1)</option>
										<option value="1" <%=getSelect(result.getInt("roulsaleflag"),  1)%>>활성(1)</option>
									</select><br>
									<input name="d24" type="text" value="<%=result.getInt("roulsalevalue")%>" size="3" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">%<br>
								</td>
								<td <%=getCheckValueOri(result.getInt("roulflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d1" >
										<option value="-1" <%=getSelect(result.getInt("roulflag"), -1)%>>비활성(-1)</option>
										<option value="1" <%=getSelect(result.getInt("roulflag"),  1)%>>활성(1)</option>
									</select>
								</td>
								<td>
									<input name="d2" type="text" value="<%=result.getInt("roulani1")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> -> <br>
									<input name="d5" type="text" value="<%=result.getInt("roulreward1")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> X
									<input name="d15" type="text" value="<%=result.getInt("roulrewardcnt1")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps4" type="text" value="<%=result.getString("roulname1")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br><br><br>
									<img src=<%=imgroot%>/<%=result.getInt("roulani1")%>.png> -> <img src=<%=imgroot%>/<%=result.getInt("roulreward1")%>.png> x <%=result.getInt("roulrewardcnt1")%>
								</td>
								<td>
									<input name="d3" type="text" value="<%=result.getInt("roulani2")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> -> <br>
									<input name="d6" type="text" value="<%=result.getInt("roulreward2")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> X
									<input name="d16" type="text" value="<%=result.getInt("roulrewardcnt2")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps5" type="text" value="<%=result.getString("roulname2")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br><br><br>
									<img src=<%=imgroot%>/<%=result.getInt("roulani2")%>.png> -> <img src=<%=imgroot%>/<%=result.getInt("roulreward2")%>.png> x <%=result.getInt("roulrewardcnt2")%>
								</td>
								<td>
									<input name="d4" type="text" value="<%=result.getInt("roulani3")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> -> <br>
									<input name="d7" type="text" value="<%=result.getInt("roulreward3")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> X
									<input name="d17" type="text" value="<%=result.getInt("roulrewardcnt3")%>" size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps6" type="text" value="<%=result.getString("roulname3")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br><br><br>
									<img src=<%=imgroot%>/<%=result.getInt("roulani3")%>.png> -> <img src=<%=imgroot%>/<%=result.getInt("roulreward3")%>.png> x <%=result.getInt("roulrewardcnt3")%>
								</td>
								<td <%=getCheckValueOri(result.getInt("roultimeflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d10" >
										<option value="-1" <%=getSelect(result.getInt("roultimeflag"), -1)%>>비활성(-1)</option>
										<option value="1" <%=getSelect(result.getInt("roultimeflag"),  1)%>>활성(1)</option>
									</select>
									<br>
									시간1:<input name="d11" type="text" value="<%=result.getInt("roultimetime1")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									시간2:<input name="d12" type="text" value="<%=result.getInt("roultimetime2")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									시간3:<input name="d13" type="text" value="<%=result.getInt("roultimetime3")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									시간4:<input name="d14" type="text" value="<%=result.getInt("roultimetime4")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
								</td>
								<td <%=getCheckValueOri(result.getInt("pmgauageflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d20" >
										<option value="-1" <%=getSelect(result.getInt("pmgauageflag"), -1)%>>비활성(-1)</option>
										<option value="1" <%=getSelect(result.getInt("pmgauageflag"),  1)%>>활성(1)</option>
									</select><br>
									point:<input name="d21" type="text" value="<%=result.getInt("pmgauagepoint")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									max:<input name="d22" type="text" value="<%=result.getInt("pmgauagemax")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<font color=red>Max는 100고정</font>
								</td>
								<td <%=getCheckValueOri(result.getInt("tsupgradesaleflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="d25" >
										<option value="-1" <%=getSelect(result.getInt("tsupgradesaleflag"), -1)%>>비활성(-1)</option>
										<option value="1" <%=getSelect(result.getInt("tsupgradesaleflag"),  1)%>>활성(1)</option>
									</select><br>
									<input name="d26" type="text" value="<%=result.getInt("tsupgradesalevalue")%>" size="3" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">%<br>
								</td>
								<td>
									<input name="ps10" type="text" value="<%=result.getString("comment")%>" size="10" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
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
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
