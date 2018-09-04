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
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;
	String dateid 				= "" + format16.format(now);
	int stateCode 				= util.getParamInt(request, "stateCode", -1);
	int mode					= FormUtil.getParamInt(request, "mode", 0);

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
	if(f_nul_chk(f.itemcode, '아이디를')) return false;
	else return true;
}
function f_Submit2(f) {
	if(f.ps3 == '') return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.itemcode.focus();">
<table align=center>
	<tbody>
	<tr>
		<td align="center">

			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table border=1 width=1300>
					<tr>
						<td colspan=5>
							- 내용은 하단에 textarea 사이즈 조절이 됩니다.<br>
							- 소속이외에 것을 수정할때는 조심하는 것이 좋습니다.<br>
							<a href=sysevent_list.jsp?stateCode=0&mode=<%=mode%>>대기중(흰색)</a>,
							<a href=sysevent_list.jsp?stateCode=1&mode=<%=mode%>>진행중(노랑)</a>,
							<a href=sysevent_list.jsp?stateCode=2&mode=<%=mode%>>완료(회색)</a>,
							<a href=sysevent_list.jsp?mode=0>읽기모드</a>,
							<a href=sysevent_list.jsp?mode=1>수정모드</a>,
							<a href=sysevent_list.jsp?mode=<%=mode%>><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<tr bgcolor=#cccccc>
						<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit2(this);">
	        			<input type="hidden" name="p1" value="20">
	        			<input type="hidden" name="p2" value="31">
	        			<input type="hidden" name="p3" value="1">
	        			<input type="hidden" name="ps2" value="<%=adminid%>">
	        			<input type="hidden" name="branch" value="sysevent_list">
						<td>새로작성</td>
						<td>
							<%=adminid%><br>
							<%=dateid%><br>
							<select name="p4" >
								<option value="0">대기중(0)</option>
								<option value="1">진행중(1)</option>
								<option value="2">완료(2)</option>
							</select>
						</td>
						<td>
		        			<input name="ps3" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:150px;"><br>
		        			~<br>
		        			<input name="ps4" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:150px;"><br>
							<select name="p6" >
								<option value="0">상상디지탈(0)</option>
								<option value="1">픽토소프트(1)</option>
							</select>
						</td>
						<td>
		        			<input name="ps9" type="text" value="" maxlength="600" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:600px;"><br>
		        			<textarea name="ps10" rows="10" cols="130" style="border:solid 1px black; font-family:tahoma; background-color:lightsteelblue;"></textarea>
						</td>
						<td>
		        			<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
						</form>
					</tr>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 20, 31, 1,  0, -1, -1, -1, -1, -1, -1, '', 'adminid', '2014-05-05 10:00', '2014-05-06 10:00', '상상디지탈', '', '', '', '제목', '내용'	-- 이벤트 글쓰기.
					//exec spu_FarmD 20, 31, 2,  0,  1, -1, -1, -1, -1, -1, '', 'adminid', '2014-05-05 10:00', '2014-05-06 10:00', '상상디지탈', '', '', '', '제목2', '내용2'	--        루비.
					//exec spu_FarmD 20, 31, 3,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''																--        리스트.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, 31);
					cstmt.setInt(idxColumn++, 3);
					cstmt.setInt(idxColumn++, stateCode);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
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
					cstmt.setString(idxColumn++, "");

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();%>



					<%if(mode == 0){%>
						<%while(result.next()){%>
							<tr <%=getInQuireStateColor(result.getInt("state"))%>>
								<td><%=result.getString("idx")%></td>
								<td>
									<%=result.getString("adminid")%><br>
									<%=getDate(result.getString("writedate"))%><br>
									<select name="p4" >
										<option value="0" <%=getSelect(result.getInt("state"), 0)%>>대기중(0)</option>
										<option value="1" <%=getSelect(result.getInt("state"), 1)%>>진행중(1)</option>
										<option value="2" <%=getSelect(result.getInt("state"), 2)%>>완료(2)</option>
									</select>
								</td>
								<td>
				        			<%=result.getString("startdate")%> ~ <%=result.getString("enddate")%>
									<select name="p6" >
										<option value="0" <%=getSelect(result.getInt("company"), 0)%>>상상디지탈(0)</option>
										<option value="1" <%=getSelect(result.getInt("company"), 1)%>>픽토소프트(1)</option>
									</select>
								</td>
								<td>
				        			<%=result.getString("title")%><br>
				        			<pre><%=result.getString("comment")%></pre>
								</td>
								<td></td>
								<%
									maxPage = result.getInt("maxPage");
								%>
							</tr>
						<%}%>
					<%}else{%>
						<%while(result.next()){%>
							<tr <%=getInQuireStateColor(result.getInt("state"))%>>
								<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit2(this);">
			        			<input type="hidden" name="p1" value="20">
			        			<input type="hidden" name="p2" value="31">
			        			<input type="hidden" name="p3" value="2">
			        			<input type="hidden" name="p5" value="<%=result.getString("idx")%>">
			        			<input type="hidden" name="ps2" value="<%=result.getString("adminid")%>">
			        			<input type="hidden" name="branch" value="sysevent_list">
			        			<input type="hidden" name="idx" value="<%=idxPage%>">
								<td><%=result.getString("idx")%></td>
								<td>
									<%=result.getString("adminid")%><br>
									<%=getDate(result.getString("writedate"))%><br>
									<select name="p4" >
										<option value="0" <%=getSelect(result.getInt("state"), 0)%>>대기중(0)</option>
										<option value="1" <%=getSelect(result.getInt("state"), 1)%>>진행중(1)</option>
										<option value="2" <%=getSelect(result.getInt("state"), 2)%>>완료(2)</option>
									</select>
								</td>
								<td>
				        			<input name="ps3" type="text" value="<%=result.getString("startdate")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:150px;"><br>
				        			~<br>
				        			<input name="ps4" type="text" value="<%=result.getString("enddate")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:150px;"><br>
									<select name="p6" >
										<option value="0" <%=getSelect(result.getInt("company"), 0)%>>상상디지탈(0)</option>
										<option value="1" <%=getSelect(result.getInt("company"), 1)%>>픽토소프트(1)</option>
									</select>
								</td>
								<td>
				        			<input name="ps9" type="text" value="<%=result.getString("title")%>" maxlength="600" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:600px;"><br>
				        			<textarea name="ps10" rows="10" cols="130" style="border:solid 1px black; font-family:tahoma; background-color:lightsteelblue;"><%=result.getString("comment")%></textarea>
								</td>
								<td>
				        			<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
								</td>
								</form>
								<%
									maxPage = result.getInt("maxPage");
								%>
							</tr>
						<%}%>
					<%}%>
						<tr>
							<td colspan=5 align=center>
									<a href=sysevent_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>&mode=<%=mode%>><<</a>
									<%=idxPage%> / <%=maxPage%>
									<a href=sysevent_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>&mode=<%=mode%>>>></a>
							</td>
						</tr>
				</table>
			</div>
		</td>
	</tr>

</tbody></table>
<%

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
	}
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
