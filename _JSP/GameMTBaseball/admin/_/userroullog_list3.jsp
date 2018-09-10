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
	int kind					= 1;

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
			<form name="GIFTFORM" method="post" action="userroullog_list3.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							주사위 검색하기. <a href=userroullog_list3.jsp><img src=images/refresh2.png alt="화면갱신"></a>
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
					//exec spu_GameMTBaseballD 19, 418,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--        개인로그
					//exec spu_GameMTBaseballD 19, 418,-1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 418);
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
							<td>framelv</td>
							<td>루비(캐쉬)</td>
							<td>종류</td>
							<td>단계1</td>
							<td>단계2</td>
							<td>단계3</td>
							<td>단계4</td>
							<td>단계5</td>
							<td>단계6</td>
							<td>주사위결과/획득단계</td>
							<td>루비</td>
							<td>코인</td>
							<td>단계</td>
							<td>리스트 갱신</td>
							<td>시도횟수</td>
							<td>남은금액(코인)</td>
							<td>남은금액(루비)</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td>
								<a href=userroullog_list3.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>
							</td>
							<td><%=result.getString("framelv")%></td>
							<td><%=result.getString("itemcode")%></td>
							<td><%=getYabauCheck(result.getInt("kind"))%></td>
							<%
							kind = result.getInt("kind");
							if(kind == 1){%>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							<%}else if(kind == 4){%>
								<td><%=result.getString("pack11")%></td>
								<td><%=result.getString("pack21")%></td>
								<td><%=result.getString("pack31")%></td>
								<td><%=result.getString("pack41")%></td>
								<td><%=result.getString("pack51")%></td>
								<td><%=result.getString("pack61")%></td>
								<td></td>
								<td></td>
								<td></td>
								<td><%=result.getString("yabaustep")%></td>
							<%}else if(kind == 3 || kind == 2){%>
								<td><%=result.getString("pack11")%></td>
								<td><%=result.getString("pack21")%></td>
								<td><%=result.getString("pack31")%></td>
								<td><%=result.getString("pack41")%></td>
								<td><%=result.getString("pack51")%></td>
								<td><%=result.getString("pack61")%></td>
								<td><%=getYabauResult(result.getInt("result"))%></td>
								<td><%=result.getString("cashcost")%></td>
								<td><%=result.getString("gamecost")%></td>
								<td><%=result.getString("yabaustep")%></td>
							<%}%>
							<td><%=result.getString("yabauchange")%></td>
							<td><%=result.getString("yabaucount")%></td>
							<td><%=result.getString("remaingamecost")%></td>
							<td><%=result.getString("remaincashcost")%></td>
							<td><%=getDate(result.getString("writedate"))%></td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=20 align=center>
								<a href=userroullog_list3.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=userroullog_list3.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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
