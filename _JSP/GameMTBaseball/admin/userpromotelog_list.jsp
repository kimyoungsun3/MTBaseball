<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>

<%
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;

	String gameid 				= util.getParamStr(request, "gameid", "");
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;

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
			<form name="GIFTFORM" method="post" action="userpromotelog_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							승급 검색하기. <a href=userpromotelog_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<tr>
						<td>계정</td>
						<td>검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 19, 420,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 뽑기리스트
					//exec spu_FarmD 19, 420,-1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 420);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
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
							<td>idx</td>
							<td></td>
							<td></td>
							<td>명성도</td>
							<td></td>
							<td></td>
							<td>루비(캐쉬)</td>
							<td>코인</td>
							<td>하트</td>
							<td>승급티켓</td>
							<td>승급(전)</td>
							<td>승급(예정)</td>
							<td>승급(결과)</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td>
								<a href=userpromotelog_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>
							</td>
							<td><%=result.getString("gameyear")%>년 <%=result.getString("gamemonth")%>월</td>
							<td><%=result.getString("famelv")%></td>
							<td><%=getPromoteKind(result.getInt("kind"))%></td>
							<td><%=result.getString("itemcodename")%>(<%=result.getString("itemcode")%>)</td>
							<td><%=result.getString("cashcost")%></td>
							<td><%=result.getString("gamecost")%></td>
							<td><%=result.getString("heart")%></td>
							<td><%=result.getString("ticket")%></td>
							<td><%=result.getString("itemcode0")%>/<%=result.getString("itemcode1")%>/<%=result.getString("itemcode2")%>/<%=result.getString("itemcode3")%>/<%=result.getString("itemcode4")%></td>
							<td><%=result.getString("resultlist")%></td>
							<td>
									<%=result.getString("bgpromotename")%>
									(<%=result.getString("bgpromoteic")%>)
							</td>
							<td><%=getDate(result.getString("writedate"))%></td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=17 align=center>
								<a href=userpromotelog_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=userpromotelog_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
						</td>
					</tr>

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
