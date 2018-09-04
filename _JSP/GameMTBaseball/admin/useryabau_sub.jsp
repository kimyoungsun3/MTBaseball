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

	String dateid2 				= "" + format.format(now);
	String dateid 				= util.getParamStr(request, "dateid", dateid2);
	long cashcost				= 0L;
	long gamecost				= 0L;
	int sellcount				= 0;
	int num						= 0;
	int view	 				= util.getParamInt(request, "view", 1);

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
			<form name="GIFTFORM" method="post" action="useryabau_sub.jsp" onsubmit="return f_Submit(this);">
			<input type="hidden" name="view" value="<%=view%>">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td>아이템구매날자</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					<tr>
						<td colspan=3>
							<a href=useryabau_sub.jsp?view=0&dateid=<%=dateid%>>그냥보기</a>
							<a href=useryabau_sub.jsp?view=1&dateid=<%=dateid%>>이미지보기</a>
						</td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 19, 416,-1, -1, -1, -1, -1, -1, -1, -1, '', '20130909', '', '', '', '', '', '', '', ''				-- 유저 월서브 통계
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 416);
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
							<td>아이템</td>
							<td>캐쉬</td>
							<td>코인</td>
							<td>구매횟수 </td>
							<td colspan=6>단계별회수/주사위/루비/코인</td>
						</tr>
					<%while(result.next()){
						cashcost += result.getInt("cashcost");
						gamecost += result.getInt("gamecost");
						sellcount += result.getInt("cnt");
						%>
						<tr>
							<td><%=++num%></td>
							<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
							<td><%=String.format("%,d", (long)result.getInt("cashcost"))%></td>
							<td><%=String.format("%,d", (long)result.getInt("gamecost"))%></td>
							<td><%=result.getString("cnt")%></td>
							<%for(int kk = 1; kk <= 6; kk++){%>
								<td>
									<%=result.getInt("step" + (kk))%><br>
									<%=result.getInt("pack" + kk+"2")%> /
									<font color=blue><%=result.getInt("pack" + kk+"3")%></font> /
									<%=result.getInt("pack" + kk+"4")%>
									<%if(view == 1){%>
										<br>
										<img src=<%=imgroot%>/<%=result.getInt("pack" + (kk) + "1")%>.png>
									<%}%>
								</td>
							<%}%>
							</td>
						</tr>
					<%}%>
					<tr>
						<td></td>
						<td></td>
						<td><%=String.format("%,d", (long)cashcost)%></td>
						<td><%=String.format("%,d", (long)gamecost)%></td>
						<td><%=sellcount%></td>
						<td colspan=6></td>
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
