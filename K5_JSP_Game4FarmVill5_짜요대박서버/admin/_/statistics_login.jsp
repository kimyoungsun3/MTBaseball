<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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
	
	String dateid 				= util.getParamStr(request, "dateid", "");
	String dateid2 				= "" + format.format(now);
	
	String dateid3				= "";
	if(dateid != null && dateid.length() >= 8){
		dateid3 = dateid.substring(0, 4) + "-" + dateid.substring(4, 6) + "-" + dateid.substring(6, 8);
	}else{
		dateid3 = dateid2.substring(0, 4) + "-" + dateid2.substring(4, 6) + "-" + dateid2.substring(6, 8);
	}

%>
<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.dateid, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script>
</head>

<style>
table.cal_calendar{padding:0px;margin:0 auto;}
table.cal_calendar th{border:1px solid #c0c0c0;background-color:#e0e0e0;width:36px;font-family:����;font-size:11px;padding:3px;}
table.cal_calendar td{border:1px solid #e0e0e0;background-color:#ffffff;text-align:center;width:20px;height:25px;font-family:tahoma;font-size:11px;padding:3px;}
.cal_today{color:#ff0000;font-weight:bold;}
.cal_days_bef_aft{color:#5a779e;}
</style>
<script type="text/javascript" src="js/manth.js"></script>
<script type="text/javascript">calendar('statistics_login.jsp', '<%=dateid3%>');</script>


<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.dateid.focus();">
<center>

<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="statistics_login.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=1> 
							<br>
						�˻��� ����<br>
						20120101<br>
						2012010120<br>

						</td>
						<td colspan=3> 
						�ð��뺰 ���� �� �÷���Ÿ��<br>
							> �˻�� ������ �ֱ� 100�Ǹ� �˻�<br>
							> 2012�� 01�� 01�� 24�ð��� �˻�<br>
							> 2012�� 01�� 01�� 20�� ��Ȯ�� �ð��˻�<br>

						</td>

					</tr>
					<tr>
						<td> �Ϻ�����[<%=dateid2%>]</td>
						<td> �˻�</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 21, -1, -1, 30, -1, -1, -1, -1, -1, -1, '', '', '', '', ''			-- �α��� �÷��� ��ŷ
					//exec spu_FarmD 21, -1, -1, 30, -1, -1, -1, -1, -1, -1, '', '2013012322', '', '', ''	
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} "); 			
					cstmt = conn.prepareCall(query.toString()); 		
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, 30);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					
					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();	
					%>
						<tr>
							<td>idx</td>
							<td>�ð��뺰</td>
							<td>����</td>
							<td>�α���</td>
							<td>�÷���</td>
						</tr>
					
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>			
							<td><a href=statistics_login.jsp?dateid=<%=result.getString("dateid10")%>><%=result.getString("dateid10")%></a></td>
							<td><%=getTel(result.getInt("market"))%></td>	
							<td><%=result.getString("logincnt")%></td>			
							<td><%=result.getString("playcnt")%></td>
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
