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
	
	int idxColumn				= 1;
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;
	int stateCode 				= util.getParamInt(request, "stateCode", -1);
	String curturntime 			= util.getParamStr(request, "curturntime", "");
	int p5, p6, p7, p8, p9, p10;
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
					<form name="GIFTFORM" method="post" action="lottoinfo_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td colspan=2>
							<a href=lottoinfo_list.jsp><img src=images/refresh2.png alt="ȭ�鰻��"></a>
						</td>
					</tr>
					<tr>
						<td>
							<input name="curturntime" type="text" value="<%=curturntime%>" size="20" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>
				<table border=1 width=1800>
					<%
					//2. ����Ÿ ����
					//exec spu_GameMTBaseballD 20, 23, 1,  1, -1, -1, -1, -1, -1, -1, '', '', '821730', '', '', '', '', '', '', ''				-- �����ζ� ����.
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, 23);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, curturntime);
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
							<td>����ȸ��</td>
							<td>����ȸ���ð�</td>
							<td>�Ϲݺ�(5)</td>
							<td>�Ϲ���</td>
							<td>�Ϲݵ��</td>
							<td>�Ϲ�Ȧ¦</td>
							<td>�Ϲݾ������</td>
							<td>�Ϲݵ��2</td>
							<td>�Ŀ���</td>
							<td>�Ŀ������</td>
							<td>�Ŀ���Ȧ¦</td>
							<td>�Ŀ����������</td>
							<td>&nbsp;</td>
							<td>�Ŀ���(Ȧ¦)<br>��Ʈ����ũ(1)/��(0)</td>
							<td>�Ŀ���(���)<br>����(1)/��ȭ��(0)</td>
							<td>����(Ȧ¦)<br>��(1)/��(0)</td>
							<td>����(���)<br>��(1)/��(0)</td>
							<td>&nbsp;</td>
							<td>����ȸ��</td>
							<td>����ȸ���ð�</td>
							<td>��ϰ�����ID</td>
							<td></td>	
							<td>(���߿Ϸ��� ��������)</td>						
						</tr>

					<%while(result.next()){
						curturntime = result.getString("curturntime");
						p5 = result.getInt("curturnnum1"); 
						p6 = result.getInt("curturnnum2"); 
						p7 = result.getInt("curturnnum3"); 
						p8 = result.getInt("curturnnum4"); 
						p9 = result.getInt("curturnnum5"); 
						p10= result.getInt("curturnnum6"); 
						%>
						<tr>
							<td><a href=lottoinfo_list.jsp?curturntime=<%=curturntime%>><%=curturntime%></a></td>
							<td><%=getDate19(result.getString("curturndate"))%></td>
							<td bgcolor="#00EE00">
								<%=result.getString("curturnnum1")%> /
								<%=result.getString("curturnnum2")%> /
								<%=result.getString("curturnnum3")%> /
								<%=result.getString("curturnnum4")%> /
								<%=result.getString("curturnnum5")%>
							</td>
							<td bgcolor="#00CC00"><%=(result.getInt("totalball"))%></td>
							<td bgcolor="#00EE00"><%=getLottoTBGrade(result.getInt("tbgrade"))%></td>
							<td bgcolor="#00EE00"><%=getLottoTBEvenOdd(result.getInt("tbevenodd"))%></td>
							<td bgcolor="#00EE00"><%=getLottoTBUnderOver(result.getInt("tbunderover"))%></td>							
							<td bgcolor="#00EE00"><%=getLottoTBGrade2(result.getInt("tbgrade2"))%></td>
							
							<td bgcolor="#CCEE99"><%=result.getString("curturnnum6")%></td>
							<td bgcolor="#CCFF99"><%=getLottoPBGrade(result.getInt("pbgrade"))%></td>
							<td bgcolor="#CCFF99"><%=getLottoPBEvenOdd(result.getInt("pbevenodd"))%></td>
							<td bgcolor="#CCFF99"><%=getLottoPBUnderOver(result.getInt("pbunderover"))%></td>
							<td></td>
							<td bgcolor="#00FF00"><%=getLottoSelect1(result.getInt("select1"))%></td>
							<td bgcolor="#00FF00"><%=getLottoSelect2(result.getInt("select2"))%></td>
							<td bgcolor="#00FF00"><%=getLottoSelect3(result.getInt("select3"))%></td>
							<td bgcolor="#00FF00"><%=getLottoSelect4(result.getInt("select4"))%></td>
							<td></td>
							<td><%=result.getString("nextturntime")%></td>
							<td><%=getDate19(result.getString("nextturndate"))%></td>
							<td><%=result.getString("adminid")%></td>
							<td><%=getDate(result.getString("writedate"))%></td>							
							<td>
								<a href=lottoinfo_form4.jsp?mode=1&p1=20&p2=23&p3=2&p4=1&ps3=<%=curturntime%>>���</a> /
								<a href=lottoinfo_form4.jsp?mode=2&p1=20&p2=23&p3=2&p4=2&p5=<%=p5%>&p6=<%=p6%>&p7=<%=p7%>&p8=<%=p8%>&p9=<%=p9%>&p10=<%=p10%>&ps3=<%=curturntime%>>����</a> / 
								<a href=usersetting_ok.jsp?p1=20&p2=23&p3=2&p4=3&ps3=<%=curturntime%>&branch=lottoinfo_list>����(�̰ǹݵ�û���)</a>
							</td>
							<%
								maxPage = result.getInt("maxPage");
							%>
						</tr>
					<%}%>
					<tr>
						<td colspan=12 align=center>
								<a href=lottoinfo_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=lottoinfo_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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
