<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>

<%
	//1. ������ ��ġ
	String gameid				= FormUtil.getParamStr(request, "gameid", "");
	String certno				= FormUtil.getParamStr(request, "certno", "");


%>

<html><head>
<title>��������</title>
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
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tbody><tr>
        <td colspan="2" height="200" align="center" style="vertical-align:middle;">
        	<table>
        		<tbody>
        		<tr>
        			<td align="center">
	        			<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return checkForm2(this);">
	        			<input type="hidden" name="p1" value="19">
	        			<input type="hidden" name="p2" value="1004">
	        			<input type="hidden" name="p3" value="3">
	        			<input type="hidden" name="branch" value="wgiftsend_list">
	        			<input type="hidden" name="gameid" value="<%=gameid%>">
	        			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
	        				<table>
	        				<tbody>
	        				<tr>
	        					<td colspan=3>
	        						<font color=red>������ ������ �����ص帳�ϴ�.(AAAABBBBCCCCDDDD)</font><br>
	        						��, 1���� �������� �ϴ� ���� �˻簡 �ȵ˴ϴ�.<br>
	        						LSYOARPUSSDGG796 > ������ ����Ȯ�մϴٶ�� �ǹ̴� �̹� ������ ��쿡 ���ؼ� ���ɴϴ�.
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>���Ӿ��̵�</td>
	        					<td><input name="ps1" type="text" value="<%=gameid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
	        					<td rowspan="2" style="padding-left:5px;">
	        						<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>������ȣ</td>
	        					<td colspan=2><input name="ps10" type="text" value="<%=certno%>" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:600px;"></td>
	        				</tr>
	        				</tbody></table>
	        			</div>
	        			</form>
        			</td>
        		</tr>
        		<!---->
        	</tbody></table>
        </td>
</tr>
</tbody></table>