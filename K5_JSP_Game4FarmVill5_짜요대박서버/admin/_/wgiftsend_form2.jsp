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
	        			<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return checkForm2(this);">
	        			<input type="hidden" name="kind" value="701">
		        		<input type="hidden" name="gameid" value="<%=adminid%>">
		        		<input type="hidden" name="branch" value="wgiftsend_form2">


	        			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
	        				<table>
	        				<tbody>
	        				<tr>
	        					<td align=center colspan=2>
	        						�ֱ� 1���� �������� ����(��ü)
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>����������</td>
	        					<td>
	        					<select name="itemcode">
									<%
									//2. ����Ÿ ����
									//exec spu_GiftList 1, ''
									query.append("{ call dbo.spu_GiftList (?, ?)} ");
									cstmt = conn.prepareCall(query.toString());
									cstmt.setInt(idxColumn++, 1);
									cstmt.setString(idxColumn++, "");

									//2-2. ������� ���ν��� �����ϱ�
									result = cstmt.executeQuery();
									%>

									<%while(result.next()){
										if(result.getInt("kind") != 90)continue;
										%>
										<option value="<%=result.getString("itemcode")%>">
											�ڵ�(<%=result.getInt("itemcode")%>)
											�ּ�lv(<%=result.getInt("lv")%>)
											����(<%=getKind(result.getInt("kind"))%>)
											����(<%=getSex(result.getInt("sex"))%>)&nbsp;
											����(<%=getPrice(result.getInt("gamecost"), result.getInt("cashcost"))%>)&nbsp;
											<%=result.getString("itemname")%>&nbsp;
										</option>
									<%}%>
								</select>
	        					</td>
	        				</tr>
					        <tr>
					        	<td align=center colspan=2>
									<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
								</td>
							</tr>
	        				</tbody></table>
	        			</div>
	        			</form>
        			</td>
        		</tr>
        	</tbody></table>
        </td>
</tr>
</tbody></table>
<%
    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
