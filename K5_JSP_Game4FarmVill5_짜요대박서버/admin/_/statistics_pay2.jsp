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
	
	String phone 				= util.getParamStr(request, "phone", "");

%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.phone, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.phone.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="statistics_pay2.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4> 
						유저 이벤트 가입자 체킹(와일드검색은 100건까지)
						</td>
					</tr>
					<tr>
						<td> 폰번호[<%=phone%>]</td>
						<td> 검색</td>
						<td><input name="phone" type="text" value="<%=phone%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 21, -1, -1, 70, -1, -1, -1, -1, -1, -1, '', '', '', '', ''			-- 가입자 유니크 체크
					//exec spu_FarmD 21, -1, -1, 70, -1, -1, -1, -1, -1, -1, '', '01022223333', '', '', ''	
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 70);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, phone);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					
					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();	
					%>
						<tr>
							<td>idx</td>
							<td>폰번호</td>
							<td>마켓</td>
							<td>최초가입일</td>
							<td></td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><a href=statistics_pay2.jsp?phone=<%=result.getString("phone")%>><%=result.getString("phone")%></a></td>
							<td><%=getTel(result.getInt("market"))%></td>
							<td><%=result.getString("writedate")%></td>
							<td>
								<%if(bAdmin && !bExpire){%>
									<a href=userinfodel_ok.jsp?pagebranch=statistics_pay2&kind=71&idx=<%=result.getString("idx")%>>개발삭제</a>
								<%}%>
							</td>
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
