package org.apache.jsp.goo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class _005flist_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/goo/_define.jsp");
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
      response.setContentType("text/html; charset=EUC-KR");
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


      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head> \r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=EUC-KR\">\r\n");
      out.write("<title></title>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"../admin/image/intra.css\" type=\"text/css\">\r\n");
      out.write("<head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table border=1 align=center>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td colspan=3 align=center>\r\n");
      out.write("\t\t\tTest URL > http://203.234.238.249:40009/Game4/goo/_list.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tcreateid.jsp(폐기처분)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=createid.jsp?gameid=sangsang&password=049000s1i0n7t8445289&market=1&buytype=0&platform=1&ukey=xxxxx&version=101&phone=01011112222&pushid=>아이디생성</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=sangsang        <br>\r\n");
      out.write("\t\t\tpassword=ppp           <br>\r\n");
      out.write("\t\t\tmarket=1               <br>\r\n");
      out.write("\t\t\tbuytype=0              <br>\r\n");
      out.write("\t\t\tplatform=1             <br>\r\n");
      out.write("\t\t\tukey=xxxxx             <br>\r\n");
      out.write("\t\t\tversion=101      \t   <br>\r\n");
      out.write("\t\t\tphone=01011112222      <br>\r\n");
      out.write("\t\t\tpushid=xxxx            <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t-->\r\n");
      out.write("\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tnewstart.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=newstart.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaouserid=kakaouseridxxxx2>계정정지</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tkakaouserid=xxxx       <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tcreateguest.jsp(이걸로 계정생성)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=createguest.jsp?gameid=farm&password=049000s1i0n7t8445289&market=5&buytype=0&platform=1&ukey=xxxxx&version=101&phone=01011112222&pushid=>farm아이디생성</a><br>\r\n");
      out.write("\t\t\t<a href=createguest.jsp?gameid=farm&password=049000s1i0n7t8445289&market=5&buytype=0&platform=1&ukey=xxxxx&version=101&phone=01011112222&pushid=&kakaotalkid=kakaotalkidxxxx2>farm 재연결</a><br>\r\n");
      out.write("\t\t\tgameid에 farm라고만하면 자동으로 생성한다.\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=farm           <br>\r\n");
      out.write("\t\t\tpassword=(클라자동생성)<br>\r\n");
      out.write("\t\t\tmarket=1               <br>\r\n");
      out.write("\t\t\tbuytype=0              <br>\r\n");
      out.write("\t\t\tplatform=1             <br>\r\n");
      out.write("\t\t\tukey=xxxxx             <br>\r\n");
      out.write("\t\t\tversion=101      \t   <br>\r\n");
      out.write("\t\t\tphone=01011112222      <br>\r\n");
      out.write("\t\t\tpushid=xxxx            <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tlogin.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=login.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&market=5&version=199>로그인</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tmarket=1\t\t\t\t<br>\r\n");
      out.write("\t\t\tversion=101\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tkchecknn.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=kchecknn.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaonickname=xxxx2>닉네임 변경</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx    <br>\r\n");
      out.write("\t\t\tpassword=xxxx    <br>\r\n");
      out.write("\t\t\tkakaonickname=xxxx    <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tkfadd.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=kfadd.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaofriendlist=0:kakaouseridxxxx;1:kakaouseridxxxx3;>카카오 친구추가</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tkakaofriendlist=kakaouseridxxxx;1:kakaouseridxxxx3;       <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tkfreset.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=kfreset.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaofriendlist=0:kakaouseridxxxx;1:kakaouseridxxxx3;>카카오 친구reset</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tkakaofriendlist=kakaouseridxxxx;1:kakaouseridxxxx3;       <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tkfinvite.jsp\r\n");
      out.write("\t\t\t(카톡 초대)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=kfinvite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaouserid=kakaouseridxxxx>카카오 초대메세지 전송후</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tkakaouserid=kakaouseridxxxx<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tkfhelp.jsp\r\n");
      out.write("\t\t\t(내동물 살려줘)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=kfhelp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx&listidx=18>친구야 내동물 살려줘(xxxx2 -> xxxx)</a><br>\r\n");
      out.write("\t\t\t<a href=kfhelp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3&listidx=18>친구야 내동물 살려줘(xxxx2 -> xxxx3)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tfriendid=xxxx<br>\r\n");
      out.write("\t\t\tlistidx=xxxx<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tkfhelplist.jsp\r\n");
      out.write("\t\t\t(내게 요청한 친구들)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=kfhelplist.jsp?gameid=xxxx&password=049000s1i0n7t8445289>친구야 내동물 살려줘(xxxx:내게 요청한 리스트)</a><br>\r\n");
      out.write("\t\t\t<a href=kfhelplist.jsp?gameid=xxxx3&password=049000s1i0n7t8445289>친구야 내동물 살려줘(xxxx3:내게 요청한 리스트)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tchangepw.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=changepw.jsp?gameid=xxxx&password=049000s1i0n7t8445289&phone=77887878888999897807684710811117>패스워드변경</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx           \t<br>\r\n");
      out.write("\t\t\tpassword=새로운패스워드\t<br>\r\n");
      out.write("\t\t\tphone=암호화된폰\t\t<br>\r\n");
      out.write("\t\t\tstrPhoneNumber:01011112221<br>\r\n");
      out.write("\t\t\tstrPhoneNumberC:77887878888999897807684710811117<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tdailyreward.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=dailyreward.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>일일보상받기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t-->\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgiftgain.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-1&idx=75&listidx=-1&fieldidx=-1&quickkind=-1>쪽지받기</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=60&listidx=-1&fieldidx=-1&quickkind=-1>소받기</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=61&listidx=-1&fieldidx=0&quickkind=-1>양(자리지정)</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=69&listidx=-1&fieldidx=-1&quickkind=-1>악세받기</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=63&listidx=-1&fieldidx=-1&quickkind=-1>총알받기</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=63&listidx=24&fieldidx=-1&quickkind=1>총알받기(누적, 링크번호 확인요)</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=70&listidx=-1&fieldidx=-1&quickkind=-1>하트받기</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=74&listidx=-1&fieldidx=-1&quickkind=-1>대회티켓B받기</a><br>\r\n");
      out.write("\t\t\t<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-5&idx=-1&listidx=-1&fieldidx=-1&quickkind=-1>리스트보기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tidx=45\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\titembuy.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=7772&itemcode=4>동물구매</a><br>\r\n");
      out.write("\t\t\t<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=6&quickind=-1&randserial=122&itemcode=4>양(자리지정6)</a><br>\r\n");
      out.write("\t\t\t<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=124&itemcode=701>총알</a><br>\r\n");
      out.write("\t\t\t<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=123&itemcode=1401>악세</a><br>\r\n");
      out.write("\t\t\t<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=126&itemcode=5105>코인환전</a><br>\r\n");
      out.write("\t\t\t<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=126&itemcode=901>건초</a><br>\r\n");
      out.write("\t\t\t<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=127&itemcode=2000>하트</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\titemcode=\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tfieldidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tquickkind=\t\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\titemsell.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=itemsell.jsp?gameid=guest90269&password=2954812d7b3k0f645541&listidx=2&sellcnt=1>동물구매</a><br>\r\n");
      out.write("\t\t\t<a href=itemsell.jsp?gameid=guest90269&password=2954812d7b3k0f645541&listidx=7&sellcnt=1>총알</a><br>\r\n");
      out.write("\t\t\t<a href=itemsell.jsp?gameid=guest90269&password=2954812d7b3k0f645541&listidx=16&sellcnt=1>악세</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tsellcnt=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\titemselllist.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=itemselllist.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=1:65;2:69;>리스트로팔기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistset=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\titemquick.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=7&quickkind=1>총알</a><br>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=8&quickkind=1>치료제</a><br>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=9&quickkind=1>일꾼</a><br>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=10&quickkind=1>촉진제</a><br>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=7&quickkind=-1>총알(해제)</a><br>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=8&quickkind=-1>치료제(해제)</a><br>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=9&quickkind=-1>일꾼(해제)</a><br>\r\n");
      out.write("\t\t\t<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=10&quickkind=-1>촉진제(해제)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tquickkind=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\titemacc.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=itemacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=1&acclistidx=16&acc2listidx=-1>1번동물에 12번악세를 머리</a><br>\r\n");
      out.write("\t\t\t<a href=itemacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=1&acclistidx=-1&acc2listidx=17>1번동물에                  13번악세를 옆구리</a><br>\r\n");
      out.write("\t\t\t<a href=itemacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=1&acclistidx=16&acc2listidx=17>1번동물에 12번악세를 머리, 13번악세를 옆구리</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tanilistidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tacclistidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tacc2listidx=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\titemaccnew.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=itemaccnew.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=19&acclistidx=20&acc2listidx=22&randserial=7771>액세끼기</a><br>\r\n");
      out.write("\t\t\t<a href=itemaccnew.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=19&acclistidx=-2&acc2listidx=-2&randserial=7772>유지</a><br>\r\n");
      out.write("\t\t\t<a href=itemaccnew.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=19&acclistidx=-1&acc2listidx=-1&randserial=7773>벗기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tanilistidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tacclistidx=\t\t\t\t<br>\r\n");
      out.write("\t\t\tacc2listidx=\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t-->\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\titeminvenexp.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=1>동물 인벤확장.</a><br>\r\n");
      out.write("\t\t\t<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=3>소비템 인벤확장.</a><br>\r\n");
      out.write("\t\t\t<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=4>악세사리 인벤확장.</a><br>\r\n");
      out.write("\t\t\t<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=1040>줄기세포 인벤확장.</a><br>\r\n");
      out.write("\t\t\t<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=1200>보물 인벤확장.</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tinvenkind=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tfacupgrade.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=60&kind=1>집(시작)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=60&kind=2>집(즉시)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=61&kind=1>탱크(시작)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=61&kind=2>탱크(즉시)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=62&kind=1>저온보관(시작)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=62&kind=2>저온보관(즉시)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=63&kind=1>정화시설(시작)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=63&kind=2>정화시설(즉시)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=64&kind=1>양동이(시작)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=64&kind=2>양동이(즉시)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=65&kind=1>착유기(시작)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=65&kind=2>착유기(즉시)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=66&kind=1>주입기(시작)</a><br>\r\n");
      out.write("\t\t\t<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=66&kind=2>주입기(즉시)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tsubcategory=\t\t\t<br>\r\n");
      out.write("\t\t\tkind=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tdogamlist.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=dogamlist.jsp?gameid=xxxx&password=049000s1i0n7t8445289>도감리스트(획득, 보상받은것)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tdogamreward.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=dogamreward.jsp?gameid=xxxx&password=049000s1i0n7t8445289&dogamidx=1>도감보상</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tdogamidx=1\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttutorial.jsp(old버젼)<br>\r\n");
      out.write("\t\t\t사용안할 예정임\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=tutorial.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1>튜토리얼 정장</a><br>\r\n");
      out.write("\t\t\t<a href=tutorial.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2>튜토리얼 재튜토리얼</a><br>\r\n");
      out.write("\t\t\t<a href=tutorial.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=3>튜토리얼 스킵</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tmode=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttutostep.jsp(new버젼)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5500&ispass=-1>튜토리얼 step1</a><br>\r\n");
      out.write("\t\t\t<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5501&ispass=1>튜토리얼 step2(패스)</a><br>\r\n");
      out.write("\t\t\t<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5502&ispass=-1>튜토리얼 step3</a><br>\r\n");
      out.write("\t\t\t<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5503&ispass=-1>튜토리얼 step4</a><br>\r\n");
      out.write("\t\t\t<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5504&ispass=-1>튜토리얼 step5</a><br>\r\n");
      out.write("\t\t\t<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5505&ispass=-1>튜토리얼 step6</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\ttutostep=\t\t\t\t<br>\r\n");
      out.write("\t\t\tispass=\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tcompetition.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90100>경쟁모드 90100</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90101>경쟁모드 90101</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90102>경쟁모드 90102</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90103>경쟁모드 90103</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90104>경쟁모드 90104</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90105>경쟁모드 90105</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90106>경쟁모드 90106</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90107>경쟁모드 90107</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90108>경쟁모드 90108</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90109>경쟁모드 90109</a><br>\r\n");
      out.write("\t\t\t<a href=competition.jsp?gameid=guest91521&password=0362431g4n3v4r824568&comreward=90106&paraminfo=0:90106;1:4;2:0;3:0;4:201304;5:06:90106&ispass=1>경쟁모드 guest91521</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t\t<br>\r\n");
      out.write("\t\t\tcomreward=1\t\t\t\t<br>\r\n");
      out.write("\t\t\tispass=\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tuserparam.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=userparam.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listset=0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;>저장모드</a><br>\r\n");
      out.write("\t\t\t<a href=userparam.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listset=>읽기모드</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2           \t<br>\r\n");
      out.write("\t\t\tpassword=xxx\t\t\t<br>\r\n");
      out.write("\t\t\tmode=xxx\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistset=xxx\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tdeleteid.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=deleteid.jsp?gameid=xxxx&password=049000s1i0n7t8445289>유저 본인 아이디 삭제요청</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t-->\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\taniset.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<!--<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listset=0:1;1:2;2:3;3:4;4:5;5:6;6:12;7:13;8:14>동물설정(정상)</a><br>\r\n");
      out.write("\t\t\t<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listset=0:1;1:3;2:17;3:16;4:8>동물설정(대표, 죽은것 포함 > 자동필터)</a><br>-->\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11110201208004>동물설정(암호화)</a><br>\r\n");
      out.write("\t\t\t<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11151:2;045010>동물설정(암호화)</a><br>\r\n");
      out.write("\t\t\t<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11341:2;2:3;3:4;4:5;5:6;6:7124>동물설정(암호화)</a><br>\r\n");
      out.write("\t\t\t<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11891:3124;2:5;3:23;5:5;21:22;22:212;23:32;24:312;41:27;51:2116;52:2211;53:2;54:2;166>동물설정(암호화)</a><br>\r\n");
      out.write("\t\t\t<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=44615:9,5,5;7:9,67,4;8:9,69,-5;243>동물설정(암호화)</a><br>\r\n");
      out.write("\t\t\t<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=22932:7;3:4;32:3;33:3;34:97;42:3;52:3;53:32;54:3;55:32;56:42;57:332;62:922;076>동물설정(암호화)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tlistset=0:1;1:3\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanidie.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anidie.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listidx=1>눌러죽음(1)</a><br>\r\n");
      out.write("\t\t\t<a href=anidie.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listidx=4>늑대죽음(2)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tmode=1 or 2\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidx=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanirevival.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anirevival.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listidx=1&fieldidx=1>필드부활(부활석x1 or 캐쉬+1) > 필드로 넣기.</a><br>\r\n");
      out.write("\t\t\t<a href=anirevival.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listidx=4&fieldidx=-1>병원부활(부활석x2 or (캐쉬+1)*2) > 인벤으로 넣기.</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tmode=1 or 2\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidx=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tfieldidx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\taniuseitem.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=aniuseitem.jsp?gameid=xxxx5&password=049000s1i0n7t8445289&crypt=1&listset=44421:5;2:6;084>소모템(12번1개, 13번 1개)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx5         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tlistset=소모템리스트:사용개수...\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanirepreg.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=0>대표동물설정(정상.)</a><br>\r\n");
      out.write("\t\t\t<a href=anirepreg.jsp?gameid=xxx0&password=049000s1i0n7t8445289&listidx=0>대표동물설정(아이디없음.)</a><br>\r\n");
      out.write("\t\t\t<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=8>대표동물설정(소모템.)</a><br>\r\n");
      out.write("\t\t\t<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=1>대표동물설정(필드동물.)</a><br>\r\n");
      out.write("\t\t\t<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=99>대표동물설정(없음.)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tlistidx=17\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanihoslist.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anihoslist.jsp?gameid=xxxx&password=049000s1i0n7t8445289>동물병원리스트(요청처리, 병원리스트, 내집동물 리스트)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\taniupgrade.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=aniupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listidxani=2&listset=0:30;&randserial=7777>동물업그레이드</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tlistidxani=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistset=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanibattlestart.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anibattlestart.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&farmidx=6900&listset=0:2;1:39;1:38;>싸움시작</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tfarmidx=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistset=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanibattleresult.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anibattleresult.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&battleidx2=65&result=1&playtime=90&star=3>싸움End</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tbattleidx2=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tresult=\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tplaytime=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tstar=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanibattleplaycntbuy.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anibattleplaycntbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&farmidx=6900>부족한횟수구매</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tfarmidx=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tpackbuy.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=packbuy.jsp?gameid=xxxx&password=049000s1i0n7t8445289&idx=1&randserial=7772>패키지템 구매</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tidx=\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\troulbuy.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=roulbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7772&mode=1&friendid=xxxx3>일반교배</a><br>\r\n");
      out.write("\t\t\t<a href=roulbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7773&mode=2&friendid=xxxx3>프리미엄교배</a><br>\r\n");
      out.write("\t\t\t<a href=roulbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7774&mode=4&friendid=xxxx3>프리미엄교배(10+1)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tmode=\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttreasurebuy.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=treasurebuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7772&mode=1>일반보물뽑기</a><br>\r\n");
      out.write("\t\t\t<a href=treasurebuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7773&mode=2>프리미엄보물뽑기</a><br>\r\n");
      out.write("\t\t\t<a href=treasurebuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7774&mode=4>프리미엄보물뽑기(10+1)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tmode=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttreasureupgrade.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=treasureupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listidx=72&randserial=7772>일반강화</a><br>\r\n");
      out.write("\t\t\t<a href=treasureupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listidx=73&randserial=7773>캐쉬강화</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tmode=\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidx=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttreasurewear.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=treasurewear.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=1:72;2:73;3:74;4:-1;5:-1;>장착하기</a><br>\r\n");
      out.write("\t\t\t<a href=treasurewear.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=1:54;2:-1;3:-1;4:-1;5:-1;>장착하기(클리어)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tlistset=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tapartitemcode.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=apartitemcode.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&randserial=8771&listset=1:25;>1개분해(동물,보물)</a><br>\r\n");
      out.write("\t\t\t<a href=apartitemcode.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&randserial=8773&listset=1:34;3:26;4:27;5:28;6:29;7:30;8:31;9:32;10:33;>여러개분해(동물,보물)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tmode=xxx\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistset=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\troulacc.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=roulacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>악세뽑기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t-->\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\taniurgency.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=aniurgency.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>긴급지원</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanirestore.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anirestore.jsp?gameid=xxxx5&password=049000s1i0n7t8445289>다죽어서 복구요청</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanicompose.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anicompose.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&itemcode=101002&listidxbase=19&listidxs1=20&randserial=11>합성(풀)</a><br>\r\n");
      out.write("\t\t\t<a href=anicompose.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&itemcode=101006&listidxbase=21&listidxs1=22&randserial=12>합성(확률)</a><br>\r\n");
      out.write("\t\t\t<a href=anicompose.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=3&itemcode=101010&listidxbase=28&listidxs1=29&randserial=13>합성(수정)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tmode=\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\titemcode=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxbase=\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs1=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs2=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs3=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs4=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanipromote.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anipromote.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=102000&listidxs1=21&listidxs2=22&randserial=8888>승급</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\titemcode=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs1=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs2=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs3=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs4=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tlistidxs5=\t\t\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tanicomposeinit.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=anicomposeinit.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>합성시간초기화</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<!--\r\n");
      out.write("\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\troulette.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=roulette.jsp?gameid=xxxx>\r\n");
      out.write("\t\t\t\t[코인사용]\r\n");
      out.write("\t\t\t</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tfriendls.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=friendls.jsp?gameid=xxxx&harvest=1>\r\n");
      out.write("\t\t\t\t[라커룸 실버획득]\r\n");
      out.write("\t\t\t</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t<br>\r\n");
      out.write("\t\t\tharvest=1\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t-->\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fsearch.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=>\t\t검색 : 랜덤검색</a>\t<br>\r\n");
      out.write("\t\t\t<a href=fsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=DD>\t\t검색 : 이웃 > 0초</a><br>\r\n");
      out.write("\t\t\t<a href=fsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=AD>\t\t검색 : 없음 > 0초</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=DD\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fadd.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fadd.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>\t친구 추가(계속추가가능))</a><br>\r\n");
      out.write("\t\t\t<a href=fadd.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=DD>\t\t\t친구 없음</a>\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=fadd.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=xxxx>\t\t자기추가</a>\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=fadd.jsp?gameid=xxxx2&password=1111&friendid=xxxx3>\t\t\t\t\t\t패스워드틀림</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=DD\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fdelete.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fdelete.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>\t친구 삭제</a>\t<br>\r\n");
      out.write("\t\t\t<a href=fdelete.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=DD>\t\t친구 없음</a>\t<br>\r\n");
      out.write("\t\t\t<a href=fdelete.jsp?gameid=xxxx&password=1111&friendid=DD1>\t\t\t\t\t\t패스워드틀림</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=DD\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fapprove.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fapprove.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&friendid=xxxx2>\t친구 승인(신청받은사람이)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=DD\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fmyfriend.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fmyfriend.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>\t\t\t\t친구 My리스트</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fvisit.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fvisit.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>\t\t친구 방문</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=xxxx2\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fheart.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fheart.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>\t\t친구에게 하트(난 우정포인트)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=xxxx3\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fproud.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fproud.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx>\t\t자랑하기(가능한가를 묻는다)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>freturn.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=freturn.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>친구야 돌아와줘 (요청)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=xxxx3\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>frent.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=frent.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx>\t\t친구동물 빌려쓰기</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tfriendid=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fpoint.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fpoint.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>우정포인트 > 캐쉬일꾼</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fwbuy.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fwbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=6900>농장 구매</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\titemcode=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fwsell.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fwsell.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=6900>농장 판매</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\titemcode=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fwincome.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fwincome.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=6900>농장 수익</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\titemcode=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>fwincomeall.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fwincomeall.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>농장 수익(전체를 한꺼번에)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx2\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tseedbuy.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=seedbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1>경작지구매(1)</a>\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tseedidx=인덱스번호\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tseedplant.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&seeditemcode=600&feeduse=1>건초 > 직접</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=6&seeditemcode=607&feeduse=1>하트 > 직접</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=7&seeditemcode=605&feeduse=1>회복 > 소모(선물함)</a>\t<br>\r\n");
      out.write("\t\t\t<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=8&seeditemcode=606&feeduse=1>촉진 > 소모(선물함)</a>\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tseedidx=인덱스번호\t<br>\r\n");
      out.write("\t\t\tseeditemcode=씨앗아이템코드\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tseedharvest.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&mode=1&feeduse=1>일반수확(건초 > 직접)</a><br>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=6&mode=1&feeduse=1>일반수확(하트 > 직접)</a><br>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=7&mode=1&feeduse=1>일반수확(회복 > 소모(선물함))</a><br>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=8&mode=1&feeduse=1>일반수확(촉진 > 소모(선물함))</a><br>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&mode=2&feeduse=1>즉시수확(건초 > 직접)</a><br>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=6&mode=2&feeduse=1>즉시수확(하트 > 직접)</a><br>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=7&mode=2&feeduse=1>즉시수확(회복 > 소모(선물함))</a><br>\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=8&mode=2&feeduse=1>즉시수확(촉진 > 소모(선물함))</a><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&mode=3&feeduse=1>일반수확(건초 > 직접)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tseedidx=인덱스번호\t<br>\r\n");
      out.write("\t\t\tmode=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tsave.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=save.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&crypt=1&userinfo=66436:8679;7:9;8:79;0:0;76:77;77:767;78:87;79:867;96:72;06:-7;07:-7;08:-7;09:7;00:-7;01:-7;126&aniitem=77948:2,8,8;0:2,90,7;1:2,92,-8;243&cusitem=667170:7;71:7;72:7;186&paraminfo=55955:5;6:6;7:7;8:8;9:9;0:0;1:1;2:2;3:3;4:4;064>저장하기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tuserinfo=\t\t\t<br>\r\n");
      out.write("\t\t\taniitem=\t\t\t<br>\r\n");
      out.write("\t\t\tcusitem=\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttrade.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=trade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&crypt=1&userinfo=0:2013;1:4;2:0;4:2;10:10;11:100;12:20;13:200;30:16;43:1;&aniitem=1:5,1,1;3:5,23,0;4:5,25,-1;&cusitem=14:1;15:1;16:1;&tradeinfo=0:5;1:2;10:2;11:1;12:75;20:10;30:1;31:11;33:7;34:20;35:77;40:5119;61:-1;62:1;63:-1;&paraminfo=0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;>거래 > 저장하기(2013.3) 코인보상</a><br>\r\n");
      out.write("\t\t\t<a href=trade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&crypt=1&userinfo=0:2013;1:4;2:0;4:2;10:10;11:100;12:20;13:200;30:16;43:1;&aniitem=1:5,1,1;3:5,23,0;4:5,25,-1;&cusitem=14:1;15:1;16:1;&tradeinfo=0:5;1:2;10:2;11:1;12:75;20:10;30:1;31:11;33:7;34:20;35:77;40:1200;61:-1;62:1;63:-1;&paraminfo=0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;>거래 > 저장하기(2013.3) 부활석</a><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tuserinfo=\t\t\t<br>\r\n");
      out.write("\t\t\taniitem=\t\t\t<br>\r\n");
      out.write("\t\t\tcusitem=\t\t\t<br>\r\n");
      out.write("\t\t\ttradeinfo=\r\n");
      out.write("\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttradecash.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=tradecash.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[게임거래_캐쉬상인]</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttradecontinue.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=tradecontinue.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[게임거래_연속거래]</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\ttradechange.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=tradechange.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&tradeinfo=0:0;1:1;2:2;3:3;4:4;5:5;6:6;>게임상인변경(기존)</a><br>\r\n");
      out.write("\t\t\t<a href=tradechange.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&tradeinfo=0:7;1:8;2:9;3:10;4:11;5:12;6:13;>게임상인변경(신규)</a>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx         \t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\ttradeinfo=:0;1:1;2:2;3:3;4:4;5:5;6:6;\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>cashbuy.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=cashbuy.jsp?ikind=sandbox&mode=1&gameid=xxxx2&password=049000s1i0n7t8445289&giftid=&acode=ewoJInNpZ25hdHVyZSIgPSAiQW82K1lmZy9XSnFZUzZyZWlsWkhIZEI1NGRpbXBuQlRTMGY1RUpoTUY3OVdzK3NUVE5LK1B5UEthdkMxcFFNTGpsaFg5VFpPQmtxUm5DUDZBYmx2eTFucUY0NWxpbUpLK1RJZTNPUGp2bGNmVHRIOVdhTmxZWHRNWEdiZWNaR041SzR5UllFUVBVNXpCSm9IajFubkErNHhKVk9MMFlCOEYyT2E5REIzY3FsYUFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5USXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1YvcnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRkS1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNqQndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBnRVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERnUVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lCM1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNlVFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIwN2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FRVnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xvSHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5qK2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2JwMGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUwTFRBeUxUSTNJREl6T2pFek9qQTRJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdWeUlpQTlJQ0kwWkdKak1XWTBNVGRrTWpJNVl6STBNREl6TnpJMVpXSTFZekJrTjJZME5HVmhaalJsWVRKaUlqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2YmkxcFpDSWdQU0FpTVRBd01EQXdNREV3TXpBeU16SXpNeUk3Q2draVluWnljeUlnUFNBaU1TNHdMakVpT3dvSkluUnlZVzV6WVdOMGFXOXVMV2xrSWlBOUlDSXhNREF3TURBd01UQXpNREl6TWpNeklqc0tDU0p4ZFdGdWRHbDBlU0lnUFNBaU1TSTdDZ2tpYjNKcFoybHVZV3d0Y0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTVNelUzTVRVNE9EUTJNaUk3Q2draWRXNXBjWFZsTFhabGJtUnZjaTFwWkdWdWRHbG1hV1Z5SWlBOUlDSkdSa1l6TlVaRVF5MUZPVFE1TFRReVFUQXRRa1ExT1MxQk9UYzBOa0kzTURZNE1FUWlPd29KSW5CeWIyUjFZM1F0YVdRaUlEMGdJbVpoY20xZk1URXdNQ0k3Q2draWFYUmxiUzFwWkNJZ1BTQWlOemt5TlRVeU1USXdJanNLQ1NKaWFXUWlJRDBnSW1OdmJTNXdhV04wYjNOdlpuUXVabUZ5YlhSNVkyOXZiaTVoY0hCc1pTSTdDZ2tpY0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTVNelUzTVRVNE9EUTJNaUk3Q2draWNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhOQzB3TWkweU9DQXdOem94TXpvd09DQkZkR012UjAxVUlqc0tDU0p3ZFhKamFHRnpaUzFrWVhSbExYQnpkQ0lnUFNBaU1qQXhOQzB3TWkweU55QXlNem94TXpvd09DQkJiV1Z5YVdOaEwweHZjMTlCYm1kbGJHVnpJanNLQ1NKdmNtbG5hVzVoYkMxd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERTBMVEF5TFRJNElEQTNPakV6T2pBNElFVjBZeTlIVFZRaU93cDkiOwoJImVudmlyb25tZW50IiA9ICJTYW5kYm94IjsKCSJwb2QiID0gIjEwMCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9&ucode=28745678911121098777bbbb66458466249504269139&market=7&itemcode=5000&cashcost=5557671427475695773506153205&cash=5557442711775695773506153210>iPhone 1100</a>\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=cashbuy.jsp?ikind=GoogleID&mode=1&gameid=xxxx2&password=049000s1i0n7t8445289&giftid=&acode={\\\"receipt\\\":{\\\"orderId\\\":\\\"12999763169054705758.1373639491822994\\\",\\\"packageName\\\":\\\"com.marbles.farmvill5gg\\\",\\\"productId\\\":\\\"farm_3300\\\",\\\"purchaseTime\\\":1393581131311,\\\"purchaseState\\\":0,\\\"developerPayload\\\":\\\"optimus\\\",\\\"purchaseToken\\\":\\\"luzeyjbwahgstidpalbmxktx.AO-J1OzjxBJ8uSbkOFQNZys0oii7p5fKa8L6r2b0aqov79dJ3QfaI2v_LiRfvMgBOQoc33Qlwfwx_FSfnKqnWTt4OyXHhzgnO_eOQglB2DXZI-hUq4QsjPBd9qJPIJ3XYuVfO2npJtTJ\\\"},\\\"status\\\":0}&ucode=81867890233443210999dddd88670688463670395145&market=5&itemcode=5000&cashcost=310&cash=3300&kakaoUserId=91188455545412240>farm_3300</a>\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=cashbuy.jsp?mode=2&gameid=xxxx2&giftid=xxxx3&password=049000s1i0n7t8445289&acode=xxxxx6&ucode=41767890323443210907dddd88679776060099800130&market=1&itemcode=5000&cashcost=8880086160708919982822110190&cash=4448644482164575548488776181>20캐쉬선물(xxxx2 > xxxx3)</a>\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tmode=xxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tgameid=xxxx                     \t<br>\r\n");
      out.write("\t\t\tgiftid=xxxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289       <br>\r\n");
      out.write("\t\t\tacode=xxxx (승인코드)               <br>\r\n");
      out.write("\t\t\tucode=xxxxx <암호화루틴>    \t\t<br>\r\n");
      out.write("\t\t\tmarket=1\t\t\t\t\t   \t\t<br>\r\n");
      out.write("\t\t\titemcode=xxxx\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tcashcost=5557653730667094(10)\t\t<br>\r\n");
      out.write("\t\t\tcash=8882988816259092(1000)\t\t\t<br>\r\n");
      out.write("\t\t\tcashcost2=5557653730667094(10)\t\t<br>\r\n");
      out.write("\t\t\tcash2=8882988816259092(1000)\t\t<br>\r\n");
      out.write("\t\t\tikind=xxxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tidata=xxxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tidata2=xxxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tnotice.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=notice.jsp?market=");
      out.print(SKT);
      out.write("&buytype=0>공지사항[SKT]</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=notice.jsp?market=");
      out.print(GOOGLE);
      out.write("&buytype=0>공지사항[GOOGLE]</a>\t<br>\r\n");
      out.write("\t\t\t<a href=notice.jsp?market=");
      out.print(IPHONE);
      out.write("&buytype=0>공지사항[NHN]</a>\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tmarket=마켓\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tbuytype=무료(0), 유료(1)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tsysagreement.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=sysagreement.jsp?lang=0>한글약관</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=sysagreement.jsp?lang=1>영문약관</a>\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tmarket=마켓\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tbuytype=무료(0), 유료(1)\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tchangeinfo.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=changeinfo.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1>추천 게시판 작성후 보상</a>\t<br>\r\n");
      out.write("\t\t\t<a href=changeinfo.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=11>푸쉬받기/안받기</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=changeinfo.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=12>카톡 메세지 블럭/해제</a>\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx                     \t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289       <br>\r\n");
      out.write("\t\t\tmode=xxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tfbwrite.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fbwrite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=1&message=normalboard>일반 게시판 작성</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=fbwrite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=2&message=friendboard>친추 게시판 작성</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=fbwrite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=3&message=schoolboard>대항 게시판 작성</a>\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx                     \t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289       <br>\r\n");
      out.write("\t\t\tkind=xxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tkind=message\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tfbread.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=fbread.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=1&page=1>일반 게시판 읽기</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=fbread.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=2&page=1>친추 게시판 읽기</a>\t\t\t<br>\r\n");
      out.write("\t\t\t<a href=fbread.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=3&page=1>대항 게시판 읽기</a>\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx                     \t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289       <br>\r\n");
      out.write("\t\t\tkind=xxx\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tpage=1\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tsendsms.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=sendsms.jsp?gameid=Superman7&password=049000s1i0n7t8445289&sendkey=3635364745483737474858519149294164505648483431548600235736&recphone=66776767777888886787864618416115>SMS발송</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=Superman7\t\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=049000s1i0n7t8445289\t<br>\r\n");
      out.write("\t\t\tsendkey=3635364745483737474858519149294164505648483431548600235736<br>\r\n");
      out.write("\t\t\trecphone=66776767777888886787864618416115\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tpushmsg.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=sendpush.jsp?gameid=guest90586&password=5697165c2c6g3u571634&receid=guest90586&kind=1&msgtitle=단순제목&msgmsg=단순내용>단순푸쉬</a><br>\r\n");
      out.write("\t\t\t<a href=sendpush.jsp?gameid=guest90586&password=5697165c2c6g3u571634&receid=guest90586&kind=2&msgtitle=자랑제목&msgmsg=자랑내용>자랑푸쉬</a><br>\r\n");
      out.write("\t\t\t<a href=sendpush.jsp?gameid=guest90586&password=5697165c2c6g3u571634&receid=guest90586&kind=3&msgtitle=URL제목&msgmsg=http://m.naver.com>URL푸쉬</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=guest73801\t\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=7845557f9w2v5m112499\t<br>\r\n");
      out.write("\t\t\treceid=guest73801\t\t\t\t<br>\r\n");
      out.write("\t\t\tkind=1\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\tmsgtitle=단순제목\t\t\t\t<br>\r\n");
      out.write("\t\t\tmsgmsg=단순내용\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t(웹에서 전송하면 문자가 깨짐(클라는 이상없음))\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t-->\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>schoolsearch.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=schoolsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&schoolkind=1&schoolname=용봉>검색 > 초등 > 용봉</a>\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tschoolkind=xxx\t\t<br>\r\n");
      out.write("\t\t\tschoolname=xxx\r\n");
      out.write("\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>schooljoin.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=schooljoin.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&schoolidx=1>가입</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tschoolidx=xxx\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>schooltop.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=schooltop.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>Top10 + 내학교순위(학교들)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>schoolusertop.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=schoolusertop.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>Top10 + 내순위(학교내)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>certno.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=certno.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&certno=F9E93CE99BEA4A89>쿠폰등록</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tcertno=\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>inquire.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=sysinquire.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&message=usermessage>문의하기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tmessage=\t\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>pettoday.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=pettoday.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=100004>[펫]오늘만 이가격 100004</a><br>\r\n");
      out.write("\t\t\t<a href=pettoday.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=100016>[펫]오늘만 이가격 100016</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tparamint=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>petroll.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=petroll.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=-1>[펫]뽑기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tparamint=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>petupgrade.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=petupgrade.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=10>[펫]업그레이드</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tparamint=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>petwear.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=petwear.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=10>[펫]장착</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tparamint=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>petexp.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=petexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[펫]체험하기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>yabauchange.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=yabauchange.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[행운의 주사위]리스트갱신</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>yabaureward.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=yabaureward.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[행운의 주사위]보상받기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>yabau.jsp</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=yabau.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&randserial=7772>[행운의 주사위]굴리기</a><br>\r\n");
      out.write("\t\t\t<a href=yabau.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=3&randserial=7773>[행운의 주사위]굴리기</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx\t\t\t<br>\r\n");
      out.write("\t\t\tpassword=\t\t\t<br>\r\n");
      out.write("\t\t\tmode=\t\t\t\t<br>\r\n");
      out.write("\t\t\trandserial=\t\t\t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tubboxopenopen.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=ubboxopenopen.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스오픈요구</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tboxslotidx=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tubboxopencash.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=ubboxopencash.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스캐쉬오픈</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tboxslotidx=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tubboxopencash2.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=ubboxopencash2.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스캐쉬2배오픈</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tboxslotidx=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tubboxopengetitem.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=ubboxopengetitem.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스시간되어 오픈</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tboxslotidx=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tubsearch.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=ubsearch.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=0:14;>유저 배틀 검색</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tboxslotidx=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tubresult.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=ubresult.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&userbattleidx2=123&result=1&playtime=90>유저 배틀 결과</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            \t<br>\r\n");
      out.write("\t\t\tpassword=xxxx          \t<br>\r\n");
      out.write("\t\t\tuserbattleidx2=xxxx  \t<br>\r\n");
      out.write("\t\t\tresult=xxxx  \t\t\t<br>\r\n");
      out.write("\t\t\tplaytime=xxxx\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tranklist.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=ranklist.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>유저 랭킹정보</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            \t<br>\r\n");
      out.write("\t\t\tpassword=xxxx          \t<br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\twheel.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=wheel.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=20&usedcashcost=0&randserial=7771>일일룰렛</a><br>\r\n");
      out.write("\t\t\t<a href=wheel.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=21&usedcashcost=300&randserial=7772>황금룰렛</a><br>\r\n");
      out.write("\t\t\t<a href=wheel.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=22&usedcashcost=0&randserial=7773>황금룰렛물료</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tmode=xxxx      \t\t   <br>\r\n");
      out.write("\t\t\tusedcashcost=xxxx      <br>\r\n");
      out.write("\t\t\trandserial=xxxx      <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\trkrank.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=rkrank.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>랭킹대전정보</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tzcpchance.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=zcpchance.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&usedcashcost=0&randserial=7771>짜요쿠폰룰렛(무료)</a><br>\r\n");
      out.write("\t\t\t<a href=zcpchance.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&usedcashcost=200&randserial=7772>짜요쿠폰룰렛(캐쉬)</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tmode=xxxx      \t\t   <br>\r\n");
      out.write("\t\t\tusedcashcost=xxxx      <br>\r\n");
      out.write("\t\t\trandserial=xxxx      <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tzcpbuy.jsp\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\t<a href=zcpbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&idx=3&randserial=7771>짜요장터구매</a><br>\r\n");
      out.write("\t\t\t<a href=zcpbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&idx=3&randserial=7772>짜요장터구매</a><br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td>\r\n");
      out.write("\t\t\tgameid=xxxx            <br>\r\n");
      out.write("\t\t\tpassword=xxxx          <br>\r\n");
      out.write("\t\t\tidx=xxxx      \t\t   <br>\r\n");
      out.write("\t\t\trandserial=xxxx      <br>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<center>\r\n");
      out.write("<IFRAME src=\"../admin/_admin.jsp\" width=\"800\" height=\"700\" scrolling=\"auto\"></IFRAME><br>\r\n");
      out.write("</center>\r\n");
      out.write("\r\n");
      out.write("<br><br><br><br><br><br><br><br>\r\n");
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
