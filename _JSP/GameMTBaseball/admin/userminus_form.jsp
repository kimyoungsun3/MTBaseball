<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>

<%
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	int mode 			= util.getParamInt(request, "mode", 0);
%>
<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.comment, '������ �ۼ��ϼ���.')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.comment.focus();">
<table align=center>
	<tbody>

	<%if(mode == 0){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=41>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>�Կ��� ĳ��(+/-)���� �Ͻðڽ��ϱ�? <font color=red>�αױ�Ͽ� �����ϴ�.</font>
							</td>
						</tr>
						<tr>
							<td><input name="p3" type="text" value="" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}else if(mode == 1){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=42>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>�Կ��� ����ġ(+/-)���� �Ͻðڽ��ϱ�? <font color=red>�αױ�Ͽ� �����ϴ�.</font>
							</td>
						</tr>
						<tr>
							<td><input name="p3" type="text" value="" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}else if(mode == 3){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=44>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>�Կ��� ��(+/-)���� �Ͻðڽ��ϱ�? <font color=red>�αױ�Ͽ� �����ϴ�.</font>
							</td>
						</tr>
						<tr>
							<td><input name="p3" type="text" value="" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}else if(mode >= 81 && mode <= 84){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type=hidden name=p1 value=19>
				<input type=hidden name=p2 value=<%=mode%>>
				<input type=hidden name=ps1 value=<%=gameid%>>
				<input type=hidden name=ps2 value=<%=adminid%>>
				<input type=hidden name=branch value=userinfo_list>
				<input type=hidden name=gameid value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td><input name="p3" type="text" value="" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}%>

</tbody></table>



