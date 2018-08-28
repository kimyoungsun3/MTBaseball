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

	int itemcode 		= util.getParamInt(request, "itemcode", -1);
	int category 		= util.getParamInt(request, "category", -1);
	int subcategory 	= util.getParamInt(request, "subcategory", -1);

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
	if(f_nul_chk(f.itemcode, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.itemcode.focus();">
<center>
<table>
	<tbody>
	<tr>
		<td align="center">
			<a href=iteminfo_list.jsp><img src=images/refresh2.png alt="화면갱신"></a>
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<form name="GIFTFORM" method="post" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
							<td>itemcode검색</td>
							<td><input name="itemcode" type="text" value="<%=itemcode==-1?"":(itemcode+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</form>
						<form name="GIFTFORM" method="post2" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
							<td>category</td>
							<td><input name="category" type="text" value="<%=category==-1?"":(category+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</form>
						<form name="GIFTFORM" method="post2" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
							<td>subcategory</td>
							<td><input name="subcategory" type="text" value="<%=subcategory==-1?"":(subcategory+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</form>
					</tr>
				</table>

				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FVFarmD 5, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--전체
					query.append("{ call dbo.spu_FVFarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 5);
					cstmt.setInt(idxColumn++, 1);
					cstmt.setInt(idxColumn++, itemcode);
					cstmt.setInt(idxColumn++, category);
					cstmt.setInt(idxColumn++, subcategory);
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
						<tr>
							<td>labelname</td>
							<td>itemcode</td>
							<td>itemname</td>
							<td>category</td>
							<td>subcategory</td>
							<td>결정->유제품</td>
							<td>sellcost</td>
							<td>description</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<td>
								<%=result.getString("labelname")%>
							</td>
							<td>
								<a href=iteminfo_list.jsp?itemcode=<%=result.getString("itemcode")%>><%=result.getString("itemcode")%></a>
								<img src=<%=imgroot%>/<%=result.getInt("itemcode")%>.png>
							</td>

							<td><%=result.getString("itemname")%></td>
							<td><a href=iteminfo_list.jsp?category=<%=result.getString("category")%>><%=result.getString("category")%></a></td>
							<td><a href=iteminfo_list.jsp?subcategory=<%=result.getString("subcategory")%>><%=result.getString("subcategory")%></a></td>
							<td><%=result.getString("buyamount")%></td>
							<td><%=result.getString("sellcost")%></td>
							<td><%=result.getString("description")%></td>
						</tr>
					<%}%>
				</table>
			</div>
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
