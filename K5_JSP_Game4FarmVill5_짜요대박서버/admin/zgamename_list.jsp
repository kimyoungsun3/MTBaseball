<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_checkfun.jsp"%>


<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;

	int num 					= 1;
	int idx 					= util.getParamInt(request, "idx", -1);
%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	return true;
}
function f_Submit2(f) {
	f.ps2.value = getCookie("JSESSIONID");
	//alert(getCookie("JSESSIONID"));
	return true;
}

function getCookie (Name){
	var search = Name + "="
	if (document.cookie.length > 0){
		offset = document.cookie.indexOf(search)
		if (offset != -1){
			offset += search.length
			end = document.cookie.indexOf(";", offset)
			if (end == -1)
    			end = document.cookie.length
		return (document.cookie.substring(offset, end))
	}else
		return ("");
	}else
		return ("");
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>


<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table align=center>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<form name="GIFTFORM" method="post" action="zsetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="1">
					<input type="hidden" name="p2" value="1">
					<input type="hidden" name="branch" value="zgamename_list">
					<tr>
						<td>
							1. 목장이름입력해주삼(한글 10까지만 해주삼)<br>
							목장명:<input name="ps1" type="text" value="" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>


				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmZ 1,  4, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''					-- 리스트.
					query.append("{ call dbo.spu_FarmZ (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++,  1);
					cstmt.setInt(idxColumn++,  4);
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
					<tr>
						<td>순서</td>
						<td>목장명</td>
						<td>점수</td>
						<td></td>
					</tr>


					<%while(result.next()){%>
						<tr <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> >
							<form name="GIFTFORM2" method="post" action="zsetting_ok.jsp" onsubmit="return f_Submit2(this);">
							<input type="hidden" name="branch" value="zgamename_list">
							<input name=idx type=hidden value=<%=result.getInt("idx")%>>
							<input type="hidden" name="p1" value="1">
							<input type="hidden" name="p2" value="3">
							<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
							<input type="hidden" name="ps2" value="">

							<td>
								<%=num++%>
								<a name="<%=result.getString("idx")%>"></a>
							</td>
							<td>
								<%=result.getString("gamename")%>
								<!--<input name="ps1" type="text" value="<%=result.getString("gamename")%>" size="40" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">-->
							</td>
							<td>
								<%=result.getString("cnt")%>
							</td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
							</form>
						</tr>
					<%}%>
				</table>
			</div>
		</td>
	</tr>

</tbody></table>


<%
    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
