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
	String packs[] = new String[6];
	int itemcode[], gamecosts[], cashcosts[];
	int cnt = 0, pack = 0, gamecost = 0, cashcost = 0;
	int pack2, pack3, pack4;
	int idx 					= util.getParamInt(request, "idx", -1);
	int packstate				= util.getParamInt(request, "packstate", 1);
	boolean bFind				= false;


	try{
		//2. 데이타 조작
		//exec spu_GameMTBaseballD 30, 46, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
		query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 46);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, packstate);
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
									+ "(" + result.getString("gamecost") + " 코인, "
									+ result.getString("cashcost") + " 루비"
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
	var ps3 = '1:' + f.pack11.value + ':' + f.pack12.value + ':' + f.pack13.value + ':' + f.pack14.value + ';'
		    + '2:' + f.pack21.value + ':' + f.pack22.value + ':' + f.pack23.value + ':' + f.pack24.value + ';'
		    + '3:' + f.pack31.value + ':' + f.pack32.value + ':' + f.pack33.value + ':' + f.pack34.value + ';'
		    + '4:' + f.pack41.value + ':' + f.pack42.value + ':' + f.pack43.value + ':' + f.pack44.value + ';'
		    + '5:' + f.pack51.value + ':' + f.pack52.value + ':' + f.pack53.value + ':' + f.pack54.value + ';'
		    + '6:' + f.pack61.value + ':' + f.pack62.value + ':' + f.pack63.value + ':' + f.pack64.value + ';'
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
				<table border=1>
					<tr>
						<td>idx</td>
						<td>행운의 명치</td>
						<td>허용레벨</td>
						<td>상품(상품코드/주사위/루비/코인/상품내용)</td>
						<td>
							<a href=systemyabau_list.jsp?packstate=<%=packstate==1?-1:1%>><%=packstate==1?"삭제보기":"정상보기"%></a>
						</td>
					</tr>

					<%if(cnt > 0){
						if(cstmt.getMoreResults()){
							result = cstmt.getResultSet();
							while(result.next()){
								//if(result.getInt("packstate") != packstate)continue;
								%>
								<tr <%=getCheckValueOri(result.getInt("packstate"), -1, "bgcolor=#aaaaaa", "")%> <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> >
									<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
									<input type="hidden" name="branch" value="systemyabau_list">
									<input name=idx type=hidden value=<%=result.getString("idx")%>>
									<input type="hidden" name="p1" value="30">
									<input type="hidden" name="p2" value="47">
									<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
									<input type="hidden" name="p10" value="<%=packstate%>">
									<input type="hidden" name="ps3" value="">

									<td>
										<%=result.getString("idx")%>
										<a name="<%=result.getString("idx")%>"></a>
									</td>
									<td>
										<input name="ps1" type="text" value="<%=result.getString("packname")%>" size="16" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
										(<%=result.getString("itemcode")%>)<br>
										<input name="ps4" type="text" value="<%=result.getString("packmarket")%>" size="16" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									</td>
									<td>
										허용레벨 : <input name="p4" type="text" value="<%=result.getString("famelvmin")%>" size="1" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										~
										<input name="p5" type="text" value="<%=result.getString("famelvmax")%>" size="1" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
										<br>
										<input name="p7" type="text" value="<%=result.getString("saleper")%>" size="2" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">(%)
										<br>
										<select name="p8" >
											<option value="-1" <%=getSelect(result.getInt("packstate"), -1)%>>비활성(-1)</option>
											<option value="1" <%=getSelect(result.getInt("packstate"),  1)%>>활성(1)</option>
										</select>
										<br>
										<input name="ps2" type="text" value="<%=result.getString("comment")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									</td>
									<td>
										<%for(int kk = 1; kk <= 6; kk++){%>
											<input name="pack<%=kk%>1" type="text" value="<%=result.getInt("pack" + kk+"1")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
											<select name="pack<%=kk%>2" >
												<%for(int k2 = 1; k2 <= 12; k2++){%>
													<% pack2 = result.getInt("pack" + kk+"2");%>
													<option value="<%=k2%>" <%=getSelect(pack2, k2)%>><%=k2%></option>
												<%}%>
											</select>
											<input name="pack<%=kk%>3" type="text" value="<%=result.getInt("pack" + kk+"3")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
											<input name="pack<%=kk%>4" type="text" value="<%=result.getInt("pack" + kk+"4")%>" size="7" maxlength="7" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
											<%pack = result.getInt("pack" + kk+"1");
											bFind = false;
											for(int i = 0; i < cnt; i++){
												if(pack == itemcode[i]){
													gamecost += gamecosts[i];
													cashcost += cashcosts[i];
													packs[kk - 1] = itemdesc2[i];
												}
												if(pack == itemcode[i]){
													out.print(itemdesc[i]);
													bFind = true;
												}
											}
											if(!bFind){
												out.print("<font color=red>System Error(itemcode is not found)</font>");
											}
											%>
											<br>
										<%}%>
									</td>
										<%for(int kk = 1; kk <= 6; kk++){%>
											<td><img src=<%=imgroot%>/<%=result.getInt("pack" + (kk) + "1")%>.png></td>
										<%}%>
									<td style="padding-left:5px;">
										<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"><br>
									</td>
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
