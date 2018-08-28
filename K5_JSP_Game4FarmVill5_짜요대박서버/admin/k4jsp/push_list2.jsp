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
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;

	//아래는 짜요 리스트 정보이다.(짜요 외전 정보가 아님)
	String tel[] = {
					//"0",			"ALL",
					"" + GOOGLE,	"GOOGLE",
					"" + SKT, 		"SKT",
					//"" + IPHONE, 	"IPHONE",
					""+NHN,			"NHN"
					};

	String tel2[] = {
					//"0",			"ALL",
					"" + GOOGLE,	"GOOGLE(Android)"
					//"" + SKT, 		"SKT",
					//"" + IPHONE, 	"IPHONE",
					//""+NHN,			"NHN"
					};

	String gameid 			= util.getParamStr(request, "gameid", "");
	int personal 			= util.getParamInt(request, "personal", -1);
	int cnt 				= 0;
	int cnt2 				= 0;
	String scheduleTime		= "" + format19.format(now);

%>

<html><head>
<title>푸쉬</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script type="text/javascript">
function checkForm2(f) {
	if(f.gameid.value == ''){
    	alert('아이디를 입력해주세요.');
    	return false;
    }else{
    	return true;
    }
}

</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>


<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">
<center>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td colspan=2 align=center>
			<a href=push_list2.jsp><img src=images/refresh2.png alt="화면갱신"></a>
			<br>
			<%
				//2. 데이타 조작
				//exec spu_FVFarmD 30, 31, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- Push카운터.
				query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
				cstmt = conn.prepareCall(query.toString());
				cstmt.setInt(idxColumn++, 30);
				cstmt.setInt(idxColumn++, 31);
				cstmt.setInt(idxColumn++, -1);
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
				cstmt.setString(idxColumn++, "");

				//2-2. 스토어즈 프로시져 실행하기
				result = cstmt.executeQuery();

				//2-3-1. 코드결과값 받기(1개)
				if(result.next()){
					cnt = result.getInt("cnt");
					cnt2 = result.getInt("cnt2");
				}
			%>
			<br>
        	<font size=5 color=blue>전송대기: Android:<%=cnt%>건 / <%=1*cnt/100%>초, iPhone:<%=cnt2%>건 / <%=1*cnt2/100%>초</font><br><br>
        	<!--
        	- 삭제대상, 블럭대상, 푸쉬거부 그리고 PC생성 제외(Distinct)<br>
        	- Android Push는 턴키로 보내서 가속 개념이 들어가 있습니다.<br>
        	- iPhone은 전송할때 건by건으로 전송해서 오래 걸립니다.
        	-->
        	<br>
		</td>
	</tr>

	<tr>
        <td align="center" style="vertical-align:middle;">
			<!--
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list2_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="32">
	        	<input type="hidden" name="pushkind" value="3">
	        	<input type="hidden" name="personal" value="<%=personal%>">
	        	<tr>
        			<td align="center">짜요 한명의 유저에게 URL 푸쉬</td>
        		</tr>
	        	<tr>
        			<td align="center">유저:<input name="gameid" type="text" value="<%=gameid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="market://details?id=com.sangsangdigital.farmvill" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<td>
        			예약시간:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
        		</td>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
			-->
		</td>
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list2_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="32000">
	        	<input type="hidden" name="pushkind" value="1">
	        	<input type="hidden" name="personal" value="<%=personal%>">
	        	<tr>
        			<td align="center">짜요(외전) 한명의 유저</td>
        		</tr>
	        	<tr>
        			<td align="center">유저:<input name="gameid" type="text" value="<%=gameid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="market://details?id=com.marbles.farmvill4gg" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<td>
        			예약시간:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
        		</td>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>
	</tr>
	<%if(personal == -1){%>
	<tr>
		<td colspan=2>
			<br>
		</td>
	</tr>
	<tr>
		<!-- 단체URL -->
        <td align="center" style="vertical-align:middle;">
       	<!--
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list2_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="33">
	        	<input type="hidden" name="pushkind" value="3">
	        	<tr>
        			<td align="center"><font color=blue>짜요 -> 짜요(외전)단체 URL 푸쉬</font></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="market://details?id=com.sangsangdigital.farmvill" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>통신사
						<select name="telkind">
							<%for(int i = 0; i < tel.length; i+=2){%>
								<option value="<%=tel[i]%>"><%=tel[i+1]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<td>
        			예약시간:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
        		</td>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
			-->
		</td>
        <td align="center" style="vertical-align:middle;">
       	<!--
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list2_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="34">
	        	<input type="hidden" name="pushkind" value="3">
	        	<tr>
        			<td align="center"><font color=blue>짜요(외전) -> 짜요(외전)단체 URL 푸쉬 (오동작함)</font></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="market://details?id=com.sangsangdigital.farmvill" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>통신사
						<select name="telkind">
							<%for(int i = 0; i < tel2.length; i+=2){%>
								<option value="<%=tel2[i]%>"><%=tel2[i+1]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<td>
        			예약시간:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
        		</td>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
			-->
		</td>
	</tr>
	<tr>
		<td colspan=2 align=center>
			<%if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();%>
				<table border=1>
					<tr>
						<td></td>
						<td>adminid</td>
						<td>sendkind</td>
						<td>market</td>
						<td bg=#ff00ff>제목</td>
						<td>내용</td>
						<td>URL</td>
						<td>cnt</td>
						<td>writedate</td>
						<td>
							<a href=usersetting_ok.jsp?p1=30&p2=35&ps2=<%=adminid%>&branch=push_list2>대기전체삭제</a>
						</td>
					</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("adminid")%></td>
							<td><%=getPushSendKind(result.getInt("sendkind"))%></td>
							<td><%=getTel2(result.getInt("market"))%></td>
							<td bgcolor=#ffe020><%=result.getString("msgtitle")%></td>
							<td bgcolor=#ffe020><%=result.getString("msgmsg")%></td>
							<td bgcolor=#ffe020><%=result.getString("msgurl")%></td>
							<td><%=result.getString("cnt")%></td>
							<td><%=result.getString("writedate")%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=30&p2=35&p3=<%=result.getString("idx")%>&ps2=<%=adminid%>&branch=push_list2>삭제</a>
							</td>
						</tr>
					<%}%>
				</table>
			<%}%>
		</td>
	</tr>
	<%}%>

</table>
</center>

<%

	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>