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
	
	String plusgoldballs[] = {
			"0", 		"골드추가(0%)",
			"5", 		"골드추가(5%)",
			"10", 		"골드추가(10%)",
			"15", 		"골드추가(15%)",
			"20", 		"골드추가(20%)"
	};
	
	
	String plussilverballs[] = {
			"0", 		"실버추가(0%)",
			"5", 		"실버추가(5%)",
			"10", 		"실버추가(10%)",
			"15", 		"실버추가(15%)",
			"20", 		"실버추가(20%)",
			"30", 		"실버추가(30%)",
			"40", 		"실버추가(40%)",
			"50", 		"실버추가(50%)",
			"60", 		"실버추가(60%)",
			"70", 		"실버추가(70%)",
			"80", 		"실버추가(80%)",
			"90", 		"실버추가(90%)",
			"100", 		"실버추가(100%)"
	};
	
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
			<form name="GIFTFORM" method="post" action="actionmode_ok.jsp" onsubmit="return f_Submit(this);">
			<input type="hidden" name="subkind" value="70">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td>
							[스테미너관리 / 골드,골드추가]
						</td>
					</tr>
					<tr>
						<td>절반충전 가격 : <input name="halfmodeprice" type="text" value="4" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
					</tr>					
					<tr>
						<td>전체충전 가격 : <input name="fullmodeprice" type="text" value="7" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
					</tr>
					<tr>
						<td>자유이용권 가격: <input name="freemodeprice" type="text" value="25" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
					</tr>
					<tr>
						<td>자유이용권 기간 : <input name="freemodeperiod" type="text" value="1" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
					</tr>
					<tr>
						<td>
							골든코인추가 : 
							<select name="plusgoldball" >
								<%for(int i = 0; i < plusgoldballs.length; i+=2){%>
									<option value="<%=plusgoldballs[i]%>" ><%=plusgoldballs[i+1]%></option>		
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							실버코인추가 : 
							<select name="plussilverball" >
								<%for(int i = 0; i < plussilverballs.length; i+=2){%>
									<option value="<%=plussilverballs[i]%>" ><%=plussilverballs[i+1]%></option>		
								<%}%>
							</select>
						</td>
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
					//exec spu_FarmD 20, -1, -1, 72, -1, -1, -1, -1, -1, -1, '', '', '', '', ''			-- > 검색
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 72);
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
							<td>절반충전 가격</td>
							<td>전체충전 가격</td>
							<td>자유이용권 가격</td>							
							<td>자유이용권 기간</td>
							<td><font color=red>골든볼할인</font></td>
							<td>작성일</td>
							<td>내용</td>
							<td></td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="actionmode_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="subkind"			value="71">
							<input type="hidden" name="idx" 			value="<%=result.getString("idx")%>">
							<input type="hidden" name="halfmodeprice" 	value="<%=result.getString("halfmodeprice")%>">
							<input type="hidden" name="fullmodeprice" 	value="<%=result.getString("fullmodeprice")%>">
							<input type="hidden" name="freemodeprice" 	value="<%=result.getString("freemodeprice")%>">
							<input type="hidden" name="freemodeperiod" 	value="<%=result.getString("freemodeperiod")%>">
							<input type="hidden" name="plusgoldball" 	value="<%=result.getString("plusgoldball")%>">
							<input type="hidden" name="plussilverball" 	value="<%=result.getString("plussilverball")%>">
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("halfmodeprice")%>GB</td>
							<td><%=result.getString("fullmodeprice")%>GB</td>
							<td><%=result.getString("freemodeprice")%>GB</td>
							<td><%=result.getString("freemodeperiod")%>기간</td>
							<td>
								<%for(int i = 0; i < plusgoldballs.length; i+=2){
									if(result.getString("plusgoldball").equals(plusgoldballs[i])){
										out.println(plusgoldballs[i+1]);
										break;
									}
								}%>
							</td>
							<td>
								<%for(int i = 0; i < plussilverballs.length; i+=2){
									if(result.getString("plussilverball").equals(plussilverballs[i])){
										out.println(plussilverballs[i+1]);
										break;
									}
								}%>
							</td>
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

