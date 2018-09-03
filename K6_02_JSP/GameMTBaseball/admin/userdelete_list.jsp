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
	int idx 					= util.getParamInt(request, "idx", -1);


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
			<form name="GIFTFORM" method="post" action="userdelete_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							1. 환급 유저<br>
							- 유저가 자신의 계정을 삭제하는 경우<br>
							- 환급을 받고 싶을 때 계정 삭제를 유저에게 요청후 환급 처리하시면 됩니다.<br>
							2. 잘못 삭제된 유저 복구<br>
						</td>
					</tr>
					<tr>
						<td> 삭제요청자</td>
						<td> 검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 19, 1002, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- 삭제리스트
					//exec spu_FarmD 19, 1002, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', '', '', '', '', '', '', '', '', ''		--
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1002);
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
						<tr <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%>>
							<form name="GIFTFORM<%=result.getString("idx")%>" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
							<input name=p1 type=hidden value=19>
							<input name=p2 type=hidden value=13>
							<input name=p3 type=hidden value=<%=result.getString("idx")%>>
							<input name=ps1 type=hidden value=<%=result.getString("gameid")%>>
							<input name=ps2 type=hidden value=<%=adminid%>>
							<input name=ps3 type=hidden value=<%=adminip%>>
							<input name=branch type=hidden value=userdelete_list>
							<input name=idx type=hidden value=<%=result.getString("idx")%>>

							<td><%=result.getString("idx")%></td>
							<td><a href=userdelete_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("writedate")%></td>
							<td><%=result.getString("comment")%></td>


							<td><%=result.getString("adminid")%></td>
							<td><%=result.getString("adminip")%></td>
							<td><%=result.getString("releasedate")%></td>
							<td><%=result.getString("comment2")%></td>
							<td>
								<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
							</td>
							</form>
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
