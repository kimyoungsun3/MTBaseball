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
			<form name="GIFTFORM" method="post" action="revmode_ok.jsp" onsubmit="return f_Submit(this);">
			<input type="hidden" name="subkind" value="60">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=2>
							[�����ν���]<br>
							<font color=red>�������ڵ� : -1 > ��Ȱ���� ó��</font><br>
							�Ǵ�1ȸ, ��尡 ����Ҷ�<br>
							��Ʋ > ���»������ (btrevprice)<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> ������ ���� ���۽� ���� ��õȴ�.<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> ��밡 �̱�� �ְ� 500m ����(5�ʰ��� ī���͵ȴ�.)<br>
							�̼� > ���»�� 1 ~ 4����(msrevprice), 5 ~ 7����(msrevprice2),<br> 
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8����(msrevprice3), 9����(msrevprice4)	<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> ������ ���� ���۽� ���� ����Ѵ�.<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;> ��밡 �̱�� �ְ� 100m  ����(5�ʰ��� ī���͵ȴ�.)<br>
						</td>
					</tr>
					<tr>
						<td>������Ʋ���� �ڵ尪(7020) : <input name="btrevitemcode" type="text" value="7020" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="btrevprice" type="text" value="2" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>					
					<tr>
						<td>�����̼ǵ���4 �ڵ尪(7021) : <input name="msrevitemcode4" type="text" value="7021" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="msrevprice4" type="text" value="1" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>
					<tr>
						<td>�����̼ǵ���7 �ڵ尪(7022) : <input name="msrevitemcode7" type="text" value="7022" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="msrevprice7" type="text" value="3" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>
					<tr>
						<td>�����̼ǵ���8 �ڵ尪(7023) : <input name="msrevitemcode8" type="text" value="-1" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
						<td><input name="msrevprice8" type="text" value="20" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">GoldBall</td>
					</tr>
					<tr>
						<td>�����̼ǵ���9 �ڵ尪(7024) : <input name="msrevitemcode9" type="text" value="-1" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"></td>
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
					//2. ����Ÿ ����
					//exec spu_FarmD 20, -1, -1, 62, -1, -1, -1, -1, -1, -1, '', '', '', '', ''					--���׷��̵� �б�
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
					
					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();	
					%>
						<tr>
							<td>idx</td>
							<td>������Ʋ����</td>
							<td>�����̼ǵ���4</td>
							<td>�����̼ǵ���7</td>							
							<td>�����̼ǵ���8</td>
							<td>�����̼ǵ���9</td>
							<td>�ۼ���</td>
							<td>�ۼ���</td>
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
    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>

