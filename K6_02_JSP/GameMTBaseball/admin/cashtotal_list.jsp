<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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
	int loopPage 				= 1;
	int loopSum 				= 0;
	boolean bFirst = true;


	int total 					= 0;
	String dateid 				= util.getParamStr(request, "dateid", "");
	String dateid2 				= "" + format.format(now);
	int sumDate 				= -1;


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
	if(f_nul_chk(f.dateid, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.dateid.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="cashtotal_list.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							일별 캐쉬 구매(일자별 구매내역별 정렬)<br>
							(* iPhone 구매는 달러이면 계산 편의상 원으로 환산된것입니다.)
							<a href=cashtotal_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
						</td>
					</tr>
					<tr>
						<td> 구매날자[<%=dateid2%>]</td>
						<td> 검색</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 21, 12,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬판매통계
					//exec spu_FarmD 21, 12,-1, -1, -1, -1, -1, -1, -1, -1, '', '20130910', '', '', '', '', '', '', '', ''				--
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, 12);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
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
							<td>dateid</td>
							<td>market</td>
							<td>판매단가</td>

							<td>누적골든볼</td>
							<td>누적캐쉬</td>
							<td>횟수</td>
						</tr>

					<%
					while(result.next()){%>
						<%
							maxPage = result.getInt("maxPage");
							if(bFirst){
								sumDate = result.getInt("dateid");
								bFirst = false;
							}
							if(sumDate != result.getInt("dateid")){%>
								<tr><td colspan=7 align=right><%=String.format("%,d", loopSum)%></td></tr>
								<%
								loopSum = 0;
								loopPage = 1;
								sumDate = result.getInt("dateid");
							}

							total += result.getInt("cash");
							loopSum += result.getInt("cash");
						%>
						<tr>
							<td><%=result.getString("idx")%></td>
							<td>
								<%if(loopPage++ == 1){%>
									<a href=cashtotal_list.jsp?dateid=<%=result.getString("dateid")%>><%=result.getString("dateid")%></a>
								<%}%>
							</td>
							<td><%=getTel(result.getInt("market"))%></td>
							<td><%=result.getString("cashkind")%></td>
							<td><%=result.getString("cashcost")%></td>
							<td><%=String.format("%,d", result.getInt("cash"))%></td>
							<td><%=result.getString("cnt")%></td>
						</tr>
					<%}%>
					<tr><td colspan=7 align=right><%=String.format("%,d", loopSum)%></td></tr>
					<tr>
						<td colspan=7>총비용:<%=String.format("%,d", total)%></td>
					</tr>

					<%if(dateid.equals("")){%>
						<tr>
							<td colspan=9 align=center>
									<a href=cashtotal_list.jsp?idxPage=<%=(idxPage - 1 < 1)?1:(idxPage-1)%>><<</a>
									<%=idxPage%> / <%=maxPage%>
									<a href=cashtotal_list.jsp?idxPage=<%=(idxPage + 1 > maxPage)?maxPage:(idxPage + 1)%>>>></a>
							</td>
						</tr>
					<%}%>
				</table>

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
