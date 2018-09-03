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

	String tel[] = {
					"" + GOOGLE,	"GOOGLE",
					"0",			"ALL",
					"" + SKT, 		"SKT",
					"" + IPHONE, 	"IPHONE"
					};
	String strCash[] = {
					"5000",		"3300(2.99)      310루비",
					"5001",		"5500(4.99)      550루비",
					"5002",		"11000(9.99)    1120루비",
					"5003",		"33000(29.99)   3450루비",
					"5004",		"55000(49.99)   5900루비",
					"5005",		"110000(99.99) 12500루비",
					"5050",		"3300(2.99)      310루비(생애첫결제)",
					"5051",		"5500(4.99)      550루비(생애첫결제)",
					"5052",		"11000(9.99)    1120루비(생애첫결제)",
					"5053",		"33000(29.99)   3450루비(생애첫결제)",
					"5054",		"55000(49.99)   5900루비(생애첫결제)",
					"5055",		"110000(99.99) 12500루비(생애첫결제)"
					};

	String gameid 			= util.getParamStr(request, "gameid", "");
	int rtn	 				= util.getParamInt(request, "rtn", -1);
	int cnt 				= 0;
%>

<html><head>
<title>캐쉬강제입력</title>
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
		<!-- 단체단순문자 -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="cash_ok.jsp" onsubmit="return checkForm2(this);">
	    			<input type="hidden" name="p1" value="21">
	    			<input type="hidden" name="p2" value="23">
	    			<input type="hidden" name="ps2" value="<%=adminid%>">
	        	<tr>
        			<td colspan=2 align="center">
        				<font color=red>캐쉬 강제입력(로그기록이 남습니다.)</font><br>
        				SKT 	: TX_00000000xxxxxx<br>
        				Google 	: GPA.1343-7937-1808-39649<br>
        				iPhone  : 57000005298xxxx<br>
        				<%if(rtn == 1){out.println("정상입력");}%>
        				<font color=red>이벤트 중이면 자동으로 해당 액수가 Plus되어서 지급됩니다. 해당하는 양만큼만 지급하면 됩니다.</font>

        			</td>
        		</tr>
        		<tr>
        			<td>서버ID</td>
        			<td><input name="ps1" type="text" value="<%=gameid%>" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>금액</td>
        			<td>
						<select name="p3">
							<%for(int i = 0; i < strCash.length; i+=2){%>
								<option value="<%=strCash[i]%>"><%=strCash[i+1]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<tr>
        			<td>영수증번호</td>
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