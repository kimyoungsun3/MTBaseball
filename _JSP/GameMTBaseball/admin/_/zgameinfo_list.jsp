<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>
<%@include file="zconstant.jsp"%>


<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;


	int idx 					= util.getParamInt(request, "idx", -1);

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
			<br><br>
			<a href=zgamemonth_list.jsp>통계입력</a>

			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<form name="GIFTFORM" method="post" action="zsetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="1">
					<input type="hidden" name="p2" value="11">
					<input type="hidden" name="branch" value="zgameinfo_list">
					<tr>
						<td>
							게임명:<input name="ps1" type="text" value="" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							회사명:<input name="ps2" type="text" value="" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							코멘트:<input name="ps3" type="text" value="" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

							오더링:<input name="p4" type="text" value="99" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<select name="p5" >
								<%for(int i = 0; i < visibleValue.length; i++){%>
									<option value="<%=visibleValue[i]%>"><%=visibleStr[i]%></option>
								<%}%>
							</select>

							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>


				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmZ 1, 14, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''								-- 리스트.
					query.append("{ call dbo.spu_FarmZ (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++,  1);
					cstmt.setInt(idxColumn++,  14);
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
						<td>코드</td>
						<td>게임이름</td>
						<td>회사명</td>
						<td>간략설명</td>
						<td>오더링</td>
						<td>활성화</td>
						<td></td>
					</tr>


					<%while(result.next()){%>
						<tr <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> >
							<form name="GIFTFORM" method="post" action="zsetting_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="branch" value="zgameinfo_list">
							<input name=idx type=hidden value=<%=result.getInt("idx")%>>
							<input type="hidden" name="p1" value="1">
							<input type="hidden" name="p2" value="12">
							<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">

							<td>
								<%=result.getString("gamecode")%>
								<a name="<%=result.getString("idx")%>"></a>
							</td>
							<td>
								<input name="ps1" type="text" value="<%=result.getString("gamename")%>" size="40" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							</td>
							<td>
								<input name="ps2" type="text" value="<%=result.getString("company")%>" size="40" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							</td>
							<td>
								<input name="ps3" type="text" value="<%=result.getString("comment")%>" size="40" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							</td>
							<td>
								<input name="p4" type="text" value="<%=result.getString("ordering")%>" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
							<td>
							<select name="p5" >
								<%for(int i = 0; i < visibleValue.length; i++){%>
									<option value="<%=visibleValue[i]%>" <%=getSelect(result.getInt("visible"), visibleValue[i])%>><%=visibleStr[i]%></option>
								<%}%>
							</select><br>

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

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
