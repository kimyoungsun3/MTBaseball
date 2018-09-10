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
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="cashchange_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							환전처리 내역, 아이디를 입력시 해당 유저 환전 내역을 볼수 있음
						</td>
					</tr>
					<tr>
						<td> 환전처리자 게임아이디</td>
						<td> 검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
		</td>
	</tr>
	<tr>
		<td>
			<table border=1>
				<%
				//2. 데이타 조작
				//exec spu_GameMTBaseballD 21, 21,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저환전로그
				//exec spu_GameMTBaseballD 21, 21,-1, -1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''					-- 유저환전로그
				query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
				cstmt = conn.prepareCall(query.toString());
				cstmt.setInt(idxColumn++, 21);
				cstmt.setInt(idxColumn++, 21);
				cstmt.setInt(idxColumn++, -1);
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
						<td>번호</td>
						<td>환전유저</td>
						<td>
							루비(캐쉬)
							->
							코인
						</td>
						<td>비율</td>
						<td>환전날짜</td>
					</tr>

				<%while(result.next()){%>
					<tr>
						<td><%=result.getString("idx")%></td>
						<td><a href=cashchange_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
						<td>
							<%=result.getString("cashcost")%>
							->
							<%=result.getString("gamecost")%>
						</td>
						<td><%=getChangeCashVS(result.getInt("cashcost"), result.getInt("gamecost"))%></td>
						<td><%=getDate(result.getString("writedate"))%></td>
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
