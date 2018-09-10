<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>
<%@include file="zconstant.jsp"%>


<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;

	int gamecodes[];
	String gamedescs[];

	int cnt = 0, pack = 0;
	int idx 					= util.getParamInt(request, "idx", -1);
	int telecom					= util.getParamInt(request, "telecom", 1);
	int telecomIdx				= 0;
	String dateid 				= util.getParamStr(request, "dateid", "");
	if(dateid.equals("")){
		dateid = "" + format.format(now);
	}
	for(int j = 0; j < telecomVal.length; j++){
		if(telecom == telecomVal[j]){
			telecomIdx = j;
			break;
		}
	}

	//2. 데이타 조작
	//exec spu_FarmZ 1, 24, -1,  1,  1,  2, 10, -1, -1, -1, '20131108', '비고', '', '', '', '', '', '', '', ''	-- 리스트.
	query.append("{ call dbo.spu_FarmZ (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
	cstmt = conn.prepareCall(query.toString());
	cstmt.setInt(idxColumn++,  1);
	cstmt.setInt(idxColumn++, 24);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, telecom);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setString(idxColumn++, dateid);
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

	if(result.next()){
		cnt = result.getInt("cnt");
	}
	gamedescs = new String[cnt + 1];
	gamecodes = new int[cnt + 1];

	int k = 0;
	if(cstmt.getMoreResults()){
		result = cstmt.getResultSet();
		while(result.next()){
			gamedescs[k] = result.getString("gamename") + "(" + result.getString("company") + ")";
			gamecodes[k] = result.getInt("gamecode");
			k++;
		}
	}
%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>


<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gamecode.focus();">
<table align=center>
	<tbody>
	<tr>
		<td align="center">
			<br><br>
			<a href=zgameinfo_list.jsp>게임입력</a><br><br>


			<table>
				<form name="GIFTFORM" method="post" action="zgamemonth_list.jsp" onsubmit="return f_Submit2(this);">
				<input type="hidden" name="p1" value="1">
				<input type="hidden" name="p2" value="24">
				<input type="hidden" name="branch" value="zgamemonth_list">
				<tr>
					<td>
						<select name="telecom" >
							<%for(int j = 0; j < telecomVal.length; j++){%>
								<option value="<%=telecomVal[j]%>" <%=getSelect(telecomIdx, j)%>><%=telecomName[j]%></option>
							<%}%>
						</select>
					</td>
					<td>
						<input name="dateid" type="text" value="<%=dateid%>" size="8" maxlength="8" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
					</td>
					<td>
						<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
					</td>
				</tr>
				</form>
			</table><br>


			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table border=1>
					<form name="GIFTFORM" method="post" action="zsetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="1">
					<input type="hidden" name="p2" value="21">
					<input type="hidden" name="p3" value="-1">
					<input type="hidden" name="p4" value="<%=telecom%>">
					<input type="hidden" name="telecom" value="<%=telecom%>">
					<input type="hidden" name="ps3" value="">
					<input type="hidden" name="branch" value="zgamemonth_list">
					<tr>
						<td>
							<%=telecomName[telecomIdx]%>
						</td>
						<td>
							<input name="ps1" type="text" value="<%=dateid%>" size="8" maxlength="8" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
						<td>
							<input name="p5" type="text" value="1" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">위
						</td>
						<td>
							게임 : <select name="p6" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=gamecodes[i]%>"><%=gamedescs[i]%></option>
								<%}%>
							</select>
						</td>
						<td>
							다운 : <input name="p7" type="text" value="0" size="10" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
						<td>
							코멘트 : <input name="ps2" type="text" value="" size="20" maxlength="40" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
						<td>
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table><br>


				<table border=1>
					<tr>
						<td>일자</td>
						<td>순위</td>
						<td>이름</td>
						<td>다운수</td>
						<td>비고</td>
						<td></td>
					</tr>

					<%
					if(cstmt.getMoreResults()){
						result = cstmt.getResultSet();
						while(result.next()){%>
							<tr>
								<td>
									<%=result.getString("dateid8")%>
								</td>
								<td>
									<%=result.getString("ranking")%>
								</td>
								<td>
									<%=result.getString("gamename")%>
								</td>
								<td>
									<%=result.getString("cnt")%>
								</td>
								<td>
									<%=result.getString("comment")%>
								</td>

								<td>
									<a href=zgamemonth_mod.jsp?idx=<%=result.getString("idx")%>&dateid8=<%=result.getInt("dateid8")%>&telecom=<%=result.getInt("telecom")%>>루비</a>
									<a href=zsetting_ok.jsp?p1=1&p2=26&p3=<%=result.getInt("idx")%>&p4=<%=telecom%>&telecom=<%=telecom%>&ps1=<%=dateid%>&branch=zgamemonth_list>삭제</a>
								</td>
							</tr>
						<%}
					}%>
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
