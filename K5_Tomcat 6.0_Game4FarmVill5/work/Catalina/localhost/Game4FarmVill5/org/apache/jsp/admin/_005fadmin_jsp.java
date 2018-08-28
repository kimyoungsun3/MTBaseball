package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class _005fadmin_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<br>\r\n");
      out.write("<center>\r\n");
      out.write("<table border=1>\r\n");
      out.write("\t<tbody>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=notice_list.jsp>@공지사항10</a>\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=push_list.jsp>Push관리</a>\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=sysinquire_list.jsp>@유저문의</a>\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=cashtotal_list2.jsp>루비구매통계(월별)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=statistics_day.jsp>일반 접속/가입통계(일별)</a><br>\r\n");
      out.write("\t\t\t<!--<a href=statistics_main.jsp>유저레벨통계(일별)</a>\t<br>-->\r\n");
      out.write("\t\t\t<a href=statistics_sub2.jsp>유저레별(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=statistics_sub3.jsp>유저통신사별(관리용)</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=sysevent_list.jsp>이벤트공유</a>\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=eventdaily_list.jsp>@이벤트(시간지정)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=eventdailyuser_list.jsp>이벤트(리스트)</a>\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=userinfo_list.jsp>유저정보</a>\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=useritembuylogtotal_mas.jsp>아이템 판매통계(일별)</a><br>\r\n");
      out.write("\t\t\t<a href=useritembuylogtotal_mon.jsp>아이템 판매통계(월별)</a><br>\r\n");
      out.write("\t\t\t<a href=userroullogtotal_mas.jsp>동물뽑기로그</a>\t<br>\r\n");
      out.write("\t\t\t<a href=usertreasurelogtotal_mas.jsp>보물뽑기로그</a><br>\r\n");
      out.write("\t\t\t<a href=useryabau_sub.jsp>주사위통계(일별)</a><br>\r\n");
      out.write("\t\t\t<a href=useryabau_mon.jsp>주사위통계(월별)</a><br>\r\n");
      out.write("\t\t\t<a href=useritemupgradelogtotal_mas.jsp>아이템 강화통계(일별)</a><br><br>\r\n");
      out.write("\t\t\t(일반적인 통계자료를 수집합니다.)\t\t\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=cashbuy_list.jsp>루비구매로그(유저별상세)</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=cashtotal_list.jsp>루비구매통계(종류별)</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=cashtotal_list2.jsp>루비구매통계(월별)</a>\t<br><br>\r\n");
      out.write("\t\t\t<a href=cashtotal_list3.jsp>루비구매통계(일별유니크)</a>\t<br><br>\r\n");
      out.write("\t\t\t<!--\r\n");
      out.write("\t\t\t<a href=useretc_push_total.jsp>Push통계</a>\t\t\t<br><br>\r\n");
      out.write("\t\t\t-->\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=wgiftsend_form.jsp>선물하기</a>\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=wgiftsend_list.jsp>선물리스트</a>\t\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=systeminfo_list.jsp>@루비,코인,하트,업글,룰렛(MAX)</a><br>\r\n");
      out.write("\t\t\t(프로모션 루비, 코인, 하트,악세뽑기 변경)\t\t\t\t<br>\r\n");
      out.write("\t\t\t(아이템 테이블 변경되면 한번씩 변경함)\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t(집,탱크,품질,축사,양동이,착유기,주입기Max)\t\t\t\t<br><br>\r\n");
      out.write("\t\t\t<a href=systempack_list.jsp>패키지상품(구성하기)</a>\t<br>\r\n");
      out.write("\t\t\t(5개의 상품을 한개묶음으로 판매)\t\t\t\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=systeminfo_list2.jsp>@동물뽑기관리</a>\t\t\t<br>\r\n");
      out.write("\t\t\t(보상, 확률증가, 무료뽑기)\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=systemroul_list.jsp>동물뽑기상품(구성하기.)</a><br>\r\n");
      out.write("\t\t\t(50개중 1 ~ 10개의 상품을 하트나 루비으로 뽑기)\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=systeminfo_list3.jsp>@보물뽑기관리</a>\t\t\t<br>\r\n");
      out.write("\t\t\t(보상, 확률증가, 무료뽑기, 강화)\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=systemroul_list2.jsp>보물뽑기상품(구성하기.)</a><br>\r\n");
      out.write("\t\t\t(50개중 1 ~ 10개의 상품을 하트나 루비으로 뽑기)\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=systemyabau_list.jsp>행운의 주사위(구성하기.)</a><br>\r\n");
      out.write("\t\t\t<a href=systemfarm_list.jsp>목장배틀 구성(구성하기.)</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=systemboard_list.jsp>게시판</a>\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=userrank_list.jsp>현재랭킹(판매)</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=userrank_list2.jsp>현재랭킹(트로피)</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=userrank_mas.jsp>지난랭킹(판매)</a>\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=userrank_mas2.jsp>지난랭킹(트로피)</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=userrk_list.jsp>랭킹대전</a>\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<!--\r\n");
      out.write("\t\t\t<a href=schoolmaster_list.jsp>학교대항(진행중)</a>\t\t<br>\r\n");
      out.write("\t\t\t<a href=schoollastweek_list.jsp>학교대항지난(지난내용)</a><br><br>\r\n");
      out.write("\t\t\t<a href=roulettelogtotal_list.jsp>룰렛통계</a>\t\t<br>\r\n");
      out.write("\t\t\t<a href=statistics_rank.jsp>랭킹통계</a>\t\t\t<br>\r\n");
      out.write("\t\t\t-->\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t(비활성화 될 예정)<br>\r\n");
      out.write("\t\t\t<a href=iteminfo_list.jsp>아이템정보(시스템)</a>\t\t<br>\r\n");
      out.write("\t\t\t<a href=iteminfo_list2.jsp>아이템정보(단계별:프로그램)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=iteminfo_list3.jsp>아이템정보(단계별:이미지)</a><br>\r\n");
      out.write("\t\t\t<a href=usertradeproduct.jsp>상인만족상품</a><br><br>\r\n");
      out.write("\t\t\t<!--\r\n");
      out.write("\t\t\t<a href=systemroulfresh_list.jsp>뽑기상품Fresh(시스템)</a>\t<br>\r\n");
      out.write("\t\t\t(신선도 기준으로 뽑기)\t\t\t\t\t\t\t\t<br><br>\r\n");
      out.write("\t\t\t-->\r\n");
      out.write("\t\t\t<a href=certno_list.jsp>@쿠폰리스트(관리용)</a>\t\t<br><br>\r\n");
      out.write("\t\t\t<a href=systemvip_list.jsp>@VIP 정보(관리용)</a>\t<br><br>\r\n");
      out.write("\t\t\t<a href=zcplog_list.jsp>@짜요쿠폰조각 정보(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=zcpmanager_list.jsp>@짜요장터 상품관리(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=zcporder_list.jsp>@짜요장터 주문관리(관리용)</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t(비활성화 될 예정)<br>\r\n");
      out.write("\t\t\t<a href=adminuserbattlebank_list.jsp>유저배틀Bank(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=adminusersalelog_list.jsp>거래내역(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=adminfarmbattlelog_list.jsp>목장배틀(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=adminuserbattlelog_list.jsp>유저배틀(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=userdellog_list.jsp>유저판매/합성/분해(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=unusual_list.jsp>비정상내용(관리용)</a>\t\t<br>\r\n");
      out.write("\t\t\t<a href=unusual_list2.jsp>비정상내용2(관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=userblock_list.jsp>블럭계정(치트유저)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=blockphone_list.jsp>블럭핸드폰(치트유저)</a><br>\r\n");
      out.write("\t\t\t<a href=blockphone_list2.jsp>블럭Push(관계사직원미발송)</a><br>\r\n");
      out.write("\t\t\t<a href=userdelete_list.jsp>삭제계정(관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=rouladlist_list.jsp>광고(교배,보물,룰렛)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=userroullog_list.jsp>뽑기정보(관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=usercomplog_list.jsp>합성정보(관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=userpromotelog_list.jsp>승급정보(관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=userroullog_list2.jsp>악세뽑기정보(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=userroullog_list3.jsp>주사위(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=adminaction_list.jsp>관리자액션(관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=statistics_phone.jsp>유니크핸드폰가입(관리용)</a><br>\r\n");
      out.write("\t\t\t<!--<a href=statistics_main.jsp>유저레벨통계(관리용)</a><br>-->\r\n");
      out.write("\t\t\t<a href=statistics_sub2.jsp>유저레별(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=statistics_sub3.jsp>유저통신사별(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=usercomreward.jsp>유저퀘스트(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=usermarket_list.jsp>유저마켓이동(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=changenickname_list.jsp>닉네임변경(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=userdielog_list.jsp>유저동물죽은(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=useralivelog_list.jsp>유저동물부활(관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=userkakaouserid_list.jsp>Kakaouserid(관리용)</a><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t<!--\r\n");
      out.write("\t\t\t<a href=zgamename_list.jsp>농장이름(상상관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=../_test/farm.htm>전달파일(상상관리용)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=zgameinfo_list.jsp>타회사게임(상상관리용)</a><br>\r\n");
      out.write("\t\t\t<a href=zgamemonth_list.jsp>정보입력(상상관리용)</a><br>\r\n");
      out.write("\t\t\t-->\r\n");
      out.write("\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</tbody></table>\r\n");
      out.write("</center>\r\n");
      out.write("</body>\r\n");
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
