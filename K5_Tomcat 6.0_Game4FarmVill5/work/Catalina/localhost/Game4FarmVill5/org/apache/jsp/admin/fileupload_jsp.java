package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class fileupload_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!--±âº»ÀûÀÎ FILE UPLOAD HTML FORM-->\r\n");
      out.write("<html>\r\n");
      out.write("<head> \r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=EUC-KR\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<form action=\"fileupload_ok.jsp\" method=\"post\" enctype=\"multipart/form-data\">     \r\n");
      out.write("\t<!--\r\n");
      out.write("\t//ÆÄÀÏÀü¼ÛÀÏ ¶§´Â Ç×»ó METHOD´Â POST·Î ÇÏ°í ENCTYPEÀ» Ç×»ó ÁÖ ¾î¾ß ÇÔ<br>\r\n");
      out.write("\t//TYPEÀº FILE·Î ÁÖ¾î¾ß ÇÔ!!<br>\r\n");
      out.write("\t-->\r\n");
      out.write("\tÆÄÀÏ1: <input type=\"file\" name=\"file1\"/><br>                                \r\n");
      out.write("\tÆÄÀÏ2: <input type=\"file\" name=\"file2\"/><br>\r\n");
      out.write("\tÆÄÀÏ3: <input type=\"file\" name=\"file3\"/><br>\r\n");
      out.write("\t<!--\r\n");
      out.write("\tÆÄ¶ó¹ÌÅÍ1: <input type=\"text\" name=\"param1\"/><br>\r\n");
      out.write("\tÆÄ¶ó¹ÌÅÍ2: <input type=\"text\" name=\"param2\"/><br>\r\n");
      out.write("\tÆÄ¶ó¹ÌÅÍ3: <input type=\"text\" name=\"param3\"/><br>\r\n");
      out.write("\t-->\r\n");
      out.write("\t<input type=\"submit\" value=\"Àü¼Û\" />\r\n");
      out.write("</form>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
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
