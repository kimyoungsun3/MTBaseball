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
	if(f_nul_chk(f.comment, '내용을 작성하세요.')) return false;
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
								<%=gameid%>님에게 캐쉬(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>
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
								<%=gameid%>님에게 코인(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>
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
	<%}else if(mode == 2){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=43>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>님에게 건초(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>
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
								<%=gameid%>님에게 하트(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>
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
	<%}else if(mode == 45){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=45>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>님에게 동물인벤Max Step(0 ~ 10)<font color=red>로그기록에 남습니다.</font>
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
	<%}else if(mode == 46){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=46>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>님에게 소비인벤Max Step(0 ~ 10)<font color=red>로그기록에 남습니다.</font>
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
	<%}else if(mode == 47){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=47>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>님에게 악세인벤Max Step(0 ~ 10)<font color=red>로그기록에 남습니다.</font>
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
	<%}else if(mode == 48){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=48>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%=gameid%>님에게 하트Max(+/-)지급 하시겠습니까?<font color=red>로그기록에 남습니다.</font>
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
	<%}else if(mode >= 51 && mode <= 63){%>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input name=p1 type=hidden value=19>
				<input name=p2 type=hidden value=<%=mode%>>
				<input name=ps1 type=hidden value=<%=gameid%>>
				<input name=ps2 type=hidden value=<%=adminid%>>
				<input name=branch type=hidden value=userinfo_list>
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=3>
								<%
								String list[] 	= {"집", "탱크", "양동이", "착유기", "주입기", "정화", "저온보관"};
								int modes[] 	= {  51,     53,       55,       57,       59,     61,         63};
								for(int i = 0; i < modes.length; i++){
									if(mode == modes[i]){
										out.print(list[i]);
										break;
									}
								}
								%>
								업그레이드 지정하기(Max는 초과안함)<font color=red>로그기록에 남습니다.</font>
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
							<td colspan=3>
								<%
								String list2[] 	= {"양동이 리터", "양동이 신선도", "탱크 리터", "탱크 신선도"};
								int modes2[] 	= {           81,              82,          83,            84};
								for(int i = 0; i < modes2.length; i++){
									if(mode == modes2[i]){
										out.print(list2[i]);
										break;
									}
								}
								%>
								30리터가 1배럴, 총신선도에 수량관계로 신선도가 배정됨
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
	<%}%>

</tbody></table>



