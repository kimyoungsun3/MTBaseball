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
	int view	 		= util.getParamInt(request, "view", 0);


	String icname[] = new String[20000];
	int iccode[] = new int[20000];
	int iclen = 0;
	int icic;

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
<table>
	<tbody>
	<tr>
		<td align="center">
			<a href=iteminfo_list.jsp?view=1>이미지보기</a>
			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
				<table>
					<tr>
						<form name="GIFTFORM" method="post" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
	        				<input type="hidden" name="view" value="<%=view%>">
							<td>itemcode검색</td>
							<td><input name="itemcode" type="text" value="<%=itemcode==-1?"":(itemcode+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</form>
						<form name="GIFTFORM" method="post2" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="view" value="<%=view%>">
							<td>category</td>
							<td><input name="category" type="text" value="<%=category==-1?"":(category+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3"></td>
						</form>
						<form name="GIFTFORM" method="post2" action="iteminfo_list.jsp" onsubmit="return f_Submit(this);">
							<input type="hidden" name="view" value="<%=view%>">
							<td>subcategory</td>
							<td><input name="subcategory" type="text" value="<%=subcategory==-1?"":(subcategory+"")%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
							<td rowspan="2" style="padding-left:5px;"><input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
							<a href=iteminfo_list.jsp><img src=images/refresh2.png alt="화면갱신"></a></td>
						</form>
					</tr>
				</table>

				<table border=1>
					<%
					//2. 데이타 조작
					//exec spu_FarmD 5, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--전체
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
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
							<%if(view == 1){%>
								<td></td>
							<%}%>
							<td>category</td>
							<td>subcategory</td>
							<td>equpslot</td>
							<td>activate</td>
							<td>toplist</td>
							<td>grade</td>
							<td>discount</td>
							<td>icon</td>
							<td>playerlv</td>
							<td>houselv</td>
							<td>gamecost</td>
							<td>cashcost</td>
							<td>buyamount</td>
							<td>sellcost</td>
							<td>description</td>
							<td>p1</td>
							<td>p2</td>
							<td>p3</td>
							<td>p4</td>
							<td>p5</td>
							<td>p6</td>
							<td>p7</td>
							<td>p8</td>
							<td>p9</td>
							<td>p10</td>
							<td>p11</td>
							<td>p12</td>
							<td>p13</td>
							<td>p14</td>
							<td>p15</td>
							<td>p16</td>
							<td>p17</td>
							<td>p18</td>
							<td>p19</td>
							<td>p20</td>
							<td>p21</td>
							<td>p22</td>
							<td>p23</td>
							<td>p24</td>
							<td>p25</td>
							<td>p26</td>
							<td>p27</td>
							<td>p28</td>
							<td>p29</td>
							<td>p30</td>
						</tr>

					<%while(result.next()){%>
						<tr>
							<!--
							<td><%=result.getString("itemcode")%></td>
							<td><%=result.getString("itemname")%></td>
							<td><%=result.getString("param6")%></td>
							-->

							<td>
								<%=result.getString("labelname")%>
								<%=getDanilga(result.getInt("subcategory"), result.getInt("gamecost"), result.getInt("cashcost"), result.getInt("buyamount"), result.getInt("sellcost"))%>
							</td>
							<td><a href=iteminfo_list.jsp?itemcode=<%=result.getString("itemcode")%>&view=<%=view%>><%=result.getString("itemcode")%></a></td>

							<td>
								<%=result.getString("itemname")%>
								<%
									int _category = result.getInt("category");
									if(_category == 1){
										icname[iclen] 	= result.getString("itemname");
										iccode[iclen]	= result.getInt("itemcode");
										iclen++;
									}

									if( _category == 1010 )
									{
										icic = result.getInt("param12");
										for( int i = 0; i < iclen; i++ )
										{
											if( iccode[i] == icic)
											{
												out.println( "<br>" + icname[i] );
											}
										}
									}
								%>
							</td>
							<%if(view == 1){%>
								<td>
									<% if( _category == 1010 ){ %>
										<%=checkImgParam(view, result.getInt("subcategory"), 12, result.getString("param12"), imgroot)%>
									<%}else{%>
										<img src=<%=imgroot%>/<%=result.getInt("itemcode")%>.png> <%=result.getInt("itemcode")%>
									<%}%>
								</td>
							<%}%>
							<td>
								<a href=iteminfo_list.jsp?category=<%=result.getString("category")%>&view=<%=view%>><%=result.getString("category")%></a>
							</td>
							<td><a href=iteminfo_list.jsp?subcategory=<%=result.getString("subcategory")%>&view=<%=view%>><%=result.getString("subcategory")%></a></td>
							<td><%=result.getString("equpslot")%></td>
							<td><%=result.getString("activate")%></td>
							<td><%=result.getString("toplist")%></td>
							<td><%=result.getString("grade")%></td>
							<td><%=result.getString("discount")%></td>
							<td><%=result.getString("icon")%></td>
							<td><%=result.getString("playerlv")%></td>
							<td><%=result.getString("houselv")%></td>
							<td><%=result.getString("gamecost")%></td>
							<td><%=result.getString("cashcost")%></td>
							<td><%=result.getString("buyamount")%></td>
							<td><%=result.getString("sellcost")%></td>
							<td><%=result.getString("description")%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 1, result.getString("param1"), imgroot)%></td>
							<td>
								<%=
								( ( result.getInt("subcategory") == 901 )?
								    checkImgParam2(view, result.getInt("subcategory"), 2, result.getString("param2"), imgroot, result.getInt("param1"))
								    :
								    checkImgParam(view, result.getInt("subcategory"), 2, result.getString("param2"), imgroot)
								 )%>
							</td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 3, result.getString("param3"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 4, result.getString("param4"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 5, result.getString("param5"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 6, result.getString("param6"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 7, result.getString("param7"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 8, result.getString("param8"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 9, result.getString("param9"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 10, result.getString("param10"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 11, result.getString("param11"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 12, result.getString("param12"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 13, result.getString("param13"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 14, result.getString("param14"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 15, result.getString("param15"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 16, result.getString("param16"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 17, result.getString("param17"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 18, result.getString("param18"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 19, result.getString("param19"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 20, result.getString("param20"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 21, result.getString("param21"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 22, result.getString("param22"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 23, result.getString("param23"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 24, result.getString("param24"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 25, result.getString("param25"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 26, result.getString("param26"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 27, result.getString("param27"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 28, result.getString("param28"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 29, result.getString("param29"), imgroot)%></td>
							<td><%=checkImgParam(view, result.getInt("subcategory"), 30, result.getString("param30"), imgroot)%></td>
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
