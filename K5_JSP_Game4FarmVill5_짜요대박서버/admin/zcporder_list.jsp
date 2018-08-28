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

	String state[] = {
			"0", 		"주문 대기중",
			"1", 		"주문 확인중",
			"2", 		"주문 발송완료"
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
							<a href=zcporder_list.jsp?stateCode=0>주문 대기중(흰색)</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href=zcporder_list.jsp?stateCode=1>주문 확인중(노랑)</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href=zcporder_list.jsp?stateCode=2>주문 발송완료(회색)</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href=zcporder_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
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
					//exec spu_FarmD 20, 41, 1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- 주문글 읽기.
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td></td>
							<td width="36%">주문내용</td>
							<td>처리내용<br>처리일<br>처리자</td>
							<td>
								짜요장터구매처리.<br>
								- 글을 쓰면 유저에게 쪽지로 발송됩니다.<br>
								- 빈공백이면 쪽지발송 안하면 상태만 변경됩니다.<br>
								- 쪽지글은 100자 이하를 권장합니다.<br>
								- 전체글은 500자까지만 기록됩니다.(첫글, 두번째글...)
							</td>
							<td width=8%>선물지급, 푸쉬발송, 유저검색</td>
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
									<option value="0" <%=getSelect(result.getInt("state"), 0)%>>대기중(0)</option>
									<option value="1" <%=getSelect(result.getInt("state"), 1)%>>확인중(1)</option>
									<option value="2" <%=getSelect(result.getInt("state"), 2)%>>발송완료(2)</option>
								</select>
			        			<input name="ps3" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:300px;">
			        			<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
							</td>
							</form>
							<td>
								<a href=wgiftsend_form.jsp?gameid=<%=result.getString("gameid")%> target=_blank>선물/쪽지</a><br>
								<a href=wgiftsend_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>선물리스트</a><br>
								<a href=push_list.jsp?gameid=<%=result.getString("gameid")%>&personal=1 target=_blank>푸쉬발송</a><br>
								<a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank><%=result.getString("gameid")%></a><br>
								<a href=unusual_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>비정상검색(일반)</a><br>
								<a href=unusual_list2.jsp?gameid=<%=result.getString("gameid")%> target=_blank>비정상검색2(일반)</a><br>
								<a href=userdellog_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>쿠폰사용내용</a><br>
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
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
