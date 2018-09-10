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

	String pluscashcosts[] = {
			"0", 		"루비(캐쉬)추가(0%)",
			"5", 		"루비(캐쉬)추가(5%)",
			"10", 		"루비(캐쉬)추가(10%)",
			"15", 		"루비(캐쉬)추가(15%)",
			"20", 		"루비(캐쉬)추가(20%)",
			"25", 		"루비(캐쉬)추가(25%)",
			"30", 		"루비(캐쉬)추가(30%)",
			"35", 		"루비(캐쉬)추가(35%)",
			"40", 		"루비(캐쉬)추가(40%)",
			"45", 		"루비(캐쉬)추가(45%)",
			"50", 		"루비(캐쉬)추가(50%)",
			"60", 		"루비(캐쉬)추가(60%)",
			"70", 		"루비(캐쉬)추가(70%)",
			"80", 		"루비(캐쉬)추가(80%)",
			"90", 		"루비(캐쉬)추가(90%)",
			"100", 		"루비(캐쉬)추가(100%)",
	};

	String plusgamecosts[] = {
			"0", 		"코인추가(0%)",
			"5", 		"코인추가(5%)",
			"10", 		"코인추가(10%)",
			"15", 		"코인추가(15%)",
			"20", 		"코인추가(20%)",
			"30", 		"코인추가(30%)",
			"40", 		"코인추가(40%)",
			"50", 		"코인추가(50%)",
			"60", 		"코인추가(60%)",
			"70", 		"코인추가(70%)",
			"80", 		"코인추가(80%)",
			"90", 		"코인추가(90%)",
			"100", 		"코인추가(100%)",
			"150", 		"코인추가(150%)",
			"200", 		"코인추가(200%)"
	};

	String plushearts[] = {
			"0", 		"하트추가(0%)",
			"5", 		"하트추가(5%)",
			"10", 		"하트추가(10%)",
			"15", 		"하트추가(15%)",
			"20", 		"하트추가(20%)",
			"30", 		"하트추가(30%)",
			"40", 		"하트추가(40%)",
			"50", 		"하트추가(50%)",
			"60", 		"하트추가(60%)",
			"70", 		"하트추가(70%)",
			"80", 		"하트추가(80%)",
			"90", 		"하트추가(90%)",
			"100", 		"하트추가(100%)"
	};


	String plusfeeds[] = {
			"0", 		"건초추가(0%)",
			"5", 		"건초추가(5%)",
			"10", 		"건초추가(10%)",
			"15", 		"건초추가(15%)",
			"20", 		"건초추가(20%)",
			"30", 		"건초추가(30%)",
			"40", 		"건초추가(40%)",
			"50", 		"건초추가(50%)",
			"60", 		"건초추가(60%)",
			"70", 		"건초추가(70%)",
			"80", 		"건초추가(80%)",
			"90", 		"건초추가(90%)",
			"100", 		"건초추가(100%)"
	};

	String plusgoldtickets[] = {
			"0", 		"골드티켓추가(0%)",
			"5", 		"골드티켓추가(5%)",
			"10", 		"골드티켓추가(10%)",
			"15", 		"골드티켓추가(15%)",
			"20", 		"골드티켓추가(20%)",
			"30", 		"골드티켓추가(30%)",
			"40", 		"골드티켓추가(40%)",
			"50", 		"골드티켓추가(50%)",
			"60", 		"골드티켓추가(60%)",
			"70", 		"골드티켓추가(70%)",
			"80", 		"골드티켓추가(80%)",
			"90", 		"골드티켓추가(90%)",
			"100", 		"골드티켓추가(100%)"
	};

	String plusbattletickets[] = {
			"0", 		"배틀티켓추가(0%)",
			"5", 		"배틀티켓추가(5%)",
			"10", 		"배틀티켓추가(10%)",
			"15", 		"배틀티켓추가(15%)",
			"20", 		"배틀티켓추가(20%)",
			"30", 		"배틀티켓추가(30%)",
			"40", 		"배틀티켓추가(40%)",
			"50", 		"배틀티켓추가(50%)",
			"60", 		"배틀티켓추가(60%)",
			"70", 		"배틀티켓추가(70%)",
			"80", 		"배틀티켓추가(80%)",
			"90", 		"배틀티켓추가(90%)",
			"100", 		"배틀티켓추가(100%)"
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
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="1">
					<input type="hidden" name="ps9" value="">
					<input type="hidden" name="branch" value="systeminfo_list">
					<tr>
						<td>
							루비(캐쉬) 구매시 추가 :
							<select name="ps9_10" >
								<%for(int i = 0; i < pluscashcosts.length; i+=2){%>
									<option value="<%=pluscashcosts[i]%>" ><%=pluscashcosts[i+1]%></option>
								<%}%>
							</select>

							코인 환전시 추가 :
							<select name="ps9_11" >
								<%for(int i = 0; i < plusgamecosts.length; i+=2){%>
									<option value="<%=plusgamecosts[i]%>" ><%=plusgamecosts[i+1]%></option>
								<%}%>
							</select>

							하트 구매시 추가 :
							<select name="ps9_12" >
								<%for(int i = 0; i < plushearts.length; i+=2){%>
									<option value="<%=plushearts[i]%>" ><%=plushearts[i+1]%></option>
								<%}%>
							</select>

							건초 구매시 추가 :
							<select name="ps9_13" >
								<%for(int i = 0; i < plusfeeds.length; i+=2){%>
									<option value="<%=plusfeeds[i]%>" ><%=plusfeeds[i+1]%></option>
								<%}%>
							</select><br>

							골드티켓 구매시 추가 :
							<select name="ps9_14" >
								<%for(int i = 0; i < plusgoldtickets.length; i+=2){%>
									<option value="<%=plusgoldtickets[i]%>" ><%=plusgoldtickets[i+1]%></option>
								<%}%>
							</select>

							싸움티켓 구매시 추가 :
							<select name="ps9_15" >
								<%for(int i = 0; i < plusbattletickets.length; i+=2){%>
									<option value="<%=plusbattletickets[i]%>" ><%=plusbattletickets[i+1]%></option>
								<%}%>
							</select>
							<!--
							악세뽑기(가격) :
							<select name="ps3" >
								<%for(int i = 0; i < accprice.length; i++){%>
									<option value="<%=accprice[i]%>" <%=getSelect(0, i)%> ><%=accprice[i]%>루비</option>
								<%}%>
							</select>

							악세뽑기(할인) :
							<select name="ps4" >
								<%for(int i = 0; i < accsale.length; i++){%>
									<option value="<%=accsale[i]%>" <%=getSelect(4, i)%> ><%=accsale[i]%>%할인</option>
								<%}%>
							</select>
							-->

							합성(할인) :
							<select name="ps9_16" >
								<%for(int i = 0; i < composesale.length; i++){%>
									<option value="<%=composesale[i]%>" <%=getSelect(0, i)%> ><%=composesale[i]%>%할인</option>
								<%}%>
							</select>
							<!--
							iPhone쿠폰창 :
							<select name="ps6" >
								<option value="0">안보이게 하기(0)</option>
								<option value="1">보이게 하기(1)</option>
							</select>
							-->
							<br>

							집맥스 :
							<select name="ps7" >
								<%for(int i = 6; i <= 8; i++){%>
									<option value="<%=i%>" <%=getSelect(8, i)%> ><%=i%>Max</option>
								<%}%>
							</select>

							탱크, 품질,축사, 양동이, 착유기, 주입기Max :
							<select name="ps8" >
								<%for(int i = 20; i <= 28; i++){%>
									<option value="<%=i%>" <%=getSelect(28, i)%> ><%=i%>Max</option>
								<%}%>
							</select><br>
							초대10명 : <input name="ps9_1" type="text" value="2000" 	size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							초대20명 : <input name="ps9_2" type="text" value="100009" 	size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							초대30명 : <input name="ps9_3" type="text" value="6" 		size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							초대40명 : <input name="ps9_4" type="text" value="100004" 	size="6" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<br>

							황금룰렛세팅 :
							<select name="ps9_20" >
								<option value="1" >활성(1)</option>
								<option value="-1">비활성(-1)</option>
							</select>
							point:<input name="ps9_21" type="text" value="10" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							max:<input name="ps9_22" type="text" value="100" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<font color=red>Max는 100고정</font>

						</td>
					</tr>
					<td>
						<br>
						코멘트 : <input name="ps10" type="text" value="코멘트" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
					</td>
					<tr>
						<td>
							iteminfo -> system info재분석(악세뽑기 가격은 로그인과 악세뽑기 SPU에 적용되어 있습니다.)<br>
							복귀는 기존것을 이어서 작동합니다. 수정모드에서만 수정이 가능합니다.<br>
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>

				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 30, 2, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 시설 정보 리스트
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>idx</td>
							<td>집Max</td>
							<td>탱크, 품질,축사, 양동이, 착유기, 주입기Max</td>
							<td>인벤단계, 확장맥스, 경작지</td>
							<td>필드</td>
							<td>plus루비(캐쉬)</td>
							<td>plus코인</td>
							<td>plus하트</td>
							<td>plus건초</td>
							<td>plus골드티켓</td>
							<td>plus배틀티켓</td>
							<td>황금룰렛(게이지)</td>
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
								<%=result.getInt("roulaccprice")%>루비
								<%=result.getInt("roulaccsale")%>%악세할인
								> <%=(result.getInt("roulaccprice") - result.getInt("roulaccprice") * result.getInt("roulaccsale")/100)%> 루비
							</td>
							<td>
								<%=result.getInt("composesale")%>% 할인
							</td>
							<td>
								iPhone쿠폰입력 <%=getIPhoneCoupon(result.getInt("iphonecoupon"))%>
							</td>
							-->
							<td <%=getCheckValueOri(result.getInt("wheelgauageflag"), -1, "bgcolor=#aaaaaa", "")%>>
									<select name="p4" >
										<option value="1" <%=getSelect(result.getInt("wheelgauageflag"),  1)%>>활성(1)</option>
										<option value="-1" <%=getSelect(result.getInt("wheelgauageflag"), -1)%>>비활성(-1)</option>
									</select><br>
									point:<input name="p5" type="text" value="<%=result.getInt("wheelgauagepoint")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									max:<input name="p6" type="text" value="<%=result.getInt("wheelgauagemax")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<font color=red>Max는 100고정</font>
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
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
