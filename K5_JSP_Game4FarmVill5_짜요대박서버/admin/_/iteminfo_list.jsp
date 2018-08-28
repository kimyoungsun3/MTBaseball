<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
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

	int itemcode = util.getParamInt(request, "itemcode", -1);
	int itemkind = util.getParamInt(request, "itemkind", -1);

%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.itemcode, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.itemcode.focus();">
<table>
	<tbody>
	<tr>
		<td align="center">

			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>

					<tr>
						<form name="GIFTFORM" method="post" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
							<td>itemcode검색</td>
							<td><input name="itemcode" type="text" value="<%=itemcode==-1?"":(itemcode+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</form>
						<form name="GIFTFORM" method="post2" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
							<td>종류검색</td>
							<td><input name="itemkind" type="text" value="<%=itemkind==-1?"":(itemkind+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</form>
					</tr>
				</table>

				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', ''
					//exec spu_FarmD 5, 0, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', ''
					//exec spu_FarmD 5, -1, 0, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', ''
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 5);
					cstmt.setInt(idxColumn++, itemcode);
					cstmt.setInt(idxColumn++, itemkind);
					cstmt.setInt(idxColumn++, 1);
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>labelname</td>
							<td>itemcode</td>
							<td>itemname</td>
							<td>sex</td>
							<td>kind</td>
							<td>setcode</td>
							<td>active</td>
							<td>itemfilename</td>
							<td>pluspower</td>
							<td>sale</td>
							<td>backicon</td>
							<td>iconindex</td>
							<td>lv</td>
							<td>param1</td>
							<td>param2</td>
							<td>param3</td>
							<td>param4</td>
							<td>param5</td>
							<td>param6</td>
							<td>param7</td>
							<td>param8</td>
							<td>param9</td>
							<td>gamecost</td>
							<td>cashcost</td>
							<td>explain</td>
						</tr>

					<%while(result.next()){%>
						<tr>

							<td><%=result.getString("labelname")%></td>
							<td><a href=iteminfo_list.jsp?itemcode=<%=result.getString("itemcode")%>><%=result.getString("itemcode")%></a></td>
							<td><%=result.getString("itemname")%></td>
							<td><%=result.getString("sex")%></td>
							<td><a href=iteminfo_list.jsp?itemkind=<%=result.getString("kind")%>><%=result.getString("kind")%></a></td>
							<td><%=result.getString("setcode")%></td>
							<td><%=result.getString("active")%></td>
							<td><%=result.getString("itemfilename")%></td>
							<td><%=result.getString("pluspower")%></td>
							<td><%=result.getString("sale")%></td>
							<td><%=result.getString("backicon")%></td>
							<td><%=result.getString("iconindex")%></td>
							<td><%=result.getString("lv")%></td>
							<td><%=result.getString("param1")%></td>
							<td><%=result.getString("param2")%></td>
							<td><%=result.getString("param3")%></td>
							<td><%=result.getString("param4")%></td>
							<td><%=result.getString("param5")%></td>
							<td><%=result.getString("param6")%></td>
							<td><%=result.getString("param7")%></td>
							<td><%=result.getString("param8")%></td>
							<td><%=result.getString("param9")%></td>
							<td><%=result.getString("gamecost")%></td>
							<td><%=result.getString("cashcost")%></td>
							<td><%=result.getString("explain")%></td>
						</tr>
					<%}%>
				</table>
			</div>
		</td>
	</tr>

</tbody></table>


<%
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
