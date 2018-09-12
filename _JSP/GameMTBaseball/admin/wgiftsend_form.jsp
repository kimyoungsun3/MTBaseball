<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>

<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer query2			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	StringBuffer resultMsg		= new StringBuffer();
	int	idxColumn 				= 1;
	String gameid				= FormUtil.getParamStr(request, "gameid", "");


	try{

%>

<html><head>
<title>선물하기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script type="text/javascript">
function checkForm2(f) {
	if(f.gameid.value == ''){
    	alert('아이디를 입력해주세요.');
    	return false;
    }else{
    	return true;
    }

}

</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.gameid.focus();">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tbody><tr>
        <td colspan="2" height="200" align="center" style="vertical-align:middle;">
        	<table>
        		<tbody>
        		<tr>
        			<td align="center">
	        			<form name="GIFTFORM" method="post" action="wgiftsend_ok.jsp" onsubmit="return checkForm2(this);">
	        			<input type="hidden" name="subkind" value="11">
	        			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
	        				<table>
	        				<tbody>
	        				<tr>
	        					<td colspan=3>
	        						<font color=red>
	        							1. 선물만 발송이 됩니다.(쪽지와 혼동 하시지 말아주세요. )<br>
	        							2. 템들의 수량을 발송은 1개가 기본입니다.<br>
	        						</font>
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>선물할 유저아이디</td>
	        					<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="16" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
	        					<td rowspan="2" style="padding-left:5px;">
	        						<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>선물아이템</td>
	        					<td>
	        					<select name="itemcode">
									<%
									//2. 데이타 조작
									//exec spu_GameMTBaseballD 27, 1,  -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 선물 가능한 리스트
									query.append("{ call dbo.spu_GameMTBaseballD (?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)} ");
									cstmt = conn.prepareCall(query.toString());
									cstmt.setInt(idxColumn++, 27);
									cstmt.setInt(idxColumn++, 1);
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

									<%while(result.next()){%>
										<option value="<%=result.getString("itemcode")%>">
											코드(<%=result.getInt("itemcode")%>)
											[<%=getCategory(result.getInt("category"))%> / <%=getSubCategory(result.getInt("subcategory"))%>]&nbsp;&nbsp;

											<%=result.getString("itemname")%>
											<br>
										</option>
									<%}%>
								</select>
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>수량</td>
	        					<td>
	        						<input name="cnt" type="text" value="1" maxlength="9" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;">
	        						(수량 맥스는 9자리까지만 지원됩니다.)
	        					</td>
	        				</tr>
	        				</tbody></table>
	        			</div>
	        			</form>
        			</td>
        		</tr>
        		<!---->
        		<tr>
        			<td align="center">
	        			<form name="GIFTFORM" method="post" action="wgiftsend_ok.jsp" onsubmit="return checkForm2(this);">
	        			<input type="hidden" name="subkind" value="12">
	        			<div  style="border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;">
	        				<table>
	        				<tbody>
	        				<tr>
	        					<td colspan=3>
	        						<font color=red>쪽지만 발송됩니다.(위의 기능과 병행 발송 안됩니다.)</font><br>
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>쪽지(ID)</td>
	        					<td><input name="gameid" type="text" value="<%=gameid%>" maxlength="20" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:154px;"></td>
	        					<td rowspan="2" style="padding-left:5px;">
	        						<input name="image" type="image" src="images/btn_send.gif" border="0" tabindex="3">
	        					</td>
	        				</tr>
	        				<tr>
	        					<td>쪽지(내용)</td>
	        					<td colspan=2><input name="message" type="text" value="" maxlength="128" tabindex="1" style="border:1px solid #EBEBEB;background:#FFFFFF;width:600px;"></td>
	        				</tr>
	        				</tbody></table>
	        			</div>
	        			</form>
        			</td>
        		</tr>
        		<!---->
        	</tbody></table>
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
