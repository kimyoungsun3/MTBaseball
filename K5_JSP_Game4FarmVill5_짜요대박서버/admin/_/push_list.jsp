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
					"" + SKT, 		"SKT",
					"" + KT, 		"KT", 
					"" + LGT,		"LGT",
					"" + NHN,		"NHN",
					"" + GOOGLE,	"GOOGLE",
					"" + IPHONE, 	"IPHONE",
			
					""+SKT2, 		"SKT2",
					""+KT2,			"KT2",
					""+LGT2,		"LGT2",
					""+GOOGLE2, 	"GOOGLE2"
					};
					
	
	
	String gameid 			= util.getParamStr(request, "gameid", "");
	int cnt 				= 0;
	
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
			<br>
			<%
				//2. ����Ÿ ����
				//exec spu_FarmD 19, -1, -1, 402, -1, -1, -1, -1, -1, -1, '', '', '', '', ''			--Push cnt
				query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
				cstmt = conn.prepareCall(query.toString()); 		
				cstmt.setInt(idxColumn++, 19);
				cstmt.setInt(idxColumn++, -1);
				cstmt.setInt(idxColumn++, -1);
				cstmt.setInt(idxColumn++, 402);
				cstmt.setInt(idxColumn++, -1);
				cstmt.setInt(idxColumn++, -1);
				cstmt.setInt(idxColumn++, -1);
				cstmt.setInt(idxColumn++, -1);
				cstmt.setInt(idxColumn++, -1);
				cstmt.setInt(idxColumn++, -1);					
				cstmt.setString(idxColumn++, adminid);
				cstmt.setString(idxColumn++, "");
				cstmt.setString(idxColumn++, "");
				cstmt.setString(idxColumn++, "");
				cstmt.setString(idxColumn++, "");
	
				//2-2. ������� ���ν��� �����ϱ�
				result = cstmt.executeQuery();	
						 
				//2-3-1. �ڵ����� �ޱ�(1��)
				if(result.next()){
					cnt = result.getInt("cnt");
				}	
				if(cstmt != null)cstmt.close();
				if(conn != null)DbUtil.closeConnection(conn);
			%>
			
        	<font size=10 color=blue>���۰Ǽ�:<%=cnt%> ����ð�:<%=5*cnt/100%>��</font>
        	<br>
		</td>
	</tr>
	<tr>
		<!-- ���δܼ����� -->
        <td align="center" style="vertical-align:middle;">        	
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="400">
	        	<input type="hidden" name="pushkind" value="1">
	        	<tr>
        			<td align="center">�Ѹ��� �������� �ܼ� Ǫ��</td>
        		</tr>
	        	<tr>
        			<td align="center">����:<input name="gameid" type="text" value="<%=gameid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>
		
		<!-- ����URL -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="400">
	        	<input type="hidden" name="pushkind" value="3">
	        	<tr>
        			<td align="center">�Ѹ��� �������� URL Ǫ��</td>
        		</tr>
	        	<tr>
        			<td align="center">����:<input name="gameid" type="text" value="<%=gameid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>
	</tr>
	<tr>
		<!-- ��ü�ܼ����� -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="401">
	        	<input type="hidden" name="pushkind" value="1">
	        	<tr>
        			<td align="center"><font color=red>[��ü �������� �ܼ� Ǫ��]</font></td>
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
							<%for(int i = 0; i < tel.length; i+=2){%>	        							
								<option value="<%=tel[i]%>"><%=tel[i+1]%></option>
							<%}%>
						</select>
					</td>
				</tr>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>
		
		<!-- ��üURL -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="401">
	        	<input type="hidden" name="pushkind" value="3">
	        	<tr>
        			<td align="center"><font color=blue>��ü�� �������� URL Ǫ��</font></td>
        		</tr>
        		<tr>
        			<td>����:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>����:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
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
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>
	<tr>
        <td align="center" style="vertical-align:middle;">
        	<table border="1">
        		<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return checkForm2(this);">
        		<input type="hidden" name="kind" value="700">
        		<input type="hidden" name="gameid" value="<%=adminid%>">
        		<input type="hidden" name="branch" value="push_list">
        		
        		<tr>
        			<td align="left">
    					��ü �������� �̱���������
    					<a href=statistics_adminid.jsp>(���޻���Ȯ��)</a><br>
    					(�ߺ����޾���)<br>
    					��1)���� 3�������� �ִ� �������� 2�� �����ϸ� => 3��<br>
    					��2)���� 3�������� �ִ� �������� 4�� �����ϸ� => 4��<br>
						��������
						<select name="idx">
							<%for(int i = 1; i <= 5; i++){%>	        							
								<option value="<%=i%>"><%=i%></option>
							<%}%>
						</select>
						<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
					</td>
				</tr>
	        	</form>
				<tr>
					<td>
						<a href=wgiftsend_form2.jsp>��ü ��������(�ֱ� 1���� ����)</a>
					</td>
				</tr>
        	</table>
		</td>
	</tr>
</table>
</center>