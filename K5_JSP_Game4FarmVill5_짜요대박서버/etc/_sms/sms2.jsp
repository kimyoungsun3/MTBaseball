<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />

<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();	
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null; 
	StringBuffer query 			= new StringBuffer();		 			
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;
	
	



	
	String[] strData = {
					"#", 														"img/top2.png", 		"[SangSang&Mobine] SKT 역전홈런",
					"http://m.mobine.co.kr/sms_snd.asp?g_id=193&tel_type=14",	"img/google2.png",		"[SangSang&Mobine] Google 역전홈런",
					"http://m.mobine.co.kr/sms_snd.asp?g_id=193&tel_type=11", 	"img/sk2.png", 			"[SangSang&Mobine] SKT 역전홈런",
					"http://m.mobine.co.kr/sms_snd.asp?g_id=193&tel_type=13",	"img/lg2.png",			"[SangSang&Mobine] LG 역전홈런",
					"http://m.mobine.co.kr/sms_snd.asp?g_id=193&tel_type=12",	"img/kt2.png", 			"[SangSang&Mobine] KT 역전홈런!"
					
	};
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>홈런리그 :: 대한민국 No.1 스마트폰게임</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<meta name="title" content="홈런리그 :: 대한민국 No.1 스마트폰게임">
	<link rel="stylesheet" type="text/css" href="css/default.css"/>
	<script type="text/javascript">
	<!--
		smart_1 = function(url_link) {
			location.href = url_link;
		}
	-->
	</script>
</head>
<body>
<a name="top"></a>
<div id="head_wrap">
<p>NO.1 스마트폰게임 홈런리그</p>
</div>

<%for(int i = 0; i < strData.length; i+=3){%>
	<div style="margin:2px 0 2px 0;  text-align:center;"><a href="javascript:;"  onClick="smart_1('<%=strData[i]%>');"  onFocus="this.blur()"><img src="<%=strData[i+1]%>"  width="358" height="100" border="0" title="<%=strData[i+2]%>" /></a></div>
<%}%>
<!--
<div style="margin:2px 0 2px 0;  text-align:center;"><a href="javascript:;"  onClick="smart_1('http://goo.gl/x7uP9');"  onFocus="this.blur()"><img src="img/sk.png"  width="358" height="100" border="0" title="[SangSang&Mobine] SKT 홈런리그" /></a></div>
<div style="margin:2px 0 2px 0;  text-align:center;"><a href="javascript:;"  onClick="smart_1('http://goo.gl/x7uP9');"  onFocus="this.blur()"><img src="img/kt_off.png"  width="358" height="100" border="0" title="[SangSang&Mobine] KT 홈런리그!" /></a></div>
<div style="margin:2px 0 2px 0;  text-align:center;"><a href="javascript:;"  onClick="smart_1('http://goo.gl/x7uP9');"  onFocus="this.blur()"><img src="img/lg_off.png"  width="358" height="100" border="0" title="[SangSang&Mobine] LG 홈런리그" /></a></div>
<div style="margin:2px 0 2px 0;  text-align:center;"><a href="javascript:;"  onClick="smart_1('http://goo.gl/x7uP9');"  onFocus="this.blur()"><img src="img/google_off.png"  width="358" height="100" border="0" title="[SangSang&Mobine] Google 홈런리그" /></a></div>
-->

<%
	//2. 데이타 조작
	query.append("{ call dbo.spu_HomerunD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 	
	cstmt = conn.prepareCall(query.toString()); 		
	cstmt.setInt(idxColumn++, 21);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, 15);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);
	cstmt.setInt(idxColumn++, -1);					
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	cstmt.setString(idxColumn++, "");
	
	//2-2. 스토어즈 프로시져 실행하기
	result = cstmt.executeQuery();	
		 
	//2-3-1. 코드결과값 받기(1개)
	result.next();
  
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>

</body>
</html>
