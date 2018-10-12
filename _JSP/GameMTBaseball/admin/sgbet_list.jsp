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
			<form name="GIFTFORM" method="post" action="sgbet_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							배팅중인 정보 있음 <a href=sgbet_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>검색</td>
						<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_GameMTBaseballD 19,1010, -1, -1, -1, -1,  1, -1, -1, -1, 'mtxxxx3', '', '', '', '', '', '', '', '', ''				-- 배팅정보 리스트.
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

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
						<tr>
							<td colspan=2></td>
							<td colspan=2>배팅</td>
							<td></td>
							<td>파워볼</td>
							<td></td>
							<td>합볼</td>
							<td></td>
							<td colspan=4>배팅시 정보</td>
							<td colspan=4></td>
						</tr>
						<tr>
							<td>인덱스</td>
							<td></td>
							<td>회차</td>
							<td>들어올예정시간</td>
							<td>게임모드</td>
							<td>스트라이크/볼</td>
							<td>직구/변화구</td>
							<td>좌/우</td>
							<td>상/하</td>
							<td>접속IP</td>
							<td>레벨</td>
							<td>경험치</td>
							<td>수수료차감값</td>
							<td>소모템</td>
							<td>배팅상태</td>
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
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=25&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=sgbet_list>강제삭제</a>
								<a href=usersetting_ok.jsp?p1=19&p2=2000&p3=26&p4=<%=result.getInt("idx")%>&ps1=<%=result.getString("gameid")%>&ps2=<%=adminid%>&gameid=<%=result.getString("gameid")%>&branch=sgbet_list>강제롤백</a>
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

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
