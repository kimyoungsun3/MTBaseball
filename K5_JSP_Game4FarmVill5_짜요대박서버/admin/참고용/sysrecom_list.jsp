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
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;

	String market[] = {
			""+GOOGLE, 		"GOOGLE(" + GOOGLE + ")",
			""+SKT, 		"SKT(" + SKT + ")",
			""+NHN,			"NHN(" + NHN + ")",
			""+KT,			"KT(" + KT + ")",
			""+LGT,			"LGT(" + LGT + ")",
			""+IPHONE,		"IPHONE(" + IPHONE + ")"
	};

	String itemkind[] = {
			""+-1, 		"없음(" + -1 + ")",
			""+3100,	"코인(" + 3100 + ")",
			""+3015, 	"결정(" + 3015 + ")"

	};

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
	if(f_nul_chk(f.comment, '내용을 작성하세요.')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.comment.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
				<form name="GIFTFORM" method="post" action="syssetting_ok.jsp" onsubmit="return f_Submit(this);">
				<input type="hidden" name="p1" value="20">
				<input type="hidden" name="p2" value="10">
				<input type="hidden" name="branch" value="sysrecom_list">
					<tr>
						<td>
							[추천게임]
							<%for(int i = 0; i < market.length; i+=2){
								out.print(market[i+1] + " " );
							}%>
						</td>
					</tr>
					<tr>
						<td>
							판매처 :
							<input name="ps1" type="text" value="1,2,3,4,5,6,7" maxlength="40" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:100px;">

							상태 :
							<select name="p6" >
								<option value="-1">보류(-1)</option>
								<option value="1">서비스중(1)</option>
							</select>
							순서 : <input name="p7" type="text" value="1" maxlength="40" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:100px;">(높을수록 위에)
						</td>
					</tr>
					<tr>
						<td>
							상품 : <select name="p4" >
								<%for(int i = 0; i < itemkind.length; i+=2){%>
									<option value="<%=itemkind[i]%>"><%=itemkind[i+1]%></option>
								<%}%>
							</select>
							수량 : <input name="p5" type="text" value="0" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;"><br>
							추천 이미지		: <input name="ps2" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><a href=fileupload.jsp target=_blank>(파일올리기)</a><br>
							추천 URL		: <input name="ps3" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
							패키지이름		: <input name="ps4" type="text" value="" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
						</td>
					</tr>

					<tr>
						<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
					</form>
				</table>
				</div>
				<table border=1>
					<%
					//exec spu_FVFarmD2 20,12, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- 리스트
					//2. 데이타 조작
					query.append("{ call dbo.spu_FVFarmD2 (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, KIND_NOTICE_SETTING);
					cstmt.setInt(idxColumn++, 12);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
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
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					%>
					<%while(result.next()){%>
						<tr <%=getSysCheck(result.getInt("syscheck"))%>>
							<form name="GIFTFORM" method="post" action="syssetting_ok.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="p1" value="20">
							<input type="hidden" name="p2" value="11">
							<input type="hidden" name="p3" value="<%=result.getString("idx")%>">
	        				<input type="hidden" name="idx" value="<%=result.getString("idx")%>">
							<input type="hidden" name="branch" value="sysrecom_list">
							<td> <%=result.getString("idx")%> </td>
							<td <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> valign=top>
								<a name="<%=result.getString("idx")%>"></a>
								<input name="ps1" type="text" value="<%=result.getString("packmarket")%>" maxlength="40" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:100px;">
							</td>
							<td>
									<select name="p6">
										<option value="-1" <%=getSelect(result.getInt("syscheck"), -1)%>>보류(-1)</option>
										<option value="1" <%=getSelect(result.getInt("syscheck"), 1)%>>서비스중(1)</option>
									</select>

									상품 : <select name="p4" >
											<option value="<%=itemkind[0]%>" <%=getSelect(result.getInt("rewarditemcode"), -1)%>><%=itemkind[1]%></option>
											<option value="<%=itemkind[2]%>" <%=getSelect(result.getInt("rewarditemcode"), 3100)%>><%=itemkind[3]%></option>
											<option value="<%=itemkind[4]%>" <%=getSelect(result.getInt("rewarditemcode"), 3015)%>><%=itemkind[5]%></option>
									</select>
									수량 : <input name="p5" type="text" value="<%=result.getString("rewardcnt")%>" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">
									<br>


									추천 이미지		: <input name="ps2" type="text" value="<%=result.getString("comfile")%>" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
									추천 URL		: <input name="ps3" type="text" value="<%=result.getString("comurl")%>" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
									패키지이름		: <input name="ps4" type="text" value="<%=result.getString("compackname")%>" maxlength="1024" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:450px;"><br>
									<%=result.getString("comurl").equals("")?"":"<a href="+(result.getString("comurl") + " target=_blank>")%><img src="<%=result.getString("comfile")%>"></a><br><br>

							</td>
							<td>
								순서 : <input name="p7" type="text" value="<%=result.getString("ordering")%>" maxlength="4" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:50px;">
							</td>
							<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
	        				</form>
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
