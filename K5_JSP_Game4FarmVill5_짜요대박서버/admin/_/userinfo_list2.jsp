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
	if(f_nul_chk(f.gameid, '아이디를')) return false;
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
							유저 아이디를 정확히 입력하세요.<br>
							(상제 유저정보를 컨트롤 가능합니다.)
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>ID검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="userinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td>폰번호검색(>아이디검색)</td>
						<td><input name="phone" type="text" value="<%=phone%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '-1', '-1', '-1', '-1'
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'SangSang', '-1', '-1', '-1', '-1'
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>번호</td>
							<td>gameid</td>
							<td>레벨</td>
							<td>계급</td>
							<td>아바타정보</td>
							<td>골든볼</td>
							<td>실버볼</td>
							<td>캐릭상태</td>
							<td>캐릭터아이템정보</td>
							<td>스테미너</td>
							<td>플래그</td>
							<td>배틀정보</td>
						</tr>

					<%while(result.next()){%>
						<tr>

							<td><%=result.getString("idx")%></td>
							<td width=200>
								ID : <a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>	<br>
								PW : <%=result.getString("password")%>	<br>
								생성일:<br>
								<%=result.getString("regdate").substring(0, 19)%><br>
								최근접속일:(<%=result.getString("concnt")%>회)<br>
								<%=result.getString("condate").substring(0, 19)%><br>
								폰:<%=result.getString("phone")%><br>

								<%if(bAdmin && !bExpire){%>
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=10>-1일</a>)
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=11>+1일</a>)
								<%}%>
								<br>
								스테미너자유권:<br><%=result.getString("actionfreedate").substring(0, 19)%><br>
								<%if(bAdmin && !bExpire){%>
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=12>-1일</a>)
									(<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=13>+1일</a>)
								<%}%>
								<br>
								통신사게시판추천:
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=26><%=getMBoardState(result.getInt("mboardstate"))%> </a>
								<%}else{%>
									<%=getMBoardState(result.getInt("mboardstate"))%>
								<%}%><br>
								승리후Push가능:
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=27><%=result.getInt("resultwinpush")%> </a>
								<%}else{%>
									<%=getMBoardState(result.getInt("resultwinpush"))%>
								<%}%><br>

								<%if(!bExpire2){%>
									<br><a href=userdeletereal_ok.jsp?gameid=<%=result.getString("gameid")%>>개발진짜삭제</a>
								<%}%>
								<br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=0>
										<%if(result.getInt("blockstate") == 0){%>
											블럭아님
										<%}else{%>
											블럭상태
										<%}%>
									</a>
								<br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=1>
										<%if(result.getInt("deletestate") == 0){%>
											삭제아님
										<%}else{%>
											삭제상태
										<%}%>
									</a>
							</td>
							<td>
								레벨:<%=result.getString("lv")%><br>
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=35>UP</a><br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=36>DOWN</a><br>
								<%}%>
								경험치:<%=result.getString("lvexp")%>
							</td>
							<td>
								계급:<%=result.getString("grade")%><br>
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=30>UP</a><br>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=31>DOWN</a><br>
								<%}%>
								코인 : <%=result.getString("coin")%><br>
								스타 : <%=result.getString("gradestar")%><br>
								경험치 : <%=result.getString("gradeexp")%>
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
								삭제: <%=getDeleteState(result.getInt("deletestate"))%><br>
								블럭: <%=getBlockState(result.getInt("blockstate"))%><br>
								캐쉬카피: <%=result.getString("cashcopy")%><br>
								결과카피: <%=result.getString("resultcopy")%>
							</td>

							<td>
								[일일골드지급]<br>
								(<%=result.getString("dayplusdate").substring(5, 19)%>)<br>
								[스테미너]<br>
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
								[SMS추천후가입]:<%=result.getString("smsjoincnt")%>명<br>
								<br>

								[락커룸코인]<br>
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=2>
										<%=result.getString("coin")%>
									</a>
								<%}else{%>
									<%=result.getString("coin")%>
								<%}%>
								[락커룸실버]<br>

								[락커룸실버]<br>
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
								연습:
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=20>
										<br><%=result.getString("trainflag")%>
									</a>
								<%}else{%>
									<%=result.getString("trainflag")%>
								<%}%>
								/ <%=result.getString("trainpoint")%><br>
							</td>
							<td>
								배틀:
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=24>
										<%=result.getString("btflag")%>
									</a>
								<%}else{%>
									<%=result.getString("btflag")%>
								<%}%>
								/
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=60>
										<%=result.getString("winstreak")%>
									</a>
								<%}else{%>
									<%=result.getString("winstreak")%>
								<%}%>
								연승<br>

								미션:
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=25>
										<%=result.getString("btflag2")%>
									</a>
								<%}else{%>
									<%=result.getString("btflag2")%>
								<%}%>
								/
								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&kind=61>
										<%=result.getString("winstreak2")%>
									</a>
								<%}else{%>
									<%=result.getString("winstreak2")%>
								<%}%>
								연승<br>
								10연승(미션):<%=result.getString("sprintwin")%><br>


								승:<%=result.getString("btwin")%>/<%=result.getString("bttotal")%><br>

								세팅/수량:<br>

							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan=12>
								푸쉬:<%=result.getString("pushid")%>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan=12>
								<table>
									<tr>
										<td>강화</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												최고:	<%=result.getString("itemupgradebest")%>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=101>U</a>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=101>D</a>
												횟수: 	<%=result.getString("itemupgradecnt")%>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=100>U</a>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=100>D</a>
											<%}else{%>
												최고:<%=result.getString("itemupgradebest")%>
												횟수:<%=result.getString("itemupgradecnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>교배</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												최고 : <%=result.getString("petmatingbest")%>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=111>U</a>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=111>D</a>
												횟수 : <%=result.getString("petmatingcnt")%>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=110>U</a>
														<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=110>D</a>
											<%}else{%>
												최고 : <%=result.getString("petmatingbest")%>
												횟수 : <%=result.getString("petmatingcnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>머신</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												점수누적	:
													<%=result.getString("machpointaccrue")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=45000&kind=120>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-45000&kind=120>D</a>
												점수최고	:
													<%=result.getString("machpointbest")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=4400&kind=121>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-4400&kind=121>D</a>
												플레이수횟수:
													<%=result.getString("machplaycnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=122>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=122>D</a>
											<%}else{%>
												점수누적	: <%=result.getString("machpointaccrue")%>
												점수최고	: <%=result.getString("machpointbest")%>
												플레이수횟수: <%=result.getString("machplaycnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>암기</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												점수누적	:
													<%=result.getString("mempointaccrue")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=45000&kind=130>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-45000&kind=130>D</a>
												점수최고	:
													<%=result.getString("mempointbest")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=1900&kind=131>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-1900&kind=131>D</a>
												플레이수횟수:
													<%=result.getString("memplaycnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=132>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=132>D</a>
											<%}else{%>
												점수누적	: <%=result.getString("mempointaccrue")%>
												최대콤보	: <%=result.getString("mempointbest")%>
												플레이수횟수: <%=result.getString("memplaycnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>친구</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												추가		:
													<%=result.getString("friendaddcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=140>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=140>D</a>
												방문횟수	:
													<%=result.getString("friendvisitcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=141>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=141>D</a>
											<%}else{%>
												추가		: <%=result.getString("friendaddcnt")%>
												방문횟수	: <%=result.getString("friendvisitcnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>폴대</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												히트횟수	:
													<%=result.getString("pollhitcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=9&kind=150>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-9&kind=150>D</a>
											<%}else{%>
												히트횟수	: <%=result.getString("pollhitcnt")%>
											<%}%>

										</td>
									</tr>
									<tr>
										<td>천장</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												히트횟수	:
													<%=result.getString("ceilhitcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=49&kind=151>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-49&kind=151>D</a>
											<%}else{%>
												히트횟수	: <%=result.getString("ceilhitcnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>보드</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												히트횟수	:
													<%=result.getString("boardhitcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=100&kind=152>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-100&kind=152>D</a>
											<%}else{%>
												히트횟수	: <%=result.getString("boardhitcnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>배틀</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												비거리누적	:
													<%=result.getString("btdistaccrue")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=100000&kind=160>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10000&kind=160>D</a>
												최고비거리	:
													<%=result.getString("btdistbest")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=161>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=161>D</a>
												홈런횟수누적	:
													<%=result.getString("bthrcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=50&kind=162>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-50&kind=162>D</a>
												홈런콤보	:
													<%=result.getString("bthrcombo")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=1&kind=163>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-1&kind=163>D</a>
												승횟수누적	:
													<%=result.getString("btwincnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=164>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=164>D</a>
												연승		:
													<%=result.getString("btwinstreak")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=1&kind=165>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-1&kind=165>D</a>
												플레이횟수	:
													<%=result.getString("btplaycnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=100&kind=166>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-100&kind=166>D</a>
											<%}else{%>
												비거리누적	: <%=result.getString("btdistaccrue")%>
												최고비거리	: <%=result.getString("btdistbest")%>
												홈런횟수누적: <%=result.getString("bthrcnt")%>
												홈런콤보	: <%=result.getString("bthrcombo")%>
												승횟수		: <%=result.getString("btwincnt")%>
												연승		: <%=result.getString("btwinstreak")%>
												플레이횟수	: <%=result.getString("btplaycnt")%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td>미션</td>
										<td>
											<%if(bAdmin && !bExpire){%>
												비거리누적	:
													<%=result.getString("spdistaccrue")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10000&kind=170>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10000&kind=170>D</a>
												최고비거리	:
													<%=result.getString("spdistbest")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=171>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=171>D</a>
												홈런횟수누적 :
													<%=result.getString("sphrcnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=172>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=172>D</a>
												홈런콤보	:
													<%=result.getString("sphrcombo")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=1&kind=173>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-1&kind=173>D</a>
												승횟수누적	:
													<%=result.getString("spwincnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=10&kind=174>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-10&kind=174>D</a>
												연승		:
													<%=result.getString("spwinstreak")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=1&kind=175>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-1&kind=175>D</a>
												플레이횟수	:
													<%=result.getString("spplaycnt")%>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=100&kind=176>U</a>
													<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=-100&kind=176>D</a>
											<%}else{%>
												비거리누적	: <%=result.getString("spdistaccrue")%>
												최고비거리	: <%=result.getString("spdistbest")%>
												홈런횟수누적: <%=result.getString("sphrcnt")%>
												홈런콤보	: <%=result.getString("sphrcombo")%>
												승횟수누적	: <%=result.getString("spwincnt")%>
												연승		: <%=result.getString("spwinstreak")%>
												플레이횟수	: <%=result.getString("spplaycnt")%>
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
					<br><br><a href=questinfo_list.jsp>퀘스트 진행상태</a>(개발끝나면 밑으로 보내자)
					<table border=1>
						<tr>
							<td>퀘스트번호</td>
							<td>퀘종류</td>
							<td>퀘서브종류</td>
							<td>목표치</td>
							<td>보상실버</td>
							<!--<td>보상템</td>-->
							<td>내용</td>
							<td>재발동시간</td>
							<td>최소레벨</td>
							<td>진행상태</td>
							<td>시작일</td>
							<td>완료일</td>
							<td>데이타클리어</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("questcode")%> -> <%=result.getString("questnext")%></td>
								<td><%=getQuestKind(result.getInt("questkind"))%></td>
								<td><%=getQuestSubKind(result.getInt("questsubkind"))%></td>
								<td> >= <%=result.getString("questvalue")%></td>
								<td><%=result.getString("rewardsb")%></td>
								<!--<td><%=result.getString("rewarditem")%></td>-->
								<td><%=result.getString("content")%></td>
								<td><%=result.getString("questtime")%>시간제</td>
								<td><%=result.getString("questlv")%></td>
								<td>
									<%if(bAdmin && !bExpire){%>
										<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=<%=result.getString("questcode")%>&kind=200><%=getQuestState(result.getInt("queststate"))%></a>
									<%}else{%>
										<%=getQuestState(result.getInt("queststate"))%>
									<%}%>
								</td>
								<td>

									<%if(bAdmin && !bExpire){%>
										<a href=usersetting_ok.jsp?gameid=<%=result.getString("gameid")%>&itemcode=<%=result.getString("questcode")%>&kind=201><%=result.getString("queststart")%></a>
									<%}else{%>
										<%=result.getString("queststart")%>
									<%}%>
								</td>
								<td><%=getQuestDate(result.getString("questend"))%></td>
								<td><%=getQuestClear(result.getInt("questclear"))%></td>
								<%
									if(result.getInt("queststate") == 0){
										questend++;
									}else if(result.getInt("queststate") == 1){
										questwait++;
									}else if(result.getInt("queststate") == 2){
										questing++;
									}
									total += 1;
								%>
							</tr>
						<%}%>
						<tr>
							<td colspan=12>
								전체(<%=total%>)
								완료(<%=questend%>)
								대기중(<%=questwait%>)
								진행중(<%=questing%>)
							</td>
						</tr>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>커스터마이징
					<table border=1>
						<tr>
							<td>idx</td>
							<!--
							<td>gameid</td>
							<td>itemcode</td>
							-->
							<td>itemname</td>
							<td>머리사이즈</td>
							<td>캐릭터구매일</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<!--
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("itemcode")%></td>
								-->
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>유저보유템
					<table border=1>
						<tr>
							<td>idx</td>
							<!--
							<td>gameid</td>
							<td>itemcode</td>
							-->
							<td>아이템</td>
							<td>구매일</td>
							<td>만기일</td>
							<td>업글단계</td>
							<td>만기상태</td>
							<td>업글투자비</td>
							<td>렙제무시</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<!--
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("itemcode")%></td>
								-->
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("buydate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=itembuylog_list.jsp>구매로그(최대10개)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<!--
							<td>gameid</td>
							<td>itemcode</td>
							-->
							<td>itemname</td>
							<td>cashcost</td>
							<td>gamecost</td>
							<td>기간제?</td>
							<!--<td>설명</td>-->
							<td>구매일</td>
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
					<br><br>유저메세지(유저쪽지)(최대10개)
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>보낸이</td>
							<td>보낸날짜</td>
							<td>내용</td>
							<td>새메세지</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("sendid")%></td>
								<td><%=result.getString("writedate")%></td>
								<td><%=result.getString("comment")%></td>
								<td>
									<a href=usersetting_ok.jsp?kind=600&idx=<%=result.getString("idx")%>&gameid=<%=result.getString("gameid")%>>
										<%=getCheckValue(result.getInt("newmsg"), 1, "<font color=red>새쪽지</font>", "한번읽음")%>
									</a>
								</td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/itemupgrade_list.jsp>유저강화정보(최대10개)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>아이템</td>
							<td>upgradebranch2</td>
							<td>업글상태</td>
							<td>업글단계</td>
							<td>실버투입비</td>
							<td>골드투입비</td>
							<td>강화일</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
								<td><%=result.getString("gamecost")%></td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>배틀 점프(최대10개(가변적으로 삭제된다.))
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>grade</td>
							<td>searchidx</td>
							<td>writedate</td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("gameid")%></td>
								<td><%=result.getString("grade")%></td>
								<td><%=result.getString("searchidx")%></td>
								<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/cashbuy_list.jsp>캐쉬로그(최대10개)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>구매자</td>
							<td>선물받은사람</td>
							<td>통신사인증</td>
							<td>클라인증</td>
							<td>구매골든볼</td>
							<td>구매캐쉬</td>
							<td>구매일</td>
							<!--
							<%if(bAdmin && !bExpire){%>
								<td>개발삭제</td>
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
									<td><a href=usercashlogd_ok.jsp?idx=<%=result.getString("idx")%>&gameid=<%=result.getString("gameid")%>>개발삭제</a></td>
								<%}%>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/cashchange_list.jsp>캐쉬환전(최대10개 1:100)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>골든볼 -> 실버볼환전</td>
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
								<td><%=result.getString("writedate")%></td>
							</tr>
						<%}%>
					</table>
				<%}%>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/wgiftsend_list.jsp>선물리스트(최대10개)</a>
					<table border=1>
						<tr>
							<td>인덱스</td>
							<td>받은유저</td>
							<td>이름(itemcode)</td>
							<td>가져간상태</td>
							<td>가져간날짜</td>
							<td>선물자</td>
							<td>선물일</td>
							<td>기간</td>
							<td>종류</td>
							<td>성별</td>
							<td>가격(GB,SB)</td>
							<td>선물받기</td>
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
					<br><br><a href=/Game4/hladmin/unusual_list.jsp>비정상해동(최대10개)</a>
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
					<br><br><a href=/Game4/hladmin/userblock_list.jsp>유저블럭(최대10개)</a>
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
					<br><br><a href=/Game4/hladmin/userdelete_list.jsp>유저삭제(최대10개)</a>
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
					<br><br>친구(최대10개)
					<table border=1>
						<tr>
							<td>idx</td>
							<td>gameid</td>
							<td>친구아이디</td>
							<td>친밀도(방문횟수)</td>
							<td>친구등록일</td>
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
					<br><br><a href=roulettetotal_list.jsp>룰렛(최대10개)</a>
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
					<br><br><a href=/Game4/hladmin/useretc_sms.jsp>추천로그(최대10개)</a>
					<table border=1>
						<tr>
							<td>idx</td>
							<td>추천자</td>
							<td>sendkey</td>
							<td>추천받은사람</td>
							<td>추천일</td>
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
									<td><a href=usersetting_ok.jsp?kind=302&idx=<%=result.getString("idx")%>&gameid=<%=result.getString("gameid")%>>개발삭제</a></td>
								<%}%>
							</tr>
						<%}%>
					</table>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br><a href=/Game4/hladmin/useretc_toto.jsp>Toto로그(최대10개)</a>
					<table border=1>
						<tr>
							<td>totoid</td>
							<td>토토정보</td>
							<td>지원정보</td>
							<td></td>
						</tr>
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("totoid")%></td>
								<td>
									<%=result.getString("totodate")%><br>
									<%=result.getString("title")%><br>
									<img src=images/<%=getCountry(result.getInt("acountry"))%>>
									(<%=result.getString("apoint")%>)
										vs
									<img src=images/<%=getCountry(result.getInt("bcountry"))%>>
									(<%=result.getString("bpoint")%>)<br>

									승리국:<img src=images/<%=getCountry(result.getInt("victcountry"))%>>
									(<%=result.getString("victpoint")%>)<br>

									지급:모드1(<%=result.getString("chalmode1give")%>), 모드2(<%=result.getString("chalmode2give")%>)<br>
									지급일:<%=getDate(result.getString("givedate"))%>
								</td>
								<td>
									지원모드 : <%=result.getInt("chalmode")==1?"국가만(1)":"국가&점수(2)"%><br>
									배팅 : <%=result.getString("chalbat")%>배 (<%=result.getString("chalsb")%>실버)<br>
									나라 : <img src=images/<%=getCountry(result.getInt("chalcountry"))%>>(<%=result.getString("chalpoint")%>점 승리)<br>
									지원일 : <%=result.getString("writedate")%><br><br>

									모드1지급 : <%=result.getString("chalresult1")%><br>
									모드2지급 : <%=result.getString("chalresult2")%><br>
									지급일 : <%=getDate(result.getString("givedate"))%><br>
									상태 : <%=getTotoChalState(result.getInt("chalstate"))%><br>
								</td>
								<%if(bAdmin && !bExpire){%>
									<td><a href=usersetting_ok.jsp?kind=500&idx=<%=result.getString("idx")%>&gameid=<%=result.getString("gameid")%>>개발삭제</a></td>
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
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
