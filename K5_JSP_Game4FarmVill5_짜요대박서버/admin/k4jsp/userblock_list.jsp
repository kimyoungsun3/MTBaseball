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
<table align=center>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="userblock_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							블럭처리자 리스트(자동으로 블럭이 처리된 유저들)<br>
							아이디로 검색을 하시면 부정행위 상세 내력이 나옵니다.<br>
							관리자는 부정행위를 풀수 있습니다.
						</td>
					</tr>
					<tr>
						<td> 블럭처리자</td>
						<td> 검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 19, 1001, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- 블럭리스트
					//exec spu_FVFarmD 19, 1001, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', '', '', '', '', '', '', '', '', ''		--
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1001);
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
							<td>블럭유저</td>
							<td>블럭날짜</td>
							<td>블럭내용</td>

							<td>관리자</td>
							<td>IP</td>
							<td>관리해제일</td>
							<td>해제하기</td>
						</tr>

					<%while(result.next()){%>
						<tr <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%>>
							<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
							<input name=p1 type=hidden value=19>
							<input name=p2 type=hidden value=3>
							<input name=p3 type=hidden value=<%=result.getString("idx")%>>
							<input name=ps1 type=hidden value=<%=result.getString("gameid")%>>
							<input name=ps2 type=hidden value=<%=adminid%>>
							<input name=ps3 type=hidden value=<%=adminip%>>
							<input name=branch type=hidden value=userblock_list>
							<input name=idx type=hidden value=<%=result.getString("idx")%>>
							<td>
								<%=result.getString("idx")%>
								<a name="<%=result.getString("idx")%>"></a>
							</td>
							<td><a href=userblock_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("writedate")%></td>
							<td><%=result.getString("comment")%></td>

							<td><%=result.getString("adminid")%></td>
							<td><%=result.getString("adminip")%></td>
							<td><%=result.getString("releasedate")%></td>
							<td>
								<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
								<a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank><%=result.getString("gameid")%></a>
								<a href=cashbuy_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>캐쉬검사</a><br>
							</td>

							</form>
						</tr>
					<%}%>
				</table>

				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<br><br>블럭사유 상세내용
					<table border=1>
						<tr>
							<td>번호</td>
							<td>비정상유저</td>
							<td>비정상내용</td>
							<td>비정상날짜</td>
							<!--
							<td>관리자확인상태</td>
							<td>관리자확인날짜</td>
							<td>관리자확인내용</td>
							-->
						</tr>
						<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("comment")%></td>
							<td><%=result.getString("writedate")%></td>
							<!--
							<td><%=result.getString("chkstate")%></td>
							<td><%=result.getString("chkdate")%></td>
							<td><%=result.getString("chkcomment")%></td>
							-->


						</tr>
						<%}%>
					</table>
				<%}%>
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
