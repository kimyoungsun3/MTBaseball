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
	//1. 생성자 위치
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
	String gameidCurRow			= "";
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
	if(f_nul_chk(f.itemcode, '아이디를')) return false;
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
					<form name="GIFTFORM" method="post" action="pcroom_list.jsp" onsubmit="return f_Submit(this);">
					<tr>
						<td colspan=2>
							<a href=pcroom_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
							<a href=pcroom_form4.jsp?mode=1&p1=20&p2=22&p3=2&p4=1&ps1=&ps2=<%=adminid%>>신규등록</a><br>
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
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 20, 22, 1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 문의글 읽기.
					query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, 22);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, idxPage);
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td></td>
							<td>PC방 사장ID</td>
							<td>PC방 IP</td>
							<td>등록일</td>
							<td></td>
							<td>등록관리자ID</td>
						</tr>

					<%while(result.next()){
						gameidCurRow = result.getString("gameid");%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><a href=pcroom_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=result.getString("connectip")%></td>
							<td><%=getDate(result.getString("writedate"))%></td>
							<td>
								<a href=pcroom_form4.jsp?mode=1&p1=20&p2=22&p3=2&p4=1&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&gameid=<%=gameidCurRow%>>추가등록</a> / 
								<a href=pcroom_form4.jsp?mode=2&p1=20&p2=22&p3=2&p4=2&p5=<%=result.getString("idx")%>&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&ps3=<%=result.getString("connectip")%>&gameid=<%=gameidCurRow%>>수정</a> / 
								<a href=usersetting_ok.jsp?p1=20&p2=22&p3=2&p4=3&p5=<%=result.getString("idx")%>&ps1=<%=gameidCurRow%>&ps2=<%=adminid%>&gameid=<%=gameidCurRow%>&branch=pcroom_list>삭제</a>
							</td>
							<td><%=result.getString("adminid")%></td>

							<%
								maxPage = result.getInt("maxPage");
							%>
						</tr>
					<%}%>
					<tr>
						<td colspan=12 align=center>
								<a href=pcroom_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=pcroom_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
