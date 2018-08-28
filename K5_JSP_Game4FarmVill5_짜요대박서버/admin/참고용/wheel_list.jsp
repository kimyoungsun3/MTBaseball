<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
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
	if(f_nul_chk(f.gameid, '아이디를')) return false;
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
			<form name="GIFTFORM" method="post" action="wheel_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							회전정보 <a href=wheel_list.jsp><img src=images/refresh2.png alt="화면갱신"></a><br>
						</td>
					</tr>
					<tr>
						<td>검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="60" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 19, 1020, -1, -1, -1, -1,  2, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 보물강화정보.
					//exec spu_FVFarmD 19, 1020, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		    검색.
					//exec spu_FVFarmD 19, 1021,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          삭제.
					//exec spu_FVFarmD 19, 1022, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          일괄삭제.
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 1020);
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td></td>
							<td></td>
							<td>gameid</td>
							<td>회전판종류</td>
							<td>보유결정</td>
							<td>사용결정</td>
							<td></td>
							<td>날짜</td>
							<td></td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td><%=result.getString("idx2")%></td>
							<td><a href=wheel_list.jsp?gameid=<%=result.getString("gameid")%>><%=result.getString("gameid")%></a></td>
							<td><%=getWheelMode(result.getInt("mode"))%></td>
							<td>
								<%=result.getLong("ownercashcost")%> -> <%=result.getLong("ownercashcost2")%>
								(<%=result.getLong("ownercashcost") - result.getLong("ownercashcost2")%>)
							</td>
							<td><%=result.getInt("cashcost")%></td>
							<td>
								<a href=usersetting_ok.jsp?p1=19&p2=1032&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&branch=wheel_list&gameid=<%=result.getString("gameid")%>><%=getTSStrange(result.getInt("strange"))%></a>
							</td>
							<td><%=result.getString("writedate")%></td>
							<td>
								<a href=unusual_list2.jsp?gameid=<%=result.getString("gameid")%> target=_blank>이상내용</a> /
								<a href=userinfo_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>정보검색</a> /
								<a href=wgiftsend_form.jsp?gameid=<%=result.getString("gameid")%> target=_blank>선물/쪽지</a> /
								<a href=wgiftsend_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>선물리스트</a> /
								<a href=cashbuy_list.jsp?gameid=<%=result.getString("gameid")%> target=_blank>캐쉬검사</a>
								<a href=usersetting_ok.jsp?p1=19&p2=1021&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=wheel_list&gameid=<%=result.getString("gameid")%>>
									삭제
								</a>
								<a href=usersetting_ok.jsp?p1=19&p2=1022&p3=<%=result.getString("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&branch=wheel_list&gameid=<%=result.getString("gameid")%>>
									일괄삭제
								</a>
							</td>
						</tr>
						<%
							maxPage = result.getInt("maxPage");
						%>
					<%}%>
					<tr>
						<td colspan=13 align=center>
								<a href=wheel_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
								<%=idxPage%> / <%=maxPage%>
								<a href=wheel_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
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

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
