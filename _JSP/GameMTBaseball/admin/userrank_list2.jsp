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
							1. 유저 배틀 랭킹. <a href=userrank_list2.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 21, 32,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저배틀현재랭킹.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, 32);
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
							<td>anirepitemcode</td>
							<td>trophy(tier)</td>
							<td>gameid</td>
							<td>kakaonickname</td>
							<td>실결제</td>
							<td>보유캐쉬</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("rank")%></td>
							<td><%=result.getString("anirepitemcode")%></td>
							<td><%=result.getString("trophy")%>(<%=result.getString("tier")%>)</td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("kakaonickname")%></td>
							<td><%=result.getString("cashpoint")%></td>
							<td><%=result.getString("cashcost")%></td>
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
