<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%

	String servername = "<font color=gray size=5>K5(짜요 타이쿤) Kakao(Test)</font>";
	String strIP = request.getLocalAddr();
	if(!strIP.equals("192.168.0.11")){
		servername = "<font color=red size=5>K5(짜요 타이쿤) Kakao(Real)</font>";
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
	if(f_nul_chk(f.adminId, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.adminId.focus();">
<center><br><br><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<form name="GIFTFORM" method="post" action="_login_ok.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td colspan=2>
							<%=servername%><br><br>
							- 관리 사이트에서 테스트 목적 이외에는 루비 추가를 자제 부탁합니다.<br>
						</td>
					</tr>
					<tr>
						<td>아이디(짜요목장이야기)</td>
						<td><input name="adminId" type="text" value="" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td><input name="adminPW" type="password" value="" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>

			</div>
		</td>
	</tr>
</tbody></table>
</center>

