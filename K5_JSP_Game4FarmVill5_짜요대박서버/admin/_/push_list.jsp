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
<title>푸쉬</title>
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
		<td colspan=2 align=center>	
			<br>
			<%
				//2. 데이타 조작
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
	
				//2-2. 스토어즈 프로시져 실행하기
				result = cstmt.executeQuery();	
						 
				//2-3-1. 코드결과값 받기(1개)
				if(result.next()){
					cnt = result.getInt("cnt");
				}	
				if(cstmt != null)cstmt.close();
				if(conn != null)DbUtil.closeConnection(conn);
			%>
			
        	<font size=10 color=blue>전송건수:<%=cnt%> 예상시간:<%=5*cnt/100%>초</font>
        	<br>
		</td>
	</tr>
	<tr>
		<!-- 개인단순문자 -->
        <td align="center" style="vertical-align:middle;">        	
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="400">
	        	<input type="hidden" name="pushkind" value="1">
	        	<tr>
        			<td align="center">한명의 유저에게 단순 푸쉬</td>
        		</tr>
	        	<tr>
        			<td align="center">유저:<input name="gameid" type="text" value="<%=gameid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
					<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
				</tr>
	        	</form>
        	</table>
		</td>
		
		<!-- 개인URL -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="400">
	        	<input type="hidden" name="pushkind" value="3">
	        	<tr>
        			<td align="center">한명의 유저에게 URL 푸쉬</td>
        		</tr>
	        	<tr>
        			<td align="center">유저:<input name="gameid" type="text" value="<%=gameid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
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
		<!-- 단체단순문자 -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="401">
	        	<input type="hidden" name="pushkind" value="1">
	        	<tr>
        			<td align="center"><font color=red>[단체 유저에게 단순 푸쉬]</font></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>통신사
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
		
		<!-- 단체URL -->
        <td align="center" style="vertical-align:middle;">
        	<table border="0">
        		<form name="GIFTFORM" method="post" action="push_list_ok.jsp" onsubmit="return checkForm2(this);">
	        	<input type="hidden" name="kind" value="401">
	        	<input type="hidden" name="pushkind" value="3">
	        	<tr>
        			<td align="center"><font color=blue>단체의 유저에게 URL 푸쉬</font></td>
        		</tr>
        		<tr>
        			<td>제목:<input name="title" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>내용:<input name="content" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
        		<tr>
        			<td>URL:<input name="branchurl" type="text" value="" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"></td>
        		</tr>
				<tr>
					<td>통신사
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
    					단체 유저에게 뽑기코인지급
    					<a href=statistics_adminid.jsp>(지급상태확인)</a><br>
    					(중복지급안함)<br>
    					예1)기존 3개가지고 있는 유저에게 2개 지급하면 => 3개<br>
    					예2)기존 3개가지고 있는 유저에게 4개 지급하면 => 4개<br>
						지급코인
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
						<a href=wgiftsend_form2.jsp>단체 선물지급(최근 1주일 접속)</a>
					</td>
				</tr>
        	</table>
		</td>
	</tr>
</table>
</center>