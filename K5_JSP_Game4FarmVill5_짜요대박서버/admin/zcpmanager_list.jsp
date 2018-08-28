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


	int viewkind		= util.getParamInt(request, "viewkind", -1);
	int idx				= util.getParamInt(request, "idx", -1);
	int view	 		= util.getParamInt(request, "view", 0);
	int param			= -1;
	int param2			= -1;
	String strParam		= "";
	String kind[] = {
			"1", 	"Best(1)",
			"2", 	"일반(2)",
			"3", 	"월별한정(3)",
			"4", 	"날씬한끼(4)",
			"5", 	"든든한끼(5)",
			"6", 	"기타(6)"
	};

	String bestmark[] = {
			"1", 	"Best마크(1)",
			"-1", 	"마크없음(-1)"
	};

	String newmark[] = {
			"1", 	"New마크(1)",
			"-1", 	"마크없음(-1)"
	};

	String zcpflag[] = {
			"-1", 	"비활성(-1)",
			"1", 	"활성(1)"
	};

	try{
		//2. 데이타 조작
		//exec spu_FarmD 30, 80, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
		query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 80);
		cstmt.setInt(idxColumn++, viewkind);
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

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	var ps9 = '1:' + f.d1.value + ';'
		    + '2:' + f.d2.value + ';'
		    + '3:' + f.d3.value + ';'
		    + '4:' + f.d4.value + ';'
		    + '5:' + f.d5.value + ';'
		    + '6:' + f.d6.value + ';'
		    + '7:' + f.d7.value + ';'
	f.ps9.value = ps9;

	if(f_nul_chk(f.itemcode, '아이디를')) return false;
	else return true;
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


				<a href=zcpmanager_list.jsp?view=0>전체보기</a>
				<%for(int i = 0; i < kind.length; i+=2){%>
					&nbsp;&nbsp;&nbsp;<a href=zcpmanager_list.jsp?viewkind=<%=kind[i]%>><%=kind[i+1]%></a>
				<%}%>
				&nbsp;&nbsp;&nbsp;<a href=zcpmanager_list.jsp?view=1>입력보기</a>
				<%if(view == 1){%>
				<table>
					<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
					<input type="hidden" name="p1" value="30">
					<input type="hidden" name="p2" value="81">
					<input type="hidden" name="p3" value="-1">
					<input type="hidden" name="ps9" value="">
					<input type="hidden" name="branch" value="zcpmanager_list">
					<tr>
						<td>타이틀</td>
						<td>
							<input name="ps1" type="text" value="" size="30" maxlength="30" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>상품이미지</td>
						<td>
							<input name="ps2" type="text" value="" size="50" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>상품점프URL</td>
						<td>
							<input name="ps3" type="text" value="" size="50" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>간략설명</td>
						<td>
							<input name="ps4" type="text" value="" size="50" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>상세설명</td>
						<td>
							<input name="ps5" type="text" value="" size="50" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>기간</td>
						<td>
							<input name="ps5" type="text" value="2014-01-01" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
							~
							<input name="ps6" type="text" value="2024-01-01 23:59" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>종류</td>
						<td>
							<select name="d1" >
								<%for(int i = 0; i < kind.length; i+=2){%>
									<option value="<%=kind[i]%>"><%=kind[i+1]%></option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>Best마크</td>
						<td>
							<select name="d2" >
								<%for(int i = 0; i < bestmark.length; i+=2){%>
									<option value="<%=bestmark[i]%>"><%=bestmark[i+1]%></option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>New마크</td>
						<td>
							<select name="d3" >
								<%for(int i = 0; i < newmark.length; i+=2){%>
									<option value="<%=newmark[i]%>"><%=newmark[i+1]%></option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>짜요쿠폰수량</td>
						<td>
							<input name="d4" type="text" value="15" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>입고수량</td>
						<td>
							<input name="d5" type="text" value="15" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>활성여부</td>
						<td>
							<select name="d6" >
								<%for(int i = 0; i < zcpflag.length; i+=2){%>
									<option value="<%=zcpflag[i]%>"><%=zcpflag[i+1]%></option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>정렬순위</td>
						<td>
							<input name="d7" type="text" value="15" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
						</td>
					</tr>
					<tr>
						<td>
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
						</td>
					</tr>
					</form>
				</table>
				<%}%>
				<table border=1>
					<tr>
						<td colspan=13>
							<font color=red>
							원칙1. <br>
							원칙2. <br>
							원칙3. <br>
							</font>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<%while(result.next()){%>
						<tr <%=getCheckValueOri(result.getInt("idx"), idx, "bgcolor=#ffe020", "")%> <%=getCheckValueOri(result.getInt("zcpflag"), -1, "bgcolor=#aaaaaa", "")%> >
								<form name="GIFTFORM<%=result.getString("idx")%>" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
								<input type="hidden" name="p1" value="30">
								<input type="hidden" name="p2" value="82">
								<input type="hidden" name="p3" value="<%=result.getInt("idx")%>">
								<input type="hidden" name="ps9" value="">
								<input name=idx type=hidden value=<%=result.getString("idx")%>>
								<input type="hidden" name="branch" value="zcpmanager_list">
								<td>
									<a href=zcpmanager_list.jsp?idx=<%=result.getString("idx")%>><%=result.getString("idx")%></a>
									<a name="<%=result.getString("idx")%>"></a>
								</td>
								<td >
									종류 : <select name="d1" >
										<%
										for(int i = 0; i < kind.length; i+=2){
											param 	= parseStringToInt(kind[i]);
											strParam= kind[i+1];
											param2 	= result.getInt("kind");
											%>
											<option value="<%=param%>" <%=getSelect(param, param2)%>><%=strParam%></option>
										<%}%>
									</select><br>

									<input name="ps1" type="text" value="<%=result.getString("title")%>" size="20" maxlength="30" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br><br>


									<select name="d2" >
										<%for(int i = 0; i < bestmark.length; i+=2){
											param 	= parseStringToInt(bestmark[i]);
											strParam= bestmark[i+1];
											param2 	= result.getInt("bestmark");%>
											<option value="<%=param%>" <%=getSelect(param, param2)%>><%=strParam%></option>
										<%}%>
									</select><br>

									<select name="d3" >
										<%for(int i = 0; i < newmark.length; i+=2){
											param 	= parseStringToInt(newmark[i]);
											strParam= newmark[i+1];
											param2 	= result.getInt("newmark");%>
											<option value="<%=param%>" <%=getSelect(param, param2)%>><%=strParam%></option>
										<%}%>
									</select><br><br>

									필요짜요쿠폰 : <input name="d4" type="text" value="<%=result.getInt("needcnt")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									사용량 :
									<a href=usersetting_ok.jsp?p1=30&p2=83&p3=<%=result.getString("idx")%>&branch=zcpmanager_list>
										<%=result.getInt("balancecnt")%>회 구매
									</a><br>
									입고량 : <input name="d5" type="text" value="<%=result.getInt("firstcnt")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>

									기간 : <input name="ps6" type="text" value="<%=getDate16(result.getString("opendate"))%>" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									~
									<input name="ps7" type="text" value="<%=getDate16(result.getString("expiredate"))%>" size="16" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>



								</td>
								<td>
									<input name="ps2" type="text" value="<%=result.getString("zcpfile")%>" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<input name="ps3" type="text" value="<%=result.getString("zcpurl")%>" size="60" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<img src="<%=result.getString("zcpfile")%>"><br>
									<a href=fileupload.jsp target=_blank>(파일올리기)</a>
								</td>
								<td>

								</td>
								<td>
									<input name="ps4" type="text" value="<%=result.getString("commentsimple")%>" size="50" maxlength="256" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"><br>
									<textarea name="ps5" rows="10" cols="50" style="border:solid 1px black; font-family:tahoma; background-color:lightsteelblue;"><%=result.getString("commentdesc")%></textarea>
								</td>
								<td>
									<select name="d6" >
										<%for(int i = 0; i < zcpflag.length; i+=2){
											param 	= parseStringToInt(zcpflag[i]);
											strParam= zcpflag[i+1];
											param2 	= result.getInt("zcpflag");%>
											<option value="<%=param%>" <%=getSelect(param, param2)%>><%=strParam%></option>
										<%}%>
									</select>
								</td>
								<td>
									<input name="d7" type="text" value="<%=result.getInt("zcporder")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;">
								</td>
								<td>
									<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
								</td>
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
