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
	String packs[] = new String[5];
	int itemcode[], gamecosts[], cashcosts[];
	int cnt = 0, pack = 0, gamecost = 0, cashcost = 0;
	int eventidx				= util.getParamInt(request, "idx", -1);
	int packstate				= util.getParamInt(request, "packstate", 1);
	String dd 					= "" + formatdd.format(now);
	int dday					= -1;
	String bgcolor				= "";


	try{
		dday = Integer.parseInt(dd);

		//2. 데이타 조작
		//exec spu_FarmD 30, 50, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''		-- 시간제 이벤트 정보.
		query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 50);
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
					<input type="hidden" name="p2" value="52">
					<input type="hidden" name="p3" value="1">
					<input type="hidden" name="p4" value="-1">
					<input type="hidden" name="branch" value="eventdaily_list">
					<tr>
						<td>선물아이템</td>
						<td>
							<select name="p5" >
								<%for(int i = 0; i < cnt; i++){%>
									<option value="<%=itemcode[i]%>"><%=itemdesc[i]%></option>
								<%}%>
							</select>
							<input name="p7" type="text" value="0" size="3" maxlength="3" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>상태</td>
						<td>
							<select name="p6" >
								<option value="0">비활성(0)</option>
								<option value="1">활성(1)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>선물자</td>
						<td>
							<input name="ps3" type="text" value="짜요 소녀" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>날짜</td>
						<td>
							<font color=blue>
								2014-05-24 12:00 ~ 2014-05-24 17:59 (형식2) > 24일 12시 ~ 17(17:59)까지<br>
								2014-05-24 18:00 ~ 2014-05-24 23:59 (형식2) > 24일 18시 ~ 23(23:59)까지
							</font><br>

							<select name="ps4" >
								<%for(int i = 1; i <= 31; i++){%>
									<option value="<%=i%>"><%=i%>일</option>
								<%}%>
							</select>일

							<select name="ps5" >
								<%for(int i = 0; i <= 23; i++){%>
									<option value="<%=i%>"><%=i%>시</option>
								<%}%>
							</select>:00
							~
							<select name="ps6" >
								<%for(int i = 0; i <= 23; i++){%>
									<option value="<%=i%>"><%=i%>시</option>
								<%}%>
							</select>:59
						</td>
					</tr>
					<tr>
						<td>푸쉬제목</td>
						<td>
							<input name="ps9" type="text" value="푸쉬제목" size="128" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>푸쉬내용</td>
						<td>
							<input name="ps10" type="text" value="푸쉬내용" size="128" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
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
					<%if(cstmt.getMoreResults()){
						result = cstmt.getResultSet();
						while(result.next()){%>
							<tr>
								<td>전체 진행상태</td>
								<td>
									<font color=blue>
										<a href=usersetting_ok.jsp?p1=30&p2=51&branch=eventdaily_list>
											<%=getEventStateMaster(result.getInt("eventstatemaster"))%>
										</a>
									</font>
								</td>
							</tr>
						<%}
					}%>

					<%if(cstmt.getMoreResults()){
						result = cstmt.getResultSet();
						while(result.next()){
							bgcolor = "";
							if( dday == result.getInt("eventday") ){
								bgcolor = "bgcolor=#aae020";
							}
							%>
						<tr <%=getCheckValueOri(result.getInt("eventstatedaily"), 0, "bgcolor=#aaaaaa", "")%> <%=getCheckValueOri(result.getInt("eventidx"), eventidx, "bgcolor=#ffe020", "")%> <%=bgcolor%>>
								<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
								<input type="hidden" name="branch" value="eventdaily_list">
								<input name=idx type=hidden value=<%=result.getString("eventidx")%>>
								<input type="hidden" name="p1" value="30">
								<input type="hidden" name="p2" value="52">
								<input type="hidden" name="p3" value="2">
								<input type="hidden" name="p4" value="<%=result.getInt("eventidx")%>">
								<input type="hidden" name="branch" value="eventdaily_list">

								<td>
									<%=result.getString("eventidx")%>
									<a name="<%=result.getString("eventidx")%>"></a>
								</td>
								<td>
									<select name="p6" >
										<option value="0" <%=getSelect(result.getInt("eventstatedaily"), 0)%>>비활성(0)</option>
										<option value="1" <%=getSelect(result.getInt("eventstatedaily"), 1)%>>  활성(1)</option>
									</select>
								</td>
								<td>
									<input name="p5" type="text" value="<%=result.getInt("eventitemcode")%>" size="5" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"> x
									<input name="p7" type="text" value="<%=result.getInt("eventcnt")%>" size="3" maxlength="5" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">개<br>
									<%=result.getString("itemname")%>
									<img src=<%=imgroot%>/<%=result.getInt("eventitemcode")%>.png>
								</td>
								<td>
									<input name="ps3" type="text" value="<%=result.getString("eventsender")%>" size="20" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
								</td>
								<td>
									<input name="ps4" type="text" value="<%=result.getString("eventday")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">일
									<input name="ps5" type="text" value="<%=result.getString("eventstarthour")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">시
									~
									<input name="ps6" type="text" value="<%=result.getString("eventendhour")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">:59
								</td>
								<td>
									<input name="ps9" type="text" value="<%=result.getString("eventpushtitle")%>" size="60" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps10" type="text" value="<%=result.getString("eventpushmsg")%>" size="60" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
								</td>
								<td>
									<a href=usersetting_ok.jsp?p1=30&p2=52&p3=3&p4=<%=result.getString("eventidx")%>&branch=eventdaily_list>이벤트:<%=getEventState(result.getInt("eventstatedaily"))%></a><br>
									<a href=usersetting_ok.jsp?p1=30&p2=52&p3=4&p4=<%=result.getString("eventidx")%>&branch=eventdaily_list>푸쉬:<%=getEventPush(result.getInt("eventpushstate"))%></a><br>
									<a href=push_list.jsp target=_blank>푸쉬발송</a><br>
									<a href=usersetting_ok.jsp?p1=30&p2=52&p3=5&p4=<%=result.getString("eventidx")%>&branch=eventdaily_list>삭제(한명이 받으면 삭제불가)</a>
								</td>
								<td>
									<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
								</td>
								</form>
							</tr>
						<%}
				}%>
				</table>
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
