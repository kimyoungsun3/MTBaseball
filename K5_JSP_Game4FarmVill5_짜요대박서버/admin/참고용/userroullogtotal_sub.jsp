<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>

<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;


	String dateid 				= util.getParamStr(request, "dateid", "");
	int view	 				= util.getParamInt(request, "view", 0);

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
<center><br>
<table>
	<tbody>
	<tr>
		<td align="center">
			<form name="GIFTFORM" method="post" action="useritembuylogtotal_sub.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=4>
							세부 내역아이템구매날자[<%=dateid%>]
							<a href=userroullogtotal_mas.jsp>(돌아가기)</a>
							<a href=userroullogtotal_sub.jsp?dateid=<%=dateid%>&view=1>(이미지보기)</a>
							<a href=userroullogtotal_sub.jsp?dateid=<%=dateid%>&view=0>(노이미지)</a>
						</td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 19, 412,-1, -1, -1, -1, -1, -1, -1, -1, '', '20131111', '', '', '', '', '', '', '', ''				-- 유저 뽑기월서브 통계
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 19);
					cstmt.setInt(idxColumn++, 412);
					cstmt.setInt(idxColumn++, -1);
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
					result = cstmt.executeQuery();%>
						<tr>
							<td>아이템</td>
							<td colspan=4>등급별뽑기(하트/유료)</td>
							<td colspan=4>무료뽑기</td>
							<td>룰렛(유료)</td>
							<td>룰렛(무료)</td>
							<td></td>
						</tr>
					<%while(result.next()){%>
						<tr>
							<td><%=result.getString("itemcodename")%>(<%=result.getString("itemcode")%>)</td>
							<td><%=result.getString("tsgrade1cnt")%></td>
							<td><%=result.getString("tsgrade2cnt")%></td>
							<td><%=result.getString("tsgrade3cnt")%></td>
							<td><%=result.getString("tsgrade4cnt")%></td>
							<td>0</td>
							<td><%=result.getString("tsgrade2freecnt")%></td>
							<td><%=result.getString("tsgrade3freecnt")%></td>
							<td><%=result.getString("tsgrade4freecnt")%></td>
							<td><%=result.getString("roulettecnt")%></td>
							<td><%=result.getString("roulettefreecnt")%></td>
							<td>
								<%if(view == 1){%>
									<img src=<%=imgroot%>/<%=result.getInt("itemcode")%>.png>
								<%}%>
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
