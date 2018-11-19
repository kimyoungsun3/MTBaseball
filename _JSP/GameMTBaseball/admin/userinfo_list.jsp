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
	String gameidCurRow			= "";
	boolean bList;
	if(gameid.equals("") && phone.equals("")){
		bList = true;
	}else{
		bList = false;
	}

	int comreward				= -1;
	int num						= 0;
	int earncoin				= 0;
	int level					= 0;
	int kind					= 0;
	int row						= 0;
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
							유저 아이디를 정확히 입력하세요.
							<a href=userinfo_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>게임아이디</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>폰번호검색</td>
						<td><input name="phone" type="text" value="<%=phone%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
					//exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''
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
						gameidCurRow = result.getString("gameid");
						//if(gameid.equals(result.getString("gameid"))){
						//}
					%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td width=200>
								ID : <a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a><br>
								PW : <%=result.getString("password")%><br>
								버젼 : <%=result.getString("version")%><br>
								SID :<%=result.getString("sid")%>
								(<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=9&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>>초기화</a>)<br>
								connectip : <a href=pcroom_list.jsp?connectip=<%=result.getString("connectip")%>><%=result.getString("connectip")%></a><br>
							</td>
							<td>
								폰:<a href=userinfo_list.jsp?phone=<%=result.getString("phone")%>><%=result.getString("phone")%></a><br>
								이름 :<%=result.getString("username")%><br>
								생일 :<%=result.getString("birthday")%><br>
								email :<%=result.getString("email")%><br>
								nickname :<%=result.getString("nickname")%><br>
							</td>
							<td>
								보유캐쉬(다이아) 	: <a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=0><%=result.getString("cashcost")%></a><br>								
								보유코인(볼) 	: <a href=userminus_form.jsp?gameid=<%=result.getString("gameid")%>&mode=3><%=result.getString("gamecost")%></a><br>								
								누적캐쉬 		: <%=result.getString("cashbuytotal")%><br>
								받은캐쉬 		: <%=result.getString("cashreceivetotal")%><br><br>
								
								배팅수익(누적볼)	: <%=result.getString("gaingamecost")%><br>
								PC방업주마진수익(누적볼): <%=result.getString("gaingamecostpc")%><br>
							</td>
							<td>
								exp :<a href=userminus_form4.jsp?mode=1&p1=19&p2=65&p3=2&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&gameid=<%=gameidCurRow%>&title=Experience&strlen=12><%=result.getString("exp")%></a><br>
								레벨 : <%=result.getString("level")%><br>
								레벨수수료 : <%=(float)result.getInt("commission")/100%>%<br>
								(7% - 레벨수수료 - 소모템)<br>
								<br>
								tutorial : 
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=1&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>>
									<%=getTutorial(result.getInt("tutorial"))%>
								</a><br>
								
								randserial : <%=result.getString("randserial")%><br>
								
								파라미터(0 ~ 9):<br>
								<%for(int i = 0; i < 10; i++){
									out.print( result.getString("param" + i) + "/");
								}%><br>
							</td>
							<td>
								착용템총: <%=(float)result.getInt("wearplusexp") / 100%>%
								(<%=(float)(result.getInt("wearplusexp") - result.getInt("setplusexp")) / 100%>
								+ <%=(float)result.getInt("setplusexp") / 100%>)
								<br>
								파트별:listidx (추가경험치/세트)<br>
								helmetlistidx 	: <%=result.getString("helmetlistidx")%>	( <%=result.getInt("helmetexp")%> / <%=result.getInt("helmetsetnum")%>)<br>
								shirtlistidx 	: <%=result.getString("shirtlistidx")%> 	( <%=result.getInt("shirtexp")%> / <%=result.getInt("shirtsetnum")%>)<br>
								pantslistidx 	: <%=result.getString("pantslistidx")%> 	( <%=result.getInt("pantsexp")%> / <%=result.getInt("pantssetnum")%>)<br>
								gloveslistidx 	: <%=result.getString("gloveslistidx")%> 	( <%=result.getInt("glovesexp")%> / <%=result.getInt("glovessetnum")%>)<br>
								shoeslistidx 	: <%=result.getString("shoeslistidx")%> 	( <%=result.getInt("shoesexp")%> / <%=result.getInt("shoessetnum")%>)<br>
								batlistidx 		: <%=result.getString("batlistidx")%> 		( <%=result.getInt("batexp")%> / <%=result.getInt("batsetnum")%>)<br>
								balllistidx 	: <%=result.getString("balllistidx")%> 		( <%=result.getInt("ballexp")%> / <%=result.getInt("ballsetnum")%>)<br>
								gogglelistidx 	: <%=result.getString("gogglelistidx")%> 	( <%=result.getInt("goggleexp")%> / <%=result.getInt("gogglesetnum")%>)<br>
								wristbandlistidx : <%=result.getString("wristbandlistidx")%>( <%=result.getInt("wristbandexp")%> / <%=result.getInt("wristbandsetnum")%>)<br>
								elbowpadlistidx : <%=result.getString("elbowpadlistidx")%> 	( <%=result.getInt("elbowpadexp")%> / <%=result.getInt("elbowpadsetnum")%>)<br>
								beltlistidx 	: <%=result.getString("beltlistidx")%> 		( <%=result.getInt("beltexp")%> / <%=result.getInt("beltsetnum")%>)<br>
								kneepadlistidx 	: <%=result.getString("kneepadlistidx")%> 	( <%=result.getInt("kneepadexp")%> / <%=result.getInt("kneepadsetnum")%>)<br>
								sockslistidx 	: <%=result.getString("sockslistidx")%> 	( <%=result.getInt("socksexp")%> / <%=result.getInt("sockssetnum")%>)<br>
							</td>
							<td>
								싱글플래그 		: 
												<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=10&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>>
													<%=getSingleFlag(result.getInt("singleflag"))%>
												</a><br>	
								싱글시도횟수 	: <%=result.getString("singletrycnt")%><br>
								싱글성공		: <%=result.getString("singlesuccesscnt")%><br>
								싱글실패 		: <%=result.getString("singlefailcnt")%><br>
								싱글오류 		: <%=result.getString("singleerrorcnt")%><br>
							</td>
							<td>
								조각박스오픈수량 		: <%=result.getString("pieceboxopencnt")%><br>
								의상박스오픈수량 		: <%=result.getString("wearboxopencnt")%><br>
								조언박스오픈수량 		: <%=result.getString("adviceboxopencnt")%><br>
								조각 조합수량 		: <%=result.getString("combinatecnt")%><br>
								의상 초월수량 		: <%=result.getString("evolutioncnt")%><br>
							</td>
							<td>
								캐쉬카피: <a href=usersetting_ok.jsp?p1=19&p2=2000&p3=20&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>><%=result.getString("cashcopy")%></a><br>
								결과카피: <a href=usersetting_ok.jsp?p1=19&p2=2000&p3=21&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>><%=result.getString("resultcopy")%></a><br>
									   <a href=usersetting_ok.jsp?p1=19&p2=2000&p3=22&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>>
											<%=getBlockState(result.getInt("blockstate"))%>
									   </a><br>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=23&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>>일괄블럭</a><br>
								<a href=usersetting_ok.jsp?p1=18&p2=1&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&branch=userinfo_list&gameid=<%=gameidCurRow%>>개발진짜삭제</a><br>
								<a href=wgiftsend_form.jsp?gameid=<%=gameidCurRow%> target=_blank>선물/쪽지</a><br>
							</td>
							<td>							
								생성일: <%=getDate(result.getString("regdate"))%><br>
								접속일: <%=getDate(result.getString("condate"))%><br>
								접속횟수: <%=result.getString("concnt")%>회<br>									
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

							<td></td>
							<td>업글</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("listidx")%></td>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td>
									<%if(getInvenKindCountDisplay(result.getInt("invenkind"))){%>
										<a href=userminus_form2.jsp?p1=19&p2=71&p3=<%=result.getString("listidx")%>&p4=<%=result.getString("cnt")%>&gameid=<%=result.getString("gameid")%>>
											<%=result.getString("cnt")%>
										</a>
									<%}%>
								</td>
								<td><%=getInvenKind(result.getInt("invenkind"))%></td>
								<td><%=getGetHow(result.getInt("gethow"))%></td>
								<td><%=getDate(result.getString("writedate"))%></td>
								<td><%=result.getString("randserial")%></td>
								<td>
									<a href=usersetting_ok.jsp?p1=19&p2=31&p3=<%=result.getString("listidx")%>&ps1=<%=result.getString("gameid")%>&branch=userinfo_list&gameid=<%=result.getString("gameid")%>>개발삭제</a>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>
				
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=userdellog_list.jsp?gameid=<%=gameid%> target=_blank>유저 삭제/판매된/분해(더보기)</a>
					<table border=1>
						<tr>
							<td>listidx[idx]</td>
							<td>이름</td>
							<td>개수</td>
							<td>인벤종류</td>
							<td>획득방식</td>
							<td>획득일</td>
							<td>랜덤씨리얼</td>

							<td>단계</td>
							<td>업글</td>
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
								<td><%=result.getString("manger")%></td>
								<td><%=result.getString("idx2")%>(<%=getDate(result.getString("writedate2"))%>)</td>
								<td><%=getUserItemState(result.getInt("state"))%></td>
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


				<!--
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
				-->
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=sgbet_list.jsp?gameid=<%=gameid%> target=_blank>싱글 배팅중(더보기)</a>
					<table border=1>
						<tr>
							<td colspan=2></td>
							<td colspan=2>배팅</td>
							<td></td>
							<td>파워볼</td>
							<td></td>
							<td>합볼</td>
							<td></td>
							<td colspan=4>배팅시 정보</td>
							<td colspan=4></td>
						</tr>
						<tr>
							<td>인덱스</td>
							<td></td>
							<td>회차</td>
							<td>들어올예정시간</td>
							<td>게임모드</td>
							<td>스트라이크(1)/볼(0)</td>
							<td>직구(1)/변화구(0)</td>
							<td>좌(1)/우(0)</td>
							<td>상(1)/하(0)</td>
							<td>접속IP</td>
							<td>레벨</td>
							<td>경험치</td>
							<td>수수료차감값</td>
							<td>소모템</td>
							<td>배팅상태</td>
							<td></td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("curturntime")%></td>
							<td><%=getDate19(result.getString("curturndate"))%></td>
							<td><%=getGameMode(result.getInt("gamemode"))%></td>
							<td>
								<%=getSelectMode(1, result.getInt("select1"), -1)%> / 
								<%=result.getInt("cnt1")%> /
							</td>
							<td>
								<%=getSelectMode(2, result.getInt("select2"), -1)%> / 
								<%=result.getInt("cnt2")%> /
							</td>
							<td>
								<%=getSelectMode(3, result.getInt("select3"), -1)%> /
								<%=result.getInt("cnt3")%> /
							</td>
							<td>
								<%=getSelectMode(4, result.getInt("select4"), -1)%> / 
								<%=result.getInt("cnt4")%> /
							</td>
							<td><%=result.getString("connectip")%></td>
							<td><%=result.getInt("level")%></td>
							<td><%=result.getInt("exp")%></td>
							<td><%=(float)result.getInt("commissionbet")/100%>%</td>
							<td><%=result.getInt("consumeitemcode")%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=28&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=userinfo_list>
									<%=getGameState(result.getInt("gamestate"))%>
								</a>
							</td>
							<td><%=getDate19(result.getString("writedate"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=25&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=userinfo_list>강제삭제</a>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=26&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=userinfo_list>강제롤백</a>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=29&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=userinfo_list>강제계산</a>
							</td>
						</tr>
					<%}%>
					</table>
				<%}%>
				
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=sgresult_list.jsp?gameid=<%=gameid%> target=_blank>싱글 배팅결과(더보기)</a>
					<table border=1>
						<tr>
							<td colspan=2></td>
							<td colspan=2>배팅</td>
							<td></td>
							<td>파워볼</td>
							<td></td>
							<td>합볼</td>
							<td></td>
							<td colspan=4>배팅시 정보</td>
							<td colspan=4></td>
						</tr>
						<tr>
							<td>인덱스</td>
							<td></td>
							<td>회차</td>
							<td>들어올예정시간</td>
							<td>게임모드<br>결과</td>
							<td>스트라이크(1)/볼(0)<br>결과</td>
							<td>직구(1)/변화구(0)<br>결과</td>
							<td>좌(1)/우(0)<br>결과</td>
							<td>상(1)/하(0)<br>결과</td>
							<td>접속IP<br>PC방gameid</td>
							<td>레벨<br>PC방획득볼</td>
							<td>경험치<br>기록일</td>
							<td>수수료차감값<br>유저획득경험치</td>
							<td>소모템<br>유저획득볼</td>
							<td>배팅상태</td>
							<td></td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr <%=getColor(++row%2)%>>
							<td><%=result.getString("idx")%>(<%=result.getString("idx2")%>)</td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("curturntime")%></td>
							<td><%=getDate19(result.getString("curturndate"))%></td>
							<td><%=getGameMode(result.getInt("gamemode"))%></td>
							<td>
								<%=getSelectMode(1, result.getInt("select1"), result.getInt("ltselect1"))%> / 
								<%=result.getInt("cnt1")%> /
							</td>
							<td>
								<%=getSelectMode(2, result.getInt("select2"), result.getInt("ltselect2"))%> / 
								<%=result.getInt("cnt2")%> /
							</td>
							<td>
								<%=getSelectMode(3, result.getInt("select3"), result.getInt("ltselect3"))%> / 
								<%=result.getInt("cnt3")%> /
							</td>
							<td>
								<%=getSelectMode(4, result.getInt("select4"), result.getInt("ltselect4"))%> / 
								<%=result.getInt("cnt4")%> /
							</td>
							<td><%=result.getString("connectip")%></td>
							<td><%=result.getInt("level")%></td>
							<td><%=result.getInt("exp")%></td>
							<td><%=(float)result.getInt("commissionbet")/100%>%</td>
							<td><%=result.getInt("consumeitemcode")%></td>
							<td><%=getGameState(result.getInt("gamestate"))%></td>
							<td><%=getDate19(result.getString("writedate"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=27&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=userinfo_list>강제삭제</a>							
							</td>
						</tr>
						<tr <%=getColor(row%2)%>>
							<td colspan=4></td>
							<td><%=getGameResult(result.getInt("gameresult"))%></td>							
							<td><%=getRSelect(result.getInt("rselect1"))%></td>
							<td><%=getRSelect(result.getInt("rselect2"))%></td>
							<td><%=getRSelect(result.getInt("rselect3"))%></td>
							<td><%=getRSelect(result.getInt("rselect4"))%></td>
							
							
							<td><%=result.getString("pcgameid")%></td>
							<td><%=result.getString("pcgamecost")%></td>
							<td><%=getDate19(result.getString("resultdate"))%></td>
							<td><%=result.getInt("gainexp")%></td>
							<td><%=result.getInt("gaingamecost")%></td>
							<td><%=getEarnCompare(result.getInt("betgamecostearn"), result.getInt("betgamecostorg"))%></td>
							<td></td>
							<td></td>
							<td></td>
							
						</tr>
					<%}%>
					</table>
				<%}%>
				

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=ptbet_list.jsp?gameid=<%=gameid%> target=_blank>연습 배팅중(더보기)</a>
					<table border=1>
						<tr>
							<td colspan=2></td>
							<td colspan=2>배팅</td>
							<td></td>
							<td>파워볼</td>
							<td></td>
							<td>합볼</td>
							<td></td>
							<td colspan=2>배팅시 정보</td>
							<td colspan=2></td>
						</tr>
						<tr>
							<td>인덱스</td>
							<td></td>
							<td>회차</td>
							<td>들어올예정시간</td>
							<td>게임모드</td>							
							<td>스트라이크(1)/볼(0)</td>
							<td>직구(1)/변화구(0)</td>
							<td>좌(1)/우(0)</td>
							<td>상(1)/하(0)</td>
							<td>레벨</td>
							<td>경험치</td>
							<td>배팅상태</td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("curturntime")%></td>
							<td><%=getDate19(result.getString("curturndate"))%></td>
							<td><%=getGameMode(result.getInt("gamemode"))%></td>
							<td>
								<%=getSelectMode(1, result.getInt("select1"), -1)%>
							</td>
							<td>
								<%=getSelectMode(2, result.getInt("select2"), -1)%>
							</td>
							<td>
								<%=getSelectMode(3, result.getInt("select3"), -1)%>
							</td>
							<td>
								<%=getSelectMode(4, result.getInt("select4"), -1)%>
							</td>
							<td><%=result.getInt("level")%></td>
							<td><%=result.getInt("exp")%></td>
							<td><%=getDate19(result.getString("writedate"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=30&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=userinfo_list>강제삭제</a>
							</td>
						</tr>
					<%}%>
					</table>
				<%}%>
				
				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=ptresult_list.jsp?gameid=<%=gameid%> target=_blank>연습 배팅결과(더보기)</a>
					<table border=1>
						<tr>
							<td colspan=2></td>
							<td colspan=2>배팅</td>
							<td></td>
							<td>파워볼</td>
							<td></td>
							<td>합볼</td>
							<td></td>
							<td colspan=4>배팅시 정보</td>
							<td colspan=4></td>
						</tr>
						<tr>
							<td>인덱스</td>
							<td></td>
							<td>회차</td>
							<td>들어올예정시간</td>
							<td>게임모드<br>결과</td>
							<td>스트라이크(1)/볼(0)<br>결과</td>
							<td>직구(1)/변화구(0)<br>결과</td>
							<td>좌(1)/우(0)<br>결과</td>
							<td>상(1)/하(0)<br>결과</td>
							<td><br>기록일</td>
							<td>배팅상태</td>
							<td></td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr <%=getColor(++row%2)%>>
							<td><%=result.getString("idx")%>(<%=result.getString("idx2")%>)</td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("curturntime")%></td>
							<td><%=getDate19(result.getString("curturndate"))%></td>
							<td><%=getGameMode(result.getInt("gamemode"))%></td>
							<td>
								<%=getSelectMode(1, result.getInt("select1"), result.getInt("ltselect1"))%>
							</td>
							<td>
								<%=getSelectMode(2, result.getInt("select2"), result.getInt("ltselect2"))%>
							</td>
							<td>
								<%=getSelectMode(3, result.getInt("select3"), result.getInt("ltselect3"))%>
							</td>
							<td>
								<%=getSelectMode(4, result.getInt("select4"), result.getInt("ltselect4"))%>
							</td>
							<td><%=result.getInt("level")%>렙</td>
							<td>exp <%=result.getInt("exp")%></td>
							<td><%=getDate19(result.getString("writedate"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=31&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=userinfo_list>강제삭제</a>							
							</td>
						</tr>
						<tr <%=getColor(row%2)%>>
							<td colspan=4></td>
							<td><%=getGameResult(result.getInt("gameresult"))%></td>							
							<td><%=getRSelect(result.getInt("rselect1"))%></td>
							<td><%=getRSelect(result.getInt("rselect2"))%></td>
							<td><%=getRSelect(result.getInt("rselect3"))%></td>
							<td><%=getRSelect(result.getInt("rselect4"))%></td>
							
							
							<td><%=getDate19(result.getString("resultdate"))%></td>
							<td>획득 exp:<%=result.getInt("gainexp")%></td>
							<td></td>
							<td></td>
							<td></td>
							
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
