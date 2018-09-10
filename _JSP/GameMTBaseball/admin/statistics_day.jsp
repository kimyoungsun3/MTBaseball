<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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
	if(f_nul_chk(f.dateid, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.dateid.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 21, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- 일별통계
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
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
							<td>날짜</td>
							<td>마켓</td>

							<td>계정생성</td>
							<td>유니크가입<br>(폰당)</td>
							<td>로그인<br>(중복)</td>
							<td>로그인<br>(비중복)</td>
							<td bgcolor=yellow>카카오<br>초대/하트전송/도와줘</td>

							<td>하트사용량</td>
							<td>동물뽑기<br>(일/프/프10)</td>
							<td>보물뽑기<br>(일/프/프10)</td>
							<td>강화<br>(동물/보물하트/보물캐쉬)</td>
							<td>합성<br>(코인/캐쉬)</td>
							<td>승급</td>
							<td>부활<br>(템/루비)</td>
							<td>Push<br>(A/I)</td>
							<td>쿠폰등록</td>
							<td>복귀<br>요청/복귀</td>

							<td>거래수/배틀/횟수구매/유저배틀</td>
							<td>
								캐쉬구매<br>
								일반/생애
							</td>
							<td>
								박스오픈<br>
								시간/단축/3배
							</td>
							<td>
								룰렛<br>
								무료/캐쉬/캐무
							</td>
							<td>
								짜요쿠폰조각<br>
								무료/캐쉬
							</td>
							<td>
								짜요쿠폰조각등장<br>
								거래/박스/건초/하트
							</td>
						</tr>

					<%
					String _str = "", _str2 = "";
					while(result.next()){
						if(_str.equals(result.getString("dateid8"))){
							_str2 = "";
						}else{
							_str = result.getString("dateid8");
							_str2 = result.getString("dateid8");
						}
						%>
						<tr>
							<td><%=_str2%></td>
							<td><%=getTel(result.getInt("market"))%></td>

							<td>
								<!--<%=result.getString("joinplayercnt")%>-->
								<%=result.getString("joinguestcnt")%>
							</td>
							<td><%=result.getString("joinukcnt")%></td>
							<td><%=result.getString("logincnt")%></td>
							<td><%=result.getString("logincnt2")%></td>
							<td bgcolor=yellow>
								<%=result.getString("invitekakao")%>
								/ <%=result.getString("kakaoheartcnt")%>
								/ <%=result.getString("kakaohelpcnt")%>
							</td>


							<td><%=result.getString("heartusecnt")%></td>
							<td>
								<%=result.getString("freeroulettcnt")%> / <%=result.getString("payroulettcnt")%> / <%=result.getString("payroulettcnt2")%>
							</td>
							<td>
								<%=result.getString("freetreasurecnt")%> / <%=result.getString("paytreasurecnt")%> / <%=result.getString("paytreasurecnt2")%>
							</td>
							<td>
								<%=result.getString("aniupgradecnt")%> / <%=result.getString("tsupgradenor")%> / <%=result.getString("tsupgradepre")%>
							</td>
							<td>
								<%=result.getString("freeanicomposecnt")%>
								/ <%=result.getString("payanicomposecnt")%>
							</td>
							<td>
								<%=result.getString("anipromotecnt")%>
							</td>
							<td>
								<%=result.getString("revivalcnt")%>
								/ <%=result.getString("revivalcntcash")%>
							</td>

							<td><%=result.getString("pushandroidcnt")%> / <%=result.getString("pushiphonecnt")%> </td>
							<td><%=result.getString("certnocnt")%></td>
							<td><%=result.getString("rtnrequest")%>/<%=result.getString("rtnrejoin")%></td>

							<td>
								<%=result.getString("tradecnt")%> /
								<%=result.getString("battlecnt")%> /
								<%=result.getString("playcntbuy")%> /
								<%=result.getString("userbattlecnt")%>
							</td>
							<td>
								<%=result.getString("cashcnt")%> /
								<%=result.getString("cashcnt2")%>
							</td>
							<td>
								<%=result.getString("boxopenopen")%> /
								<%=result.getString("boxopencash")%> /
								<%=result.getString("boxopentriple")%>
							</td>
							<td>
								<%=result.getString("wheelnor")%> /
								<%=result.getString("wheelpre")%> /
								<%=result.getString("wheelprefree")%>
							</td>
							<td>
								<%=result.getString("zcpcntfree")%> /
								<%=result.getString("zcpcntcash")%>
							</td>
							<td>
								<%=result.getString("zcpappeartradecnt")%> /
								<%=result.getString("zcpappearboxcnt")%> /
								<%=result.getString("zcpappearfeedcnt")%> /
								<%=result.getString("zcpappearheartcnt")%>
							</td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=18 align=center>
								<a href=statistics_day.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=statistics_day.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
						</td>
					</tr>
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
