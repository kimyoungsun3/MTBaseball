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
	StringBuffer query2			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	StringBuffer resultMsg		= new StringBuffer();
	int	idxColumn 				= 1;
	String gameid				= FormUtil.getParamStr(request, "gameid", "");


	try{

%>

<html><head>
<title>�����ϱ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script type="text/javascript">
function checkForm2(f) {
	if(f.gameid.value == ''){
    	alert('���̵� �Է����ּ���.');
    	return false;
    }else{
    	return true;
    }

}

</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tbody><tr>
        <td colspan="2" height="200" align="center" style="vertical-align:middle;">
        	<table>
        		<tbody>
        		<tr>
        			<td align="center">
	        			<form name="GIFTFORM" method="post" action="wgiftsend_ok.jsp" onsubmit="return checkForm2(this);">
	        			<input type="hidden" name="subkind" value="11">
	        			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
	        				<table>
	        				<tbody>
	        				<tr>
	        					<td colspan=3>
	        						<font color=red>
	        							1. ������ �߼��� �˴ϴ�.(������ ȥ�� �Ͻ��� �����ּ���. )<br>
	        							2. �۵��� ������ �߼��� 1���� �⺻�Դϴ�.<br>
	        						</font>
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>������ �������̵�</td>
	        					<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
	        					<td rowspan="2" style="padding-left:5px;">
	        						<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>����������</td>
	        					<td>
	        					<select name="itemcode">
									<%
									//2. ����Ÿ ����
									//exec spu_GameMTBaseballD 27, 1,  -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- ���� ������ ����Ʈ
									query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
									cstmt = conn.prepareCall(query.toString());
									cstmt.setInt(idxColumn++, 27);
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
									cstmt.setString(idxColumn++, "");
									cstmt.setString(idxColumn++, "");
									cstmt.setString(idxColumn++, "");
									cstmt.setString(idxColumn++, "");
									cstmt.setString(idxColumn++, "");

									//2-2. ������� ���ν��� �����ϱ�
									result = cstmt.executeQuery();
									%>

									<%while(result.next()){%>
										<option value="<%=result.getString("itemcode")%>">
											�ڵ�(<%=result.getInt("itemcode")%>)
											[<%=getCategory(result.getInt("category"))%> / <%=getSubCategory(result.getInt("subcategory"))%>]&nbsp;&nbsp;

											<%=result.getString("itemname")%>
											<br>
										</option>
									<%}%>
								</select>
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>����</td>
	        					<td>
	        						<input name="cnt" type="text" value="1" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;">
	        						(���� �ƽ��� 9�ڸ������� �����˴ϴ�.)
	        					</td>
	        				</tr>
	        				</tbody></table>
	        			</div>
	        			</form>
        			</td>
        		</tr>
        		<!---->
        		<tr>
        			<td align="center">
	        			<form name="GIFTFORM" method="post" action="wgiftsend_ok.jsp" onsubmit="return checkForm2(this);">
	        			<input type="hidden" name="subkind" value="12">
	        			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
	        				<table>
	        				<tbody>
	        				<tr>
	        					<td colspan=3>
	        						<font color=red>������ �߼۵˴ϴ�.(���� ��ɰ� ���� �߼� �ȵ˴ϴ�.)</font><br>
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>����(ID)</td>
	        					<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
	        					<td rowspan="2" style="padding-left:5px;">
	        						<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>����(����)</td>
	        					<td colspan=2><input name="message" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:600px;"></td>
	        				</tr>
	        				</tbody></table>
	        			</div>
	        			</form>
        			</td>
        		</tr>
        		<!---->
        	</tbody></table>
        </td>
</tr>
</tbody></table>
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
