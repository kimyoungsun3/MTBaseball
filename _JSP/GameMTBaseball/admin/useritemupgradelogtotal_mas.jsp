<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>

<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;


	String dateid 				= util.getParamStr(request, "dateid", "");
	String dateid2 				= "" + format.format(now);
	long cashcost				= 0L;
	long gamecost				= 0L;
	long heart					= 0L;
	int sellcount				= 0;
	int num						= 0;


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
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="useritemupgradelogtotal_sub.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							아이템 업그레이드 내역(날짜를 누르면 세부 내역이 나옵니다.)
							<a href=useritemupgradelogtotal_mas.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<!--
					<tr>
						<td> 아이템구매날자[<%=dateid2%>]</td>
						<td> 검색</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					-->
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 19, 421,-1, -1, -1, -1, -1, -1, -1, -1, '', '20140724', '', '', '', '', '', '', '', ''
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 421);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					//2-2. 스토어즈 프로시져 실행하기
					%>

					<%result = cstmt.executeQuery();%>
						<tr>
							<td>idx</td>
							<td>일</td>
							<td>루비</td>
							<td>코인(만)</td>
							<td>하트</td>
							<td>강화횟수</td>
							<td></td>
						</tr>
					<%while(result.next()){
						cashcost += result.getLong("cashcost");
						gamecost += result.getLong("gamecost");
						heart += result.getLong("heart");
						sellcount += result.getInt("cnt");%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("dateid8")%></td>
							<td><%=String.format("%,d", (long)result.getLong("cashcost"))%></td>
							<td><%=String.format("%,d", (long)result.getLong("gamecost"))%></td>
							<td><%=String.format("%,d", (long)result.getLong("heart"))%></td>
							<td><%=result.getString("cnt")%></td>
							<td><a href=useritemupgradelogtotal_sub.jsp?dateid=<%=result.getString("dateid8")%>>상세내역보기</a></td>
						</tr>
					<%}%>
					<tr>
						<td></td>
						<td></td>
						<td><%=String.format("%,d", (long)cashcost)%></td>
						<td><%=String.format("%,d", (long)gamecost)%></td>
						<td><%=String.format("%,d", (long)heart)%></td>
						<td><%=sellcount%></td>
						<td></td>
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
