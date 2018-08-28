<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>

<%

	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer query2			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	StringBuffer resultMsg		= new StringBuffer();
	int	idxColumn 				= 1;

	String title 		= util.getParamStr(request, "title", "");
	int p1				= util.getParamInt(request, "p1", 0);
	int p2				= util.getParamInt(request, "p2", 0);
	int p3				= util.getParamInt(request, "p3", 0);
	int p4				= util.getParamInt(request, "p4", 5000);
	String ps1 			= util.getParamStr(request, "ps1", "");
	String ps2			= util.getParamStr(request, "ps2", "");
	String ps4			= util.getParamStr(request, "ps4", "");
	String ps5			= "" + format16.format(now);
	String gameid 		= util.getParamStr(request, "gameid", "");
	String branch 		= util.getParamStr(request, "branch", "userinfo_list");

	int nCash[] = {
					5000,
					10000,
					30000,
					55000,
					99000
					};


	try{
		//exec spu_FVFarmD 17, 4, 22, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''					-- 정보
		query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 17);
		cstmt.setInt(idxColumn++, 4);
		cstmt.setInt(idxColumn++, p3);
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

		if(result.next()){
			ps4 = getDate(result.getString("acode"));
			ps5 = getDate(result.getString("writedate"));
		}
%>
<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.comment, '내용을 작성하세요.')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.comment.focus();">
<table align=center>
	<tbody>
		<tr>
			<td align="center">
				<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type=hidden name=p1 value=<%=p1%>>
				<input type=hidden name=p2 value=<%=p2%>>
				<input type=hidden name=p3 value=<%=p3%>>
				<input type=hidden name=ps1 value=<%=ps1%>>
				<input type=hidden name=ps2 value=<%=ps2%>>
				<input type=hidden name=branch value="<%=branch%>">
				<input type=hidden name=gameid value="<%=gameid%>">
				<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
					<table>
						<tr>
							<td colspan=2>
								<%=title%> (공백사용음 금지합니다.)
							</td>
						</tr>
						<tr>
							<td>

								<select name="p4">
									<%for(int i = 0; i < nCash.length; i++){%>
										<option value="<%=nCash[i]%>" <%=getSelect(nCash[i], p4)%>><%=nCash[i]%></option>
									<%}%>
								</select><br>
								<input name="ps4" type="text" value="<%=ps4%>" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"><br>
								<input name="ps5" type="text" value="<%=ps5%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:400px;"><br>
							</td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</tr>
					</table>
				</div>
				</form>
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
