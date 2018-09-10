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


	int idx 					= util.getParamInt(request, "idx", -1);

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
	if(f_nul_chk(f.comment, '내용을 작성하세요.')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.comment.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
				<form name="GIFTFORM" method="post" action="notice_ok.jsp" onsubmit="return f_Submit(this);">
				<input type="hidden" name="subkind" value="0">
					<tr>
						<td>
							[공지사항]
						</td>
					</tr>
					<tr>
						<td>
							<font color=red>- 상태:점검중으로 선택하면 해당 통신사 모든 유저 로그인불가</font><br>

							상태 :
							<select name="syscheck" >
								<option value="0">서비스중(0)</option>
								<option value="1">점검중..(1)</option>
							</select>

							버젼 : <input name="version" type="text" value="100" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:100px;"><br>

							<a href=fileupload.jsp target=_blank>(파일올리기)</a>
							<br>
							<br>
						</td>
					</tr>
					<tr>
						<td>
							광고1 이미지	: <input name="comfile1" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							광고1 URL		: <input name="comurl1" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
							광고2 이미지	: <input name="comfile2" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							광고2 URL		: <input name="comurl2" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
							광고3 이미지	: <input name="comfile3" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							광고3 URL		: <input name="comurl3" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
							광고4 이미지	: <input name="comfile4" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							광고4 URL		: <input name="comurl4" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
							광고5 이미지	: <input name="comfile5" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							광고5 URL		: <input name="comurl5" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>

							패치URL			: <input name="patchurl" type="text" value="" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>

						</td>
					</tr>
					<tr>
						<td style="padding-left:5px;">
							<textarea name="comment" rows="10" cols="120" style="border:solid 1px black; font-family:tahoma; background-color:lightsteelblue;"></textarea>
						</td>
					</tr>
					<tr>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				</div>
				<table border=1>
					<%
					//exec spu_GameMTBaseballD2 20, 2, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- 리스트
					//2. 데이타 조작
					query.append("{ call dbo.spu_GameMTBaseballD2 (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, KIND_NOTICE_SETTING);
					cstmt.setInt(idxColumn++, 2);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
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
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="notice_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="subkind" value="1">
	        				<input type="hidden" name="idx" value="<%=result.getString("idx")%>">
							<td <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> valign=top>
								<a name="<%=result.getString("idx")%>"></a>
							</td>
							<td>
								<table <%=getCheckValueOri(result.getInt("syscheck"), 1, "bgcolor=#aa00aa", "")%> valign=top>
									<tr>
										<td>서비스</td>
										<td>
											<!--<%=result.getString("writedate")%><br>-->
											<select name="syscheck">
												<option value="0" <%=getSelect(result.getInt("syscheck"), 0)%>>서비스중(0)</option>
												<option value="1" <%=getSelect(result.getInt("syscheck"), 1)%>>점검중..(1)</option>
											</select>
										</td>
									</tr>
									<tr>
										<td>버 젼</td>
										<td>
											<input name="version" type="text" value="<%=result.getString("version")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										</td>
									</tr>
									<tr>
										<td>광고1</td>
										<td>
											<input name="comfile1" type="text" value="<%=result.getString("comfile1")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
											<input name="comurl1" type="text" value="<%=result.getString("comurl1")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl1").equals("")?"":"<a href="+(result.getString("comurl1") + " target=_blank>")%><img src="<%=result.getString("comfile1")%>"></a>
										</td>
									</tr>
									<tr>
										<td>광고2</td>
										<td>
											<input name="comfile2" type="text" value="<%=result.getString("comfile2")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
											<input name="comurl2" type="text" value="<%=result.getString("comurl2")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl2").equals("")?"":"<a href="+(result.getString("comurl2") + " target=_blank>")%><img src="<%=result.getString("comfile2")%>"></a>
										</td>
									</tr>
									<tr>
										<td>광고3</td>
										<td>
											<input name="comfile3" type="text" value="<%=result.getString("comfile3")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
											<input name="comurl3" type="text" value="<%=result.getString("comurl3")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl3").equals("")?"":"<a href="+(result.getString("comurl3") + " target=_blank>")%><img src="<%=result.getString("comfile3")%>"></a>
										</td>
									</tr>
									<tr>
										<td>광고4</td>
										<td>
											<input name="comfile4" type="text" value="<%=result.getString("comfile4")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
											<input name="comurl4" type="text" value="<%=result.getString("comurl4")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl4").equals("")?"":"<a href="+(result.getString("comurl4") + " target=_blank>")%><img src="<%=result.getString("comfile4")%>"></a>
										</td>
									</tr>
									<tr>
										<td>광고5</td>
										<td>
											<input name="comfile5" type="text" value="<%=result.getString("comfile5")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
											<input name="comurl5" type="text" value="<%=result.getString("comurl5")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl5").equals("")?"":"<a href="+(result.getString("comurl5") + " target=_blank>")%><img src="<%=result.getString("comfile5")%>"></a>
										</td>
									</tr>
									<tr>
										<td>패치 URL</td>
										<td>
											<input name="patchurl" type="text" value="<%=result.getString("patchurl")%>" size="100" maxlength="512" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										</td>
									</tr>
									<tr>
										<td>텍스트 공지</td>
										<td>
											<textarea name="comment" rows="10" cols="120" style="border:solid 1px black; font-family:tahoma; background-color:lightsteelblue;"><%=result.getString("comment")%></textarea>
										</td>
									</tr>
								</table>
							</td>
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
  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
