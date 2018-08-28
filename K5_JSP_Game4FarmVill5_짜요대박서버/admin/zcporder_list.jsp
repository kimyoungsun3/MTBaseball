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
	//1. ������ ��ġ
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	String gameid 				= util.getParamStr(request, "gameid", "");
	int idxColumn				= 1;
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;
	int stateCode 				= util.getParamInt(request, "stateCode", -1);

	String state[] = {
			"0", 		"�ֹ� �����",
			"1", 		"�ֹ� Ȯ����",
			"2", 		"�ֹ� �߼ۿϷ�"
	};

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
	if(f_nul_chk(f.itemcode, '���̵�')) return false;
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
				<table>
					<form name="GIFTFORM" method="post" action="zcporder_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td colspan=2>
							<a href=zcporder_list.jsp?stateCode=0>�ֹ� �����(���)</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href=zcporder_list.jsp?stateCode=1>�ֹ� Ȯ����(���)</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href=zcporder_list.jsp?stateCode=2>�ֹ� �߼ۿϷ�(ȸ��)</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href=zcporder_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<tr>
						<td>
							<input name="gameid" type="text" value="<%=gameid%>" size="20" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>
				<table border=1 width=1300>
					<%
					//2. ����Ÿ ����
					//exec spu_FarmD 20, 41, 1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- �ֹ��� �б�.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, 41);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, stateCode);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, gameid);
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
						<tr>
							<td></td>
							<td width="36%">�ֹ�����</td>
							<td>ó������<br>ó����<br>ó����</td>
							<td>
								¥�����ͱ���ó��.<br>
								- ���� ���� �������� ������ �߼۵˴ϴ�.<br>
								- ������̸� �����߼� ���ϸ� ���¸� ����˴ϴ�.<br>
								- �������� 100�� ���ϸ� �����մϴ�.<br>
								- ��ü���� 500�ڱ����� ��ϵ˴ϴ�.(ù��, �ι�°��...)
							</td>
							<td width=8%>��������, Ǫ���߼�, �����˻�</td>
						</tr>

					<%while(result.next()){%>
						<tr <%=getInQuireStateColor(result.getInt("state"))%>>
							<td><%=result.getString("idx")%></td>
							<td>
								<a href=zcporder_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a><br>
								<%=result.getString("comment")%><br>
								<%=getDate(result.getString("orderdate"))%><br>
								<a href=zcpmanager_list.jsp?idx=<%=result.getString("zcpidx")%> target=_blank>
									<img src="<%=result.getString("zcpfile")%>">
								</a>
							</td>
							<td>
								<%=result.getString("comment2")%><br>
								<%=getDate(result.getString("deliverdate"))%><br>
								<%=result.getString("adminid")%>
							</td>
							<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit2(this);">
		        			<input type="hidden" name="p1" value="20">
		        			<input type="hidden" name="p2" value="41">
		        			<input type="hidden" name="p3" value="2">
		        			<input type="hidden" name="p4" value="">
		        			<input type="hidden" name="p5" value="<%=result.getString("idx")%>">
		        			<input type="hidden" name="p7" value="1">
		        			<input type="hidden" name="ps2" value="<%=adminid%>">
		        			<input type="hidden" name="branch" value="zcporder_list">
		        			<input type="hidden" name="idx" value="<%=idxPage%>">
		        			<input type="hidden" name="gameid" value="<%=result.getString("gameid")%>">

							<td>
								<select name="p6" >
									<option value="0" <%=getSelect(result.getInt("state"), 0)%>>�����(0)</option>
									<option value="1" <%=getSelect(result.getInt("state"), 1)%>>Ȯ����(1)</option>
									<option value="2" <%=getSelect(result.getInt("state"), 2)%>>�߼ۿϷ�(2)</option>
								</select>
			        			<input name="ps3" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;">
			        			<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
							</td>
							</form>
							<td>
								<a href=wgiftsend_form.jsp?gameid=<%=result.getString("gameid")%> target=_blank>����/����</a><br>
								<a href=wgiftsend_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>��������Ʈ</a><br>
								<a href=push_list.jsp?gameid=<%=result.getString("gameid")%>&personal=1 target=_blank>Ǫ���߼�</a><br>
								<a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank><%=result.getString("gameid")%></a><br>
								<a href=unusual_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>������˻�(�Ϲ�)</a><br>
								<a href=unusual_list2.jsp?gameid=<%=result.getString("gameid")%> target=_blank>������˻�2(�Ϲ�)</a><br>
								<a href=userdellog_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>������볻��</a><br>
							</td>
							<%
								maxPage = result.getInt("maxPage");
							%>
						</tr>
					<%}%>
					<tr>
						<td colspan=12 align=center>
								<a href=zcporder_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=zcporder_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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
		System.out.println(_strErr);
	}
    //3. ����, ����Ÿ �ݳ�
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
