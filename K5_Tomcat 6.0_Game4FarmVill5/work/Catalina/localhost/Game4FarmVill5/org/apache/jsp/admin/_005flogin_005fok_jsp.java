package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;

public final class _005flogin_005fok_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
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

	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;


	//1-2. 데이타 받기
	String adminId 		= util.getParamStr(request, "adminId", "");
	String adminPW		= util.getParamStr(request, "adminPW", "");
	int adminGradeDB			= 0;

	try{
		//2. 데이타 조작
		//exec spu_FarmD 25, 2, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'a1s2d3f4', '', '', '', '', '', '', '', ''			-- 관리자 로그인
		query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");

		cstmt = conn.prepareCall(query.toString());

		cstmt.setInt(idxColumn++, KIND_ADMIN_LOGIN);
		cstmt.setInt(idxColumn++, 2);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setInt(idxColumn++, -1);
		cstmt.setString(idxColumn++, adminId);
		cstmt.setString(idxColumn++, adminPW);
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

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			adminGradeDB = result.getInt("grade");
		}
  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

	if(resultCode == 1){
		session.setAttribute("adminId", adminId.trim());
		session.setAttribute("adminGrade", adminGradeDB);
		response.sendRedirect("_admin.jsp");
	}else if(resultCode == -1){
		out.print("<script language='javascript'>alert('아이디나 패스워드가 일치하지 않습니다.'); history.back(-1);</script>");
	}
	/**/

      out.write('\r');
      out.write('\n');
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
