<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>

<%
	//1. ������ ��ġ
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;

	//�Ʒ��� ¥�� ����Ʈ �����̴�.(¥�� ���� ������ �ƴ�)
	String tel[] = {
					//"0",			"ALL",
					"" + GOOGLE,	"GOOGLE(Android)",
					"" + IPHONE, 	"IPHONE"
					};

	String tel2[] = {
					//"0",			"ALL",
					"" + GOOGLE,	"GOOGLE(Android)",
					"" + IPHONE, 	"IPHONE"
					};
	String urls[] = {
					"market://details?id=com.marbles.farmvill5gg",				"GOOGLE",
					"http://itunes.apple.com/app/id942946851(���̵��ʿ���)",	"iPhone"
					};

	String sends[] = {
					"1",	"¥��(K1) Push����",
					"2",	"¥�� ����(Google)"
					};


	String gameid 			= util.getParamStr(request, "gameid", "");
	int personal 			= util.getParamInt(request, "personal", -1);
	int cnt 				= 0;
	int cnt2 				= 0;
	int cnt3 				= 0;
	int cnt4 				= 0;
	String scheduleTime		= "" + format19.format(now);

%>

<html><head>
<title>Ǫ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script type="text/javascript">
function checkForm2(f) {
	if(f.gameid.value == ''){
    	alert('���̵� �Է����ּ���.');
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
			<a href=push_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
			<br>
			<%
				//2. ����Ÿ ����
				//exec spu_FarmD 30, 31, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- Pushī����.
				query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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

				//2-2. ������� ���ν��� �����ϱ�
				result = cstmt.executeQuery();

				//2-3-1. �ڵ����� �ޱ�(1��)
				if(result.next()){
					cnt = result.getInt("cnt");
					cnt2 = result.getInt("cnt2");
					cnt3 = result.getInt("cnt3");
					cnt4 = result.getInt("cnt4");
				}
			%>
			<br>
        	<font size=5 color=blue>¥��(K1) ���۴��: Android:<%=cnt3%>�� / <%=1*cnt3/100%>��, iPhone:<%=cnt4%>�� / <%=1*cnt4/100%>��</font><br><br>
        	<font size=5 color=blue>���� ���۴��: Android:<%=cnt%>�� / <%=1*cnt/100%>��, iPhone:<%=cnt2%>�� / <%=1*cnt2/100%>��</font><br><br>
        	<font size=5 color=blue>¥�� Ÿ����(K5) ���� Ǫ���� �������.</font><br><br>
        	<font size=5 color=red>iPhone�� ���ɶ��� ��������.</font>
        	<!--
        	- �������, �����, Ǫ���ź� �׸��� PC���� ����(Distinct)<br>
        	- Android Push�� ��Ű�� ������ ���� ������ �� �ֽ��ϴ�.<br>
        	- iPhone�� �����Ҷ� ��by������ �����ؼ� ���� �ɸ��ϴ�.
        	-->
        	<br>
		</td>
	</tr>

	<tr>
        <td align="center" style="vertical-align:middle;">
			<!--
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="32">
	        	<input type="hidden" name="sendkind" value="3">
	        	<input type="hidden" name="personal" value="<%=personal%>">
	        	<tr>
        			<td align="center">¥�� �Ѹ��� �������� URL Ǫ��</td>
        		</tr>
	        	<tr>
        			<td align="center">����:<input name="gameid" type="text" value="<%=gameid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="market://details?id=com.sangsangdigital.farmvill" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<td>
        			����ð�:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
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
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="32000">
	        	<input type="hidden" name="sendkind" value="3">
	        	<input type="hidden" name="personal" value="<%=personal%>">
	        	<tr>
        			<td align="center">¥�� Ÿ����(K5) �Ѹ��� �������� URL Ǫ��</td>
        		</tr>
	        	<tr>
        			<td align="center">����:<input name="gameid" type="text" value="<%=gameid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="market://details?id=com.marbles.farmvill5gg" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<td>
        			����ð�:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
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
		<!-- ��üURL -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="33">
	        	<input type="hidden" name="sendkind" value="3">
	        	<tr>
        			<td align="center">
        				<font color=blue>¥��(K1)(70����) -> ¥��(K1), ����(Push) -> ¥�� Ÿ����(K5) ��ü URL Ǫ�� </font> <br>¥��(K1) �������� ����ͼ� ¥�� Ÿ����(K5) ������ ����� ������ �̿��ϼ���.
        			</td>
        		</tr>
				<tr>
					<td>Ǫ����������
						<select name="p5">
							<%for(int i = 0; i < sends.length; i+=2){%>
								<option value="<%=sends[i]%>">(<%=sends[i+1]%>)<%=sends[i]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<tr>
        			<td>����:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>URL
						<select name="branchurl">
							<%for(int i = 0; i < urls.length; i+=2){%>
								<option value="<%=urls[i]%>">(<%=urls[i+1]%>)<%=urls[i]%></option>
							<%}%>
						</select>
					</td>
				</tr>
				<tr>
					<td>��Ż�
						<select name="telkind">
							<%for(int i = 0; i < tel.length; i+=2){%>
								<option value="<%=tel[i]%>"><%=tel[i+1]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<td>
        			����ð�:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
        		</td>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>


        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="34">
	        	<input type="hidden" name="sendkind" value="1">
	        	<tr>
        			<td align="center"><font color=red>¥�� Ÿ����(K5) �����鿡�� ��ü Ǫ�� > �ٷν���</font></td>
        		</tr>
				<tr>
					<td>Ǫ����������
						<select name="p5">
							<%for(int i = 0; i < sends.length; i+=2){%>
								<option value="<%=sends[i]%>">(<%=sends[i+1]%>)<%=sends[i]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<tr>
        			<td>����:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>��Ż�
						<select name="telkind">
							<%for(int i = 0; i < tel2.length; i+=2){%>
								<option value="<%=tel2[i]%>"><%=tel2[i+1]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<td>
        			����ð�:<input name="scheduleTime" type="text" value="<%=scheduleTime%>" maxlength="19" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
        		</td>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
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
						<td bg=#ff00ff>����</td>
						<td>����</td>
						<td>URL</td>
						<td>cnt</td>
						<td>writedate</td>
						<td>
							<a href=usersetting_ok.jsp?p1=30&p2=35&p3=0&ps2=<%=adminid%>&branch=push_list>�����ü����</a><br>
							<a href=usersetting_ok.jsp?p1=30&p2=35&p3=1&ps2=<%=adminid%>&branch=push_list>¥��͸�����</a><br>
							<a href=usersetting_ok.jsp?p1=30&p2=35&p3=2&ps2=<%=adminid%>&branch=push_list>�����ͻ���</a>
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
								<a href=usersetting_ok.jsp?p1=30&p2=35&p3=<%=result.getString("idx")%>&ps2=<%=adminid%>&branch=push_list>����</a>
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