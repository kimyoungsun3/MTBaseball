<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>

<%
	String title 		= util.getParamStr(request, "title", "");
	int p1				= util.getParamInt(request, "p1", 0);
	int p2				= util.getParamInt(request, "p2", 0);
	int p3				= util.getParamInt(request, "p3", -1);
	String ps1			= util.getParamStr(request, "ps1", "");
%>
<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	f.gameid.value = f.ps1.value;
	if(f_nul_chk(f.comment, '내용을 작성하세요.')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.comment.focus();">
<table align=center>
	<tbody>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type=hidden name=p1 value=<%=p1%>>
				<input type=hidden name=p2 value=<%=p2%>>
				<input type=hidden name=p3 value=<%=p3%>>
				<input type=hidden name=branch value=userinfo_list>
				<input type=hidden name=gameid value="">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=2>
								데이타입력 (한줄로 만들어서 복사해야한다.)<br>
								1. 데이타를 메모장이나 에디터에 복사<br>
								2. SaveData에 해당 데이타를 한줄로 입력한다.
							</td>
						</tr>
						<tr>
							<td>입력할 ID</td>
							<td><input name="ps1" type="text" value="<%=ps1%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
						</tr>
						<tr>
							<td>SaveData</td>
							<td><input name="ps10" type="text" value="" maxlength="8000" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
						</tr>
						<tr>
							<td colspan=2 style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
</tbody></table>



