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

	String tel[] = {
					"0",			"ALL",
					"" + SKT, 		"SKT",
					//"" + KT, 		"KT",
					//"" + LGT,		"LGT",
					"" + GOOGLE,	"GOOGLE",
					"" + IPHONE, 	"IPHONE"
					};
	String strCash[] = {
					"7000",	"5000(����) 5000 x 2",
					"7001",	"10000(����) 12000 x 2",
					"7002",	"30000(����) 39000 x 2",
					"7003",	"55000(����) 77000 x 2",
					"7004",	"99000(����) 148500 x 2",

					"7005",	"5000(�Ϲ�) 5000",
					"7006",	"10000(�Ϲ�) 12000",
					"7007",	"30000(�Ϲ�) 39000",
					"7008",	"55000(�Ϲ�) 77000",
					"7009",	"99000(�Ϲ�) 148500"
					};

	String gameid 			= util.getParamStr(request, "gameid", "");
	int rtn	 				= util.getParamInt(request, "rtn", -1);
	int cnt 				= 0;
%>

<html><head>
<title>ĳ�������Է�</title>
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
		<!-- ��ü�ܼ����� -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="cash_ok.jsp" onsubmit="return checkForm2(this);">
	    			<input type="hidden" name="p1" value="21">
	    			<input type="hidden" name="p2" value="23">
	    			<input type="hidden" name="ps2" value="<%=adminid%>">
	        	<tr>
        			<td colspan=2 align="center">
        				<font color=red>ĳ�� �����Է�(�αױ���� �����ϴ�.)</font><br>
        				SKT 	: TX_00000000xxxxxx<br>
        				Google 	: 12999763169054705758.13071xxxxxxx<br>
        				iPhone  : mhng5dl6s0 or 57000005298xxxx<br>
        				<%if(rtn == 1){out.println("�����Է�");}%>
        				<font color=red>�̺�Ʈ ���̸� �ڵ����� �ش� �׼��� Plus�Ǿ ���޵˴ϴ�. �ش��ϴ� �縸ŭ�� �����ϸ� �˴ϴ�.</font>

        			</td>
        		</tr>
        		<tr>
        			<td>����ID</td>
        			<td><input name="ps1" type="text" value="<%=gameid%>" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>�ݾ�</td>
        			<td>
						<select name="p3">
							<%for(int i = 0; i < strCash.length; i+=2){%>
								<option value="<%=strCash[i]%>"><%=strCash[i+1]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<tr>
        			<td>��������ȣ</td>
        			<td><input name="ps3" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
					<td colspan=2 style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>
	</tr>
</table>
</center>