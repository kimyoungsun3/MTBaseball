<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
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

	String gameid 				= util.getParamStr(request, "gameid", "");

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
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="adminusersalelog_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							유저들이 하는 부정행위 정보가 들어가 있음
							<a href=adminusersalelog_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<tr>
						<td>부정행위정보들</td>
						<td>검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%

					//2. 데이타 조작
					//exec spu_GameMTBaseballD 19, 66,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 			   리스트.
					//exec spu_GameMTBaseballD 19, 66,  2, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 				검색.
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 66);
					cstmt.setInt(idxColumn++,  2);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
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
							<td></td>
							<td>아이디</td>
							<td>거래일</td>
							<td>명성도/레벨</td>
							<td>사용건초</td>
							<td>총수익(0)</td>
							<td>판매금액(1)</td>
							<td>상인요구(상인번호는 +1)</td>
							<td>상장금액(2)</td>
							<td>게임중획득금액(3)</td>
							<td>성과템(초과성과템)</td>
							<td>골드티켓</td>
							<td></td>
							<td>로그(소스보기로)</td>
							<td>루비/코인/하트/건초/우정</td>
							<td>유제품</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><a href=adminusersalelog_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
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
							<td>
								<%=result.getString("writedate")%>
								<a href=usersetting_ok.jsp?p1=19&p2=66&p3=1&p4=<%=result.getString("idx2")%>&ps1=<%=result.getString("gameid")%>&branch=adminusersalelog_list&gameid=<%=result.getString("gameid")%>>개발삭제</a>
							</td>
							<td>
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














				</table>
			</div>
			</form>
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
