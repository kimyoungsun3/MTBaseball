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
			<form name="GIFTFORM" method="post" action="adminuserbattlebank_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							���� ��Ʋ�α�
							<a href=adminuserbattlebank_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<tr>
						<td>�˻�</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					<tr>
						<td>idx(������ȣ)</td>
						<td><input name="idx" type="text" value="<%=idx%>" maxlength="10" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%

					//2. ����Ÿ ����
					//exec spu_FarmD 19, 73,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 			   ����Ʈ.
					//exec spu_FarmD 19, 73,  2, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 				�˻�.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 73);
					cstmt.setInt(idxColumn++,  2);
					cstmt.setInt(idxColumn++, idx);
					cstmt.setInt(idxColumn++, -1);
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
							<td>idx(������ȣ)</td>
							<td>������(��ȣ)</td>
							<td>gameid</td>
							<td>Ʈ����(Ƽ��)</td>
							<td>����1(�ڵ�/��ȭ/att/def/hp/time)</td>
							<td>����2</td>
							<td>����3</td>
							<td>����1(��ȭ)</td>
							<td>����2</td>
							<td>����3</td>
							<td>����4</td>
							<td>����5</td>
							<td>������</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td>
								<a href=adminuserbattlebank_list.jsp?idx=<%=result.getString("idx")%>><%=result.getString("idx")%></a>
							</td>
							<td><%=result.getString("idx2")%></td>
							<td>
								<a href=adminuserbattlebank_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a>
								(<%=result.getString("kakaonickname")%> )
							</td>
							<td><%=result.getInt("trophy")%>(<%=result.getInt("tier")%>)</td>
							<td>
								<%=result.getString("aniitemcode1")%> /
								<%=result.getString("upcnt1")%> /
								<%=result.getString("attstem1")%> /
								<%=result.getString("defstem1")%> /
								<%=result.getString("hpstem1")%> /
								<%=result.getString("timestem1")%> /
							</td>
							<td>
								<%=result.getString("aniitemcode2")%> /
								<%=result.getString("upcnt2")%> /
								<%=result.getString("attstem2")%> /
								<%=result.getString("defstem2")%> /
								<%=result.getString("hpstem2")%> /
								<%=result.getString("timestem2")%> /
							</td>
							<td>
								<%=result.getString("aniitemcode3")%> /
								<%=result.getString("upcnt3")%> /
								<%=result.getString("attstem3")%> /
								<%=result.getString("defstem3")%> /
								<%=result.getString("hpstem3")%> /
								<%=result.getString("timestem3")%> /
							</td>
							<td><%=result.getString("treasure1")%>(<%=result.getString("treasureupgrade1")%>)</td>
							<td><%=result.getString("treasure2")%>(<%=result.getString("treasureupgrade2")%>)</td>
							<td><%=result.getString("treasure3")%>(<%=result.getString("treasureupgrade3")%>)</td>
							<td><%=result.getString("treasure4")%>(<%=result.getString("treasureupgrade4")%>)</td>
							<td><%=result.getString("treasure5")%>(<%=result.getString("treasureupgrade5")%>)</td>
							<td><%=getDate(result.getString("writedate"))%></td>
						</tr>
					<%}%>

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
