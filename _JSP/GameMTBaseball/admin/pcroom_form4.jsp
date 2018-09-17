<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>

<%
	int mode 			= util.getParamInt(request, "mode", 0);
	String title 		= util.getParamStr(request, "title", "");
	int p1				= util.getParamInt(request, "p1", 0);
	int p2				= util.getParamInt(request, "p2", 0);
	int p3				= util.getParamInt(request, "p3", 0);
	int p4				= util.getParamInt(request, "p4", 0);
	int p5				= util.getParamInt(request, "p5", 0);
	String ps1 			= util.getParamStr(request, "ps1", "");
	String ps2			= util.getParamStr(request, "ps2", "");
	String ps3			= util.getParamStr(request, "ps3", "");
	String gameid 		= util.getParamStr(request, "gameid", "");
%>
<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.comment, '내용을 작성하세요.')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.comment.focus();">
<table align=center>
	<tbody>
	<%if(mode == 1){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type=hidden name=p1 value=<%=p1%>>
				<input type=hidden name=p2 value=<%=p2%>>
				<input type=hidden name=p3 value=<%=p3%>>
				<input type=hidden name=p4 value=<%=p4%>>
				<input type=hidden name=ps2 value=<%=ps2%>>
				<input type=hidden name=branch value=pcroom_list>
				<input type=hidden name=gameid value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=2>
								PC방 정보 등록
							</td>
						</tr>
						<tr>
							<td colspan=2>PC방 상장 gameID : <input name="ps1" type="text" value="<%=ps1%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:200px;"></td>
						</tr>
						<tr>
							<td>등록IP : <input name="ps3" type="text" value="" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:200px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}else if(mode == 2){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type=hidden name=p1 value=<%=p1%>>
				<input type=hidden name=p2 value=<%=p2%>>
				<input type=hidden name=p3 value=<%=p3%>>
				<input type=hidden name=p4 value=<%=p4%>>
				<input type=hidden name=p5 value=<%=p5%>>
				<input type=hidden name=ps2 value=<%=ps2%>>
				<input type=hidden name=branch value=pcroom_list>
				<input type=hidden name=gameid value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=2>
								PC방 정보 수정
							</td>
						</tr>
						<tr>
							<td colspan=2>PC방 상장 gameID : <input name="ps1" type="text" value="<%=ps1%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:200px;"></td>
						</tr>
						<tr>
							<td>등록IP : <input name="ps3" type="text" value="<%=ps3%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:200px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}%>
</tbody></table>



