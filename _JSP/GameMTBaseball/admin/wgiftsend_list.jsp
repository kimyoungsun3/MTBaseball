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
	StringBuffer query2			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	StringBuffer resultMsg		= new StringBuffer();
	int	idxColumn 				= 1;

	String gameid 				= util.getParamStr(request, "gameid", "");
	String giftid 				= util.getParamStr(request, "giftid", "");
	int idx 					= util.getParamInt(request, "idx", -1);

	try{
%>

<html><head>
<title>선물하기</title>
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
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="wgiftsend_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td>검색 유저ID</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td>선물자<input name="giftid" type="text" value="<%=giftid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						<td rowspan="2" style="padding-left:5px;"><a href="wgiftsend_form.jsp?gameid=<%=gameid%>">선물하기</a></td>
					</tr>
					<tr>
						<td colspan=5>
							<a href=wgiftsend_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
							 캐쉬선물, 쿠폰선물, 교배지급, 퀘스트지급, 랭킹보상, 로그인보상, 출석보상, 교배하트보상, 도감보상<br>
							 튜토리얼보상, 농장수확물, 대회보상, 상인보상, 패키지구매, 초대 보상, 친구도움, 친구도움보상<br>
							 액세서리뽑기, 오픈이벤트, 레벨업이벤트, 어린이날보상, 석가탄신보상<br>
						</td>
					</td>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 27, 2,  -1, -1, -1, -1, -1, -1, -1, -1, '', 'xxxx', '', '', '', '', '', '', '', ''						-- 선물 받은 리스트( 전체, 개인)
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 27);
					cstmt.setInt(idxColumn++,  2);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, giftid);
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
							<td>인덱스</td>
							<td>유저</td>
							<td></td>
							<td>종류</td>
							<td>아이템</td>
							<td>선물수량</td>
							<td>등급</td>
							<td>수령일</td>

							<td>단가</td>
							<td>선물자</td>
							<td>선물일</td>
							<td></td>
							<td>삭제</td>
						</tr>

					<%while(result.next()){%>
						<tr <%=getGiftKindColor(result.getInt("giftkind"))%> <%=getCheckValueOri(result.getInt("idxt"), idx, "bgcolor=#ffe020", "")%>>
							<td><%=result.getString("idxt")%></td>
							<td><a href=wgiftsend_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("idx2")%></td>
							<td><%=getGiftKind(result.getInt("giftkind"))%></td>

							<%if(result.getInt("giftkind") == 2 || result.getInt("giftkind") == -2  || result.getInt("giftkind") == -3  || result.getInt("giftkind") == -4  ){%>
								<td>
									<%=result.getString("itemname")%>
									(<%=result.getString("itemcode")%> / <%=getGiftCount(result.getInt("subcategory"), result.getInt("buyamount"), result.getInt("cnt"))%>개)
								</td>
								<td>
									<%=getGiftCount(result.getInt("subcategory"), result.getInt("buyamount"), result.getInt("cnt"))%>
									<%=getCategoryUnit(result.getInt("category"))%>
								</td>
								<td><%=getGrade(result.getInt("grade"))%></td>
								<td><%=getDate(result.getString("gaindate"))%></td>

								<td>
									<%=getPrice(result.getInt("gamecost"), result.getInt("cashcost"))%>
								</td>
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
								<a href=usersetting_ok.jsp?p1=27&p2=21&p4=<%=result.getInt("idxt")%>&branch=wgiftsend_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>삭제마킹</a>
								<a href=usersetting_ok.jsp?p1=27&p2=22&p4=<%=result.getInt("idxt")%>&branch=wgiftsend_list&gameid=<%=result.getString("gameid")%>&idx=<%=result.getInt("idxt")%>>개발원복</a>
							</td>

						</tr>
					<%}%>
				</table>
			</div>
			</form>
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
