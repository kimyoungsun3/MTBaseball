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
			<form name="GIFTFORM" method="post" action="usercomreward.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							유저들이 퀘스트 상태<a href=usercomreward.jsp><img src=images/refresh2.png alt="화면갱신"></a><br>
						</td>
					</tr>
					<tr>
						<td>검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 19, 1008, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 경쟁모드(퀘스트정보).
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1008);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td>경쟁모드(상태)</td>
							<td>이름</td>
							<td>보상종류</td>
							<td>수량/아이템</td>
							<td>체크1</td>
							<td>체크2</td>
							<td>다음번호</td>
							<td>초기화1</td>
							<td>초기화2</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%>(<%=result.getString("idx2")%>)</td>
							<td><a href=usercomreward.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("gameyear")%>년 <%=result.getString("gamemonth")%>월(LV : <%=result.getString("famelv")%>)</td>
							<td><%=result.getString("itemcode")%>(<%=getComRewardCheckPass(result.getInt("ispass"))%>)</td>
							<td><%=result.getString("itemname")%></td>
							<td><%=getComRewardKind(result.getInt("param1"))%></td>
							<td><%=result.getString("param2")%></td>
							<td><%=getComRewardCheckPart(result.getInt("param3"), result.getInt("param4"))%></td>
							<td><%=getComRewardCheckPart(result.getInt("param5"), result.getInt("param6"))%></td>
							<td><%=result.getString("param8")%></td>
							<td><%=getComRewardInitPart(result.getInt("param9"))%></td>
							<td><%=getComRewardInitPart(result.getInt("param10"))%></td>
								<td><%=result.getString("getdate")%></td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=13 align=center>
								<a href=usercomreward.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=usercomreward.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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
