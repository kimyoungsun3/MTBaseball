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
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="smsrec_ok.jsp" onsubmit="return f_Submit(this);">
			<input type="hidden" name="subkind" value="20">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td>
							[SMS ��õ(�ֱ��Ѱ���)]
						</td>
					</tr>
					<tr>
						<td>
							<select name="gamekind" >
								<option value="1">Ȩ������(1)</option>
								<option value="2">����Ȩ��(2)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							���� ����� ���� ��õ�� ��<br>
							<input name="comment" type="text" value="" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
						</td>
					</tr>
					<tr>
						<td>
							SMS ��õ ���� ����� ���� URL(SKT, KT, LGT ��� ����)<br>
							<input name="url" type="text" value="" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;">
						</td>
					</tr>
					<tr>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 20, -1, -1, 22, -1, -1, -1, -1, -1, -1, '', '', '', '', ''		--SMS URL
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 22);
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
					
					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();	
					%>
						<tr>
							<td>idx</td>
							<td>��Ʈ</td>
							<td>URL</td>
							<td>�ۼ���</td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<form name="GIFTFORM" method="post" action="smsrec_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="subkind" value="21">
							<input type="hidden" name="idx" value="<%=result.getString("idx")%>">
							<td>
								<%=result.getString("idx")%>
							</td>
							<td>
								<select name="gamekind">
									<option value="1" <%=getSelect(result.getInt("gamekind"), 1)%>>Ȩ������(1)</option>
									<option value="2" <%=getSelect(result.getInt("gamekind"), 2)%>>����Ȩ��(2)</option>								
								</select>
							</td>
							<td>
								<input name="comment" type="text" value="<%=result.getString("comment")%>" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
							</td>
							<td>
								<input name="url" type="text" value="<%=result.getString("url")%>" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							</td>
							<td style="padding-left:5px;">
								<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"><br>
								<%=result.getString("writedate")%>
							</td>
	        				</form>
						</tr>
					<%}%>
				</table>
		</td>
	</tr>
	
</tbody></table>
</center>	
<%
    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>

