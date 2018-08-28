<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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
	int idxColumn				= 1;
	
	String dateid 				= util.getParamStr(request, "dateid", "");
	String dateid2 				= "" + format.format(now);

%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.dateid, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.dateid.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="statistics_join.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4> 
						일별 유저 가입현황
						</td>
					</tr>
					<tr>
						<td> 일별날자[<%=dateid2%>]</td>
						<td> 검색</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 21, -1, -1, 7, -1, -1, -1, -1, -1, -1, '', '', '', '', ''		--스프린트통계(7)
					//exec spu_FarmD 21, -1, -1, 7, -1, -1, -1, -1, -1, -1, '', '20120928', '', '', ''
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 10);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					
					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();	
					%>
						<tr>
							<td>idx</td>
							<td>요일</td>
							<td>마켓</td>
							<td>직접가입</td>
							<td>Guest가입</td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>			
							<td><a href=statistics_join.jsp?dateid=<%=result.getString("dateid")%>><%=result.getString("dateid")%></a></td>
							<td><%=getTel(result.getInt("market"))%></td>	
							<td><%=result.getString("cnt")%></td>			
							<td><%=result.getString("cnt2")%></td>
						</tr>
					<%}%>
				</table>
				
		</td>
	</tr>
	
</tbody></table>
</center>
	
<%
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
