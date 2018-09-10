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
	//1. 생성자 위치
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
	if(f_nul_chk(f.gameid, '아이디를')) return false;
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
							유저 아이디를 정확히 입력하세요.<br>
							<font color=red>과금 기록 없이 2000루비/100만코인 이상 이면 블럭계정, 블럭핸드폰, 블럭카톡(자동이니까 유의하세요.)</font>
							<a href=userinfo_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>게임아이디(farmxx)</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>폰번호검색(>아이디검색)</td>
						<td><input name="phone" type="text" value="<%=phone%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>번호</td>
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
								생성일: <%=getDate(result.getString("regdate"))%><br>
								접속일:(<%=result.getString("concnt")%>회)
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=6&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>>
										<!-- 잘사용안함 , 아래의 출석일을 주로 사용한다.-->
										<%=getDate(result.getString("condate"))%>
									</a><br>
								<br>
								폰:<a href=userinfo_list.jsp?phone=<%=result.getString("phone")%>><%=result.getString("phone")%></a><br><br>

								<!--SMS발송 : <%=result.getString("smssendcnt")%> / <%=result.getString("smsjoincnt")%>	<br>-->
								<a href=usersetting_ok.jsp?p1=19&p2=4&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									<%=getCheckValue(result.getInt("kkopushallow"), 1, "푸쉬발송가능", "<font color=red>푸쉬발송거절</font>")%>
								</a>
								<br>
								<a href=usersetting_ok.jsp?p1=19&p2=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									<%=getBlockState(result.getInt("blockstate"))%>
								</a><br>

								<a href=usersetting_ok.jsp?p1=19&p2=10&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									<%=getDeleteState(result.getInt("deletestate"))%>
								</a><br>
								캐쉬카피: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=13&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>><%=result.getString("cashcopy")%></a><br>
								결과카피: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=14&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>><%=result.getString("resultcopy")%></a><br>

								<br>
								<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>일괄블럭</a><br>
								<a href=usersetting_ok.jsp?p1=18&p2=1&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>개발진짜삭제</a><br>
								<a href=usersetting_ok.jsp?p1=18&p2=2&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>개발맥스초기화</a><br>
								<a href=wgiftsend_form.jsp?gameid=<%=result.getString("gameid")%> target=_blank>선물/쪽지</a><br>
								<a href=push_list.jsp?gameid=<%=result.getString("gameid")%>&personal=1 target=_blank>푸쉬발송</a><br><br>

								대전참여상태 	: <%=getRKStartState(result.getInt("rkstartstate"))%><br>
								팀		 		: <%=getRKTeam(result.getInt("rkteam"))%><br>
								판매수익 		: <%=result.getString("rksalemoney")%><br>
								생산배럴 		: <%=result.getString("rksalebarrel")%><br>
								배틀포인트		: <%=result.getString("rkbattlecnt")%><br>
								동물교배,보물뽑기 : <%=result.getString("rkbogicnt")%><br>
								친구포인트 		: <%=result.getString("rkfriendpoint")%><br>
								룰렛포인트 		: <%=result.getString("rkroulettecnt")%><br>
								늑대포인트		: <%=result.getString("rkwolfcnt")%><br>
								(
								<a href=usersetting_ok.jsp?p1=19&p2=86&p3=60&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									개발:미참여로 돌리기
							  	</a>
								)
							</td>
							<td>
								<%=getTel(result.getInt("market"))%>
								<%=getBytType(result.getInt("buytype"))%>
								<%=getPlatform(result.getInt("platform"))%>
								<%=result.getString("ukey")%>,
								<%=result.getString("version")%><br>
								세션ID:<%=result.getString("sid")%><br><br>
								게시판: <%=getMBoardState(result.getInt("mboardstate"))%><br><br>

								출석일:
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
										<%=getDate(result.getString("attenddate"))%>
									</a><br>
								출석횟수:
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
										<%=result.getString("attendcnt")%>
									</a><br>
								복귀단계:
										<a href=userminus_form3.jsp?p1=19&p2=89&p3=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>>
											<%=getRtnStep(result.getInt("rtnstep"))%>
										</a><br>
								복귀진행월:
										<a href=userminus_form3.jsp?p1=19&p2=89&p3=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>>
											<%=result.getString("rtnplaycnt")%>
										</a><br>
								복귀요청사람:
										<%=result.getString("rtngameid")%>(<%=getDate19(result.getString("rtndate"))%>)<br>
								<!--
								대회참여횟수 : <%=result.getString("contestcnt")%>	<br>
								별칭 : <%=result.getString("nickname")%>	<br>
								-->

								파라미터(0 ~ 9):<br>
									<%for(int i = 0; i < 10; i++){
										out.print( result.getString("param" + i) + "/");
									}%><br>


								<br>
							</td>
							<td>
								캐쉬 : <a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=0><%=result.getString("cashcost")%></a><br>

								<br>


								동물인벤Max : <%=result.getString("invenanimalmax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=45><%=result.getString("invenanimalstep")%></a>)<br>
								소비인벤Max : <%=result.getString("invencustommax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=46><%=result.getString("invencustomstep")%></a>)<br>
								줄기인벤Max : <%=result.getString("invenstemcellmax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=47><%=result.getString("invenstemcellstep")%></a>)<br>
								보물인벤Max : <%=result.getString("inventreasuremax")%>(<a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=49><%=result.getString("inventreasurestep")%></a>)<br>
								<!--임시아이템 : <%=result.getString("tempitemcode")%> / <%=result.getString("tempcnt")%>	<br>-->
								필드0 : <%=getCheckValue(result.getInt("field0"), 1, "오픈", "닫힘")%><br>
								필드1 : <%=getCheckValue(result.getInt("field1"), 1, "오픈", "닫힘")%><br>
								필드2 : <%=getCheckValue(result.getInt("field2"), 1, "오픈", "닫힘")%><br>
								필드3 : <%=getCheckValue(result.getInt("field3"), 1, "오픈", "닫힘")%><br>
								필드4 : <%=getCheckValue(result.getInt("field4"), 1, "오픈", "닫힘")%><br>
								필드5 : <%=getCheckValue(result.getInt("field5"), 1, "오픈", "닫힘")%><br>
								필드6 : <%=getCheckValue(result.getInt("field6"), 1, "오픈", "닫힘")%><br>
								필드7 : <%=getCheckValue(result.getInt("field7"), 1, "오픈", "닫힘")%><br>
								필드8 : <%=getCheckValue(result.getInt("field8"), 1, "오픈", "닫힘")%><br>
								낙농포인트 : <a href=userminus_form3.jsp?p1=19&p2=87&p3=60&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=cashpoint><%=result.getString("cashpoint")%></a>원 <br>
								(실구매금액 VIP)<br><br>

								무료룰렛: <a href=usersetting_ok.jsp?p1=19&p2=86&p3=50&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getWheelToday(result.getInt("wheeltodaycnt"))%>
										  </a>
										  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=51&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getDate10(result.getString("wheeltodaydate"))%>
										  </a>)<br>
								황금룰렛: <a href=usersetting_ok.jsp?p1=19&p2=86&p3=52&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												게이지 : <%=result.getInt("wheelgauage")%> / 100
										  </a>
										  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=53&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getWheelFree(result.getInt("wheelfree"))%>
										  </a>)<br>
										  전체 <%=result.getInt("bkwheelcnt")%>회<br><br>

								짜요쿠폰조각룰렛:
											<a href=usersetting_ok.jsp?p1=19&p2=86&p3=61&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=getZCPChance(result.getInt("zcpchance"))%>
											</a><br>
											룰렛등장 : <%= getZCPSaleFresh(70, result.getInt("salefresh")) %><br>
											상승효과(<%=result.getInt("zcpplus")%>%)
											일일등장횟수 : (
															<a href=usersetting_ok.jsp?p1=19&p2=86&p3=62&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
																<%=result.getInt("zcpappearcnt")%>회등장
															</a>)<br>
											무료횟수(<%=result.getInt("bkzcpcntfree")%>)
											유료횟수(<%=result.getInt("bkzcpcntcash")%>) <br><br>
								입력폰 : <%=result.getString("phone2")%><br>
								입력주소 : <%=result.getString("address1")%> <%=result.getString("address1")%><br>
								           <%=result.getString("zipcode")%>

							</td>
							<td>
								게임년월:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Game Year(2013 ~ 2999)">
										<%=result.getString("gameyear")%>
									</a>년
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Game Month(1 ~ 12)">
										<%=result.getString("gamemonth")%>
									</a>월
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=3&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Game Day(0 ~ 70)">
										<%=result.getString("frametime")%>
									</a>frame
									<br>
								피버 : <%=result.getString("fevergauge")%><br>
								양동이 :
									<a href=userminus_form.jsp?mode=81&gameid=<%=result.getString("gameid")%>><%=result.getString("bottlelittle")%></a> 총리터 (+<%=result.getInt("tsskillbottlelittle")%>)
									/
									<a href=userminus_form.jsp?mode=82&gameid=<%=result.getString("gameid")%>><%=result.getString("bottlefresh")%></a> 총신선도
									<br>
								탱크 :
									<a href=userminus_form.jsp?mode=83&gameid=<%=result.getString("gameid")%>><%=result.getString("tanklittle")%></a> 총리터
									/
									<a href=userminus_form.jsp?mode=84&gameid=<%=result.getString("gameid")%>><%=result.getString("tankfresh")%></a> 총신선도
									<br><br>

								연속거래성공:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=6&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Trade Success(0 ~ )">
										<%=result.getString("tradecnt")%>(<%=result.getString("tradecntold")%>)
									</a><br>
								연속상장횟수:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=7&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Prize Count(0 ~ )">
										<%=result.getString("prizecnt")%>(<%=result.getString("prizecntold")%>)
									</a><br>
								연속거래실패성공:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=9&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Trade Fail(0 ~ )">
										<%=result.getString("tradefailcnt")%>
									</a><br><br>
								<!--(연속성공과 실패는 상호배타)-->

								<정책지원금:
									 <a href=usersetting_ok.jsp?p1=19&p2=64&p3=55&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%> alt="(다시보기)">
										<%=result.getInt("settlestep")%>
									</a>
								><br>
								연도와 로고가 초기화됨
								<br><br>

								<상인정보><br>
								거래성공횟수:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=10&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Trade Fail(0 ~ )">
										<%=result.getString("tradesuccesscnt")%>
									</a><br>
								거래상인번호:
									<%=result.getInt("tradeclosedealer")%>(<%=getTradeState(result.getInt("tradestate"))%>)<br>
								<br>

								명성도(누적) :
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=4&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Fame(0 ~ )">
										<%=result.getString("fame")%>
									</a><br>
								레벨 : <%=result.getString("famelv")%>(최고:
									<a href="userminus_form3.jsp?p1=19&p2=65&p3=8&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change Fame(0 ~ 50)">
										<%=result.getString("famelvbest")%>
									</a>
									)<br>

							</td>
							<td>
								[분기별내역]<br>
								판매배럴(분기) 		: <%=result.getString("qtsalebarrel")%><br>
								판매수익(분기) 		: <%=result.getString("qtsalecoin")%><br>
								획득명성(분기) 		: <%=result.getString("qtfame")%><br>
								사용건초(분기) 		: <%=result.getString("qtfeeduse")%><br>
								연속거래횟수(분기): <%=result.getString("qttradecnt")%><br>
								최고거래가(분기): <%=result.getString("qtsalecoinbest")%><br><br>

								행운의 주사위<br>
								번호 		:
											<a href=usersetting_ok.jsp?p1=19&p2=64&p3=52&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
												<%=result.getString("yabauidx")%>
											</a>
											<br>
								교체비용 	: <%
												famelv = result.getInt("famelv") / 10 + 1;
												famelv = famelv * famelv * 100;
												out.println(famelv);
											%><br>
								방금돌린주사위: <%=result.getInt("yabaunum")%><br>
								시도횟수	:
									         <a href=userminus_form3.jsp?p1=19&p2=64&p3=53&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Yabauistrycount>
												<%=result.getInt("yabaucount")%>
											</a>
											<br><br>
								동물일일구매 : <a href=usersetting_ok.jsp?p1=19&p2=64&p3=57&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
													<%=result.getString("anibuycnt")%>
											   </a><br>
											   <a href=usersetting_ok.jsp?p1=19&p2=64&p3=58&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
											  	(<%=getDate10(result.getString("anibuydate"))%>)
											   </a><br><br>

								유저배틀박스/완료시간 <br>
								1번 : <%=result.getInt("boxslot1")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=1&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	개발삭제
									  </a>
									  <br>
								2번 : <%=result.getInt("boxslot2")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	개발삭제
									  </a><br>
								3번 : <%=result.getInt("boxslot3")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=3&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	개발삭제
									  </a><br>
								4번 : <%=result.getInt("boxslot4")%>
									  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=4&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	개발삭제
									  </a><br>
								진행중:<%=result.getInt("boxslotidx")%>
									  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=41&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
									  	<%=getDateShort2(result.getString("boxslottime"))%>
									  </a>)<br><br>

								트로피(티어):
									<a href=userminus_form3.jsp?p1=19&p2=64&p3=59&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=trophy>
									  	<%=result.getInt("trophy")%>
									</a>(<%=result.getInt("tier")%>)<br>
								유저배틀상태:
									<%=getUserBattleFlag(result.getInt("userbattleflag"))%><br>
								박스로테이션번호:
									<a href=userminus_form3.jsp?p1=19&p2=64&p3=60&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=boxrotidx>
									  	<%=result.getInt("boxrotidx")%>
									</a><br><br>

							</td>
							<td>


							</td>
							<td>
								경쟁모드(
								<a href=userminus_form3.jsp?p1=19&p2=64&p3=45&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
								<%
									comreward = result.getInt("comreward");
									out.print(comreward);
								%>
								</a>)<br>
								임시늑대잡이(1)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=1&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktwolfkillcnt><%=result.getString("bktwolfkillcnt")%></a><br>
								임시판매금액(11)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=11&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsalecoin><%=result.getString("bktsalecoin")%></a><br>
								임시하트획득(12)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=12&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkheart><%=result.getString("bkheart")%></a><br>
								임시건초획득(13)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=13&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkfeed><%=result.getString("bkfeed")%></a><br>
								임시연속성공횟수(14): <a href=userminus_form3.jsp?p1=19&p2=87&p3=14&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsuccesscnt><%=result.getString("bktsuccesscnt")%></a><br>
								최고신선도(15) 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=15&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestfresh><%=result.getString("bktbestfresh")%></a><br>
								최고배럴(16) 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=16&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestbarrel><%=result.getString("bktbestbarrel")%></a><br>
								최고판매금액(17)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=17&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestcoin><%=result.getString("bktbestcoin")%></a><br>
								누적배럴(18) 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=18&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktbestbarrel><%=result.getString("bkbarrel")%></a><br>
								임시일반교배(21)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=21&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkcrossnormal><%=result.getString("bkcrossnormal")%></a><br>
								임시프리미엄교배(22): <a href=userminus_form3.jsp?p1=19&p2=87&p3=22&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkcrosspremium><%=result.getString("bkcrosspremium")%></a><br><br>

								임시일반보물뽑기(23)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=48&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsgrade1cnt><%=result.getString("bktsgrade1cnt")%></a><br>
								임시프림보물뽑기(24)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=49&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bktsgrade2cnt><%=result.getString("bktsgrade2cnt")%></a><br>
								임시보물강화횟수(25)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=50&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=tsupcnt><%=result.getString("bktsupcnt")%></a><br>
								<br>
								임시배틀참여횟수(26)	: <a href=userminus_form3.jsp?p1=19&p2=87&p3=51&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkbattlecnt><%=result.getString("bkbattlecnt")%></a><br>
								임시동물강화(27)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=52&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkaniupcnt><%=result.getString("bkaniupcnt")%></a><br>
								임시동물분해(28)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=58&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkapartani><%=result.getString("bkapartani")%></a><br>
								임시보물분해(29)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=59&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkapartts><%=result.getString("bkapartts")%></a><br>
								임시동물합성(20)		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=61&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=bkcomposecnt><%=result.getString("bkcomposecnt")%></a><br><br>


								친구랭킹포인트		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=31&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=ttsalecoin><%=result.getString("ttsalecoin")%></a><br>
								에피소드포인트 		: <a href=userminus_form3.jsp?p1=19&p2=87&p3=32&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=etsalecoin><%=result.getString("etsalecoin")%></a>
								(<%=result.getString("etremain")%>)<br><br>


								지난 친구간성적<br>
								<%=result.getInt("lmcnt")%>명중 <%=result.getInt("lmrank")%>위(<%=result.getInt("lmsalecoin")%>점)<br>
								1위 <%=result.getString("l1kakaonickname")%>(<%=result.getString("l1gameid")%>) <%=result.getInt("l1salecoin")%>점 (<%=result.getInt("l1itemcode")%>, <%=result.getInt("l1acc1")%>, <%=result.getInt("l1acc2")%>)<br>
								2위 <%=result.getString("l2kakaonickname")%>(<%=result.getString("l2gameid")%>) <%=result.getInt("l2salecoin")%>점 (<%=result.getInt("l2itemcode")%>, <%=result.getInt("l2acc1")%>, <%=result.getInt("l2acc2")%>)<br>
								3위 <%=result.getString("l3kakaonickname")%>(<%=result.getString("l3gameid")%>) <%=result.getInt("l3salecoin")%>점 (<%=result.getInt("l3itemcode")%>, <%=result.getInt("l3acc1")%>, <%=result.getInt("l3acc2")%>)
							</td>
							<td>
								필드동물수량(30)		<br>
								명성레벨(31)			<br>
								친구추가(32)			<br>
								친구하트선물(33)		<br><br>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan=12>
								푸쉬<%=checkPush(result.getInt("kkopushallow"))%>:<%=getPushData(result.getString("pushid"))%><br>
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
					<br><br>유저보유템
					<table border=1>
						<tr>
							<td>listidx</td>
							<td>이름</td>
							<td>개수</td>
							<td>인벤종류</td>
							<td>획득방식</td>
							<td>획득일</td>
							<td>랜덤씨리얼</td>

							<td>필드번호</td>
							<td>단계</td>
							<td>여물통상태</td>
							<td>질병상태</td>
							<td>죽음상태</td>
							<td>필요도움</td>
							<td></td>
							<td>펫/보물(업글)/쿠폰(만기일)</td>
							<td></td>
							<td>업글</td>
							<td>줄기세포(신/공/타/방/HP)</td>
							<td>사용하트/코인</td>
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
											<%=result.getString("petupgrade")%> (펫)
										</a>
									<%}else if( result.getInt("invenkind") == 1200 ){%>
										<a href="userminus_form3.jsp?p1=19&p2=69&p3=<%=result.getInt("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change TreasureUpgrade(0 ~ <%=result.getString("upstepmax")%>)">
											<%=result.getString("treasureupgrade")%>
										</a> /
										<a href="userminus_form3.jsp?p1=19&p2=70&p3=<%=result.getInt("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&title=Change TreasureUpgrade(7 ~ 99)">
											<%=result.getString("upstepmax")%>
										</a>
										(보물)
									<%}else if( result.getInt("expirekind") == 1 ){%>
										<%=getDate19(result.getString("expiredate"))%>
										<a href=usersetting_ok.jsp?p1=19&p2=64&p3=110&p4=<%=result.getString("listidx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>
											(개발만기하기)
										</a>
									<%}%>
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=31&p3=<%=result.getString("listidx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>개발삭제</a>
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
				<br><br>유저 정보 검색이 늦어져서 링크로 옮김<br>
				<a href=userdielog_list.jsp?gameid=<%=gameid%> target=_blank>동물 죽음</a><br><br>
				<a href=useralivelog_list.jsp?gameid=<%=gameid%> target=_blank>동물 부활</a><br><br>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userdellog_list.jsp?gameid=<%=gameid%> target=_blank>유저 삭제동물/판매된동물/분해(더보기)</a>
					<table border=1>
						<tr>
							<td>listidx[idx]</td>
							<td>이름</td>
							<td>개수</td>
							<td>인벤종류</td>
							<td>획득방식</td>
							<td>획득일</td>
							<td>랜덤씨리얼</td>

							<td>필드번호</td>
							<td>단계</td>
							<td>여물통상태</td>
							<td>질병상태</td>
							<td>죽음상태</td>
							<td>머리악세</td>
							<td>꼬리악세</td>
							<td>업글</td>
							<td>줄기세포(신/공/타/방/HP)</td>
							<td>삭제순번</td>
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
					<br><br>유저 경작지
					<table border=1>
						<tr>
							<td>필드번호</td>
							<td>이름</td>
							<td>
								심은시간 ->
								완료시간
							</td>
							<td>
								획득상품
							</td>
							<td>즉시완료캐쉬</td>
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
									(<%=result.getString("param2")%>초) ->
									<%=getDate19(result.getString("seedenddate"))%>
								</td>
								<td>
									<%=getSeedItemcode(result.getInt("param6"))%>
									(<%=result.getString("param1")%>)개
								</td>
								<td><%=result.getString("param5")%></td>
							<%}else if(_fs == -1){%>
								<td><%=result.getInt("seedidx")%></td>
								<td colspan=4>구매 or 빈상태</td>
							<%}else if(_fs == -2){%>
								<td><%=result.getInt("seedidx")%></td>
								<td colspan=4>미구매</td>
							<%}%>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=85&p3=1&p4=<%=result.getString("seedidx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발비구매</a>
									<a href=usersetting_ok.jsp?p1=19&p2=85&p3=2&p4=<%=result.getString("seedidx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발구매(빈곳)</a>
									<a href=usersetting_ok.jsp?p1=19&p2=85&p3=3&p4=<%=result.getString("seedidx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발시간완료</a>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>유저 농장
					<table border=1>
						<tr>
							<!--<td>gameid</td>-->
							<td></td>
							<td>농장</td>
							<td>원가(현재가)</td>
							<td>1시간당 수입</td>
							<td>수입</td>
							<td></td>
							<td>구매</td>
							<td>상승률</td>
							<td>걷어들인총수입</td>
							<td>사고팔기</td>
							<td>구분</td>
							<td>star</td>
							<td>남은횟수</td>
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
								<td><%=getCheckValue(result.getInt("buywhere"), 1, "직접구매", "에피소드보상")%></td>
								<td><%=result.getString("star")%></td>
								<td><%=result.getString("playcnt")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>유저 에피소드 진행도
					<table border=1>
						<tr>
							<td>이름</td>
							<td>보상년도</td>
							<td>획득점수</td>
							<td>등급</td>
							<td></td>
							<td>보상템</td>
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
					<br><br><a href=usercomreward.jsp?gameid=<%=gameid%>>경쟁모드 보상</a>(진행번호 : <%=comreward%>)</a>
					<table border=1>
						<tr>
							<td></td>
							<td></td>
							<td>경쟁모드(상태)</td>
							<td>이름</td>
							<td>보상종류</td>
							<td>수량/아이템</td>
							<td>체크1</td>
							<td>체크2</td>
							<td>다음번호</td>
							<td>초기화1</td>
							<td>초기화2</td>
							<td></td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%>(<%=result.getString("idx2")%>)</td>
								<td><%=result.getString("gameyear")%>년 <%=result.getString("gamemonth")%>월(LV : <%=result.getString("famelv")%>)</td>
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
								<td><a href=usersetting_ok.jsp?p1=19&p2=95&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발삭제</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>튜토리얼 모드 진행</a>
					<table border=1>
						<tr>
							<td></td>
							<td>튜토리얼모드(상태)</td>
							<td>이름</td>
							<td>보상종류</td>
							<td>수량/아이템</td>
							<td>다음번호</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("gameyear")%>년 <%=result.getString("gamemonth")%>월(LV : <%=result.getString("famelv")%>)</td>
								<td><%=result.getString("itemcode")%>(<%=getComRewardCheckPass(result.getInt("ispass"))%>)</td>
								<td><%=result.getString("itemname")%></td>
								<td><%=getComRewardKind(result.getInt("param1"))%></td>
								<td><%=result.getString("param2")%></td>
								<td><%=result.getString("param3")%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=96&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발삭제</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=wgiftsend_list.jsp?gameid=<%=gameid%>  target=_blank>선물 받은 리스트(더보기)</a>
					<table border=1>
						<tr>
							<td>인덱스</td>
							<td>유저</td>
							<td></td>
							<td>종류</td>
							<td>아이템</td>
							<td>등급</td>
							<td>수령일</td>

							<td>가격</td>
							<td>선물자</td>
							<td>선물일</td>
							<td></td>
							<td>삭제</td>
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
									(<%=result.getString("itemcode")%> / <%=getGiftCount(result.getInt("subcategory"), result.getInt("buyamount"), result.getInt("cnt"))%>개)
								</td>
								<td><%=getGrade(result.getInt("grade"))%></td>
								<td><%=getDate(result.getString("gaindate"))%></td>

								<td><%=getPrice(result.getInt("gamecost"), result.getInt("cashcost"))%></td>
								<td><%=result.getString("giftid")%></td>
								<td><%=getDate(result.getString("giftdate"))%></td>
								<!--
								<td>
									<%if(result.getInt("gainstate") == 0){%>
										<a href=/Game4/hlskt/giftgain.jsp?idx=<%=result.getString("idxt")%>>선물강제받기</a>
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
								<a href=usersetting_ok.jsp?p1=27&p2=21&p4=<%=result.getInt("idxt")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>삭제마킹</a>
								<a href=usersetting_ok.jsp?p1=27&p2=22&p4=<%=result.getInt("idxt")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>개발원복</a>
								<a href=usersetting_ok.jsp?p1=27&p2=23&p4=<%=result.getInt("idxt")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>개발삭제</a>
							</td>
						</tr>
					<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=useritembuylog_list.jsp?gameid=<%=gameid%> target=_blank>구매 로그(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>itemname</td>
							<td>개수</td>
							<td>코인구매가/원가</td>
							<td>캐쉬구매가/원가</td>
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
					<br><br><a href=cashbuy_list.jsp?gameid=<%=gameid%> target=_blank>캐쉬로그(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>ikind</td>
							<td>구매자(gameid)</td>
							<td>선물받은사람(giftid)</td>
							<td>통신사인증(acode)</td>
							<td>클라인증(ucode)</td>
							<td>구매루비(cashcost)</td>
							<td>구매캐쉬(cash)</td>
							<td>kakaouk</td>
							<td>구매일</td>
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
								<td><a href=usersetting_ok.jsp?p1=17&p2=1&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>로그삭제</a></td>
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
					<br><br><a href=cashchange_list.jsp?gameid=<%=gameid%> target=_blank>캐쉬환전(더보기 1:100)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>루비(캐쉬) -> 코인환전</td>
							<td>환전일</td>
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
					<br><br>생애첫결제 내역</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>구매자(gameid)</td>
							<td>itemcode</td>
							<td>구매일</td>
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
								<td><a href=usersetting_ok.jsp?p1=17&p2=11&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>로그삭제</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=unusual_list.jsp?gameid=<%=gameid%> target=_blank>비정상행동(더보기)</a>
					<table border=1>
						<tr>
							<td>번호</td>
							<td>비정상유저</td>
							<td>비정상내용</td>
							<td>비정상날짜</td>
							<!--
							<td>관리자확인상태</td>
							<td>관리자확인날짜</td>
							<td>관리자확인내용</td>
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
					<br><br><a href=unusual_list2.jsp?gameid=<%=gameid%> target=_blank>비정상정보(더보기)</a>
					<table border=1>
						<tr>
							<td>번호</td>
							<td>비정상유저</td>
							<td>비정상내용</td>
							<td>비정상날짜</td>
							<!--
							<td>관리자확인상태</td>
							<td>관리자확인날짜</td>
							<td>관리자확인내용</td>
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
					<br><br><a href=userblock_list.jsp?gameid=<%=gameid%> target=_blank>유저블럭(더보기)</a>
					<table border=1>
						<tr>
							<td>번호</td>
							<td>블럭유저</td>
							<td>블럭날짜</td>
							<td>블럭내용</td>

							<td>관리자</td>
							<td>IP</td>
							<td>관리해제일</td>
							<td>해제코멘트</td>
							<td>해제하기</td>
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
					<br><br><a href=userdelete_list.jsp?gameid=<%=gameid%>>유저삭제(더보기)</a>
					<table border=1>
						<tr>
							<td>번호</td>
							<td>삭제유저</td>
							<td>삭제날짜</td>
							<td>삭제내용</td>

							<td>관리자</td>
							<td>IP</td>
							<td>관리해제일</td>
							<td>해제코멘트</td>
							<td>해제하기</td>
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
					<br><br>친구<!--<a href=userfriend_list.jsp?gameid=<%=gameid%>>친구 10명만 출력됨(더보기)</a>-->
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>친구아이디</td>
							<td>친구상태</td>
							<td>친구종류</td>
							<td>하트전송일</td>
							<td>도와줘요청일</td>
							<td>친구동물빌리기</td>
							<td></td>
							<!--
							<td>친밀도</td>
							<td>친구등록일</td>
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
									<a href=usersetting_ok.jsp?p1=19&p2=97&p3=1&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>>개발거절</a>
									<a href=usersetting_ok.jsp?p1=19&p2=97&p3=2&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>>상호승인</a>
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
					<br><br><a href=usertreasurelog_list.jsp?gameid=<%=gameid%> target=_blank>보물뽑기(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>kind</td>
							<td></td>
							<td>명성도</td>
							<td></td>
							<td>루비/코인/하트</td>
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
								<td><%=result.getString("gameyear")%>년 <%=result.getString("gamemonth")%>월</td>
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
					<br><br><a href=usercomplog_list.jsp?gameid=<%=gameid%> target=_blank>합성(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>명성도</td>
							<td></td>
							<td></td>
							<td>루비(캐쉬)</td>
							<td>코인</td>
							<td>하트</td>
							<td>합성티켓</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameyear")%>년 <%=result.getString("gamemonth")%>월</td>
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
					<br><br><a href=userpromotelog_list.jsp?gameid=<%=gameid%> target=_blank>승급(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>명성도</td>
							<td></td>
							<td></td>
							<td>루비(캐쉬)</td>
							<td>코인</td>
							<td>하트</td>
							<td>승급티켓</td>
							<td>승급(전)</td>
							<td>승급(예정)</td>
							<td>승급(결과)</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameyear")%>년 <%=result.getString("gamemonth")%>월</td>
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
					<br><br><a href=userroullog_list2.jsp?gameid=<%=gameid%> target=_blank>악세뽑기(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>framelv</td>
							<td>루비(캐쉬)</td>
							<td>코인</td>
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
					<br><br><a href=userroullog_list3.jsp?gameid=<%=gameid%> target=_blank>행운의 주사위(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td></td>
							<td>framelv</td>
							<td>루비(캐쉬)</td>
							<td>종류</td>
							<td>단계1</td>
							<td>단계2</td>
							<td>단계3</td>
							<td>단계4</td>
							<td>단계5</td>
							<td>단계6</td>
							<td>주사위결과/획득단계</td>
							<td>루비</td>
							<td>코인</td>
							<td>단계</td>
							<td>리스트 갱신</td>
							<td>시도횟수</td>
							<td>남은금액(코인)</td>
							<td>남은금액(루비)</td>
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
					<br><br>펫도감</a>
					<table border=1>
						<tr>
							<td>펫(itemcode)</td>
							<td>획득일</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("getdate")%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=92&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발삭제</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>동물도감:(개인보유)</a>
					<table border=1>
						<tr>
							<td>동물(itemcode)</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=90&p3=<%=result.getString("itemcode")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발삭제</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>동물도감(개인보상)</a>
					<table border=1>
						<tr>
							<td>도감번호</td>
							<td>도감동물(아이템코드)</td>
							<td>도감보상</td>
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
									<%=result.getString("param8")%>(<%=result.getString("param9")%>개)
								</td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=91&p3=<%=result.getString("param1")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발삭제</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>



				<%if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();%>
					<br><br><a href=adminusersalelog_list.jsp?gameid=<%=gameid%> target=_blank>거래정보(최근10개만 보임) 더보기</a>
					<table border=1>
						<tr>
							<td></td>
							<td>거래일</td>
							<td>명성도/레벨</td>
							<td>사용건초</td>
							<td>총수익(0)</td>
							<td>판매금액(1)</td>
							<td>상인요구</td>
							<td>상장금액(2)</td>
							<td>게임중획득금액(3)</td>
							<td>성과템(초과성과템)</td>
							<td>골드티켓</td>
							<td></td>
							<td>로그(소스보기로)</td>
							<td>루비/코인/하트/건초/우정</td>
							<td>유제품</td>
						</tr>
						<%while(result.next()){
							earncoin += result.getInt("salecoin") + result.getInt("prizecoin"); %>
							<tr>
								<td><%=num++%></td>
								<td>
									<%=result.getString("gameyear")%>년
									<%=result.getString("gamemonth")%>월
								</td>
								<td><%=result.getString("fame")%>/<%=result.getString("famelv")%></td>
								<td><%=result.getString("feeduse")%>개</td>
								<td>
									<%=result.getInt("salebarrel")*(result.getInt("saledanga") + result.getInt("saleplusdanga"))%>
									+ <%=result.getInt("prizecoin")%>
									+ <%=result.getInt("playcoin")%>
								</td>
								<td>
									<%=result.getString("saletrader")%>번상인
									(단가:<%=result.getString("saledanga")%>코인 + 추가:<%=result.getString("saleplusdanga")%>코인)
									x <%=result.getString("salebarrel")%>배럴(<%=result.getString("salefresh")%>신선도) =
									판매금:<%=result.getString("salecoin")%>
								</td>
								<td>
									<%=result.getString("saletrader")%>번상인
									배럴:<%=result.getString("orderbarrel")%>
									신선:<%=result.getString("orderfresh")%>
								</td>
								<td>
									연속:<%=result.getString("tradecnt")%>회
									상장:<%=result.getString("prizecnt")%>회
									수익금:<%=result.getString("prizecoin")%>
								</td>
								<td>
									수익금:<%=result.getString("playcoin")%>
									(최대Max:<%=result.getString("playcoinmax")%>)
								</td>
								<td><%=result.getString("saleitemcode")%></td>
								<td>
									<%=result.getString("goldticket")%>남음 /
									<%=getGoldTicketUsed(result.getInt("goldticketused"))%>
								</td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=66&p3=1&p4=<%=result.getString("idx2")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발삭제</a></td>
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
								총수익 : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>저장정보(개발후 삭제합니다.)</a>
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
									<%=result.getString("gameyear")%>년
									<%=result.getString("gamemonth")%>월
									<%=result.getString("frametime")%>일
								</td>
								<td><%=result.getString("fevergauge")%></td>
								<td><%=result.getString("bottlelittle")%> 	/ <%=result.getString("bottlefresh")%></td>
								<td><%=result.getString("tanklittle")%>		/ <%=result.getString("tankfresh")%></td>
								<td><%=result.getString("feeduse")%></td>
								<td><%=result.getString("boosteruse")%></td>
								<td><%=result.getString("albause")%> / <%=result.getString("albausesecond")%> / <%=result.getString("albausethird")%></td>
								<td><%=result.getString("wolfappear")%>		/ <%=result.getString("wolfkillcnt")%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=66&p3=11&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>개발삭제</a></td>
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
					<br><br><a href=adminfarmbattlelog_list.jsp?gameid=<%=gameid%> target=_blank>목장배틀정보(최근10개만 보임) 더보기</a>
					<table border=1>
						<tr>
							<td>배틀번호</td>
							<!--<td>gameid</td>-->
							<td>목장번호</td>
							<td>결과</td>
							<td>적동물</td>
							<td>동물1</td>
							<td>동물2</td>
							<td>동물3</td>
							<td>보물1</td>
							<td>보물2</td>
							<td>보물3</td>
							<td>보물4</td>
							<td>보물5</td>
							<td>참여일</td>
							<td>플레이타임</td>
							<td>보상템</td>
							<td>보상코인</td>
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
								총수익 : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();%>
					<br><br><a href=adminuserbattlelog_list.jsp?gameid=<%=gameid%> target=_blank>유저배틀정보(최근10개만 보임) 더보기</a>
					<table border=1>
						<tr>
							<td>배틀번호</td>
							<td>결과</td>
							<td>trophy(tier)</td>
							<td>동물1</td>
							<td>동물2</td>
							<td>동물3</td>
							<td>보물1</td>
							<td>보물2</td>
							<td>보물3</td>
							<td>보물4</td>
							<td>보물5</td>
							<td>상대방(gameid/nickname)</td>
							<td>상대방(trophy/tier)</td>
							<td>상대방(bankidx)</td>
							<td>참여일</td>
							<td>플레이타임</td>
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
								총수익 : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();%>
					<br><br><a href=adminuserbattlebank_list.jsp?gameid=<%=gameid%> target=_blank>유저배틀뱅크(최근10개만 보임) 더보기</a>
					<table border=1>
						<tr>
							<td>뱅크번호</td>
							<td>트로피(티어)</td>
							<td>동물1(코드/강화/att/def/hp/time)</td>
							<td>동물2</td>
							<td>동물3</td>
							<td>보물1(강화)</td>
							<td>보물2</td>
							<td>보물3</td>
							<td>보물4</td>
							<td>보물5</td>
							<td>참여일</td>
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
								총수익 : <%=earncoin%>
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=zcplog_list.jsp?gameid=<%=gameid%> target=_blank>로그(더보기)</a>
					<table border=1>
						<tr>
							<td></td>
							<td>종류</td>
							<td>사용캐쉬/보유캐쉬</td>
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

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
