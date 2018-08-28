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

	int mode	 				= util.getParamInt(request, "mode", 1);
	String certno 				= util.getParamStr(request, "certno", "");
	String gameid 				= util.getParamStr(request, "gameid", "");
	if(certno.equals("")){
		mode = 1;
	}


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
			<a href=certno_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
			<form name="GIFTFORM" method="post" action="certno_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<input type="hidden" name="mode" value="2">
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<table>
					<tr>
						<td colspan=4>
							<font color=blue><%=gameid%> 지급확인중</font><br>
							쿠폰 번호를 입력하시면 (미사용) / (사용된) 것이지 구분을 해줍니다.<br>
	        				쿠폰은 동일한 곳에 지급된것은 1인 1매을 원칙으로 합니다.<br>
	        				A유저 B사이트 > 1인 2장 가지고있으면 > 1장만 사용하고 1장은 못사용<br>
	        				A유저 A사이트 > 1인 2장 가지고있으면 > 1장만 사용하고 1장은 못사용<br>
	        				A는 각사이트 1개씩만 2개 사용하고 2개는 못사용함
						</td>
					</tr>
					<tr>
						<td>쿠포검색</td>
						<td>검색</td>
						<td><input name="certno" type="text" value="<%=certno%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 19, 1004,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''					-- 쿠폰리스트.
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1004);
					cstmt.setInt(idxColumn++, mode);
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
					cstmt.setString(idxColumn++, certno);

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>번호</td>
							<td>쿠폰번호(<font color=blue>미사용</font>)</td>
							<td>내용</td>
							<td>분류코드</td>
							<td colspan=2></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("certno")%></a></td>
							<td>
								<%=result.getString("itemcode1")%> (<%=result.getString("cnt1")%>개)
								/ <%=result.getString("itemcode2")%> (<%=result.getString("cnt2")%>개)
								/ <%=result.getString("itemcode3")%> (<%=result.getString("cnt3")%>개)
							</td>
							<td colspan=2><%=result.getString("kind")%></a></td>
							<td></td>
						</tr>
					<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<tr><td colspan=6><br><br> </td></tr>
					<tr>
						<td>번호</td>
						<td>쿠폰번호(<font color=red>사용된것</font>)</td>
						<td>내용</td>
						<td>분류코드</td>
						<td>통신사</td>
						<td></td>
					</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("certno")%> / <a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank><%=result.getString("gameid")%></a></td>

							<td>
								<%=result.getString("itemcode1")%> <%=result.getString("cnt1")%>
								/ <%=result.getString("itemcode2")%> <%=result.getString("cnt2")%>
								/ <%=result.getString("itemcode3")%> <%=result.getString("cnt3")%><br>
								<%=result.getString("usedtime")%>
							</td>
							<td><%=result.getString("kind")%></td>
							<td><%=getTel(result.getInt("market"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=1004&p3=4&p4=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=certno_list&gameid=<%=result.getString("gameid")%>>삭제</a>
							</td>
						</tr>
					<%}%>
				<%}%>
				</table>
			</div>
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
