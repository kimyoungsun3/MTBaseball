<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
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

	int mode	 				= util.getParamInt(request, "mode", 1);
	String certno 				= util.getParamStr(request, "certno", "");
	String gameid 				= util.getParamStr(request, "gameid", "");
	if(certno.equals("")){
		mode = 1;
	}


	try{
%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.gameid, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="certno_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<input type="hidden" name="mode" value="2">
				<input type="hidden" name="gameid" value="<%=gameid%>">
				<table>
					<tr>
						<td colspan=4>
							<font color=blue><%=gameid%> 지급확인중</font><br>
							쿠폰 번호를 입력하시면 (미사용) / (사용된) 것이지 구분을 해줍니다.<br>
	        				단, 1개로 여러명이 하는 것음 검사가 안됩니다.(설문지 쿠폰은 검색이 안됩니다.)
						</td>
					</tr>
					<tr>
						<td>쿠포검색</td>
						<td>검색</td>
						<td><input name="certno" type="text" value="<%=certno%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 19, 1004,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''					-- 쿠폰리스트.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1004);
					cstmt.setInt(idxColumn++, mode);
					cstmt.setInt(idxColumn++, -1);
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
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, certno);

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr><td colspan=5>공용쿠폰</td></tr>
						<tr>
							<td>번호</td>
							<td>쿠폰번호(<font color=blue>미사용</font>)</td>
							<td>내용</td>
							<td>분류</td>
							<td>기간</td>
						</tr>

						<!-- 공용 -->
						<%while(result.next()){%>
							<tr>
								<td><%=result.getString("idx")%></td>
								<td><%=result.getString("certno")%></td>
								<td>
									<%=result.getString("itemcode1")%> ( <%=result.getString("cnt1")%> ) /
									<%=result.getString("itemcode2")%> ( <%=result.getString("cnt2")%> ) /
									<%=result.getString("itemcode3")%> ( <%=result.getString("cnt3")%> )
								</td>
								<td>
									<%= getCertMainKind( result.getInt("mainkind") ) %> ( <%=result.getInt("kind")%> )
								</td>
								<td>
									<%= getDate16( result.getString("startdate") ) %>
									~
									<%= getDate16( result.getString("enddate") ) %>
								</td>
							</tr>
						<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<tr><td colspan=5><br><br>1인 1매쿠폰</td></tr>
					<!-- 1인용 -->
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("certno")%></td>
							<td>
								<%=result.getString("itemcode1")%> ( <%=result.getString("cnt1")%> ) /
								<%=result.getString("itemcode2")%> ( <%=result.getString("cnt2")%> ) /
								<%=result.getString("itemcode3")%> ( <%=result.getString("cnt3")%> )
							</td>
							<td>
								<%= getCertMainKind( result.getInt("mainkind") ) %> ( <%=result.getInt("kind")%> )
							</td>
							<td>
								<%= getDate16( result.getString("startdate") ) %>
								~
								<%= getDate16( result.getString("enddate") ) %>
							</td>
						</tr>
					<%}%>
				<%}%>


				<%if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();%>
					<tr><td colspan=5><br><br>사용쿠폰 </td></tr>
					<tr>
						<td>번호</td>
						<td>쿠폰번호(<font color=red>사용된것</font>)</td>
						<td>내용</td>
						<td>분류</td>
						<td>사용날짜</td>
					</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("certno")%> / <a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank><%=result.getString("gameid")%></a></td>
							<td>
								<%=result.getString("itemcode1")%> ( <%=result.getString("cnt1")%> ) /
								<%=result.getString("itemcode2")%> ( <%=result.getString("cnt2")%> ) /
								<%=result.getString("itemcode3")%> ( <%=result.getString("cnt3")%> )
							</td>
							<td>
								<%= getCertMainKind( result.getInt("mainkind") ) %> ( <%=result.getInt("kind")%> )
							</td>
							<td>
								<%= getDate16( result.getString("usedtime") ) %>
							</td>
						</tr>
					<%}%>
				<%}%>
				</table>
			</div>
		</td>
	</tr>

</tbody></table>
</center>

<%

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
