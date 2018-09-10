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


	try{
		//2. 데이타 조작
		//exec spu_GameMTBaseballD 30, 70, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
		query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 70);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
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

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	var ps3 = '1:' + f.pack1.value + ';'
		    + '2:' + f.pack2.value + ';'
		    + '3:' + f.pack3.value + ';'
		    + '4:' + f.pack4.value + ';'
		    + '5:' + f.pack5.value + ';'
		    + '6:' + f.pack6.value + ';'
		    + '7:' + f.pack7.value + ';'
		    + '8:' + f.pack8.value + ';'
		    + '9:' + f.pack9.value + ';'
	f.ps3.value = ps3;

	return true;
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
				낙농포인트 = 캐쉬포인트  (1원당 1포인트)
				<table border=1>
					<tr>
						<td>idx</td>
						<td>vip_grade</td>
						<td>vip_cashpoint</td>
						<td>vip_cashplus</td>
						<td>vip_gamecost</td>
						<td>vip_heart</td>
						<td>vip_animal10</td>
						<td>vip_wheel10</td>
						<td>vip_treasure10</td>
						<td>vip_box</td>
						<td>vip_fbplus</td>
					</tr>
					<%while(result.next()){%>
					<tr <%= (result.getInt("idx") % 2 == 0) ? "bgcolor=#aaffaa":""%>>
						<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
						<input type="hidden" name="branch" value="systemvip_list">
						<input type="hidden" name="p1" value="30">
						<input type="hidden" name="p2" value="71">
						<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
						<input type="hidden" name="ps3" value="">

						<td><%=result.getString("idx")%></td>

						<td><%=result.getString("vip_grade")%></td>
						<td><%=result.getString("vip_cashpoint")%></td>
						<td><%=result.getString("vip_cashplus")%></td>
						<td><%=result.getString("vip_gamecost")%></td>
						<td><%=result.getString("vip_heart")%></td>
						<td><%=result.getString("vip_animal10")%></td>
						<td><%=result.getString("vip_wheel10")%></td>
						<td><%=result.getString("vip_treasure10")%></td>
						<td><%=result.getString("vip_box")%></td>
						<td><%=result.getString("vip_fbplus")%></td>
						<!--<td style="padding-left:5px;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"><br>
						</td>-->
						</form>
					</tr>
					<%}%>
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
