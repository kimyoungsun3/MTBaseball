<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
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
	String dateid2 				= "" + format6.format(now);
	int idx 	= 0,
		market 	= 1,
		cnt		= 0,
		loop	= 31,
		loop2	= 7+1;
	String listDate[]			= new String[loop];
	int listCount[][]			= new int[loop][loop2];

	boolean bFind;

	if(dateid.equals("")){
		dateid = dateid2;
	}

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
	if(f_nul_chk(f.gameid, '���̵�')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
	        		<form name="GIFTFORM" method="post" action="statistics_sub2.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td colspan=3>
							������ ����
						</td>
					</tr>
					<tr>
						<td> �˻�</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
	        	</form>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_GameMTBaseballD 19, 98,  4, -1, -1, -1, -1, -1, -1, -1, '', '', '20140404', '', '', '', '', '', '', ''				--         ��������, ������Ż�.
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 98);
					cstmt.setInt(idxColumn++,  4);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");

					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();
					while(result.next()){
						bFind	= false;
						dateid	= result.getString("dateid");
						market 	= result.getInt("market");
						cnt 	= result.getInt("cnt");
						for(idx = 1; idx < loop2; idx++){
							if(listDate[idx] == null){
								bFind 			= true;
								listDate[idx]	= dateid;
								break;
							}else if(listDate[idx].equals(dateid)){
								bFind 			= true;
								break;
							}
						}

						if(bFind){
							listCount[idx][market] = cnt;
						}
					}%>
					<tr>
						<td>����</td>
						<%for(int i = 1; i < loop2; i++){
							out.print("<td>"+getTel(i)+"</td>");
						}%>
					</tr>
					<%
					for(int i = 1; i < loop; i++){
						if(listDate[i] == null)break;%>
						<tr>
							<td><%=listDate[i]%></td>
							<%for(int j = 1; j < loop2; j++){
								if(listCount[i][j] == 0)
									out.print("<td></td>");
								else
									out.print("<td>"+listCount[i][j]+"</td>");
							}%>
						</tr>
					<%}%>
				</table>
			</div>
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