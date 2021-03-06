<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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

	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;
	String dateid 				= util.getParamStr(request, "dateid", "");

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
			<form name="GIFTFORM" method="post" action="sgresult_log.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							
							<a href=sgresult_log.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<tr>
						<td></td>
						<td> 검색</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 20, 26, 1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''					-- 배팅결과 정보...
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, 26);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
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
							<td></td>
							<td>1번 승수/시도수</td>
							<td>2번횟수</td>
							<td>3번횟수</td>
							<td>4번횟수</td>
							<td>유저획득+PC방수수료/투자비</td>
							<td>회사수익</td>
							<td>횟수</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>							
							<td><a href=sgresult_log.jsp?dateid=<%=result.getString("dateid8")%>><%=result.getString("dateid8")%></a></td>
							<td><%=result.getString("selectsuccess1")%> / <%=result.getString("selecttry1")%></td>							
							<td><%=result.getString("selectsuccess2")%> / <%=result.getString("selecttry2")%></td>							
							<td><%=result.getString("selectsuccess3")%> / <%=result.getString("selecttry3")%></td>							
							<td><%=result.getString("selectsuccess4")%> / <%=result.getString("selecttry4")%></td>							
							<td><%=getEarnCompareReverse(result.getLong("betgamecostearn"), result.getLong("rpcgamecost"), result.getLong("betgamecostorg"))%></td>		
							<td><%=(result.getLong("betgamecostorg") - result.getLong("betgamecostearn") - result.getLong("rpcgamecost"))%></td>
							<td><%=result.getString("cnt")%></td>
							<td>
								<%= ( result.getInt("selectsuccess1") + result.getInt("selectsuccess2") + result.getInt("selectsuccess3") + result.getInt("selectsuccess4") ) %> 
								/ 
								<%= ( result.getInt("selecttry1") + result.getInt("selecttry2") + result.getInt("selecttry3") + result.getInt("selecttry4") ) %> 
							</td>							
						</tr>
					<%}%>
					<tr>
						<td colspan=9 align=center>
								<a href=sgresult_log.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=sgresult_log.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
						</td>
					</tr>
					<tr>
						<td colspan=9 align=center>
							<br><br><br><br>
							보는 방법<br>
							<img src=image/betearn.png>
						</td>
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
