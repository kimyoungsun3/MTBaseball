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

	int schoolidx 				= util.getParamInt(request, "schoolidx", -1);
	String dateid 				= util.getParamStr(request, "dateid", "20131217");

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

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="unusual_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							1. 환생을 해야지만이 랭킹이 기록됩니다.(일, 월, 화, 수, 목, 금, 토) -> 기록<br>
							2. 저번주 토요일일 이전에 환생하면 랭킹이 기록 안됩니다.<br>
							100위 랭킹 <a href=userrank_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 19, 94, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 상위랭킹 100위
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 94);
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
							<td>rank</td>
							<td>bestani</td>
							<td>salemoney</td>
							<td>gameid</td>
							<td>현캐쉬</td>
							<td>nickname</td>
							<td>cashpoint/cashcost/vippoint/초대(초대bg)</td>
							<td>cashcost2/vippoint2</td>
							<td></td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("rank")%></td>
							<td><%=result.getString("bestani")%></td>
							<td><%=displayMoney(result.getString("salemoney"))%></td>
							<td><%=result.getString("gameid")%></td>
							<td><%=displayMoney(result.getString("ownercashcost"))%></td>
							<td><%=result.getString("nickname")%></td>
							<td>
								<%=result.getString("cashpoint")%> /
								<%=result.getString("cashcost")%> /
								<%=result.getString("vippoint")%> /
								<%=result.getString("kakaomsginvitecnt")%>(<%=result.getString("kakaomsginvitecntbg")%>)
							</td>
							<td>
								<%=result.getString("cashcost2")%> /
								<%=result.getString("vippoint2")%>
							</td>
							<td>
								<%
									String _src = result.getString("savedata");
									String _rtn = "";

									_rtn  = getPart4(_src, "%6:", "년도");
									_rtn += getPart4(_src, "%21:", "결정(언락)");
									_rtn += getPart4(_src, "%22:", "알바(언락)");
									_rtn += getPart4(_src, "%2:",  "알바(단계)");
									_rtn += getPart4(_src, "%23:", "동물(언락)");
									_rtn += getPart4(_src, "%25:", "동물(단계)");
									_rtn += getPart4(_src, "%260:","비료(언락)");
									_rtn += getPart4(_src, "%250:","비료(단계)");
									_rtn += getPart4(_src, "%70:", "사냥총(단계)");
									out.print(_rtn);

								%>
							</td>
							<td>
								<a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>보기</a>
								<%=getBlockState(result.getInt("blockstate"))%>
							</td>
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
