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

	String gameid 				= util.getParamStr(request, "gameid", "");
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;

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

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="userdellog_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							���� ��������/�Ǹŵȵ���/����
							<a href=userdellog_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<tr>
						<td>����</td>
						<td>�˻�</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%
					//exec spu_FarmD 19, 1110, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1110);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");
					cstmt.setString(idxColumn++, "-1");

					//2-2. ������� ���ν��� �����ϱ�
					result = cstmt.executeQuery();
					%>
						<tr>
							<td></td>
							<td>���̵�</td>
							<td>listidx</td>
							<td>�̸�</td>
							<td>����</td>
							<td>�κ�����</td>
							<td>ȹ����</td>
							<td>ȹ����</td>
							<td>����������</td>

							<td>�ʵ��ȣ</td>
							<td>�ܰ�</td>
							<td>���������</td>
							<td>��������</td>
							<td>��������</td>
							<td>�Ӹ��Ǽ�</td>
							<td>�����Ǽ�</td>
							<td>����</td>
							<td>�ٱ⼼��(��/��/Ÿ/��/HP)</td>
							<td>��������</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><a href=userdellog_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("listidx")%> </td>
							<td><%=result.getString("itemname")%>(<%=result.getString("itemcode")%>)</td>
							<td><%=result.getString("cnt")%></td>
							<td><%=getInvenKind(result.getInt("invenkind"))%></td>
							<td><%=getGetHow(result.getInt("gethow"))%></td>
							<td><%=getDate(result.getString("writedate"))%></td>
							<td><%=result.getString("randserial")%></td>
							<td><%=getFieldIdx(result.getInt("fieldidx"))%></td>
							<td><%=result.getString("anistep")%></td>
							<td><%=result.getString("manger")%></td>
							<td><%=getDiseasestate(result.getInt("diseasestate"))%></td>
							<td><%=getDieMode(result.getInt("diemode"))%></td>
							<td><%=result.getString("acc1")%></td>
							<td><%=result.getString("acc2")%></td>
							<td><%=getStemCellUpgrade( result.getInt("invenkind"), result.getInt("upcnt"), result.getInt("upstepmax") )%></td>
							<td><%=getStemCellInfo( result.getInt("invenkind"), result.getInt("freshstem100"), result.getInt("attstem100"), result.getInt("timestem100"), result.getInt("defstem100"), result.getInt("hpstem100") )%></td>
							<td><%=result.getString("idx2")%>(<%=getDate(result.getString("writedate2"))%>)</td>
							<td><%=getUserItemState(result.getInt("state"))%></td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=20 align=center>
								<a href=userdellog_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=userdellog_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
						</td>
					</tr>
				</table>
			</div>
			</form>
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