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
	var ps3 = '1:' + f.groupstep1.value + ';'
		    + '2:' + f.groupstep2.value + ';'
		    + '3:' + f.groupstep3.value + ';'
		    + '4:' + f.groupstep4.value + ';'
		    + '5:' + f.groupstep5.value + ';'
		    + '6:' + f.groupstep6.value + ';'
		    + '7:' + f.groupstep7.value + ';'
		    + '8:' + f.groupstep8.value + ';'
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
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="42">
					<input type="hidden" name="p3" value="-1">
					<input type="hidden" name="ps3" value="">
					<input type="hidden" name="branch" value="systemroulfresh_list">
					<tr>
						<td>
							교배뽑기명:<input name="ps1" type="text" value="" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							(* 600xx대역에 신규 아이템이 추가됩니다.)
						</td>
					</tr>
					<tr>
						<td>
							허용레벨:
							<input name="p4" type="text" value="1" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="p5" type="text" value="50" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>
							G1:
							<input name="groupstep1" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="groupstep2" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

							G2:
							<input name="groupstep3" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="groupstep4" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

							G3:
							<input name="groupstep5" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="groupstep6" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

							G4:
							<input name="groupstep7" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="groupstep8" type="text" value="" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>
							프리미엄뽑기
							<img src=item/cc.png><input name="p6" type="text" value="30" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							할인:<input name="p7" type="text" value="0" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">(%)


							일반뽑기
							<img src=item/gc.png> <input name="p9" type="text" value="3000" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							<img src=item/ht.png> <input name="p10" type="text" value="300" size="4" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>
							<select name="p8" >
								<option value="-1">비활성(-1)</option>
								<option value="1" >활성(1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							코멘트:<input name="ps2" type="text" value="" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>


				<table border=1>
					<tr>
						<td>idx</td>
						<td>교배뽑기명</td>
						<td></td>
						<td>상품</td>
						<td></td>
						<td></td>
					</tr>
					<%
						//2. 데이타 조작
						//exec spu_FarmD 30, 41, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 교배뽑기상품(아이템리스트, 템리스트).
						query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
						cstmt = conn.prepareCall(query.toString());
						cstmt.setInt(idxColumn++, 30);
						cstmt.setInt(idxColumn++, 41);
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
						while(result.next()){%>
							<tr <%=getCheckValueOri(result.getInt("packstate"), -1, "bgcolor=#aaaaaa", "")%> <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> >
								<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
								<input type="hidden" name="branch" value="systemroulfresh_list">
								<input name=idx type=hidden value=<%=result.getString("idx")%>>
								<input type="hidden" name="p1" value="30">
								<input type="hidden" name="p2" value="43">
								<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
								<input type="hidden" name="ps3" value="">
								<td>
									<%=result.getString("idx")%>
									<a name="<%=result.getString("idx")%>"></a>
								</td>
								<td>
									<input name="ps1" type="text" value="<%=result.getString("packname")%>" size="16" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									<br>(<%=result.getString("itemcode")%>)
								</td>
								<td>
									허용렙 : <input name="p4" type="text" value="<%=result.getString("famelvmin")%>" size="1" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									~
									<input name="p5" type="text" value="<%=result.getString("famelvmax")%>" size="1" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									<br>

									<img src=item/cc.png><input name="p6" type="text" value="<%=result.getString("cashcostcost")%>" size="3" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									->
									<input name="p7" type="text" value="<%=result.getString("cashcostper")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">(%)
									-> 판매 <%=result.getString("cashcostsale")%>
									<br>

									<img src=item/gc.png><input name="p9" type="text" value="<%=result.getString("gamecost")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									<img src=item/ht.png><input name="p10" type="text" value="<%=result.getString("heart")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
									<br>

									<select name="p8" >
										<option value="-1" <%=getSelect(result.getInt("packstate"), -1)%>>비활성(-1)</option>
										<option value="1" <%=getSelect(result.getInt("packstate"),  1)%>>활성(1)</option>
									</select>
									<br>

									<input name="ps2" type="text" value="<%=result.getString("comment")%>" size="50" maxlength="50" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<!--<%=getDate(result.getString("writedate"))%>-->
								</td>
								<td>
									<table>
										<tr>
											G1:
											<input name="groupstep1" type="text" value="<%=result.getString("groupstep1")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
											~
											<input name="groupstep2" type="text" value="<%=result.getString("groupstep2")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

											G2:
											<input name="groupstep3" type="text" value="<%=result.getString("groupstep3")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
											~
											<input name="groupstep4" type="text" value="<%=result.getString("groupstep4")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

											G3:
											<input name="groupstep5" type="text" value="<%=result.getString("groupstep5")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
											~
											<input name="groupstep6" type="text" value="<%=result.getString("groupstep6")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

											G4:
											<input name="groupstep7" type="text" value="<%=result.getString("groupstep7")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
											~
											<input name="groupstep8" type="text" value="<%=result.getString("groupstep8")%>" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">

										</tr>
									</table>
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

  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
%>
