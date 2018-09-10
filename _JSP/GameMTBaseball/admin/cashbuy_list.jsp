<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
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
	String acode 				= util.getParamStr(request, "acode", "");
	int cashcosttotal 			= 0;
	int cashtotal				= 0;

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
	if(f_nul_chk(f.gameid, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							루비(캐쉬)구매 내역(유저기준 검색) > 검색을 하면 전체 내역이 나옵니다.<br>
							(*오류발생(-444):게스트 유저는 카톡 아이디가 없어서 카톡 서버에 전송만 불가한 것입니다. 과금은 정상 처리된것입니다.)<br>
							(* iPhone 구매는 달러이면 계산 편의상 원으로 환산된것입니다.)
							<a href=cashbuy_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
							<a href=userinfo_list.jsp?gameid=<%=gameid%> target=_blank><%=gameid%></a><br>
						</td>
					</tr>
					<form name="GIFTFORM" method="post" action="cashbuy_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td> 루비(캐쉬)구매자 서버 계정</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:304px;"></td>
						<td style="padding-left:5px;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
					<form name="GIFTFORM" method="post" action="cashbuy_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td> 영수증번호(TX_xxx(SKT), 19xx.xx(Google), xxxx(iPhone))</td>
						<td><input name="acode" type="text" value="<%=acode%>" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:304px;"></td>
						<td style="padding-left:5px;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>

					<tr>
						<td colspan=4>
							<%if(!gameid.equals("")){%>
								<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=<%=gameid%>&ps2=<%=adminid%>&branch=cashbuy_list&gameid=<%=gameid%>>블럭(계정,핸드폰)</a>
							<%}%>
						</td>
					</tr>
				</table>
			</div>

				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 21, 11,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 루비(캐쉬)판매로그
					//exec spu_GameMTBaseballD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
					//exec spu_GameMTBaseballD 21, 11,10, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
					//exec spu_GameMTBaseballD 21, 11,10, -1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''					--
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, 11);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, acode);
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
							<td>환경(ikind)</td>
							<td>구매자(gameid)</td>
							<td>선물받은사람(giftid)</td>
							<td>승인번호1(acode)</td>
							<td>승인번호2(ucode)</td>
							<td>승인번호3(kakaouk)</td>

							<td>루비(cashcost)</td>
							<td>현금(cash)</td>
							<td>구매일</td>
							<td>market</td>
							<td>카톡서버전송</td>
							<!--
							<td>전송원문(소스보기)</td>
							<td>전송해석(소스보기)</td>
							-->
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=getTel(result.getInt("market"))%>(<%=result.getString("ikind")%>)</td>
							<td>
								<a href=cashbuy_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>
								(<%=result.getString("gameyear")%>년<%=result.getString("gamemonth")%>월 <%=result.getString("famelv")%>LV)
							</td>
							<td><%=getIsNull(result.getString("giftid"), "")%></td>
							<td>
								<a href=cashbuy_list.jsp?acode=<%=result.getString("acode")%>><%=result.getString("acode")%>
							</td>
							<td><%=result.getString("ucode")%></td>
							<td><%=result.getString("kakaouk")%></td>


							<td><%=result.getString("cashcost")%></td>
							<td>
								<%=String.format("%,d", result.getInt("cash"))%>
								(<%=result.getString("productid")%>)
							</td>
							<td><%=result.getString("writedate")%></td>
							<td>

								<%if(bAdmin && !bExpire){%>
									<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=cashbuy_list&gameid=<%=result.getString("gameid")%>>블럭(계정,핸드폰)</a>
									/
									<a href=usersetting_ok.jsp?p1=17&p2=1&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=cashbuy_list&gameid=<%=result.getString("gameid")%>>로그삭제</a>
									/
									<a href=usersetting_ok.jsp?p1=17&p2=2&ps1=<%=result.getString("gameid")%>&branch=cashbuy_list&gameid=<%=result.getString("gameid")%>>로그일괄삭제</a>
								<%}%>
							</td>
							<td><%=getKakaoSend(result.getInt("kakaosend"))%></td>
							<!--
							<td><%=result.getString("idata")%></td>
							<td><%=result.getString("idata2")%></td>
							-->
							<%
								maxPage = result.getInt("maxPage");
								cashcosttotal += result.getInt("cashcost");
								cashtotal += result.getInt("cash");
							%>
						</tr>
					<%}%>
					<tr>
						<td colspan=13>총루비:<%=cashcosttotal%>,  총캐쉬:<%=String.format("%,d", cashtotal)%></td>
					</tr>

					<%if(gameid.equals("")){%>
						<tr>
							<td colspan=13 align=center>
									<a href=cashbuy_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
									<%=idxPage%> / <%=maxPage%>
									<a href=cashbuy_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
							</td>
						</tr>
					<%}%>
				</table>

		</td>
	</tr>

</tbody></table>
</center>

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
