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
	String kakaouserid			= util.getParamStr(request, "kakaouserid", "");
	int kakaomsginvitecnt		= 0;
	boolean bList;
	if(gameid.equals("") && phone.equals("") && kakaouserid.equals("")){
		bList = true;
	}else{
		bList = false;
	}

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
							<a href=userinfo_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
							유저 메일을 정확히 입력하세요.<br>
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>ID검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>폰번호검색(>아이디검색)</td>
						<td><input name="phone" type="text" value="<%=phone%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					<tr>
						<td>KakaoUserId(>검색)</td>
						<td><input name="kakaouserid" type="text" value="<%=kakaouserid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
					//exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'SangSang', '', '', '', '', '', '', '', '', ''
					//exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '01022223333', '', '', '', '', '', '', '', ''
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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
					cstmt.setString(idxColumn++, kakaouserid);
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
							<td></td>
						</tr>

					<%while(result.next()){
						gameid = result.getString("gameid");
						%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td width=200>
								ID : <a href=userinfo_list.jsp?gameid=<%=gameid%>><%=gameid%></a><br>
								ID : <%=result.getString("password")%><br>
								생성일: <%=getDate(result.getString("regdate"))%><br>
								최근접속일:(<%=result.getString("concnt")%>회)<%=getDate(result.getString("condate"))%><br>
								폰:<a href=userinfo_list.jsp?phone=<%=result.getString("phone")%>><%=result.getString("phone")%></a><br><br>
								체험초기: <a href=usersetting_ok.jsp?p1=19&p2=2000&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>><%=result.getString("logindate")%></a><br>
								(통계정보, 일일보물효과)
								<br><br>
								<a href=usersetting_ok.jsp?p1=19&p2=4&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>
									<%=getCheckValue(result.getInt("kkopushallow"), 1, "푸쉬발송가능", "<font color=red>푸쉬발송거절</font>")%>
								</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=1&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>
									<%=getBlockState(result.getInt("blockstate"))%>
								</a><br>
								캐쉬조작:<%=result.getString("cashcopy")%><br>
							</td>
							<td>
								<%=getTel(result.getInt("market"))%>
								<%=getPlatform(result.getInt("platform"))%><br>
								ver:<%=result.getString("version")%><br>
								캐쉬구매:<%=result.getString("cashpoint")%><br>
								VIP:<%=result.getString("vippoint")%> / <%=result.getString("vippoint2")%><br>
								우유결정:<%=result.getString("cashcost")%> / <%=result.getString("cashcost2")%><br>
								<a href=usersetting_ok.jsp?p1=19&p2=97&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>
									<%=getLogWrite2(result.getInt("logwrite2"))%>
								</a><br><br>

								SessionID		: <%=result.getString("sid")%><br><br>

								환생일 			: <%=getDate(result.getString("rebirthdate"))%>
												  <a href=usersetting_ok.jsp?p1=19&p2=64&p3=202&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>(start)</a><br>
								환생횟수(누적)	: <%=result.getInt("rebirthcnt")%><br>
								환생별수(누적): <%=result.getInt("rebirthpoint")%><br>
								환생점수(랭킹용): <%=result.getInt("rebirthpts")%>
												  <a href=usersetting_ok.jsp?p1=19&p2=64&p3=201&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>(clear)</a><br>
								환생횟수(랭킹용): <%=result.getInt("rebirthptscnt")%><br>
								<br>

								<%=getConCode(result.getInt("concode"))%><br>
								복귀단계:
										<a href=userminus_form3.jsp?p1=19&p2=89&p3=1&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>
											<%=getRtnStep(result.getInt("rtnstep"))%>
										</a><br>
								복귀진행월:
										<a href=userminus_form3.jsp?p1=19&p2=89&p3=2&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>
											<%=result.getString("rtnplaycnt")%>
										</a><br>
								복귀요청사람:
										<%=result.getString("rtngameid")%><br>
										(<%=getDate19(result.getString("rtndate"))%>)<br>
										<a href=usersetting_ok.jsp?p1=19&p2=89&p3=3&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>1일전</a> /
										<a href=usersetting_ok.jsp?p1=19&p2=89&p3=4&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>30일전</a><br>

							</td>
							<td>
								닉네임(카톡아님): <%=result.getString("nickname")%><br>
								카톡 talkId 	: <%=result.getString("kakaotalkid")%><br>
								카톡 userId 	: <a href=userinfo_list.jsp?kakaouserid=<%=result.getString("kakaouserid")%>><%=result.getString("kakaouserid")%></a><br>
								카톡 메세지블럭 : <a href=usersetting_ok.jsp?p1=19&p2=88&p3=10&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=><%=getKakaoMessageBlocked(result.getInt("kakaomsgblocked"))%></a><br>
								카톡 현재상태 	:
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=12&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=>
										<%=getKakaoStatus(result.getInt("kakaostatus"))%>
									</a><br>
								카톡 초대인원수: <a href=userminus_form3.jsp?p1=19&p2=88&p3=1&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=kakaomsgInviteCount><%=(kakaomsginvitecnt = result.getInt("kakaomsginvitecnt"))%></a>명을 초대<br>
								카톡 1일초대인원: <a href=userminus_form3.jsp?p1=19&p2=88&p3=8&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=kakaomsgInviteTodayCnt><%=result.getInt("kakaomsginvitetodaycnt")%></a><br>
								카톡 1일초대날짜 : <a href=usersetting_ok.jsp?p1=19&p2=88&p3=9&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=kakaomsgInviteTodayCnt><%=getDate19(result.getString("kakaomsginvitetodaydate"))%></a><br>


							</td>
							<td>
								하트 받을것 : 		<a href=userminus_form3.jsp?p1=19&p2=64&p3=60&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=heartget><%=result.getString("heartget")%></a><br>
									                (로그인,하트,저장 => 받아간후 초기화됨)<br>
								하트 일일전송량 : 	<a href=userminus_form3.jsp?p1=19&p2=64&p3=61&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=heartcnt><%=result.getString("heartcnt")%>(하루전송량)</a><br>
													(하루동안 전송된량, 한번 10씩 전송됨)<br>
								하트 max :		 	<%=result.getString("heartcntmax")%><br>
								하트 초기화날 : 	<a href=usersetting_ok.jsp?p1=19&p2=64&p3=62&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=heartdate><%=result.getString("heartdate")%></a><br>
									                (날짜가 지나면 [일일전송량]이 초기화됨)<br><br>

								일일회전판(20) :<a href=usersetting_ok.jsp?p1=19&p2=88&p3=18&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=heartdate><%=getRouletteState(result.getInt("roulette"))%></a><br>
								무료룰렛:(<%=result.getInt("roulettefreecnt")%>)<br>
								유료룰렛:(<%=result.getInt("roulettepaycnt")%>)<br>
								황금무료게이지: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=19&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=heartdate><%=result.getInt("wheelgauage")%></a> (클릭시 풀로해워줌)<br>
								황금무료수량: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=20&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=heartdate><%=result.getInt("wheelfree")%></a> (클릭시 한장을줌)<br>

								<br>

							</td>
							<td>
								현재점수 : <a href=userminus_form3.jsp?p1=19&p2=88&p3=16&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=salemoney><%=result.getLong("salemoney")%></a>점
									       <a href=usersetting_ok.jsp?p1=19&p2=88&p3=17&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>Clear</a><br>
								지난 친구간성적<br>
								<a href=usersetting_ok.jsp?p1=19&p2=2003&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>><%=getRankResult(result.getInt("rankresult"))%></a><br>

								<%=result.getInt("lmcnt")%>명중 <%=result.getInt("lmrank")%>위(<%=result.getLong("lmsalemoney")%>점)<br>
								1위 <%=result.getString("l1gameid")%> <%=result.getLong("l1salemoney")%>점 (<%=result.getInt("l1bestani")%>)<br>
								2위 <%=result.getString("l2gameid")%> <%=result.getLong("l2salemoney")%>점 (<%=result.getInt("l2bestani")%>)<br>
								3위 <%=result.getString("l3gameid")%> <%=result.getLong("l3salemoney")%>점 (<%=result.getInt("l3bestani")%>)

							</td>
							<td>
								보상일: <%=result.getString("rkdateid8bf")%><br>
								팀    : <%=getRKTeam(result.getInt("rkteam"))%><br>

								판매수익 : <%=result.getString("rksalemoney")%><br>
								생산수량 : <%=result.getString("rkproductcnt")%><br>
								목장수익 : <%=result.getString("rkfarmearn")%><br>
								늑대사냥 :  <%=result.getString("rkwolfcnt")%><br>
								친구포인트 : <%=result.getString("rkfriendpoint")%><br>
								룰렛횟수 : <%=result.getString("rkroulettecnt")%><br>
								플레이타임: <%=result.getString("rkplaycnt")%><br>
							</td>
							<td>
								최고동물	: <%=result.getString("bestani")%><br><br>
								보유금액	: <%=result.getString("ownercashcost")%><br><br>
								(횟수/이벤트게이지/무료수량)<br>
								뽑기횟수(D,C):
													<a href=usersetting_ok.jsp?p1=19&p2=64&p3=100&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>><%=result.getString("tsgrade1cnt")%></a><br>
								뽑기횟수(B,A):
													<a href=usersetting_ok.jsp?p1=19&p2=64&p3=101&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>><%=result.getString("tsgrade2cnt")%></a>
													/ <%=result.getString("tsgrade2gauage")%>
													/ <%=result.getString("tsgrade2free")%><br>
								뽑기횟수(A,S):
													<a href=usersetting_ok.jsp?p1=19&p2=64&p3=102&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>><%=result.getString("tsgrade3cnt")%></a>
													/ <%=result.getString("tsgrade3gauage")%> / <%=result.getString("tsgrade3free")%><br>
								뽑기횟수(A,S)(3+1):
													<a href=usersetting_ok.jsp?p1=19&p2=64&p3=103&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>><%=result.getString("tsgrade4cnt")%></a>
													/ <%=result.getString("tsgrade4gauage")%>
													/ <%=result.getString("tsgrade4free")%><br>

								광고번호 :<a href=usersetting_ok.jsp?p1=19&p2=64&p3=31&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>><%=result.getString("adidx")%></a>
							</td>
							<td>
								<a href=wgiftsend_form.jsp?gameid=<%=gameid%> target=_blank>선물/쪽지</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=1&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>일괄블럭</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=<%=gameid%>&branch=userinfo_list&gameid=<%=gameid%>>개발진짜삭제</a><br>
								<a href=push_list.jsp?gameid=<%=gameid%>&personal=1 target=_blank>푸쉬발송</a><br><br>

								<a href=userminus_form4.jsp?p1=19&p2=4003&title=SaveData&ps1=<%=gameid%>>세이브 데이타 강제입력</a><br><br>
								<a href=cash_form.jsp?gameid=<%=gameid%> target=_blank>캐쉬강제입력</a><br><br>
							</td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2004&ps1=<%=gameid%>&ps2=91188455545412242&branch=userinfo_list&gameid=<%=gameid%>>영선PC</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2004&ps1=<%=gameid%>&ps2=91188455545412249&branch=userinfo_list&gameid=<%=gameid%>>영선집PC</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2004&ps1=<%=gameid%>&ps2=88258263875124913&branch=userinfo_list&gameid=<%=gameid%>>영선핸드폰</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2004&ps1=<%=gameid%>&ps2=88470968441492992&branch=userinfo_list&gameid=<%=gameid%>>임과장</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2004&ps1=<%=gameid%>&ps2=88812599272546640&branch=userinfo_list&gameid=<%=gameid%>>최정기</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2004&ps1=<%=gameid%>&ps2=92064568193308403&branch=userinfo_list&gameid=<%=gameid%>>박인규</a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2004&ps1=<%=gameid%>&ps2=91188455545412243&branch=userinfo_list&gameid=<%=gameid%>>박준식PC</a><br>
							</td>
						</tr>
						<tr>
							<td colspan=10><%=result.getString("pushid")%></td>
						</tr>
					<%
						if(bList){
							maxPage = result.getInt("maxPage");
						}
					}%>
					<%if(bList){%>
						<tr>
							<td colspan=10 align=center>
									<a href=userinfo_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
									<%=idxPage%> / <%=maxPage%>
									<a href=userinfo_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
							</td>
						</tr>
					<%}%>
				</table>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>유저 카톡 정보
					<table border=1>
						<tr>
							<td></td>
							<td>kakaouserid</td>
							<td>kakaotalkid</td>
							<td>gameid</td>
							<td></td>
							<td>kakaodata</td>
							<td>가입일</td>
							<td>삭제일(클릭시 재가입초기화)</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("kakaouserid")%></td>
								<td><%=result.getString("kakaotalkid")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("cnt")%> / <%=result.getString("cnt2")%></td>
								<td><%=result.getString("kakaodata")%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=64&p3=41&p4=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameid%>>
										<%=getDate(result.getString("deldate"))%>
									</a> /
									<%if(gameid.equals(result.getString("gameid"))){%>
										<font color=blue>활성계정상태</a>
										<a href=usersetting_ok.jsp?p1=19&p2=64&p3=43&ps1=<%=gameid%>&ps2=<%=adminid%>&ps3=<%=result.getString("kakaouserid")%>&branch=userinfo_list&gameid=<%=gameid%>>
											(연결끊기)
										</a>
									<%}else{%>
										<a href=usersetting_ok.jsp?p1=19&p2=64&p3=42&ps1=<%=gameid%>&ps2=<%=adminid%>&ps3=<%=result.getString("kakaouserid")%>&branch=userinfo_list&gameid=<%=gameid%>>
											재연결(조심히 사용하삼)
										</a>
									<%}%>
								</td>
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
							<td>구매자</td>
							<td>친구선물</td>
							<td>통신사인증(acode)</td>
							<td>구매캐쉬(cash)</td>
							<td>구매일</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("ikind")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=getGameid(result.getString("giftid"))%></td>
								<td><%=result.getString("acode")%></td>
								<td><%=result.getString("cash")%></td>
								<td><%=result.getString("writedate")%></td>
								<td><a href=usersetting_ok.jsp?p1=17&p2=1&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>로그삭제</a></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=wgiftsend_list.jsp?gameid=<%=gameid%>  target=_blank>선물 리스트(더보기)</a>
					<table border=1>
						<tr>
							<td>인덱스</td>
							<td>유저</td>
							<td></td>
							<td>종류</td>
							<td>아이템</td>
							<td>선물수량</td>
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
									(<%=result.getString("itemcode")%>)
								</td>
								<td>
									<%=result.getString("cnt")%>
									<%=getCategoryUnit(result.getInt("category"))%>

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
								<td colspan=5>
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
					<br><br><a href=userroullog_list.jsp?gameid=<%=gameid%> target=_blank>보물뽑기(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>kind</td>
							<td>bestani</td>
							<td></td>
							<td>보유결정</td>
							<td></td>
							<td>수정(캐쉬)</td>
							<td>코인</td>
							<td>하트</td>
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
								<td><%=getCheckRoulMode(result.getInt("kind"))%></td>
								<td><%=result.getString("bestani")%></td>
								<td><%=result.getString("itemcodename")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getInt("ownercashcost")%> -> <%=result.getInt("ownercashcost2")%></td>
								<td><%=getTSStrange(result.getInt("strange"))%></td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("gamecost")%></td>
								<td><%=result.getString("heart")%></td>
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
					<br><br><a href=tsupgrade_list.jsp?gameid=<%=gameid%> target=_blank>보물강화(더보기)</a>
					<table border=1>
						<tr>
							<td></td>
							<td></td>
							<td>강화종류</td>
							<td>강화단계</td>
							<td>결과</td>
							<td>보유결정</td>
							<td></td>
							<td>사용우유결정</td>
							<td>하트</td>
							<td>날짜</td>
						</tr>
						<%while(result.next()){%>
							<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("idx2")%></td>
							<td><%=getTSMode(result.getInt("mode"))%></td>
							<td><%=result.getInt("step")%></td>
							<td><%=getTSResult(result.getInt("results"))%></td>
							<td><%=result.getInt("ownercashcost")%> -> <%=result.getInt("ownercashcost2")%></td>
							<td><%=getTSStrange(result.getInt("strange"))%></td>
							<td><%=result.getInt("cashcost")%></td>
							<td><%=result.getInt("heart")%></td>
							<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=wheel_list.jsp?gameid=<%=gameid%> target=_blank>회전판(더보기)</a>
					<table border=1>
						<tr>
							<td></td>
							<td></td>
							<td>회전판종류</td>
							<td>보유결정</td>
							<td></td>
							<td>사용우유결정</td>
							<td>날짜</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("idx2")%></td>
								<td><%=getWheelMode(result.getInt("mode"))%></td>
								<td><%=result.getInt("ownercashcost")%> -> <%=result.getInt("ownercashcost2")%></td>
								<td><%=getTSStrange(result.getInt("strange"))%></td>
								<td><%=result.getInt("cashcost")%></td>
								<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<br>
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<table border=1>
						<tr>
							<td>분류코드</td>
							<td>마켓</td>
							<td>쿠폰</td>
							<td>아이템1</td>
							<td>아이템2</td>
							<td>아이템3</td>
							<td>받은시간</td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr >
							<td><%=result.getString("kind")%></td>
							<td><%=getTel(result.getInt("market"))%></td>
							<td><%=result.getString("certno")%></td>
							<td><%=result.getString("itemcode1")%> <%=result.getString("cnt1")%>개</td>
							<td><%=result.getString("itemcode1")%> <%=result.getString("cnt1")%>개</td>
							<td><%=result.getString("itemcode1")%> <%=result.getString("cnt1")%>개</td>
							<td><%=getDate(result.getString("usedtime"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=1004&p3=4&p4=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>삭제</a>
							</td>
						</tr>
					<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=rebirth_list.jsp?gameid=<%=gameid%> target=_blank>환생정보(더보기)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>rebirthpoint</td>
							<td></td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr >
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("rebirthpoint")%></td>
							<td><%=getDate(result.getString("writedate"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=88&p3=24&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>>개발삭제</a>
							</td>
						</tr>
					<%}%>
					</table>
				<%}%>

				<br>
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<table border=1>
						<tr>
							<td>세이브데이타</td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr>
							<td colspan=2>
								휴지(1틱) : <a href=usersetting_ok.jsp?p1=19&p2=88&p3=21&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>><%=getDate19(result.getString("savedate"))%></a><br>
								휴지(1일) : <a href=usersetting_ok.jsp?p1=19&p2=88&p3=22&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>><%=getDate19(result.getString("savedate"))%></a><br><br>
							</td>
						</tr>
						<tr >
							<td><%=getStringDivide(200, result.getString("savedata"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2001&p3=<%=result.getString("idx")%>&p4=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>삭제</a>
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<%
								//String _str = "14:302337673%270:45%1:24280,24282,24283,24284,24285%2:30%3:2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2013,2013,2013,2013,2013,2013,2013%4:523,523,523,522,522,522,522,522,522,522,522,522,522,522,522,522,522,522,522,522,522,522,522,521,521,521,515,515,-1,-1%5:11,11,10,11,11,11,11,10,11,11,11,11,11,10,11,11,10,10,11,10,11,11,11,10,11,11,10,11,-1,-1%280:%6:2593%7:9%8:44%27:-1%19:4000,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026%50:260232,260232,260232,260232,260232,260232,260232,260232,260232,0,0,0%51:2342088%52:258282099%40:4000@6,4001@6,4002@6,4003@6,4004@6,4005@6,4006@6,4007@6,4008@6,4009@6,4010@6,4011@6,4012@6,4013@6,4014@6,4015@6,4016@6,4017@6,4018@6,4019@6,4020@6,4021@6,4022@6,4023@6,4024@6,4025@6,4026@6%9:11530,5898,3095,2430,1941,1664,1606,1422,1378,1039,1221,1010,855,1089,301,83815%100:24309%101:24321%102:24289%13:369600%21:1%22:1%23:1%260:1%28:-1%29:-1%34:%35:%30:7002,7001,7000,7003,7004%15:3151%24:85248881698%31:1,0,3,6,2,8,10,4,9,13,5,11,18,12,7,16,19,20,29,23,21,15,28,17,22,39,26,33,38,30,32,25,14,31,43,48,42,27,36,24,52,41,58,37,40,35,34,53,51,45,47,62,57,61,50,46,49,68,55,67,56,66,63%16:9%17:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0%18:5012%25:30%36:24303%33:test_for_pc%37:com.sangsangdigital.farmgg%60:1%61:31125%62:3014%63:175%65:114%70:30%85:1,1,1,1,1,1,1,1,1,1,1,1,1,1,0%86:10,9,8,8,8,8,9,8,8,8,8,8,8,8,1%88:03/08/2015 04@54@38^03/03/2015 19@26@33^02/28/2015 11@08@33^02/28/2015 11@08@36^02/28/2015 11@08@40^02/28/2015 11@08@43^03/03/2015 19@27@28^02/28/2015 11@08@53^02/28/2015 11@08@59^02/28/2015 11@09@07^02/28/2015 11@10@39^02/28/2015 21@12@24^02/28/2015 11@10@48^02/28/2015 21@03@58^-1%93:0^0^0^10^51704@1^0^0^9^9560@2^0^0^8^5474@3^188^2^8^55600@4^0^0^8^37023@5^0^0^8^9611@7^102^2^8^55712@8^0^1^8^55624@9^0^0^8^5474@11^35^2^8^55640@12^76^2^8^55747@13^35^2^8^55672%201:7%210:305%221:11%250:30%290:4%300:02/18/2016 00@17@39";
								//out.print(getParseData(_str));
								out.print(getParseData(result.getString("savedata")));
								%>
							</td>
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
					<br><br>친구<!--<a href=userfriend_list.jsp?gameid=<%=gameid%>>친구 10명만 출력됨(더보기)</a>-->
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>친구아이디</td>
							<td>닉네임11</td>
							<td>친구상태</td>
							<td>친구종류</td>
							<td>하트전송일</td>
							<!--
							<td>도와줘요청일</td>
							<td>친구동물빌리기</td>
							-->
							<td></td>
							<td>친구등록일</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("friendid")%></td>
								<td><%=result.getString("nickname")%></td>
								<td><%=getFriend(result.getInt("state"))%></td>
								<td><%=getFriendKind(result.getInt("kakaofriendkind"))%></td>
								<td><a href=usersetting_ok.jsp?p1=19&p2=64&p3=3&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>><%=getDate(result.getString("senddate"))%></a>
								</td>
								<!--
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=4&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>><%=getDate(result.getString("helpdate"))%></a>
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=11&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>><%=getDate(result.getString("rentdate"))%></a>
								</td>
								-->
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=97&p3=1&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>>개발거절</a>
									<!--<a href=usersetting_ok.jsp?p1=19&p2=97&p3=2&ps1=<%=gameid%>&ps2=<%=result.getString("friendid")%>&branch=userinfo_list&gameid=<%=gameid%>>상호승인</a>-->
								</td>
								<td><%=getDate(result.getString("writedate"))%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userkakaoinvite_list.jsp?gameid=<%=gameid%> target=_blank>카톡 친구 초대(<%=kakaomsginvitecnt%>명 초대중)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>receuserid</td>
							<td>cnt</td>
							<td>senddate</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("receuserid")%></td>
								<td><%=result.getString("cnt")%></td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=2&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=kakaomsgInviteCount><%=getDate(result.getString("senddate"))%></a>
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=3&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=kakaomsgInviteCount>개발삭제</a>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userrecommand_list.jsp?gameid=<%=gameid%> target=_blank>친구 추천보상</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>kakaouserid</td>
							<td>kakaouseridfd</td>
							<td>writedate</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("kakaouserid")%></td>
								<td><%=result.getString("kakaouseridfd")%></td>
								<td><%=result.getString("writedate")%></td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=88&p3=23&p4=<%=result.getString("idx")%>&ps1=<%=gameid%>&ps2=<%=adminid%>&gameid=<%=gameid%>&title=kakaomsgInviteCount>개발삭제</a>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userfreecashlog_list.jsp?gameid=<%=gameid%> target=_blank>무료로고</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>bestani</td>
							<td>cashcost</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("bestani")%></td>
								<td><%=result.getString("cashcost")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					백업파일
					<table border=1>
						<tr>
							<td>idx2</td>
							<td>savedata</td>
							<td></td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr >
							<td><%=result.getInt("idx2")%></td>
							<td><%=getStringDivide(200, result.getString("savedata"))%></td>
							<td><%=result.getString("writedate")%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2005&p3=<%=result.getString("idx")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>유저복구</a><br>
							</td>
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
