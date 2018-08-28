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
	int idxColumn				= 1;
	
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
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="revmode_ok.jsp" onsubmit="return f_Submit(this);">
			<input type="hidden" name="subkind" value="60">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=2>
							[역전부스터]<br>
							<font color=red>아이템코드 : -1 > 비활성하 처리</font><br>
							판당1회, 골드가 충분할때<br>
							배틀 > 연승상관무관 (btrevprice)<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> 가격은 게임 시작시 광고에 명시된다.<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> 상대가 이기고 있고 500m 도달(5초간만 카운터된다.)<br>
							미션 > 연승상관 1 ~ 4도전(msrevprice), 5 ~ 7도전(msrevprice2),<br> 
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8도전(msrevprice3), 9도전(msrevprice4)	<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> 가격은 게임 시작시 광고에 명시한다.<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> 상대가 이기고 있고 100m  도달(5초간만 카운터된다.)<br>
						</td>
					</tr>
					<tr>
						<td>역전배틀도전 코드값(7020) : <input name="btrevitemcode" type="text" value="7020" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="btrevprice" type="text" value="2" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>					
					<tr>
						<td>역전미션도전4 코드값(7021) : <input name="msrevitemcode4" type="text" value="7021" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="msrevprice4" type="text" value="1" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>
					<tr>
						<td>역전미션도전7 코드값(7022) : <input name="msrevitemcode7" type="text" value="7022" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="msrevprice7" type="text" value="3" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>
					<tr>
						<td>역전미션도전8 코드값(7023) : <input name="msrevitemcode8" type="text" value="-1" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="msrevprice8" type="text" value="20" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>
					<tr>
						<td>역전미션도전9 코드값(7024) : <input name="msrevitemcode9" type="text" value="-1" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="msrevprice9" type="text" value="50" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>
					<tr>
						<td colspan=2 style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 20, -1, -1, 62, -1, -1, -1, -1, -1, -1, '', '', '', '', ''					--업그레이드 읽기
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 62);
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
					%>
						<tr>
							<td>idx</td>
							<td>역전배틀도전</td>
							<td>역전미션도전4</td>
							<td>역전미션도전7</td>							
							<td>역전미션도전8</td>
							<td>역전미션도전9</td>
							<td>작성일</td>
							<td>작성일</td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="revmode_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="subkind"			value="61">
							<input type="hidden" name="idx" 			value="<%=result.getString("idx")%>">
							<input type="hidden" name="btrevitemcode" 	value="<%=result.getString("btrevitemcode")%>">
							<input type="hidden" name="btrevprice" 		value="<%=result.getString("btrevprice")%>">
							<input type="hidden" name="msrevitemcode4" 	value="<%=result.getString("msrevitemcode4")%>">
							<input type="hidden" name="msrevprice4" 	value="<%=result.getString("msrevprice4")%>">
							<input type="hidden" name="msrevitemcode7" 	value="<%=result.getString("msrevitemcode7")%>">
							<input type="hidden" name="msrevprice7" 	value="<%=result.getString("msrevprice7")%>">
							<input type="hidden" name="msrevitemcode8" 	value="<%=result.getString("msrevitemcode8")%>">
							<input type="hidden" name="msrevprice8" 	value="<%=result.getString("msrevprice8")%>">
							<input type="hidden" name="msrevitemcode9" 	value="<%=result.getString("msrevitemcode9")%>">
							<input type="hidden" name="msrevprice9" 	value="<%=result.getString("msrevprice9")%>">
							<td><%=result.getString("idx")%></td>
							<td><%=getRevMode(result.getInt("btrevitemcode"))%> / <%=result.getString("btrevprice")%>GB</td>
							<td><%=getRevMode(result.getInt("msrevitemcode4"))%> / <%=result.getString("msrevprice4")%>GB</td>
							<td><%=getRevMode(result.getInt("msrevitemcode7"))%> / <%=result.getString("msrevprice7")%>GB</td>
							<td><%=getRevMode(result.getInt("msrevitemcode8"))%> / <%=result.getString("msrevprice8")%>GB</td>
							<td><%=getRevMode(result.getInt("msrevitemcode9"))%> / <%=result.getString("msrevprice9")%>GB</td>
							<td><%=result.getString("writedate")%></td>
							<td><input name="comment" type="text" value="<%=result.getString("comment")%>" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
	        				</form>
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

