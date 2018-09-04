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
	int idxColumn				= 1;
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;

	String boardkind[] = {
			"1", 		"친추게시판",
			"2", 		"일반게시판",
			"3", 		"학교게시판"
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
	if(f_nul_chk(f.itemcode, '아이디를')) return false;
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
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="20">
					<input type="hidden" name="p2" value="11">
					<input type="hidden" name="p3" value="2">
					<input type="hidden" name="branch" value="systemboard_list">
					<tr>
						<td>
							<a href=systemboard_list.jsp><img src=images/refresh2.png alt="화면갱신"></a><br>
							<select name="p4" >
								<option value="<%=boardkind[0]%>" ><%=boardkind[1]%></option>
							</select>
							<input name="ps10" type="text" value="내용을 작성하세요." size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>

				<table border=1>
					<%

					//2. 데이타 조작
					//exec spu_FarmD 20, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- 게시판 읽기.
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 20);
					cstmt.setInt(idxColumn++, 11);
					cstmt.setInt(idxColumn++,  1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td>idx</td>
							<td>종류</td>
							<td>작성자</td>
							<td>메세지</td>
							<td>작성일</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td>
								<%for(int i = 0; i < boardkind.length; i+=2){
									if(result.getString("kind").equals(boardkind[i])){
										out.println(boardkind[i+1]);
										break;
									}
								}%>
							</td>
							<td><%=result.getString("gameid")%></td>
							<td><%=result.getString("message")%></td>
							<td><%=result.getString("writedate")%></td>
							<td>
								<%=result.getString("schoolidx")%>
								<a href=usersetting_ok.jsp?p1=20&p2=11&p3=3&p5=<%=result.getString("idx")%>&branch=systemboard_list>삭제</a>
								<a href=wgiftsend_form.jsp?gameid=<%=result.getString("gameid")%> target=_blank>쪽지</a>
							</td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=6 align=center>
								<a href=systemboard_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=systemboard_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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
