package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;

public final class userminus_005fform_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/admin/_define.jsp");
    _jspx_dependants.add("/admin/_constant.jsp");
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=euc-kr");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      formutil.FormUtil util = null;
      synchronized (_jspx_page_context) {
        util = (formutil.FormUtil) _jspx_page_context.getAttribute("util", PageContext.PAGE_SCOPE);
        if (util == null){
          util = new formutil.FormUtil();
          _jspx_page_context.setAttribute("util", util, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');

	//마켓패치용 정의파일
	int 				SKT 					= 1,
						GOOGLE 					= 5,
						NHN 					= 6,
						IPHONE					= 7;

	int 				BUYTYPE_FREE			= 0,	//무료가입 : 리워드 최소.
					 	BUYTYPE_PAY 			= 1;	//유료가입 : 리워드 많음.

	int					KIND_USER_MESSAGE				= 1,
						KIND_USER_BLOCK_LOG				= 2,
						KIND_USER_BLOCK_RELEASE			= 8,
						KIND_USER_DELETE_LOG			= 10,
						KIND_USER_DELETE_RELEASE		= 11,
						KIND_BATTLE_SEARCHLOG			= 15,
						KIND_USER_UNUSUAL_LOG			= 4,
						KIND_SEARCH_ITEMINFO			= 5,
						KIND_ITEM_BUY_LOG				= 6,
						KIND_USER_SEARCH				= 7,
						KIND_USER_ITEM_UPGRADE 			= 9,
						KIND_USER_CASH_CHANGE			= 12,
						KIND_USER_CASH_BUY				= 13,
						KIND_USER_CASH_PLUS				= 16,
						KIND_USER_CASH_MINUS			= 23,
						KIND_USER_CASH_LOG_DELETE		= 17,
						KIND_USER_DELETEID				= 18,
						KIND_USER_SETTING				= 19,
						KIND_NOTICE_SETTING				= 20,
						KIND_STATISTICS_INFO			= 21,
						KIND_OPEN_TEST					= 22,
						KIND_ADMIN_LOGIN				= 25,
						KIND_NEWINFO_LIST				= 26;

      out.write('\r');
      out.write('\n');

	String pwdateid = "1234";
	int YEAR = 2013;
	int MONTH = 12;
	int DATE = 30;
	int HOUR = 23;
	int MIN = 59;

	boolean bExpire 					= false;
	boolean bExpire2 					= true;
	java.text.SimpleDateFormat format 	= new java.text.SimpleDateFormat("yyyyMMdd");
	java.text.SimpleDateFormat format6 	= new java.text.SimpleDateFormat("yyyyMM");
	java.text.SimpleDateFormat format19 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.text.SimpleDateFormat format16 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	java.text.SimpleDateFormat formatdd = new java.text.SimpleDateFormat("dd");
	java.util.Date now 					= new java.util.Date();
	java.util.Date end 					= new java.util.Date(YEAR - 1900, MONTH - 1, DATE, HOUR, MIN);
	if(now.getTime() >= end.getTime()){
		bExpire = true;
	}else{
		bExpire = false;
	}

	String adminip 				= request.getRemoteAddr();
	String adminid 				= (String)session.getAttribute("adminId");
	Integer adminGrade 			= (Integer)session.getAttribute("adminGrade");
	if(adminGrade == null || adminGrade < 1000){
		out.println("관리자만이 접근 할 수 있습니다.");
		response.sendRedirect("_login.jsp");
		return;
	}else if(adminGrade >= 1000){
		bExpire = false;
	}

	boolean bAdmin 				= false;
	if(adminip.indexOf("192.168.0") >= 0){
		bAdmin = true;
	}
	bAdmin = true;

	String strIP = request.getLocalAddr();
	String strPort;
	String strServerName = "";
	boolean bRealServer = false;
	if(strIP.equals("192.168.0.11")){
		strIP = "121.138.201.251";
		strPort = "40012";
		strServerName = "<font size=10 color=gray>[K5(짜요 타이쿤)(Test)]</font>";
		bRealServer = false;
	}else{
		strIP = "175.117.144.244";
		strPort = "8882";
		strServerName = "<font size=10 color=red>[K5(짜요 타이쿤)(Real)]</font>";
		bRealServer = true;
	}
	String imgroot	= "http://" + strIP + ":" + strPort + "/Game4FarmVill5/admin/item";
	//페이지 기능에 사용되는 변수


      out.write("<br><br>\r\n");
      out.write("<center>\r\n");
      out.print(strServerName);
      out.write("<font size=10 color=blue><a href=_admin.jsp>[메인]</a></font>\r\n");
      out.write("</center>");
      out.write("\r\n");
      out.write("\r\n");

	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	int mode 			= util.getParamInt(request, "mode", 0);

      out.write("\r\n");
      out.write("<html><head>\r\n");
      out.write("<title></title>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=euc-kr\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"image/intra.css\">\r\n");
      out.write("<script type=\"text/javascript\" async=\"\" src=\"http://www.google-analytics.com/ga.js\"></script><script type=\"text/javascript\" async=\"\" src=\"http://www.google-analytics.com/ga.js\"></script><script language=\"javascript\" src=\"image/script.js\"></script>\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("<!--\r\n");
      out.write("function f_Submit(f) {\r\n");
      out.write("\tif(f_nul_chk(f.comment, '내용을 작성하세요.')) return false;\r\n");
      out.write("\telse return true;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("//-->\r\n");
      out.write("</script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js\"></script><script type=\"text/javascript\" src=\"chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js\"></script></head>\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\" onload=\"javascript:document.GIFTFORM.comment.focus();\">\r\n");
      out.write("<table align=center>\r\n");
      out.write("\t<tbody>\r\n");
      out.write("\r\n");
      out.write("\t");
if(mode == 0){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=41>\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 캐쉬(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode == 1){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=42>\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 코인(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode == 2){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=43>\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 건초(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode == 3){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=44>\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 하트(+/-)지급 하시겠습니까? <font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode == 45){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=45>\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 인벤Max Step(0 ~ 15)<font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode == 46){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=46>\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 소비인벤Max Step(0 ~ 10)<font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode == 47 || mode == 49){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=");
      out.print(mode);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 인벤Max Step(0 ~ 10)<font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode == 48){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=48>\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(gameid);
      out.write("님에게 하트Max(+/-)지급 하시겠습니까?<font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode >= 51 && mode <= 63){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input name=p1 type=hidden value=19>\r\n");
      out.write("\t\t\t\t<input name=p2 type=hidden value=");
      out.print(mode);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps1 type=hidden value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=ps2 type=hidden value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input name=branch type=hidden value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"gameid\" value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");

								String list[] 	= {"집", "탱크", "양동이", "착유기", "주입기", "정화", "저온보관"};
								int modes[] 	= {  51,     53,       55,       57,       59,     61,         63};
								for(int i = 0; i < modes.length; i++){
									if(mode == modes[i]){
										out.print(list[i]);
										break;
									}
								}
								
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t업그레이드 지정하기(Max는 초과안함)<font color=red>로그기록에 남습니다.</font>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}else if(mode >= 81 && mode <= 84){
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"usersetting_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t<input type=hidden name=p1 value=19>\r\n");
      out.write("\t\t\t\t<input type=hidden name=p2 value=");
      out.print(mode);
      out.write(">\r\n");
      out.write("\t\t\t\t<input type=hidden name=ps1 value=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input type=hidden name=ps2 value=");
      out.print(adminid);
      out.write(">\r\n");
      out.write("\t\t\t\t<input type=hidden name=branch value=userinfo_list>\r\n");
      out.write("\t\t\t\t<input type=hidden name=gameid value=\"");
      out.print(gameid);
      out.write("\">\r\n");
      out.write("\t\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t");

								String list2[] 	= {"양동이 리터", "양동이 신선도", "탱크 리터", "탱크 신선도"};
								int modes2[] 	= {           81,              82,          83,            84};
								for(int i = 0; i < modes2.length; i++){
									if(mode == modes2[i]){
										out.print(list2[i]);
										break;
									}
								}
								
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t30리터가 1배럴, 총신선도에 수량관계로 신선도가 배정됨\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input name=\"p3\" type=\"text\" value=\"\" maxlength=\"9\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:400px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("</tbody></table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else log(t.getMessage(), t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
