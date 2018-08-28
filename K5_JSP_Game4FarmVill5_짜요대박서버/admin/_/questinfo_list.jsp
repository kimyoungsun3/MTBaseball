<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.io.*"%>
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
	
	int count = 0;
%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<center><br><br><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				전체 퀘스트 정보<br>
				questorder : 클라이언트에서 정렬되는 순서를 의미, 여기서는 questcode로 정렬됨
				
				
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 24, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', ''		--퀘스트 정보
					//exec spu_FarmD 24, 2, 100, 100, 2, 20, 750, -1, 0, 1, '0', '100', '', '', 'xxxx'		--퀘스트 수정
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 24);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, -1);
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
					
					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();	
					%>
						<tr>
							<td>idx</td>
							<td>questlv</td>
							<td>questcode</td>
							<td>questkind</td>
							<td>questsubkind</td>
							<td>questvalue</td>
							<td>content</td>
							<td>rewardsb</td>
							<td>rewarditem</td>
							<td>questtime</td>
							<td>questinit</td>
							<td>questclear</td>
							<td>questorder</td>
							<td></td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="questinfo_ok.jsp" onsubmit="return f_Submit(this);">
								<input type="hidden" name="questcode" value="<%=result.getString("questcode")%>">
								<td><%=result.getString("idx")%></td>
								<td>
									<input name="questlv" type="text" value="<%=result.getString("questlv")%>" size="4" maxlength="10">
								</td>
								<td><%=result.getString("questcode")%> -> <%=result.getString("questnext")%></td>
								<td>
									<select name="questkind">
										<%
										int questkind[] = {100, 200, 300, 400, 500, 600, 700, 800, 900, 1000};
										for(int i = 0; i < questkind.length; i++){
											%>
											<option value="<%=questkind[i]%>" <%=getSelect(result.getInt("questkind"), questkind[i])%>>
												<%=getQuestKind(questkind[i])%>
											</option>
										<%}%>
									</select>
								</td>
								<td>
									
									<select name="questsubkind">
										<%
										int questsubkind[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
										for(int i = 0; i < questsubkind.length; i++){
											%>
											<option value="<%=questsubkind[i]%>" <%=getSelect(result.getInt("questsubkind"), questsubkind[i])%>>
												<%=getQuestSubKind(questsubkind[i])%>
											</option>
										<%}%>
									</select>
								</td>
								<td> >= 
									<input name="questvalue" type="text" value="<%=result.getString("questvalue")%>" size="6" maxlength="10">
								</td>
								<td>
									<input name="content" type="text" value="<%=result.getString("content")%>" size="40" maxlength="128">
								</td>
								<td>
									<input name="rewardsb" type="text" value="<%=result.getString("rewardsb")%>" size="6" maxlength="10">
								</td>
								<td>
									<input name="rewarditem" type="text" value="<%=result.getString("rewarditem")%>" size="6" maxlength="10">
								</td>
								<td>
									<input name="questtime" type="text" value="<%=result.getString("questtime")%>" size="2" maxlength="2">
									(시간)
								</td>
								<td>
									<select name="questinit">
										<%
										int questinit[] = {0, 1};
										for(int i = 0; i < questinit.length; i++){
											%>
											<option value="<%=questinit[i]%>" <%=getSelect(result.getInt("questinit"), questinit[i])%>>
												<%=getQuestInit(questinit[i])%>
											</option>
										<%}%>
									</select>
								</td>
								<td>
									<select name="questclear">
										<%
										int questclear[] = {0, 1, 2};
										for(int i = 0; i < questclear.length; i++){
											%>
											<option value="<%=questclear[i]%>" <%=getSelect(result.getInt("questclear"), questclear[i])%>>
												<%=getQuestClear(questclear[i])%>
											</option>
										<%}%>
									</select>
								</td>
								<td>
									<input name="questorder" type="text" value="<%=result.getString("questorder")%>" size="4" maxlength="10">
								</td>
								<td><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
		        			</form>
							<%
								count += result.getInt("questinit");
							%>
						</tr>
					<%}%>
					<tr>
						<td colspan=9><td>
						<td colspan=2>초기 시작 퀘스트 : <%=count%></td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	
</tbody></table>
</center>	
	
<%
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
