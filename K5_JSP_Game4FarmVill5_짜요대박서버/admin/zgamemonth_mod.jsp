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
	//exec spu_FarmZ 1, 25,  1,  1, -1, -1, -1, -1, -1, -1, '20131108', '', '', '', '', '', '', '', '', ''		-- 리스트(1개리스트).
	query.append("{ call dbo.spu_FarmZ (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
	cstmt = conn.prepareCall(query.toString());
	cstmt.setInt(idxColumn++,  1);
	cstmt.setInt(idxColumn++, 25);
	cstmt.setInt(idxColumn++, idx);
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
	gamedescs = new String[cnt];
	gamecodes = new int[cnt];

	int k = 0;
	if(cstmt.getMoreResults()){
		result = cstmt.getResultSet();
		while(result.next()){
			gamedescs[k] = result.getString("gamename") + "(" + result.getString("company") + ")";
			gamecodes[k] = result.getInt("gamecode");
			k++;
		}
	}

	int ranking = 999;
	int gamecode = 999;
	int cnt2 = 999;
	String comment = "";
	if(cstmt.getMoreResults()){
		result = cstmt.getResultSet();
		if(result.next()){
			ranking 	= result.getInt("ranking");
			gamecode 	= result.getInt("gamecode");
			cnt2 		= result.getInt("cnt");
			comment		= result.getString("comment");
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

			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table border=1>
					<form name="GIFTFORM" method="post" action="zsetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="1">
					<input type="hidden" name="p2" value="22">
					<input type="hidden" name="p3" value="<%=idx%>">
					<input type="hidden" name="p4" value="<%=telecom%>">
					<input type="hidden" name="telecom" value="<%=telecom%>">
					<input type="hidden" name="ps3" value="">
					<input type="hidden" name="branch" value="zgamemonth_list">
					<tr>
						<td>
							<input name="ps1" type="text" value="<%=dateid%>" size="8" maxlength="8" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
						<td>
							<%=telecomName[telecomIdx]%>
							<input name="p5" type="text" value="<%=ranking%>" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">위
						</td>
						<td>
							게임 : <select name="p6" >
								<%for(int ii = 0; ii < cnt; ii++){%>
									<option value="<%=gamecodes[ii]%>" <%=getSelect(gamecode, gamecodes[ii])%>><%=gamedescs[ii]%></option>
								<%}%>
							</select>
						</td>
						<td>
							다운 : <input name="p7" type="text" value="<%=cnt2%>" size="10" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
						<td>
							코멘트 : <input name="ps2" type="text" value="<%=comment%>" size="20" maxlength="40" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
						<td>
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table><br>
			</div>
		</td>
	</tr>

</tbody></table>


<%
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
