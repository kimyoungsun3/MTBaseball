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
		//exec spu_FarmD 30, 21, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 교배뽑기상품(아이템리스트, 템리스트).
		query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
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
					<tr>
						<td>
							할인은 마스터에서 관리합니다.


								<font size=10>
									<a href=systemroul_list.jsp?packstate=-1>삭제보기</a>
									<a href=systemroul_list.jsp?packstate=1>정상보기</a>
								</font>
						</td>
					</tr>
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
									<td>
										<%=result.getString("idx")%>
										<a name="<%=result.getString("idx")%>"></a>
									</td>
									<td>

										<input name="ps1" type="text" value="<%=result.getString("packname")%>" size="40" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
										(<%=result.getString("itemcode")%>)<br>
										허용렙 : <input name="p4" type="text" value="<%=result.getString("famelvmin")%>" size="1" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										~
										<input name="p5" type="text" value="<%=result.getString("famelvmax")%>" size="1" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										<br>
										<!--
										<img src=item/cc.png><input name="p6" type="text" value="<%=result.getString("cashcostcost")%>" size="3" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										->
										<input name="p7" type="text" value="<%=result.getString("cashcostper")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">(%)
										-> 판매 <%=result.getString("cashcostsale")%>
										<br>
										<img src=item/gc.png><input name="p9" type="text" value="<%=result.getString("gamecost")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										<img src=item/ht.png><input name="p10" type="text" value="<%=result.getString("heart")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										<br>
										-->

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
											<tr bgcolor=#999999>
												<td>1번그룹</td>
												<td>2번그룹</td>
												<td>3번그룹</td>
												<td>4번그룹</td>
												<td>5번그룹</td>
											</tr>
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
