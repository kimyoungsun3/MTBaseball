package org.apache.jsp.goo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import formutil.FormUtil;

public final class sysagreement_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/goo/_define.jsp");
    _jspx_dependants.add("/goo/_sysagreement.jsp");
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
      response.setContentType("text/html; charset=utf-8");
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
request.setCharacterEncoding("utf-8");
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
				int 	SKT 					= 1,
						GOOGLE 					= 5,
						NHN						= 6,
						IPHONE					= 7;

				 int 	PTC_NOTICE			= 28,	//[notice.jsp]
						PTS_NOTICE			= 28,
						PTC_AGREEMENT		= 81,	//sysagreement.jsp
						PTS_AGREEMENT		= 81,
						PTC_SYSINQUIRE		= 82,	//sysinquire.jsp
						PTS_SYSINQUIRE		= 82,

						PTC_CREATEID		= 0,	//createid.jsp
						PTS_CREATEID		= 0,
						PTC_CREATEGUEST		= 22,	//createguest.jsp
						PTS_CREATEGUEST		= 22,
						PTC_NEWSTART		= 87,	//newstart.jsp
						PTS_NEWSTART		= 87,
						PTC_KFADD			= 88,	//kfadd.jsp
						PTS_KFADD			= 88,
						PTC_KFRESET			= 96,	//kfreset.jsp
						PTS_KFRESET			= 96,
						PTC_KFINVITE		= 89,	//kfinvite.jsp
						PTS_KFINVITE		= 89,
						PTC_KFHELP			= 90,	//kfhelp.jsp
						PTS_KFHELP			= 90,
						PTC_KFHELPLIST		= 98,	//kfhelplist.jsp
						PTS_KFHELPLIST		= 98,
						PTC_KCHECKNN		= 91,	//kchecknn.jsp
						PTS_KCHECKNN		= 91,

						PTC_LOGIN			= 1,	//login.jsp
						PTS_LOGIN			= 1,
						PTC_CHANGEPW		= 32,	//changepw.jsp
						PTS_CHANGEPW		= 32,
						PTC_DELETEID		= 11, 	//deleteid.jsp
						PTS_DELETEID		= 11,
						PTC_DAILYREWARD		= 41, 	//dailyreward.jsp
						PTS_DAILYREWARD		= 41,
						PTC_GIFTGAIN		= 21, 	//giftgain.jsp
						PTS_GIFTGAIN		= 21,

						PTC_ITEMBUY			= 8,	//itembuy.jsp
						PTS_ITEMBUY			= 8,
						PTC_ITEMSELL		= 50,	//itemsell.jsp
						PTS_ITEMSELL		= 50,
						PTC_ITEMSELLLIST	= 111,	//itemselllist.jsp
						PTS_ITEMSELLLIST	= 111,
						PTC_ITEMQUICK		= 51,	//itemquick.jsp
						PTS_ITEMQUICK		= 51,
						PTC_ITEMACC			= 52,	//itemacc.jsp
						PTS_ITEMACC			= 52,
						PTC_ITEMACCNEW		= 102,	//itemaccnew.jsp
						PTS_ITEMACCNEW		= 102,
						PTC_ITEMINVENEXP	= 53,	//iteminvenexp.jsp
						PTS_ITEMINVENEXP	= 53,

						PTC_FACUPGRADE		= 54,	//facupgrade.jsp
						PTS_FACUPGRADE		= 54,

						PTC_SEEDBUY			= 55,	//seedbuy.jsp
						PTS_SEEDBUY			= 55,
						PTC_SEEDPLANT		= 56,	//seedplant.jsp
						PTS_SEEDPLANT		= 56,
						PTC_SEEDHARVEST		= 57,	//seedharvest.jsp
						PTS_SEEDHARVEST		= 57,

						PTC_TRADE			= 58,	//trade.jsp
						PTS_TRADE			= 58,
						PTC_SAVE			= 59,	//save.jsp
						PTS_SAVE			= 59,
						PTC_TRADECASH		= 71,	//tradecash.jsp
						PTS_TRADECASH		= 71,
						PTC_TRADECONTINUE	= 74,	//tradecontinue.jsp
						PTS_TRADECONTINUE	= 74,
						PTC_TRADECHANGE		= 103,	//tradechange.jsp
						PTS_TRADECHANGE		= 103,
						PTC_RANKLIST		= 124, 	//ranklist.jsp
						PTS_RANKLIST		= 124,

						PTC_PACKBUY			= 60,	//packbuy.jsp
						PTS_PACKBUY			= 60,
						PTC_ROULBUY			= 61,	//roulbuy.jsp
						PTS_ROULBUY			= 61,
						PTC_TREASUREBUY		= 112,	//treasurebuy.jsp
						PTS_TREASUREBUY		= 112,
						PTC_ROULACC			= 94,	//roulacc.jsp
						PTS_ROULACC			= 94,

						PTC_TREASUREUPGRADE	= 113,	//treasureupgrade.jsp
						PTS_TREASUREUPGRADE	= 113,
						PTC_TREASUREWEAR	= 114,	//treasurewear.jsp
						PTS_TREASUREWEAR	= 114,

						PTC_DOGAMLIST		= 44, 	//dogamlist.jsp
						PTS_DOGAMLIST		= 44,
						PTC_DOGAMREWARD		= 42, 	//dogamreward.jsp
						PTS_DOGAMREWARD		= 42,

						PTC_TUTORIAL		= 30,	//tutorial.jsp
						PTS_TUTORIAL		= 30,
						PTC_TUTOSTEP		= 75,	//tutostep.jsp
						PTS_TUTOSTEP		= 75,
						PTC_COMPETITION		= 63,	//competition.jsp
						PTS_COMPETITION		= 63,
						PTC_USERPARAM		= 64,	//userparam.jsp
						PTS_USERPARAM		= 64,
						PTC_CHANGEINFO		= 7,	//changeinfo.jsp
						PTS_CHANGEINFO		= 7,

						PTC_ANISET			= 46,	//aniset.jsp
						PTS_ANISET			= 46,
						PTC_ANIDIE			= 47,	//anidie.jsp
						PTS_ANIDIE			= 47,
						PTC_ANIREVIVAL		= 48,	//anirevival.jsp
						PTS_ANIREVIVAL		= 48,
						PTC_ANIUSEITEM		= 49,	//aniuseitem.jsp
						PTS_ANIUSEITEM		= 49,
						PTC_ANIREPREG		= 43,	//anirepreg.jsp
						PTS_ANIREPREG		= 43,
						PTC_ANIHOSLIST		= 45,	//anihoslist.jsp
						PTS_ANIHOSLIST		= 45,
						PTC_ANIURGENCY		= 62,	//aniurgency.jsp
						PTS_ANIURGENCY		= 62,
						PTC_ANIRESTORE		= 92,	//anirestore.jsp
						PTS_ANIRESTORE		= 92,
						PTC_ANICOMPOSE		= 97,	//anicompose.jsp
						PTS_ANICOMPOSE		= 97,
						PTC_ANICOMPOSEINIT	= 100,	//anicomposeinit.jsp
						PTS_ANICOMPOSEINIT	= 100,
						PTC_ANIPROMOTE		= 117,	//anipromote.jsp
						PTS_ANIPROMOTE		= 117,
						PTC_ANIUPGRADE		= 108, 	//aniupgrade.jsp
						PTS_ANIUPGRADE		= 108,
						PTC_ANIBATTLESTART	= 109, 	//anibattlestart.jsp
						PTS_ANIBATTLESTART	= 109,
						PTC_ANIBATTLERESULT	= 110, 	//anibattleresult.jsp
						PTS_ANIBATTLERESULT	= 110,
						PTC_ANIBATTLEPLAYCNTBUY	= 115, 	//anibattleplaycntbuy.jsp
						PTS_ANIBATTLEPLAYCNTBUY	= 115,
						PTC_APARTITEMCODE	= 116, 	//apartitemcode.jsp
						PTS_APARTITEMCODE	= 116,

						PTC_UBBOXOPENOPEN	= 118, 	//ubboxopenopen.jsp
						PTS_UBBOXOPENOPEN	= 118,
						PTC_UBBOXOPENCASH	= 119, 	//ubboxopencash.jsp
						PTS_UBBOXOPENCASH	= 119,
						PTC_UBBOXOPENCASH2	= 125, 	//ubboxopencash2.jsp
						PTS_UBBOXOPENCASH2	= 125,
						PTC_UBBOXOPENGETITEM= 120, 	//ubboxopengetitem.jsp
						PTS_UBBOXOPENGETITEM= 120,
						PTC_UBSEARCH		= 121, 	//ubsearch.jsp
						PTS_UBSEARCH		= 121,
						PTC_UBRESULT		= 122, 	//ubresult.jsp
						PTS_UBRESULT		= 122,
						PTC_WHEEL			= 126, 	//wheel.jsp
						PTS_WHEEL			= 126,
						PTC_RKRANK			= 127,	//rkrank.jsp
						PTS_RKRANK			= 127,
						PTC_ZCPCHANCE		= 128,	//zcpchance.jsp
						PTS_ZCPCHANCE		= 128,
						PTC_ZCPBUY			= 129,	//zcpbuy.jsp
						PTS_ZCPBUY			= 129,

						PTC_FWBUY			= 68,	//fwbuy.jsp
						PTS_FWBUY			= 68,
						PTC_FWSELL			= 69,	//fwsell.jsp
						PTS_FWSELL			= 69,
						PTC_FWINCOME		= 70,	//fwincome.jsp
						PTS_FWINCOME		= 70,
						PTC_FWINCOMEALL		= 95,	//fwincomeall.jsp
						PTS_FWINCOMEALL		= 95,

						PTC_FSEARCH			= 16, 	//fsearch.jsp
						PTS_FSEARCH			= 16,
						PTC_FADD			= 17, 	//fadd.jsp
						PTS_FADD			= 17,
						PTC_FDELETE			= 18, 	//fdelete.jsp
						PTS_FDELETE			= 18,
						PTC_FAPPROVE		= 65, 	//fapprove.jsp
						PTS_FAPPROVE		= 65,
						PTC_FHEART			= 66, 	//fheart.jsp
						PTS_FHEART			= 66,
						PTC_FPROUD			= 123, 	//fproud.jsp
						PTS_FPROUD			= 123,
						PTC_FPOINT			= 67,	//fpoint.jsp
						PTS_FPOINT			= 67,
						PTC_FMYFRIEND		= 19, 	//fmyfriend.jsp
						PTS_FMYFRIEND		= 19,
						PTC_FVISIT			= 20, 	//fvisit.jsp
						PTS_FVISIT			= 20,
						PTC_PUSHMSG			= 34,	//sendpush.jsp
						PTS_PUSHMSG			= 34,
						PTC_FBWRITE			= 72,	//fbwrite.jsp
						PTS_FBWRITE			= 72,
						PTC_FBREAD			= 73,	//fbread.jsp
						PTS_FBREAD			= 73,
						PTC_FRENT			= 93, 	//frent.jsp
						PTS_FRENT			= 93,
						PTC_FRETURN			= 107, 	//freturn.jsp
						PTS_FRETURN			= 107,

						PTC_SCHOOLSEARCH	= 76,	//schoolsearch.jsp
						PTS_SCHOOLSEARCH	= 76,
						PTC_SCHOOLJOIN		= 77,	//schooljoin.jsp
						PTS_SCHOOLJOIN		= 77,
						PTC_SCHOOLTOP		= 78,	//schooltop.jsp
						PTS_SCHOOLTOP		= 78,
						PTC_SCHOOLUSERTOP	= 79,	//schoolusertop.jsp
						PTS_SCHOOLUSERTOP	= 79,

						PTC_CERTNO			= 80,	//certno.jsp
						PTS_CERTNO			= 80,

						PTC_CASHBUY			= 14,	//cashbuy.jsp
						PTS_CASHBUY			= 14,

						PTC_PETTODAY		= 83,	//pettoday.jsp
						PTS_PETTODAY		= 83,
						PTC_PETROLL			= 84,	//petroll.jsp
						PTS_PETROLL			= 84,
						PTC_PETUPGRADE		= 85,	//petupgrade.jsp
						PTS_PETUPGRADE		= 85,
						PTC_PETWEAR			= 86,	//petwear.jsp
						PTS_PETWEAR			= 86,
						PTC_PETEXP			= 101,	//petexp.jsp
						PTS_PETEXP			= 101,

						PTC_YABAUCHANGE		= 104,	//yabauchange.jsp
						PTS_YABAUCHANGE		= 104,
						PTC_YABAUREWARD		= 105,	//yabaureward.jsp
						PTS_YABAUREWARD		= 105,
						PTC_YABAU			= 106,	//yabau.jsp
						PTS_YABAU			= 106,


						PTC_XXXXX			= 99,
						PTS_XXXXX			= 99,	//_xxxxx.jsp

						PTC_ROULETTE		= 6,	//roulette.jsp
						PTS_ROULETTE		= 6,
						PTC_ROULETTE2		= 37,	//roulette2.jsp
						PTS_ROULETTE2		= 37,


						PTC_RECHARGEACTION	= 12, 	//rechargeaction.jsp
						PTS_RECHARGEACTION	= 12,

						PTC_RANK			= 13,	//rank.jsp
						PTS_RANK			= 13,

						PTC_SENDSMS			= 33,	//sendsms.jsp
						PTS_SENDSMS			= 33;





	String strIP = request.getLocalAddr();
	String strPort;
	if(strIP.equals("192.168.0.11")){
		strIP = "210.123.107.7";
		strPort = "40009";
	}else{
		strIP = "14.63.218.20";
		strPort = "8989";
	}

	boolean DEBUG_LOG_PARAM = false;
	StringBuffer DEBUG_LOG_STR	= new StringBuffer();


      out.write('\r');
      out.write('\n');

	String strAgreement[]				= {
"모바일 서비스 이용약관\n\n이 약관은 주식회사 마블스(이하 마블스라 한다)에서 제공하는 모바일 게임 어플리케이션(이하 마블스앱 이라 한다)의 이용과 관련하여 마블스와 고객간의 권리, 의무 및 필요한 제반 사항을 정하고 있습니다. 마블스앱 이용 전에 이 약관을 주의 깊게 읽어 보시기 바라며, 마블스앱을 이용하는 경우 이 약관에 동의한 것으로 간주됩니다. 이 약관은 마블스앱 최초 실행 시 고지되어 이용자로부터 동의를 받으며, 이용자는 이 약관을 마블스앱을 통하여 다시 확인 할 수 있습니다.\n\n1. 수집회사 및 연락처\n-회사명: 마블스\n-상담시간: 월요일~금요일(10:00~18:00),토/일 공휴일 휴무\n\n2. 정의\n 1) 이용자란 마블스앱을 다운로드 받아 이용하는 고객을 말합니다. 특별한 사유가 없는 한 마블스는 마블스앱이 설치된 핸드폰, 스마트폰 또는 태블릿 PC 등의 단말기 명의자를 이용자로 간주합니다.\n 2) 오픈마켓이란 이용자가 마블스앱을 유료 또는 무료로 다운로드 받을 수 있도록 마블스와 이용자간의 거래를 중개하는 공간, 어플리케이션, 웹사이트 등을 말합니다.\n 3) 오픈마켓사업자란 오픈마켓을 운영하는 사업자를 말합니다.\n 4) 카카오톡 게임 서비스(이하 서비스라 합니다)라 함은 회사가 카카오톡과 제휴하여 제공하는 서비스로서, 카카오톡 회원 정보를 이용해 모바일 기기에서 콘텐츠를 이용할 수 있도록 제공하는 개별 또는 일체의 서비스를 의미합니다.\n 5) In-App아이템이란 In-App결제를 통하여 이용자가 구매할 수 있는 아이템, 기능, 게임머니 등을 말하며 다음과 같이 캐시형 아이템과 단품형 아이템으로 구분됩니다.\n 6) 캐시형In-App아이템이란 이용자가 마블스앱 내에서 다른 아이템을 획득하거나 마블스앱의 일정 기능을 이용하는데 사용하기 위하여 마블스앱 내에서 구매할 수 있는 게임머니 성격의 아이템을 말합니다.\n 7) 단품형In-App아이템이란 이용자가 캐시형 아이템을 이용하지 않고 마블스앱 내에서 직접 구매할 수 있는 아이템을 말합니다.\n 8) 네트워크형게임앱이란 마블스앱 이용내역이 마블스 서버에 저장, 관리되는 게임앱을 말합니다.\n 9) 기간제서비스란 일정한 기간을 정하여 이용자가 기간제서비스에 대한 대금을 지불하고 해당 기간동안만 해당 서비스를 이용할 수 있도록 제공되는 서비스를 말합니다.\n 10) 위치정보라 함은 이동성이 있는 물건 또는 개인이 특정한 시간에 존재하거나 존재하였던 장소에 관한 정보로서 「전기통신사업법」 제2조 제2호 및 제3호에 따른 전기통신설비 및 전기통신회선설비를 이용하여 수집된 것을 의미합니다.\n 11) 개인위치정보라 함은 특정 개인의 위치정보(위치정보만으로는 특정 개인의 위치를 알 수 없는 경우에도 다른 정보와 용이하게 결합하여 특정 개인의 위치를 알 수 있는 것을 포함합니다)를 의미합니다.\n 12) 개인위치정보주체라 함은 개인위치정보에 의하여 식별되는 자를 의미합니다.\n 13) 위치기반서비스라 함은 마블스가 위치정보 또는 개인위치정보를 활용하여 제공하는 서비스를 의미합니다.\n\n3. 서비스 주체의 구분\n가. 마블스앱의 서비스 주체는 다음과 같이 구분됩니다.\n- 오픈마켓 / 오픈마켓사업자\n나. 이 약관은 이용자가 편의를 위하여 마블스가 서비스하는 마블스앱에 대한 내용을 함께 규정하고 있을 뿐, 이 약관의 어떠한 내용이나 표현도 마블스와 이용자에 대한 책임, 의무를 연대 또는 공동으로 부담하는 것으로 해석되지 않습니다. 즉, 이 약관의 내용은 서비스 주체 별로 마블스와 이용자간 거래에 대한 적용이며, 마블스가 서비스 주체인 마블스앱에 대하여 고객 상담 업무를 대행할 수 있습니다.\n\n4. 약관의 적용 및 변경\n가. 이 약관은 마블스와 대한민국 영역에서 서비스 되는 마블스앱의 이용자간에 적용됩니다.\n나. 이 약관은 전자상거래 등에서의 소비자보호에 관한 법률, 콘텐츠산업 진흥법, 약관의 규제에 관한 법률 등 관련 법령의 제/개정, 시스템 변경 등에 따라 필요한 경우 관련 법령을 위반하지 않는 범위 내에서 수시로 변경될 수 있습니다. 마블스는 이 약관이 변경되는 경우 변경된 약관의 적용일자 및 변경사유를 최소하나 그 적용일자 7일(이용자에게 불리하거나 중대한 사항의 변경은 30일) 이전부터 적용일 후 상당기간 마블스앱을 통하여 공지하면서 일정한 동의 기간 내에 거절의 의사를 표시하지 않으면 변경된 약관에 동의한 것으로 간주합니다.\n\n5. 마블스앱 서비스의 제공, 변경 및 중단 등\n가. 마블스는 특별한 사정이 없는 한 연중무휴 24시간 서비스를 제공합니다. 단, 마블스 시스템 및 서버점검, 증설, 교체, 장애정비등을 위하여 일정 시간 서비스 제공을 중지할 수 있으며, 부득이한 경우 사전예고 없이 일시적으로 서비스를 중지할 수 있습니다.\n나. 마블스는 수시로 마블스앱을 변경, 수정, 업데이트 할 수 있습니다. 업데이트가 이용자 보호 및 관련 법령 대응을 위한 것일 경우, 이용자는 마블스앱 업데이트 후 마블스앱의 이용이 가능합니다.\n다. 마블스는 마블스앱의 서비스가 중단되는 경우 최소 1개월 전에 이용자에게 마블스앱 서비스 중단을 공지합니다. 이용자는 마블스앱 서비스 중단을 이유로 마블스에게 어떠한 보상도 요구할 수 없으며, 이용자는 서비스 중단 공지 이후 In-App결제에 대하여 서비스 중단을 이유로 한 환급 등을 요청할 수 없습니다.\n라. 마블스가 기간제 서비스를 제공하는 경우 이용자는 해당 기간제 서비스를 정해진 기간 동안만 이용할 수 있습니다. 만약 기간제 서비스에 대한 대금 결제방식을 매월 자동결제방식으로 하는 경우, 마블스는 자동결제방식에 대하여 이용자로부터 동의를 받습니다.\n\n6. 카카오톡 게임 서비스\n가. 서비스는 다른 카카오톡 이용자와 함께 게임을 즐길 수 있는 서비스입니다.\n나. 서비스 이용 전, 이용자는 카카오톡ID, 카카오톡 닉네임, 프로필 사진 등 서비스의 제공에 필요한 개인정보의 제공 및 이용에 동의하여야 합니다. 동의하지 않으실 경우 서비스를 이용할 수 없습니다.\n다. 마블스는 제휴사와 여러가지의 서비스를 제공할 수 있습니다. 서비스의 특성 상, 여러 개의 서비스에 가입한 회원이 서비스 이용을 해지하고자 하는 경우 가입한 서비스 별로 해지(회원탈퇴)신청을 하여야 합니다.\n라. 서비스는 카카오톡 회원 정보를 이용하여 제공되는 서비스이므로, 회원이 카카오톡 회원 자격을 상실하거나 카카오톡 회원 탈퇴 시 정상적으로 서비스의 제공이 이루어지지 않을 수 있습니다.\n마. 설치된 콘텐츠를 삭제 할 경우, 회원이 보유하고 있던 아이템 등 이용 정보가 삭제되는 경우가 있을 수 있으므로 사전에 확인 후 삭제하시기 바랍니다.\n\n7. 위치기반서비스 제공\n가. 마블스는 위치기반서비스가 포함된 콘텐츠에 한하여 위치정보를 활용하여 콘텐츠에서 제공하는 혜택이나 광고주의 이벤트에 참여함으로써 해당 혜택을 이용할 수 있도록 하는 등의 위치기반서비스를 제공할 수 있습니다.\n나. 위치기반서비스는 모바일 기기의 위치정보를 위치정보사업자로부터 전달받아 무료로 제공합니다. 단, 위치기반서비스 이용과정에서 이용자에게 통신비용이 발생할 수 있습니다.\n다. 마블스는 아래같은 방법으로 위치기반서비스를 제공합니다.\n 1) 마블스는 이용자가 위치기반서비스가 포함된 콘텐츠에 접속한 후 위치정보이용에 동의한 경우 이용자의 위치정보를 이용합니다.\n 2) 마블스는 위치정보 제공에 동의하지 않은 이용자의 위치정보는 이용하지 않습니다.\n 3) 이용자가 자동 로그인 기능을 선택하지 않거나 위치정보 이용에 동의하지 않은 경우 서비스에 접속할 때 마다 위치정보 이용에 대한 동의 여부를 확인 할 수 있으며, 동의하지 않을 경우 위치정보와 관계된 서비스의 정상적인 이용이 어려울 수 있습니다.\n 4) 마블스는 위치정보 이용에 동의한 이용자가 위치기반서비스가 포함된 콘텐츠에 접속한 경우 GPS, 기지국위치정보, WIFI-AP 기술을 통해 위치정보를 수집하여 위치기반서비스를 제공합니다.\n 5) 마블스는 이용자가 지도를 통해 자신의 위치 조회를 요청하는 경우 위치정보를 이용 할 수 있습니다.\n 6) 이용자가 원하는 경우 언제든지 서비스 탈퇴를 할 수 있으며, 서비스를 탈퇴한 경우 위치정보 이용에 대한 이용자의 동의는 철회한 것으로 간주합니다.\n라. 이용자과 법정대리인은 위치기반서비스와 관련하여 아래와 같은 권리를 가집니다.\n 1) 이용자은 자신의 위치정보 이용 및 제공에 대한 동의의 전부 또는 일부를 철회할 수 있으며, 언제든지 자신의 위치정보의 이용 또는 제공의 일시적인 중지를 요구할 수 있습니다. 이 경우 마블스는 요구를 거절하지 아니하며, 이를 위한 기술적 수단을 갖추고 있습니다.\n 2) 이용자은 이용자에 대한 위치정보 이용, 제공사실 확인자료, 이용자의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법령의 규정에 의하여 제3자에게 제공된 이유 및 내용 자료의 열람 또는 고지’를 마블스에 요구할 수 있고, 당해 자료에 오류가 있는 경우에는 그 정정을 요구할 수 있습니다. 이 경우 마블스는 정당한 이유 없이 요구를 거절하지 아니합니다.\n 3) 마블스는 이용자가 동의의 전부 또는 일부를 철회한 경우에는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항의 규정에 의하여 기록 및 보존하여야 하는 위치정보 수집, 이용 및 제공사실 확인자료를 제외하고 지체 없이 수집된 개인위치정보를 파기합니다.\n 4) 마블스는 만14세 미만 아동의 개인위치정보를 이용 또는 제공하고자 하는 경우(개인위치정보주체가 지정하는 제3자에게 제공하는 서비스를 하고자 하는 경우 포함)에는 14세미만의 아동과 그 법정대리인의 동의를 받아야 합니다.\n 5) 법정대리인은 만14세 미만 아동의 개인위치정보를 이용 또는 제공하는 것에 동의하는 경우 동의유보권, 동의철회권 및 일시중지권, 열람 및 고지요구권을 행사할 수 있습니다.\n 6) 마블스는 8세 이하의 아동 등(금치산자, 중증 정신장애인 포함)의 보호의무자가 개인위치정보의 이용 또는 제공에 서면으로 동의하는 경우에는 해당 본인의 동의가 있는 것으로 보며, 이 경우 보호의무자는 개인위치정보주체의 권리를 모두 행사할 수 있습니다.\n 7) 이용자은 위치기반서비스와 관련된 권리행사를 위하여 다음의 연락처를 이용하여 마블스에 요구할 수 있습니다.\n    회사명: (주)마블스\n    주소: 서울특별시 구로구 구일로8길20 비-501호(구로동,현진그린빌)\n    대표자 : 도윤정\n    전화번호: 02-6092-8784\n마. 마블스는 이용자의 위치정보를 안전하게 관리 및 보호하고 개인위치정보주체의 불만을 원활히 처리할 수 있도록 아해와 같이 위치정보관리책임자를 지정하여 운영합니다.\n 1) 소  속 : 운영정책실\n 2) 성  명 : 이상민\n 3) 연락처 : 02-6092-8784\n 위치정보관리책임자는 2015년 7월을 기준으로 다음과 같이 지정합니다.\n바. 마블스는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항에 근거하여 이용자의 개인위치정보 및 위치정보 이용, 제공사실 확인자료를 1년간 보관하며, 이용자의 서비스 탈퇴 시 마블스는 이용자의 위치정보를 지체 없이 파기하겠습니다.\n사. 마블스는 이용자의 동의 없이 당해 이용자의 개인위치정보를 제3자에게 제공하지 아니하며, 제3자 에게 제공하는 경우에는 제공 받는 자 및 제공목적’을 사전에 이용자에게 고지하고 동의를 받습니다.\n아. 마블스는 이용자의 개인위치정보를 이용자가 지정하는 제3자에게 제공하는 경우에는 개인위치정보를 수집한 당해 통신단말장치로 매회 개인위치정보를 제공받는 자, 제공 일시 및 제공목적을 즉시 통보합니다.\n자. 전항의 내용에도 불구하고 아래에 해당하는 경우에는 이용자가 미리 특정하여 지정한 모바일 기기 또는 푸쉬알림, 전자우편 등으로 통보합니다.\n 1). 개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우\n 2). 이용자가 개인위치정보를 수집한 당해 통신단말장치 외의 모바일 기기 또는 푸쉬알림, 전자우편 등으로 통보할 것을 미리 요청한 경우\n차. 위치기반서비스를 사용하는 콘텐츠는 이용자의 모바일 기기와 지속적으로 통신하여 위치정보를 수집하고 이 정보를 콘텐츠에 반영하여 서비스를 제공할 수 있습니다. 단, 이용자가 콘텐츠에서 위치 알림을 설정하지 않은 경우 마블스는 위치기반서비스를 제공하지 않습니다.\n\n8. In-App결제\n가. 마블스앱은 In-App아이템 구매를 위한 In-App결제 기능을 포함하고 있습니다.\n나. 이용자는 단말기의 비밀번호 설정 기능, 오픈마켓에서 제공하는 비밀번호 설정 기능 등을 이용하여 제 3자의 In-App결제를 방지하여야 하며, 마블스는 이를 위하여 방송통신위원회의 권고 및 오픈마켓 모바일콘텐츠 결제 가이드라인에 따라 오픈마켓이 제공하는 인증절차 등이 적용된 In-App결제를 위한 모듈, 라이브러리 등을 마블스앱에 적용합니다.\n다. 이용자가 단말기 및 오픈마켓의 비밀번호 설정 기능 등을 이용하지 않아 발생하는 제3자의 In-App결제에 대하여 마블스는 어떠한 책임도 부담하지 않습니다.\n라. 이용자가 이동통신사에서 제공하는 청소년 요금제 등에 가입한 경우, 해당 단말기에서의 In-App결제는 법정대리인의 동의가 있는 것으로 간주됩니다.\n마. 이용자는 In-App결제 대금을 성실히 납부하여야 할 책임이 있습니다.\n\n9. 청약철회, 미성년자 결제취소\n가. 마블스앱에서 판매되는 In-App아이템은 전자상거래 등에서의 소비자보호에 관한 법률 및 콘텐츠산업 진흥법 등 관련 법령에 따라 청약철회가 가능한 것과 제한되는 것으로 구분됩니다. 청약철회가 가능한 In-App아이템의 경우 이용자는 해당In-App아이템 구매 후 7일 이내에 사용하지 않는 In-App아이템에 한하여 전화 또는 이메일 등을 통하여 마블스에 청약철회를 요청할 수 있습니다. 단, 마블스앱에서 판매되는 In-App아이템의 내용이 표시, 광고 내용과 다르거나 계약 내용과 다르게 이행된 경우 이용자는 해당 In-App아이템의 구매일로부터 3개월 또는 In-App아이템과 표시 내용 등과의 상이함이나, 하자가 있음을 알았거나, 알 수 있었던 날로부터 30일 이내에 청약철회가 가능합니다. 마블스는 청약철회가 제한되는 In-App아이템에 대하여 In-App결제 전에 청약철회가 제한됨을 표시합니다.\n나. 다음과 같은 경우 In-App아이템의 청약철회가 제한됩니다.\n- 단품형 In-App아이템의 경우\n- 구매 후 즉시 사용이 시작되거나 즉시 마블스앱에 적용되는 In-App아이템의 경우\n- 부가혜택이 제공되는 In-App아이템에서 해당 부가혜택이 사용된 경우\n- 묶음형으로 판매된 In-App아이템의 일부가 사용된 경우\n- 개봉행위를 사용으로 볼 수 있거나 개봉 시 효용이 결정되는 캡슐형/확률형 In-App아이템의 경우\n- 마블스앱에서 판매되는 In-App아이템을 미성년자가 법정대리인의 동의 없이 구매한 경우, 미성년자 또는 법정대리인은 In-App결제를 취소할 수 있습니다. 단, 미성년자의 In-App결제가 법정대리인으로부터 처분을 허락 받은 재산의 범위 내인 경우 또는 미성년자가 사술 등을 이용하여 성인으로 믿게 한 때에는 취소가 제한됩니다. In-App아이템 구매자가 미성년자인지 여부는 In-App결제가 진행된 단말기 또는 신용카드 등 결제수단의 명의자를 기준으로 판단됩니다.\n\n10. 환급신청 및 절차\n가. 이용자는 이 약관에서 정하는 환급신청 사유에 해당하는 경우 이 약관 2번 항목(서비스 주체의 구분)에 명시된 마블스앱 서비스 주체에게 이 약관에서 정하는 바에 따라 환급을 신청하여야 합니다. 단, 앱스토어(Appstore)의 경우 마블스는 이용자의 In-App결제 여부를 확인할 수 없도록 되어있으며, 따라서 이용자는 애플에 직접 환급을 신청하여야 합니다.\n나. 이용자의 정당한 청약철회, 결제취소에 따른 환급 요청을 받은 경우 마블스는 이용자가 구매한 In-App아이템을 반환, 회수 또는 삭제하고 환급에 필요한 서류등을 접수한 날로부터 3일(영업일) 이내에 전자상거래 등에서의 소비자 보호에 관현 법률 등 관련 법령에 따라 오픈마켓사업자에 대한 결제취소 요청 등 필요한 환급절차를 진행합니다.\n다. 이용자가 구매한 In-App아이템에 대한 청약철회를 요청하였으나 해당 In-App아이템의 일부를 사용 또는 소비한 경우 마블스는 그 In-App아이템의 일부 사용 또는 소비에 의하여 이용자가 얻은 이익 또는 그 In-App아이템의 공급에 소요된 비용에 상당하는 금액을 이용자에게 청구할 수 있으며, 이에 따라 마블스는 이용자가 해당 금액을 납부한 날로부터 3일(영업일) 이내에 결제취소 요청 등 필요한 환급절차를 진행합니다.\n라. 이용자의 In-App결제가 이동통신사의 정보이용료로 청구되는 경우에 있어서 이용자의 환급 요청이 이동통신사의 이용자에 대한 정보이용료 청구 이후에 이루어진 경우 환급은 이동통신사의 정책에 따라 원칙적으로 익월 이용자의 이동통신사 요금에서 차감하는 방식으로 진행됩니다.\n마. 이용자가 이 약관에서 정한 바에 따라 환급을 요청하시는 경우 팩스, 우편 등을 통하여 마블스로 아래 서류를 제출하셔야 합니다.\n- 환급요청서\n- 환급요청자의 본인 확인을 위한 서류\n- 환급요청자의 단말기 가입증명을 위한 서류\n- 미성년자 및 법정대리인을 증명할 수 있는 서류(사본 가능, 미성년자 결제 취소의 경우에 한함)\n- 마블스앱의 구매를 위한 결제 및 In-App결제는 오픈마켓사업자가 제공하는 결제방식에 따릅니다. 따라서 마블스앱 구매 또는 In-App결제 과정에서 오과금이 발생하는 경우 원칙적으로 오픈마켓사업자에게 환급을 요청하여야 합니다. 단, 오픈마켓사업자의 정책, 시스템에 따라 가능한 경우 마블스가 오픈마켓사업자에게 필요한 환급절차의 이행을 요청할 수도 있습니다.\n- 선물하기 기능을 통하여 이루어진 In-App결제에 대하여는 구매한 In-App아이템 하자가 있는 경우를 제외하고는 원칙적으로 환급이 불가하며 In-App아이템의 하자로 인한 환급은 선물을 보낸 이용자에 한하여 가능합니다.\n\n11. 권리, 의무\n가. 마블스의 권리, 의무는 다음과 같습니다.\n나. 마블스앱 및 마블스앱에서 각종 데이터, 아이템등(이하 아이템등 이라 합니다.)에 대한 소유권과 지식재산권은 마블스가 보유하며, 이용자는 마블스앱 및 아이템등을 이용할 권리만을 갖습니다.\n다. 마블스는 마블스앱의 이용 및 이용약관의 내용과 관련하여 이용자로부터 제기되는 각종 의견이나 불만사항을 최대한 신속히 처리하여 이용자에게 그 결과를 통지할 것입니다.\n라. 마블스는 마블스앱에서 이용자간에 발생하는 문제에 대하여는 개입하지 않습니다.\n마. 마블스는 이용자에게 무료로 제공하는 마블스앱 서비스에 대하여는 고의, 중과실이 없는 한 어떠한 책임도 부담하지 않습니다.\n바. 마블스는 이용자가 이 약관 또는 관계 법령에 반하는 행위를 하는 경우 마블스앱의 이용을 제한 또는 차단할 수 있으며, 이용자는 이를 이유로 환급, 보상 등을 청구할 수 없습니다.\n사. 마블스는 이용자가 마블스앱 내에서 다른 이용자와 주고 받는 채팅 대화나, 쪽지 게시판 글을 저장할 수 있으며, 이용자는 이에 동의합니다. 마블스는 저장된 채팅 대화, 쪽지, 게시판 글 등을 비정상적인 마블스앱의 이용 제재나 이용간 분쟁해결 등에 한하여 사용할 것이며 필요 최소한의 인원만이 이를 확인할 수 있도록 조치할 것입니다.\n아. 마블스는 이 약관에 반하는 이름이나, 명칭, 게시물, 쪽지 등을 사전 경고 없이 삭제할 수 있습니다.\n자. 이용자의 권리, 의무는 다음과 같습니다.\n- 이용자는 이 약관 및 관계 법령에서 정하는 경우를 제외하고는 1일, 24시간, 365일 마블스앱을 이용할 수 있습니다.\n- 이용자는 자신의 단말기 및 마블스 계정 관리에 대한 주의 의무가 있으며, 만약 제3자에게 이용자의 단말기 또는 계정을 이용하게 하는 경우 그에 대한 일체의 책임은 이용자가 부담합니다. 따라서 이용자는 단말기의 비밀번호, 설정기능, 오픈마켓에서 제공하는 비밀번호 설정 기능 등을 통하여 제3자가 이용자의 단말기 또는 마블스 계정을 통하여 마블스앱을 이용하도록 하는 경우 해당 제3자의 이용행위를 관리, 감독하여야 할 의무가 있습니다. 방송통신위원회의 오픈마켓 모바일콘텐츠 가이드라인 및 권고, 오픈마켓사업자의 결제 정책을 모두 준수한 경우, 이용자는 제3자의 이용 및 결제를 이유로 마블스에게 환급, 배상 등을 청구할 수 없습니다.\n- 이용자가 임의로 다운로드형 게임앱을 삭제하거나 네트워크형 게임앱에서 마블스 계정 회원탈퇴를 하는 경우 마블스는 이에 대한 어떠한 보상이나 환급에 대하여도 책임을 지지 않습니다.\n- 이용자가 마블스앱 내에서 In-App아이템을 구매하는 경우 오픈마켓에서 제공하는 결제수단을 통하여 In-App아이템 구매 금액을 결제하고 그에 대한 대금을 성실히 납부하여야 합니다.\n\n12. 이용계약의 해제, 해지 및 이용제한\n가. 마블스는 이용자가 다음 사항에 해당하는 경우 운영정책 및 이 약관의 이용제한기준에 따라 이용자와의 이용계약을 해지하거나 일시 또는 영구적으로 마블스앱의 이용을 제한 또는 차단할 수 있습니다.\n나. 타인 명의 도용 또는 허위 명의 사용 또는 운영자 사칭 등의 행위\n다. 마블스앱 또는 마블스앱의 데이터 등을 임의로 수정, 조작, 변경하는 행위\n라. 다른 이용자의 명예를 훼손 또는 모욕하거나 성적 또는 인격적 수치심을 유발하게 하는 행위\n마. 다른 이용자를 협박하거나 지속적으로 고통을 주는 행위\n바. 마블스앱을 영리목적 또는 범죄목적으로 이용하는 행위\n사. 타인의 개인정보를 해당 개인정보주체의 동의 없이 수집하거나 공개하는 행위\n아. 마블스앱의 아이템등이나 마블스 계정 등을 마블스 허락 없이 매매, 양도, 이전하거나 담보로 제공하는 행위\n자. In-App아이템을 마블스앱에서 정한 방법 이외의 비정상적인 방법으로 구매하거나 마블스가 아닌 제3자로부터 구매하는 행위\n차. 미성년자가 법정대리인의 동이 없이 In-App결제를 하거나 만 14세 미만의 자가 법정대리인의 동이 없이 개인정보를 제공하는 행위\n카. 마블스앱의 버그를 악용, 유포하거나 비정상적인 방법으로 아이템 등을 획득 또는 그러한 방법을 유포하는 행위\n타. 이용자가 마블스앱 및 In-App아이템 결제금액을 납부하지 않는 경우\n파. 기타 게임산업진흥에 관한 법률, 콘텐츠산업 진흥법, 청소년 보호법, 형법 등 관련 법률을 위반하는 행위\n하. 이용자는 언제라도 마블스앱을 삭제하거나 마블스앱의 이용에 필요한 마블스 계정에서 회원 탈퇴를 통하여 마블스앱의 이용계약을 해지할 수 있습니다. 이 경우 이용자는 이미 구매 또는 사용한 In-App아이템에 대하여 환급을 요청할 수 없습니다.\n\n13. 기간제서비스의 해지\n가. 마블스는 일정한 기간을 정하여 서비스를 제공하는 기간제서비스를 제공할 수 있으며, 기간제서비스의 이용대금은 기간에 따라 할인율이 차등 적용될 수 있습니다.\n나. 이용자가 기간제서비스를 이용하는 경우 해당 기간제서비스에 하자가 있는 경우를 제외하고는 해지예약을 신청하여야 하며, 해지예약에 따른 해지의 효과는 해당 기간제서비스의 단위기간 종료일에 발생합니다. 단, 기간제서비스의 단위기간이 1개월 이상인 거래(이하 계속거래라 합니다.)의 경우에는 언제라도 해지가 가능합니다.\n다. 마블스가 기간제서비스를 제공함에 있어서 약정 기간에 따른 대금 할인율이 다르고 이용자가 장기의 기간제서비스에 대한 이용계약을 체결한 후 이동자의 이용기간이 단기인 기간제서비스 기간을 경과한 후 해지하는 경우, 마블스는 환급금액을 결정함에 있어 단기 할인율을 적용합니다.\n라. 계속거래에 해당하는 기간제서비스의 해지에 따른 위약금은 해당 거래 전체 대금의 10%로 하며, 위약금은 계속거래에 해당하는 기간제서비스의 해지에 책임이 있는 당사자가 부담합니다.\n\n14. 손해배상 및 면책\n가. 마블스는 전쟁, 국가비상사태, 천재지변 등의 불가항력적인 사유, 오픈마켓사업자, 이동통신사업자 등에게 책임이 있는 사유, 단말기 성능이나 네트워크 기능 문제 또는 이용자에게 책임이 있는 사유로 인하여 마블스앱의 이용에 장애가 발생한 경우 등 마블스에게 책임 없는 사유로 인하여 발생한 문제에 대하여는 어떠한 책임도 부담하지 않습니다.\n나. 마블스는 이용자의 기기변경, 번호변경, 해외로밍 등의 사유로 인한 마블스앱의 이용 장애 또는 마블스앱 및 데이터 등의 손실에 대하여는 어떠한 책임도 부담하지 않습니다.\n다. 마블스는 관련 법령에서 허용되는 범위 하에서 이용자에게 발생한 간접적, 우연적, 특수적, 결과적, 확대 손해에 대하여는 책임을 부담하지 않습니다.\n라. 마블스는 고의, 중과실이 없는 한 이용자가 다른 이용자로부터 받은 손해에 대하여는 책임을 부담하지 않습니다.\n마. 마블스는 마블스앱을 현상태 그대로 제공하며, 마블스앱에 하자 또는 버그가 없다거나 특정한 목적에 부합한다거나 제3자의 지적재산권 등의 권리를 침해하지 않음을 이용자에게 보증하지 않습니다.\n\n15. 약관의 해석 및 약관 이외의 준칙\n 본 약관에서 명시되지 아니한 사항에 대해서는 마블스의 운영정책, 이용제한규정, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 콘텐츠산업 진흥법, 약관의 규제에 관한 법률, 전자상거래 등에서의 소비자 보호에 관한 법률, 위치정보의 보호 및 이용 등에 관한 법률, 기타 대한민국의 관련 법 규정에 의합니다\n\n부칙\n이 약관은 2015년 08월 01일부터 적용됩니다.\n2012년 12월 10일부터 시행되던 종전의 정책은 본 정책으로 대체합니다.",

"개인정보 수집 및 이용에 대한 안내\n\n개인정보의 수집 및 이용동의\n\n이 약관은 주식회사 마블스, 마블스(이하 마블스, 마블스라 한다)는 고객의 원활한 게임 이용과 회사의 더 나은 게임서비스를 위하여 다음과 같이 고객의 개인정보를 수집, 이용함에 있어서 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 개인정보보호법 등 관련 법령에 따라 아래와 같이 개인정보 수집 및 이용에 관하여 동의를 받고 있습니다. 아래 내용을 잘 읽어 보시고 동의 여부를 체크해 주시기 바랍니다.\n\n1. 개인정보의 수집 및 이용 목적\n  마블스는 수집한 개인정보를 다음의 목적을 위해 고지한 범위 내에서 사용 및 활용하며, 원칙적으로 이용자의 사전동의 없이는 이용자의 개인정보를 외부에 공개하지 않습니다.(단 이용자가 사전에 개인정보 공개에 대하여 동의한 경우와 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우에는 외부에 공개합니다)\n가. 콘텐츠 제공 및 특정 맞춤 서비스제공, 정식구매인증,구매 및 요금 결제\n나. 고객 서비스 이용에 따른 본인확인, 개인식별, 불량고객의 부정이용 방지화 비인가 사용방지, 인증의사 확인, 분쟁 조정을 위한 기록 보존, 불만처리 등 민원처리, 공지사항 전달\n다. 신규 서비스 개발, 통계학적 특성에 따른 서비스 제공 및 광고 게재. 서비스의 유효성 확인, 이벤트 및 광고 성 정보 제공 및 참여기회 제공, 접속빈도 파악, 고객의 서비스이용에 대한 통계\n\n2. 수집하는 개인정보 항목 및 수집 방법\n 마블스는 원활한 고객상담, 각종서비스제공, 데이터 통계 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.\n가. 수집항목\n 이용자의 휴대전화, 게임이용기록, 접속 로그 및 인증일자, 결제기록, 게임버전, 통신사정보, 단말기 정보(모델명, 통신사정보, OS버전, 기기고유 버전)\n나. 개인정보 수집방법\n 마블스는 게임 구매 후 최초 실행 시, 게임 이용 중, 네트워크 접속 시 개인정보를 수집합니다.\n\n3. 개인정보의 보유 및 이용기간\n 원칙적으로 개인정보 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.\n 단, 관계법령의 규정의 의하여 보존 할 필요가 있는 경우 마블스는 아래와 같이 관계 법령에서 정한 일정한 기간 동안 개인정보를 보관합니다.\n가. 보존 항목\n 마블스는 1. 수집하는 개인정보 항목 및 수집방법(중)가. 수집항목 의 내용 모두를 보존한다.\n나. 관계법령에 의한 정보보호사유상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사 관계법령에서 정한 일정한 기간 동안 고객 정보를 보관합니다.\n 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.\n\n  계약 또는 청약철회 등에 관한 기록\n  보존이유: 전자상거래 등에서의 소비자보호에 관한 법률\n  보존기간: 5년\n\n  대금결제 및 재화 등의 공급에 관한 기록\n  보존이유: 전자상거래 등에서의 소비자보호에 관한 기록\n  보존 기간 : 5년\n\n  소비자의 불만 또는 분쟁처리에 관한 기록\n  보존이유: 전자상거래 등에서의 소비자보호에 관한 법률\n  보존기간: 3년\n\n  방문에 관한 기록\n  보존이유: 통신비밀보호법\n  보존기간: 3개월\n\n5. 개인정보 파기절차 및 방법\n 이용자의 개인정보는 수집 및 이용목적이 달성되면 지체 없이 파기되며, 파기 절차 및 방법은 아래의 기준에 의해 관리됩니다.\n가. 파기절차\n 이용자가 회원가입 등을 위해 입력한 정보는 목적이 달성된 후 내부 방침 및 기타 관련 법령에 의한 보관 기간 동안 저장된 후 파기됩니다.\n나. 파기방법\n 1) 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.\n 2) 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.\n\n6. 이용자 및 법정대리인의 권리와 그 행사방법\n가. 이용자는 1조, 2조 항목에 대하여 거부할 권리가 있으며 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며, 해지나 수정을 원하시는 경우 마블스앱의 옵션 회원탈퇴 메뉴를 이용해 직접 수정 또는 해지할 수 있습니다. 단, 해지시 서비스 이용을 하실 수 없으며, 개인정보는 제5조의 규정에 따라 처리됩니다.\n나. 정보통신망이용촉진및정보보호등에관한법률 상 만14세 미만의 아동은 온라인으로 타인에게 개인정보를 보내기 전에 반드시 개인정보의 수집 및 이용목적에 대하여 충분히 숙지하고 법정대리인(부모)의 동의를 받아야 하며, 게임산업진흥에관한법률 상 만18세 미만의 청소년은 회원 가입 시 법정대리인(부모)의 동의를 받아야 합니다.\n이에 마블스는 모바일 서비스 이용약관 등을 통해 위 사항을 설명하고 있으며 가입 시에는 반드시 법정대리인(부모)의 동의를 받는 확인절차를 거치고 있습니다.\n다. 이와 같이 수집한 법정대리인(부모)의 개인정보는 만18세 미만 청소년의 개인정보 수집·이용에 대한 동의 여부 확인, 동의 계정 개수 제한, 만18세 미만 청소년 개인정보 열람, 정정 등을 위한 고객지원, 미성년회원의 유료서비스 이용에 대한 동의 여부 확인 등의 목적으로 사용 되며, 이메일 주소는 만18세 미만 청소년의 게임이용내역 고지의 목적으로 사용됩니다. 해당 정보는 미성년회원의 회원 탈퇴 시까지 보유 합니다.\n라.만18세 미만 청소년의 법정 대리인(부모)은 청소년의 개인정보 열람, 정정, 개인정보 제공 및 회원가입에 대한 동의 철회를 요청할 수 있으며, 이러한 요청이 있을 경우 마블스는 지체 없이 필요한 조치를 취합니다.\n\n7. 개인(위치)정보 관리책임자 및 담당부서의 연락처\n 마블스는 이용자의 개인정보 및 위치정보를 안전하게 관리 및 보호하고, 개인정보주체 및 개인위치정보주체의 불만을 원활히 처리할 수 있도록 아래와 같이 개안정보관리책임자 및 위치정보관리책임자를 지정하여 운영합니다.\n \n 개인(위치)정보 관리책임자\n 1) 소  속 : 운영정책실\n 2) 직  책 : 실장  \n 3) 성  명 : 이상민\n 4) 연락처 : 02-6092-8784 / 010-2044-0205\n 5) 이메일 : marbles01.inc@gmail.com\n\n개인(위치)정보관리 담당부서\n 1) 부서명 : 운영정책실\n 2) 전화번호 : 02-6092-8784\n 3) 이메일 : marbles01.inc@gmail.com\n \n8.기타\n마블스는 이용자들의 개인정보와 관련하여 이용자 분들의 의견을 수렴하고 있으며 불만을 처리하기 위하여 모든 절차와 방법을 마련하고 있습니다.\n이용자들은 상단에 명시한 개인정보관리책임자 및 담당부서의 연락처 항을 참고하여 전화 등의 정해진 절차를 통해 불만사항을 신고할 수 있고, 마블스는 이용자들의 신고사항에 대하여 신속하고도 충분한 답변을 해 드릴 것입니다.\n\n기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.\n- 개인정보침해신고센터 (http://privacy.kisa.or.kr/ 국번없이 118)\n- 대검찰청 사이버범죄수사단 (http://www.spo.go.kr/ 02-3480-3571)\n- 경찰청 사이버테러대응센터 (http://www.ctrc.go.kr/ 국번없이 182)\n\n9. 고지의 의무\n개인정보취급방침의 내용 추가, 삭제 및 수정이 있을 시에는 개정 최소 7일전부터 서비스 초기화면의 [공지사항]을 통해 고지할 것입니다.\n\n부칙\n이 약관은 2015년 08월 01일부터 적용됩니다.\n2012년 12월 10일부터 시행되던 종전의 정책은 본 정책으로 대체합니다.",

"Eng1",

"Eng2"

	};

      out.write('\r');
      out.write('\n');

	//1. 생성자 위치
	StringBuffer msg 			= new StringBuffer();
	int lang 					= util.getParamInt(request, "lang", 0);
	int idx						= lang;
	if(lang >= strAgreement.length){
		idx = 0;
	}

	//2-3. xml형태로 데이타 출력
	msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
	msg.append("<rows>\n");
	msg.append("	<result>\n");
	msg.append("		<code>");			msg.append(PTS_AGREEMENT); 				msg.append("</code>\n");
	msg.append("		<resultcode>");		msg.append(1);    						msg.append("</resultcode>\n");
	msg.append("		<resultmsg>");		msg.append("약관동의("+lang+")");		msg.append("</resultmsg>\n");
	msg.append("		<resultagreement>");msg.append(strAgreement[idx*2    ]);  	msg.append("</resultagreement>\n");
	msg.append("		<resultsms>");		msg.append(strAgreement[idx*2 + 1]);  	msg.append("</resultsms>\n");
	msg.append("	</result>\n");
    msg.append("</rows>\n");
	out.print(msg);

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
