<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>
<%
	//1. ������ ��ġ
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;

	String market[] = {
			""+SKT, 		"SKT(" + SKT + ")",
			""+GOOGLE, 		"GOOGLE(" + GOOGLE + ")",
			""+IPHONE,		"IPHONE(" + IPHONE + ")",
			""+NHN,			"NHN(" + NHN + ")"
			//""+LGT, 		"LGT(" + LGT + ")",
			//""+KT, 		"KT(" + KT + ")"
	};

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
	if(f_nul_chk(f.comment, '������ �ۼ��ϼ���.')) return false;
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
			<a href=notice_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
				<form name="GIFTFORM" method="post" action="notice_ok.jsp" onsubmit="return f_Submit(this);">
				<input type="hidden" name="subkind" value="0">
				<input type="hidden" name="buytype" value="0">
					<tr>
						<td>
							[��������]
						</td>
					</tr>
					<tr>
						<td>
							<font color=red>- ����:���������� �����ϸ� �ش� ��Ż� ��� ���� �α��κҰ�</font><br>
							<!--<a href=fileupload.jsp>�̹���UpLoad(PNG)</a> <br><br>-->

							�Ǹ�ó :
							<select name="market" >
								<%for(int i = 0; i < market.length; i+=2){%>
									<option value="<%=market[i]%>"><%=market[i+1]%></option>
								<%}%>
							</select>

							���� :
							<select name="syscheck" >
								<option value="0">������(0)</option>
								<option value="1">������..(1)</option>
							</select>

							���� : <input name="version" type="text" value="101" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:100px;"><br>
							�Խ���URL		: <input name="recurl" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							<a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>


						</td>
					</tr>
					<tr>
						<td>
							���� �̹���		: <input name="comfile" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							���� URL		: <input name="comurl" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
							����2 �̹���	: <input name="comfile2" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							����2 URL		: <input name="comurl2" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
							����3 �̹���	: <input name="comfile3" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							����3 URL		: <input name="comurl3" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
							����4 �̹���	: <input name="comfile4" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							����4 URL		: <input name="comurl4" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
							����5 �̹���	: <input name="comfile5" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							����5 URL		: <input name="comurl5" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>

							��ġURL			: <input name="patchurl" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
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
					//exec spu_FVFarmD2 20, 2, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- ����Ʈ
					//2. ����Ÿ ����
					query.append("{ call dbo.spu_FVFarmD2 (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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

					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();
					%>
					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="notice_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="subkind" value="1">
	        				<input type="hidden" name="idx" value="<%=result.getString("idx")%>">
	        				<input type="hidden" name="market" value="<%=result.getString("market")%>">
	        				<input type="hidden" name="buytype" value="<%=result.getString("buytype")%>">
							<td <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> valign=top>
								<%=getTel(result.getInt("market"))%><a name="<%=result.getString("idx")%>"></a>
							</td>
							<td>
								<table <%=getCheckValueOri(result.getInt("syscheck"), 1, "bgcolor=#aa00aa", "")%> valign=top>
									<tr>
										<td>����</td>
										<td>
											<!--<%=result.getString("writedate")%><br>-->
											<select name="syscheck">
												<option value="0" <%=getSelect(result.getInt("syscheck"), 0)%>>������(0)</option>
												<option value="1" <%=getSelect(result.getInt("syscheck"), 1)%>>������..(1)</option>
											</select>
										</td>
									</tr>
									<tr>
										<td>�� ��</td>
										<td>
											<input name="version" type="text" value="<%=result.getString("version")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										</td>
									</tr>
									<tr>
										<td>����1</td>
										<td>
											<input name="comfile" type="text" value="<%=result.getString("comfile")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
											<input name="comurl" type="text" value="<%=result.getString("comurl")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl").equals("")?"":"<a href="+(result.getString("comurl") + " target=_blank>")%><img src="<%=result.getString("comfile")%>"></a>
										</td>
									</tr>
									<tr>
										<td>����2</td>
										<td>
											<input name="comfile2" type="text" value="<%=result.getString("comfile2")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
											<input name="comurl2" type="text" value="<%=result.getString("comurl2")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl2").equals("")?"":"<a href="+(result.getString("comurl2") + " target=_blank>")%><img src="<%=result.getString("comfile2")%>"></a>
										</td>
									</tr>
									<tr>
										<td>����3</td>
										<td>
											<input name="comfile3" type="text" value="<%=result.getString("comfile3")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
											<input name="comurl3" type="text" value="<%=result.getString("comurl3")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl3").equals("")?"":"<a href="+(result.getString("comurl3") + " target=_blank>")%><img src="<%=result.getString("comfile3")%>"></a>
										</td>
									</tr>
									<tr>
										<td>����4</td>
										<td>
											<input name="comfile4" type="text" value="<%=result.getString("comfile4")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
											<input name="comurl4" type="text" value="<%=result.getString("comurl4")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl4").equals("")?"":"<a href="+(result.getString("comurl4") + " target=_blank>")%><img src="<%=result.getString("comfile4")%>"></a>
										</td>
									</tr>
									<tr>
										<td>����5</td>
										<td>
											<input name="comfile5" type="text" value="<%=result.getString("comfile5")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><a href=fileupload.jsp target=_blank>(���Ͽø���)</a><br>
											<input name="comurl5" type="text" value="<%=result.getString("comurl5")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
											<%=result.getString("comurl5").equals("")?"":"<a href="+(result.getString("comurl5") + " target=_blank>")%><img src="<%=result.getString("comfile5")%>"></a>
										</td>
									</tr>
									<tr>
										<td>��ġ URL</td>
										<td>
											<input name="patchurl" type="text" value="<%=result.getString("patchurl")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										</td>
									</tr>
									<tr>
										<td>��õ �Խ���URL</td>
										<td>
											<input name="recurl" type="text" value="<%=result.getString("recurl")%>" size="100" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>

										</td>
									</tr>
									<tr>
										<td>�ؽ�Ʈ ����</td>
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

    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
