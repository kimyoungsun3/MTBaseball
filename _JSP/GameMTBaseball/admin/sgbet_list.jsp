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
			<form name="GIFTFORM" method="post" action="sgbet_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							�������� ���� ���� <a href=sgbet_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>�˻�</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. ����Ÿ ����
					//exec spu_GameMTBaseballD 19,1010, -1, -1, -1, -1,  1, -1, -1, -1, 'mtxxxx3', '', '', '', '', '', '', '', '', ''				-- �������� ����Ʈ.
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1010);
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
							<td colspan=2></td>
							<td colspan=2>����</td>
							<td></td>
							<td>�Ŀ���</td>
							<td></td>
							<td>�պ�</td>
							<td></td>
							<td colspan=4>���ý� ����</td>
							<td colspan=4></td>
						</tr>
						<tr>
							<td>�ε���</td>
							<td></td>
							<td>ȸ��</td>
							<td>���ÿ����ð�</td>
							<td>���Ӹ��</td>
							<td>��Ʈ����ũ/��</td>
							<td>����/��ȭ��</td>
							<td>��/��</td>
							<td>��/��</td>
							<td>����IP</td>
							<td>����</td>
							<td>����ġ</td>
							<td>������������</td>
							<td>�Ҹ���</td>
							<td>���û���</td>
							<td></td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><a href=sgbet_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("curturntime")%></td>
							<td><%=getDate19(result.getString("curturndate"))%></td>
							<td><%=getGameMode(result.getInt("gamemode"))%></td>
							<td>
								<%=getSelectMode(1, result.getInt("select1"))%> / 
								<%=result.getInt("cnt1")%> /
							</td>
							<td>
								<%=getSelectMode(2, result.getInt("select2"))%> / 
								<%=result.getInt("cnt2")%> /
							</td>
							<td>
								<%=getSelectMode(3, result.getInt("select3"))%> / 
								<%=result.getInt("cnt3")%> /
							</td>
							<td>
								<%=getSelectMode(4, result.getInt("select4"))%> / 
								<%=result.getInt("cnt4")%> /
							</td>
							<td><%=result.getString("connectip")%></td>
							<td><%=result.getInt("level")%></td>
							<td><%=result.getInt("exp")%></td>
							<td><%=(float)result.getInt("commission")/100%>%</td>
							<td><%=result.getInt("consumeitemcode")%></td>
							<td><%=getGameState(result.getInt("gamestate"))%></td>
							<td><%=getDate19(result.getString("writedate"))%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=25&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=sgbet_list>��������</a>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=26&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=sgbet_list>�����ѹ�</a>
							</td>	
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=5 align=center>
								<a href=sgbet_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=sgbet_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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
