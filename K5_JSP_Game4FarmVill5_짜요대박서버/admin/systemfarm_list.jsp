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

	int itemcode 					= util.getParamInt(request, "idx", -1);
	int packstate				= util.getParamInt(request, "packstate", 1);
	boolean bFind				= false;

	int len, param, enemycnt, stagecnt;
	String limitaniStr[]= {	"없음(0)",		"소(4)", "양(2)", "산양(1)",		"소,양(6)", "소,산양(5)", "양,산양(3)",	"소,양,산양(7)"	};
	int limitaniInt[] 	= {			0,            4,       2,         1,                 6,            5,            3,             7	};

	String enemybossStr[]= { "없음(0)", "보스Att(1)", "보스Def(2)", "보스Turn(4)", "보스at(13)", "보스dt(15)", "보스AD(11)", "보스adt(22)", "보스HP(3)", "보스ah(12)", "보스dh(14)", "보스ht(16)", "보스aht(23)", "보스adh(21)", "보스dht(24)", "보스adht(31)"};
	int enemybossInt[] 	= {	       0,            1  ,          2  ,           4,           13,           15,           11,            22,           3,           12,           14,           16,            23,            21,            24,             31};

	try{
		//2. 데이타 조작
		//exec spu_FarmD 30, 60, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
		query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setInt(idxColumn++, 30);
		cstmt.setInt(idxColumn++, 60);
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

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	var ps3 = '2:' + f.pack16.value + ';'
		    + '3:' + f.pack17.value + ';'
		    + '4:' + f.pack18.value + ';'
		    + '5:' + f.pack19.value + ';'
		    + '6:' + f.pack20.value + ';'
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
						<td>itemcode</td>
						<td>itemname</td>
						<td>ticket</td>
						<td>유저동물제한</td>
						<td>상대동물</td>
						<td>enemylv</td>
						<td>enemycnt</td>
						<td>stagecnt</td>
						<td></td>
						<td>enemyboss</td>
						<td></td>
					</tr>

					<%while(result.next()){%>
					<tr <%=getCheckValueOri(result.getInt("itemcode"), itemcode, "bgcolor=#ffe020", "")%> <%=result.getInt("itemcode") >= 6930?"bgcolor=#aaffaa":""%>>
						<form name="GIFTFORM" method="post" action="usersetting_ok.jsp" onsubmit="return f_Submit(this);">
						<input type="hidden" name="branch" value="systemfarm_list">
						<input name=itemcode type=hidden value=<%=result.getString("itemcode")%>>
						<input type="hidden" name="p1" value="30">
						<input type="hidden" name="p2" value="61">
						<input type="hidden" name="p3" value="<%=result.getInt("itemcode")%>">
						<input type="hidden" name="ps3" value="">
						<input name=idx type=hidden value=<%=result.getString("itemcode")%>>

						<td>
							<%=result.getString("itemcode")%>
							<a name="<%=result.getString("itemcode")%>"></a>
						</td>
						<td><%=result.getString("itemname")%></td>
						<td><%=result.getString("param14")%></td>
						<td>
							<%
								param = result.getInt("param15");
								len = limitaniStr.length;
								for(int k2 = 0; k2 < len; k2++){
									if(limitaniInt[k2] == param){
										out.println(limitaniStr[k2]);
										break;
									}
								}
							%>
						</td>
						<td>
							<select name="pack16" >
								<%
								param = result.getInt("param16");
								len = limitaniStr.length;
								for(int k2 = 0; k2 < len; k2++){%>
									<option value="<%=limitaniInt[k2]%>" <%=getSelect(param, limitaniInt[k2])%>><%=limitaniStr[k2]%></option>
								<%}%>
							</select>
						</td>
						<td><input name="pack17" type="text" value="<%=result.getInt("param17")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"></td>
						<td><input name="pack18" type="text" value="<%=result.getInt("param18")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"></td>
						<td><input name="pack19" type="text" value="<%=result.getInt("param19")%>" size="2" maxlength="2" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;"></td>
						<td>
							<%
							enemycnt = result.getInt("param18");
							stagecnt = result.getInt("param19");
							while(enemycnt > 0){

								enemycnt -= stagecnt;
								if(enemycnt <= 0 ){
									out.print(enemycnt + stagecnt);
								}else{
									out.print(stagecnt + "/");
								}
							}
							%>
						</td>
						<td>
							<select name="pack20" >
								<%
								param = result.getInt("param20");
								len = enemybossStr.length;
								for(int k2 = 0; k2 < len; k2++){%>
									<option value="<%=enemybossInt[k2]%>" <%=getSelect(param, enemybossInt[k2])%>><%=enemybossStr[k2]%></option>
								<%}%>
							</select>
						</td>
						<td style="padding-left:5px;">
							<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"><br>
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
