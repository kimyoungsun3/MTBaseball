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

	String itemdesc[], itemdesc2[];
	String packs[] = new String[50];
	int itemcode[], gamecosts[], cashcosts[];
	int cnt = 0, pack = 0, gamecost = 0, cashcost = 0;
	int idx 					= util.getParamInt(request, "idx", -1);
	int packstate				= util.getParamInt(request, "packstate", 1);


	try{
		//2. 데이타 조작
		//exec spu_FVFarmD 30, 21, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 교배뽑기상품(아이템리스트, 템리스트).
		query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 21);
		cstmt.setInt(idxColumn++, packstate);
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
			cnt = result.getInt("cnt");
		}
		itemdesc = new String[cnt + 1];
		itemdesc2 = new String[cnt + 1];
		itemcode = new int[cnt + 1];
		gamecosts = new int[cnt + 1];
		cashcosts = new int[cnt + 1];

		int k = 1;
		itemdesc[0] = "없음";
		itemdesc2[0] = "없음";
		itemcode[0] = -1;
		gamecosts[0] = 0;
		cashcosts[0] = 0;

		if(cstmt.getMoreResults()){
			result = cstmt.getResultSet();
			while(result.next()){
				itemdesc[k] = result.getString("itemname") + "x" + result.getString("buyamount") + "개"
									+ "(" + result.getString("gamecost") + "gc, "
									+ result.getString("cashcost") + "cc"
									+ "[" + result.getString("itemcode") + "]"
									+ ")";
				itemdesc2[k] = result.getString("itemname") + "x" + result.getString("buyamount") + "개";
				gamecosts[k] = result.getInt("gamecost");
				cashcosts[k] = result.getInt("cashcost");
				itemcode[k] = result.getInt("itemcode");
				k++;
			}
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
	var ps3 = '1:' + f.pack1.value + ';'
		    + '2:' + f.pack2.value + ';'
		    + '3:' + f.pack3.value + ';'
		    + '4:' + f.pack4.value + ';'
		    + '5:' + f.pack5.value + ';'
		    + '6:' + f.pack6.value + ';'
		    + '7:' + f.pack7.value + ';'
		    + '8:' + f.pack8.value + ';'
		    + '9:' + f.pack9.value + ';'
		    + '10:' + f.pack10.value + ';'
		    + '11:' + f.pack11.value + ';'
		    + '12:' + f.pack12.value + ';'
		    + '13:' + f.pack13.value + ';'
		    + '14:' + f.pack14.value + ';'
		    + '15:' + f.pack15.value + ';'
		    + '16:' + f.pack16.value + ';'
		    + '17:' + f.pack17.value + ';'
		    + '18:' + f.pack18.value + ';'
		    + '19:' + f.pack19.value + ';'
		    + '20:' + f.pack20.value + ';'
		    + '21:' + f.pack21.value + ';'
		    + '22:' + f.pack22.value + ';'
		    + '23:' + f.pack23.value + ';'
		    + '24:' + f.pack24.value + ';'
		    + '25:' + f.pack25.value + ';'
		    + '26:' + f.pack26.value + ';'
		    + '27:' + f.pack27.value + ';'
		    + '28:' + f.pack28.value + ';'
		    + '29:' + f.pack29.value + ';'
		    + '30:' + f.pack30.value + ';'
		    + '31:' + f.pack31.value + ';'
		    + '32:' + f.pack32.value + ';'
		    + '33:' + f.pack33.value + ';'
		    + '34:' + f.pack34.value + ';'
		    + '35:' + f.pack35.value + ';'
		    + '36:' + f.pack36.value + ';'
		    + '37:' + f.pack37.value + ';'
		    + '38:' + f.pack38.value + ';'
		    + '39:' + f.pack39.value + ';'
		    + '40:' + f.pack40.value + ';'
		    + '41:' + f.pack41.value + ';'
		    + '42:' + f.pack42.value + ';'
		    + '43:' + f.pack43.value + ';'
		    + '44:' + f.pack44.value + ';'
		    + '45:' + f.pack45.value + ';'
		    + '46:' + f.pack46.value + ';'
		    + '47:' + f.pack47.value + ';'
		    + '48:' + f.pack48.value + ';'
		    + '49:' + f.pack49.value + ';'
		    + '50:' + f.pack50.value + ';'
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
				<!--
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="22">
					<input type="hidden" name="p3" value="-1">
					<input type="hidden" name="ps3" value="">
					<input type="hidden" name="branch" value="systemroul_list">
					<tr>
						<td>
							보물뽑기명:<input name="ps1" type="text" value="" size="30" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
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
							<table>
								<tr>
									<%for(int kk = 1; kk <= 40; kk++){%>
										<%=(kk%10==1)?"<td>":""%>
										<select name="pack<%=kk%>" >
											<%for(int i = 0; i < cnt; i++){%>
												<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
											<%}%>
										</select><br>
										<%=(kk%10==0)?"</td>":""%>
									<%}%>
								</tr>
							</table>
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
				-->
				<!--
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="24">
					<input type="hidden" name="branch" value="systemroul_list">
					<tr>
						<td>
							일괄 할인하기
								<select name="p7" >
									<%for(int kk = 0; kk <= 50; kk+=5){%>
										<option value="<%=kk%>"><%=kk%>%할인</option>
									<%}%>
								</select>
								<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>
				-->
				<table>
					<tr>
						<td>
							<font size=10>
								<a href=systemroul_list.jsp?packstate=-1>삭제보기</a>
								<a href=systemroul_list.jsp?packstate=1>정상보기</a>
							</font>
						</td>
					</tr>
					</form>
				</table>

				<table border=1>
					<tr>
						<td>idx</td>
						<td></td>
						<td>상품</td>
						<td><a href=systemroul_list.jsp?packstate=<%=packstate==1?-1:1%>><%=packstate==1?"삭제보기":"정상보기"%></a></td>
					</tr>
					<%if(cnt > 0){
						if(cstmt.getMoreResults()){
							result = cstmt.getResultSet();
							while(result.next()){
								if(result.getInt("packstate") != packstate)continue;%>
								<tr <%=getCheckValueOri(result.getInt("packstate"), -1, "bgcolor=#aaaaaa", "")%> <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> >
									<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
									<input type="hidden" name="branch" value="systemroul_list">
									<input name=idx type=hidden value=<%=result.getString("idx")%>>
									<input type="hidden" name="p1" value="30">
									<input type="hidden" name="p2" value="23">
									<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
									<input type="hidden" name="ps3" value="">
									<td>
										<%=result.getString("idx")%>
										<a name="<%=result.getString("idx")%>"></a>
									</td>
									<td>

										<input name="ps1" type="text" value="<%=result.getString("packname")%>" size="40" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
										(<%=result.getString("itemcode")%>)<br>
										허용동물 : <input name="p4" type="text" value="<%=result.getString("famelvmin")%>" size="1" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
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

										<input name="ps2" type="text" value="<%=result.getString("comment")%>" size="40" maxlength="50" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
										<!--<%=getDate(result.getString("writedate"))%>-->
									</td>
									<td>
										<table>
											<tr>
												<%for(int kk = 1; kk <= 50; kk++){
													if(kk%10==1)out.print("<td>");
													pack = result.getInt("pack" + kk);
													for(int i = 0; i < cnt; i++){
														if(pack == itemcode[i]){
															gamecost		+= gamecosts[i];
															cashcost 		+= cashcosts[i];
															packs[kk - 1] 	 = itemdesc2[i];
														}
														if(pack == itemcode[i]){
															out.print("<input type=hidden name=pack" + kk + " value=" +itemcode[i]+ ">");
															out.print(itemdesc[i] + "<br>");
															break;
														}
													}
													if(kk%10==0)out.print("</td>");
												}%>
											</tr>
											<tr>
												<%for(int kk = 1; kk <= 50; kk++){%>
													<%=(kk%10==1)?"<td>":""%>
													<img src=<%=imgroot%>/<%=result.getInt("pack" + (kk))%>.png>
													<%=(kk%10==0)?"</td>":""%>
												<%}%>
											</tr>
										</table>
									</td>
									<td style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
									</form>
								</tr>
							<%}
						}
					}%>
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
