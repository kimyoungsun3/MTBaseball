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
			<form name="GIFTFORM" method="post" action="itemupgradestep_ok.jsp" onsubmit="return f_Submit(this);">
			<input type="hidden" name="subkind" value="50">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=2>
							업그레이드 단게 관리(가장 최근것만 작동합니다)
						</td>
					</tr>
					<tr>
						<td>영구귀속(단계) : 
						<td>
							<input name="permanentstep" type="text" value="25" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">
						</td>
					</tr>
					<tr>
						<td>일반템(기본) : 
						<td>
							<input name="normalitemupgradebase" type="text" value="50" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">
							상의, 하의, 배트
						</td>
					</tr>
					<tr>
						<td>일반템(단계) : 
						<td><input name="normalitemupgradestep" type="text" value="10" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>				
					</tr>
					<tr>
						<td>펫(기본) : </td>
						<td>
							<input name="petitemupgradebase" type="text" value="50" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">
							펫
						</td>
					</tr>
					<tr>
						<td>펫(단계) : 
						<td>
							<input name="petitemupgradestep" type="text" value="30" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">
							
						</td>
					</tr>
					<tr>
						<td>맨트 : 
						<td><input name="comment" type="text" value="(25단계로 변동 기본변동)" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:200px;"></td>
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
					//exec spu_FarmD 20, -1, -1, 52, -1, -1, -1, -1, -1, -1, '', '', '', '', ''
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 52);
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
							<td>영구귀속(단계)</td>	
							<td>일반템(기본)</td>							
							<td>일반템(단계)</td>
							<td>펫(기본)</td>
							<td>펫(단계)</td>
							<td>작성일</td>
							<td>멘트</td>
							<td></td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="itemupgradestep_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="subkind" value="51">
							<input type="hidden" name="idx" value="<%=result.getString("idx")%>">
							<input type="hiddEn" name="permanentstep" value="<%=result.getString("permanentstep")%>">
							<input type="hiddEn" name="normalitemupgradebase" value="<%=result.getString("normalitemupgradebase")%>">
							<input type="hidden" name="normalitemupgradestep" value="<%=result.getString("normalitemupgradestep")%>">
							<input type="hidden" name="petitemupgradebase" value="<%=result.getString("petitemupgradebase")%>">
							<input type="hidden" name="petitemupgradestep" value="<%=result.getString("petitemupgradestep")%>">
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("permanentstep")%></td>
							<td><%=result.getString("normalitemupgradebase")%></td>
							<td><%=result.getString("normalitemupgradestep")%></td>
							<td><%=result.getString("petitemupgradebase")%></td>
							<td><%=result.getString("petitemupgradestep")%></td>
							<td><%=result.getString("writedate")%></td>
							<td><input name="comment" type="text" value="<%=result.getString("comment")%>" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"></td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
	        				</form>
						</tr>
						<tr>
							<td></td>
							<td colspan=7>
								<%
								int price = 0, p1, p2;
								
								p1 = result.getInt("normalitemupgradebase");
								p2 = result.getInt("normalitemupgradestep");
								out.print("일반템 : 강화단계 * ("+p1+" + 아이템lv/5 * "+p2+")<br>");
								for(int j = 0; j <= 50; j+=5){
									out.print("아이템("+j+"~"+(j+4)+") ");
									for(int i = 1; i <= 20; i++){
										price = i*( p1+ j/5 * p2);
										out.println(i + ":" + price + "/");
									}								
									out.print("<br>");
								}
								
								String pet[] = {"펫(B) ", "펫(A) ", "펫(S) "};
								p1 = result.getInt("petitemupgradebase");
								p2 = result.getInt("petitemupgradestep");
								out.print("펫 : 강화단계 * ("+p1+" + 아이템lv * "+p2+")<br>");
								for(int j = 0; j <= 2; j++){									
									out.print(pet[j]);
									for(int i = 1; i <= 20; i++){
										price = i*(p1 + j * p2);
										out.println(i + ":" + price + "/");
									}								
									out.print("<br>");
								}								
								
								%>
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

