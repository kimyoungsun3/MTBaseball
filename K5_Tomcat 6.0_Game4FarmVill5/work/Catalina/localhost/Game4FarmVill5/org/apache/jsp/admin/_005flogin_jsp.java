package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;
import java.util.*;
import java.text.*;

public final class _005flogin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

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
      out.write("\r\n");
      out.write("\r\n");
request.setCharacterEncoding("EUC-KR");
      out.write('\r');
      out.write('\n');
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


	String servername = "<font color=gray size=5>K5(짜요 타이쿤) Kakao(Test)</font>";
	String strIP = request.getLocalAddr();
	if(!strIP.equals("192.168.0.11")){
		servername = "<font color=red size=5>K5(짜요 타이쿤) Kakao(Real)</font>";
	}


      out.write("\r\n");
      out.write("\r\n");
      out.write("<html><head>\r\n");
      out.write("<title></title>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=euc-kr\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"image/intra.css\">\r\n");
      out.write("<script type=\"text/javascript\" async=\"\" src=\"http://www.google-analytics.com/ga.js\"></script><script type=\"text/javascript\" async=\"\" src=\"http://www.google-analytics.com/ga.js\"></script><script language=\"javascript\" src=\"image/script.js\"></script>\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("<!--\r\n");
      out.write("function f_Submit(f) {\r\n");
      out.write("\tif(f_nul_chk(f.adminId, '아이디를')) return false;\r\n");
      out.write("\telse return true;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("//-->\r\n");
      out.write("</script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js\"></script><script type=\"text/javascript\" src=\"chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js\"></script></head>\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\" onload=\"javascript:document.GIFTFORM.adminId.focus();\">\r\n");
      out.write("<center><br><br><br>\r\n");
      out.write("<table>\r\n");
      out.write("\t<tbody>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"_login_ok.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td colspan=2>\r\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(servername);
      out.write("<br><br>\r\n");
      out.write("\t\t\t\t\t\t\t- 관리 사이트에서 테스트 목적 이외에는 루비 추가를 자제 부탁합니다.<br>\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>아이디(짜요목장이야기)</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input name=\"adminId\" type=\"text\" value=\"\" maxlength=\"16\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:154px;\"></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>패스워드</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input name=\"adminPW\" type=\"password\" value=\"\" maxlength=\"16\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:154px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t<td rowspan=\"2\" style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</tbody></table>\r\n");
      out.write("</center>\r\n");
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
