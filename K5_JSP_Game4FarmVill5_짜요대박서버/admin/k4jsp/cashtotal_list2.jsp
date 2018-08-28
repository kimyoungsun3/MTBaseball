<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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

	int total 					= 0;
	int market					= -1;
	int cash					= 0;
	String dateid 				= util.getParamStr(request, "dateid", "");
	String dateid2 				= "" + format6.format(now);
	String listDate[]			= new String[31];
	int listSKT[]				= new int[31];
	int listGOOGLE[]			= new int[31];
	int listIPHONE[]			= new int[31];
	int listNHN[]				= new int[31];
	int listLGT[]				= new int[31];
	int listKT[]				= new int[31];
	int listDateTotal[]			= new int[31];
	int len						= listSKT.length;
	for(int i = 0; i < len; i++){
		listDate[i]		= null;
		listSKT[i]		= 0;
		listGOOGLE[i]	= 0;
		listIPHONE[i]	= 0;
		listNHN[i]		= 0;
		listLGT[i]		= 0;
		listKT[i]		= 0;
		listDateTotal[i]= 0;
	}

	if(dateid.equals("")){
		dateid = dateid2;
	}


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
	if(f_nul_chk(f.dateid, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.dateid.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<a href=cashtotal_list2.jsp><img src=images/refresh2.png alt="화면갱신"></a>
			<form name="GIFTFORM" method="post" action="cashtotal_list2.jsp" onsubmit="return f_Submit(this);">
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<td colspan=3>
							월별 캐쉬 구매(일자별 구매내역별 정렬)<br>
							(* iPhone 구매는 달러이면 계산 편의상 원으로 환산된것입니다.)
						</td>
					</tr>
					<tr>
						<td> 검색</td>
						<td><input name="dateid" type="text" value="<%=dateid%>" maxlength="6" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
						<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
					</tr>
				</table>
			</div>
			</form>
				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 21, 13,-1, -1, -1, -1, -1, -1, -1, -1, '', '201404', '', '', '', '', '', '', '', ''				--
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 21);
					cstmt.setInt(idxColumn++, 13);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, dateid);
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
							<td>요일</td>
							<td>SKT</td>
							<td>Google</td>
							<td>iPhone</td>
							<td>nhn</td>
							<td>lgt</td>
							<td>kt</td>
							<td>일매출</td>
						</tr>
					<%
					boolean _bFind;
					while(result.next()){
						dateid 	= result.getString("dateid");
						market 	= result.getInt("market");
						cash	= result.getInt("cash");
						total 	+= cash;
						_bFind = false;
						for(int i = 0; i < len; i++){
							if(listDate[i] == null){
								listDate[i] 	= dateid;
								_bFind = true;
							}else if(dateid.equals(listDate[i])){
								_bFind 			= true;
							}

							if(_bFind){
								listSKT[i] 		+= (market==SKT)?cash:0;
								listGOOGLE[i] 	+= (market==GOOGLE)?cash:0;
								listIPHONE[i] 	+= (market==IPHONE)?cash:0;
								listNHN[i] 		+= (market==NHN)?cash:0;
								listLGT[i] 		+= (market==LGT)?cash:0;
								listKT[i] 		+= (market==KT)?cash:0;
								listDateTotal[i]+=cash;
								break;
							}
						}
					}%>
					<%for(int i = 0; i < len; i++){
						if(listDate[i] == null)break;
						%>
						<tr>
							<td width=100p><%=listDate[i]%></td>
							<td width=100p><%=String.format("%,d", listSKT[i])%></td>
							<td width=100p><%=String.format("%,d", listGOOGLE[i])%></td>
							<td width=100p><%=String.format("%,d", listIPHONE[i])%></td>
							<td width=100p><%=String.format("%,d", listNHN[i])%></td>
							<td width=100p><%=String.format("%,d", listLGT[i])%></td>
							<td width=100p><%=String.format("%,d", listKT[i])%></td>
							<td width=100p><%=String.format("%,d", listDateTotal[i])%></td>
						</tr>
					<%}%>
					<tr>
						<td colspan=8 >총비용:<%=String.format("%,d", total)%></td>
					</tr>

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
