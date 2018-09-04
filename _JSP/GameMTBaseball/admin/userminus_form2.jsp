<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>

<%
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	int p1		 			= util.getParamInt(request, "p1", -1);
	int p2		 			= util.getParamInt(request, "p2", -1);
	int p3 					= util.getParamInt(request, "p3", -1);
	int p4 					= util.getParamInt(request, "p4", -1);
	int p5 					= util.getParamInt(request, "p5", -1);
	int p6 					= util.getParamInt(request, "p6", -1);
	int p7 					= util.getParamInt(request, "p7", -1);
	int p8 					= util.getParamInt(request, "p8", -1);
	int p9 					= util.getParamInt(request, "p9", -1);
	int p10					= util.getParamInt(request, "p10", -1);

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

	<%if(p2 == 70){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type=hidden name=p1 value=19>
				<input type=hidden name=p2 value=<%=p2%>>
				<input type=hidden name=ps1 value=<%=gameid%>>
				<input type=hidden name=ps2 value=<%=adminid%>>
				<input type=hidden name=branch value=userinfo_list>
				<input type=hidden name=gameid value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
	        					<select name="p3">
	        						<%
	        						int subkind[] 		= {         1,      2,      3,        4};
	        						String subname[] 	= {"프리미엄", "골드", "실버", "브론즈"};
	        						for(int i = 0; i < subkind.length; i++){%>
	        							<option value="<%=subkind[i]%>" <%=getSelect(p3, subkind[i])%>><%=subname[i]%></option>
	        						<%}%>
								</select><br>
								다른 모드는 해당값으로 변경됨(-1 : 미연결상태)
							</td>
						</tr>
						<tr>
							<td><input name="p4" type="text" value="" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}else if(p2 == 71){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type=hidden name=p1 value=<%=p1%>>
				<input type=hidden name=p2 value=<%=p2%>>
				<input type=hidden name=p3 value=<%=p3%>>
				<input type=hidden name=ps1 value=<%=gameid%>>
				<input type=hidden name=ps2 value=<%=adminid%>>
				<input type=hidden name=branch value=userinfo_list>
				<input type=hidden name=gameid value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								수량변경
							</td>
						</tr>
						<tr>
							<td><input name="p4" type="text" value="<%=p4%>" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
			</td>
		</tr>
	<%}%>

</tbody></table>



