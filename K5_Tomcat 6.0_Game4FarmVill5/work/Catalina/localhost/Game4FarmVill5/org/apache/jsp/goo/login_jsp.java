package org.apache.jsp.goo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\r\n");
      out.write(" \r\n");
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

	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idx						= 1;

	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	String market		= util.getParamStr(request, "market", "1");
	String version 		= util.getParamStr(request, "version", "101");
	String kakaoprofile	= util.getParamStr(request, "kakaoprofile", "");
	String kakaomsgblocked= util.getParamStr(request, "kakaomsgblocked", "0");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n market=" 	+ market);
		DEBUG_LOG_STR.append("\r\n version=" 	+ version);
		DEBUG_LOG_STR.append("\r\n kakaoprofile="+ kakaoprofile);
		DEBUG_LOG_STR.append("\r\n kakaomsgblocked="+ kakaomsgblocked);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 1, 101, '', '', -1			-- 정상유저
		query.append("{ call dbo.spu_Login (?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, market);
		cstmt.setString(idx++, version);
		cstmt.setString(idx++, kakaoprofile);
		cstmt.setString(idx++, kakaomsgblocked);
		cstmt.registerOutParameter(idx++, Types.INTEGER);

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3. xml형태로 데이타 출력
		msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
		msg.append("<rows>\n");

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			resultMsg.append(result.getString(2));
		}
		msg.append("	<result>\n");
		msg.append("		<code>");			msg.append(PTS_LOGIN); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("	</result>\n");

		if(resultCode == 1){
			//2-3-2. 유저 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<userinfo>\n");

					//출석정보
					msg.append("		<attenddate>");		msg.append(result.getString("attenddate").substring(0, 19)); msg.append("</attenddate>\n");
					msg.append("		<attendcnt>");		msg.append(result.getString("attendcnt")); 		msg.append("</attendcnt>\n");
					msg.append("		<attendnewday>");	msg.append(result.getString("attendnewday")); 	msg.append("</attendnewday>\n");

					//유저기본정보
					msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
					msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));   	msg.append("</gamecost>\n");
					msg.append("		<feed>");			msg.append(result.getString("feed"));   		msg.append("</feed>\n");
					msg.append("		<feedmax>");		msg.append(result.getString("feedmax"));   		msg.append("</feedmax>\n");
					msg.append("		<heart>");			msg.append(result.getString("heart"));   		msg.append("</heart>\n");
					msg.append("		<heartmax>");		msg.append(result.getString("heartmax"));   	msg.append("</heartmax>\n");
					msg.append("		<fpointmax>");		msg.append(result.getString("fpointmax"));   	msg.append("</fpointmax>\n");
					msg.append("		<fevergauge>");		msg.append(result.getString("fevergauge"));   	msg.append("</fevergauge>\n");
					msg.append("		<tutorial>");		msg.append(result.getString("tutorial"));   	msg.append("</tutorial>\n");
					msg.append("		<tutostep>");		msg.append(result.getString("tutostep"));   	msg.append("</tutostep>\n");
					msg.append("		<fpoint>");			msg.append(result.getString("fpoint"));   		msg.append("</fpoint>\n");
					msg.append("		<goldticket>");		msg.append(result.getInt("goldticket"));    	msg.append("</goldticket>\n");
					msg.append("		<goldticketmax>");	msg.append(result.getInt("goldticketmax"));    	msg.append("</goldticketmax>\n");
					msg.append("		<goldtickettime>");	msg.append(result.getString("goldtickettime").substring(0, 19));msg.append("</goldtickettime>\n");
					msg.append("		<battleticket>");	msg.append(result.getInt("battleticket"));    	msg.append("</battleticket>\n");
					msg.append("		<battleticketmax>");msg.append(result.getInt("battleticketmax"));   msg.append("</battleticketmax>\n");
					msg.append("		<battletickettime>");msg.append(result.getString("battletickettime").substring(0, 19));msg.append("</battletickettime>\n");
					msg.append("		<battlefarmidx>");	msg.append(result.getInt("battlefarmidx"));   	msg.append("</battlefarmidx>\n");
					msg.append("		<battleanilistidx1>");msg.append(result.getInt("battleanilistidx1"));msg.append("</battleanilistidx1>\n");
					msg.append("		<battleanilistidx2>");msg.append(result.getInt("battleanilistidx2"));msg.append("</battleanilistidx2>\n");
					msg.append("		<battleanilistidx3>");msg.append(result.getInt("battleanilistidx3"));msg.append("</battleanilistidx3>\n");
					msg.append("		<battleanilistidx4>");msg.append(result.getInt("battleanilistidx4"));msg.append("</battleanilistidx4>\n");
					msg.append("		<battleanilistidx5>");msg.append(result.getInt("battleanilistidx5"));msg.append("</battleanilistidx5>\n");
					msg.append("		<comreward>");		msg.append(result.getString("comreward"));   	msg.append("</comreward>\n");
					msg.append("		<mboardstate>");	msg.append(result.getString("mboardstate"));   	msg.append("</mboardstate>\n");
					msg.append("		<mboardreward>");	msg.append(result.getString("mboardreward"));   msg.append("</mboardreward>\n");
					msg.append("		<farmharvest>");	msg.append(result.getString("farmharvest"));  	msg.append("</farmharvest>\n");
					msg.append("		<sendheart>");		msg.append(result.getString("sendheart"));  	msg.append("</sendheart>\n");
					msg.append("		<friendinvite>");	msg.append(result.getString("friendinvite"));  	msg.append("</friendinvite>\n");
					msg.append("		<nicknamechange>");	msg.append(result.getString("nicknamechange")); msg.append("</nicknamechange>\n");

					msg.append("		<kakaotalkid>");	msg.append(result.getString("kakaotalkid"));  	msg.append("</kakaotalkid>\n");
					msg.append("		<kakaouserid>");	msg.append(result.getString("kakaouserid"));  	msg.append("</kakaouserid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
					msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));  	msg.append("</kakaoprofile>\n");
					msg.append("		<kakaomsgblocked>");msg.append(result.getString("kakaomsgblocked"));msg.append("</kakaomsgblocked>\n");

					msg.append("		<kakaomsginvitecnt>");msg.append(result.getString("kakaomsginvitecnt"));msg.append("</kakaomsginvitecnt>\n");
					msg.append("		<kakaomsginvitetodaycnt>");msg.append(result.getString("kakaomsginvitetodaycnt"));msg.append("</kakaomsginvitetodaycnt>\n");
					msg.append("		<kakaomsginvitetodaydate>");msg.append(result.getString("kakaomsginvitetodaydate").substring(0, 19));msg.append("</kakaomsginvitetodaydate>\n");
					msg.append("		<kkhelpalivecnt>");	msg.append(result.getString("kkhelpalivecnt2")); msg.append("</kkhelpalivecnt>\n");

					//게임정보(일반)
					msg.append("		<anireplistidx>");	msg.append(result.getString("anireplistidx"));  msg.append("</anireplistidx>\n");
					msg.append("		<anirepmsg>");		msg.append(result.getString("anirepmsg"));   	msg.append("</anirepmsg>\n");
					msg.append("		<startyear>");		msg.append(result.getString("startyear"));   	msg.append("</startyear>\n");
					msg.append("		<startmonth>");		msg.append(result.getString("startmonth"));   	msg.append("</startmonth>\n");
					msg.append("		<gameyear>");		msg.append(result.getString("gameyear"));   	msg.append("</gameyear>\n");
					msg.append("		<gamemonth>");		msg.append(result.getString("gamemonth"));   	msg.append("</gamemonth>\n");
					msg.append("		<frametime>");		msg.append(result.getString("frametime"));   	msg.append("</frametime>\n");
					msg.append("		<tradecnt>");		msg.append(result.getString("tradecnt"));   	msg.append("</tradecnt>\n");
					msg.append("		<tradesuccesscnt>");msg.append(result.getString("tradesuccesscnt"));msg.append("</tradesuccesscnt>\n");
					msg.append("		<tradeclosedealer>");msg.append(result.getString("tradeclosedealer"));msg.append("</tradeclosedealer>\n");
					msg.append("		<prizecnt>");		msg.append(result.getString("prizecnt"));   	msg.append("</prizecnt>\n");
					msg.append("		<tradefailcnt>");	msg.append(result.getString("tradefailcnt"));   msg.append("</tradefailcnt>\n");
					msg.append("		<fame>");			msg.append(result.getString("fame"));   		msg.append("</fame>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   		msg.append("</famelv>\n");
					msg.append("		<famelvbest>");		msg.append(result.getString("famelvbest"));   	msg.append("</famelvbest>\n");
					msg.append("		<bottlelittle>");	msg.append(result.getString("bottlelittle"));   msg.append("</bottlelittle>\n");
					msg.append("		<bottlefresh>");	msg.append(result.getString("bottlefresh"));   	msg.append("</bottlefresh>\n");
					msg.append("		<tanklittle>");		msg.append(result.getString("tanklittle"));   	msg.append("</tanklittle>\n");
					msg.append("		<tankfresh>");		msg.append(result.getString("tankfresh"));   	msg.append("</tankfresh>\n");

					//필드정보.
					msg.append("		<field0>");			msg.append(result.getString("field0")); 		msg.append("</field0>\n");
					msg.append("		<field1>");			msg.append(result.getString("field1")); 		msg.append("</field1>\n");
					msg.append("		<field2>");			msg.append(result.getString("field2")); 		msg.append("</field2>\n");
					msg.append("		<field3>");			msg.append(result.getString("field3")); 		msg.append("</field3>\n");
					msg.append("		<field4>");			msg.append(result.getString("field4")); 		msg.append("</field4>\n");
					msg.append("		<field5>");			msg.append(result.getString("field5")); 		msg.append("</field5>\n");
					msg.append("		<field6>");			msg.append(result.getString("field6")); 		msg.append("</field6>\n");
					msg.append("		<field7>");			msg.append(result.getString("field7")); 		msg.append("</field7>\n");
					msg.append("		<field8>");			msg.append(result.getString("field8")); 		msg.append("</field8>\n");

					//펫정보.
					msg.append("		<petlistidx>");		msg.append(result.getString("petlistidx")); 	msg.append("</petlistidx>\n");
					msg.append("		<petitemcode>");	msg.append(result.getString("petitemcode")); 	msg.append("</petitemcode>\n");
					msg.append("		<petcooltime>");	msg.append(result.getString("petcooltime")); 	msg.append("</petcooltime>\n");
					msg.append("		<pettodayitemcode>");	msg.append(result.getString("pettodayitemcode")); 	msg.append("</pettodayitemcode>\n");
					msg.append("		<pettodayitemcode2>");	msg.append(result.getString("pettodayitemcode2")); 	msg.append("</pettodayitemcode2>\n");

					//게임정보(소모)
					msg.append("		<bulletlistidx>");	msg.append(result.getString("bulletlistidx"));  msg.append("</bulletlistidx>\n");
					msg.append("		<vaccinelistidx>");	msg.append(result.getString("vaccinelistidx")); msg.append("</vaccinelistidx>\n");
					msg.append("		<boosterlistidx>");	msg.append(result.getString("boosterlistidx")); msg.append("</boosterlistidx>\n");
					msg.append("		<albalistidx>");	msg.append(result.getString("albalistidx"));   	msg.append("</albalistidx>\n");

					//보물슬롯.
					msg.append("		<tslistidx1>");		msg.append(result.getString("tslistidx1"));  	msg.append("</tslistidx1>\n");
					msg.append("		<tslistidx2>");		msg.append(result.getString("tslistidx2"));  	msg.append("</tslistidx2>\n");
					msg.append("		<tslistidx3>");		msg.append(result.getString("tslistidx3"));  	msg.append("</tslistidx3>\n");
					msg.append("		<tslistidx4>");		msg.append(result.getString("tslistidx4"));  	msg.append("</tslistidx4>\n");
					msg.append("		<tslistidx5>");		msg.append(result.getString("tslistidx5"));  	msg.append("</tslistidx5>\n");

					//게임정보(인벤)
					msg.append("		<invenanimalbase>");msg.append(result.getString("invenanimalbase"));msg.append("</invenanimalbase>\n");
					msg.append("		<invenanimalmax>");	msg.append(result.getString("invenanimalmax")); msg.append("</invenanimalmax>\n");
					msg.append("		<invenanimalstep>");msg.append(result.getString("invenanimalstep"));msg.append("</invenanimalstep>\n");
					msg.append("		<invencustombase>");msg.append(result.getString("invencustombase"));msg.append("</invencustombase>\n");
					msg.append("		<invencustommax>");	msg.append(result.getString("invencustommax")); msg.append("</invencustommax>\n");
					msg.append("		<invencustomstep>");msg.append(result.getString("invencustomstep")); msg.append("</invencustomstep>\n");
					msg.append("		<invenaccbase>");	msg.append(result.getString("invenaccbase"));   msg.append("</invenaccbase>\n");
					msg.append("		<invenaccmax>");	msg.append(result.getString("invenaccmax"));   	msg.append("</invenaccmax>\n");
					msg.append("		<invenaccstep>");	msg.append(result.getString("invenaccstep"));  	msg.append("</invenaccstep>\n");
					msg.append("		<invenstemcellbase>");msg.append(result.getString("invenstemcellbase"));msg.append("</invenstemcellbase>\n");
					msg.append("		<invenstemcellmax>");msg.append(result.getString("invenstemcellmax"));msg.append("</invenstemcellmax>\n");
					msg.append("		<invenstemcellstep>");msg.append(result.getString("invenstemcellstep"));msg.append("</invenstemcellstep>\n");
					msg.append("		<inventreasurebase>");msg.append(result.getString("inventreasurebase"));msg.append("</inventreasurebase>\n");
					msg.append("		<inventreasuremax>");msg.append(result.getString("inventreasuremax"));msg.append("</inventreasuremax>\n");
					msg.append("		<inventreasurestep>");msg.append(result.getString("inventreasurestep"));msg.append("</inventreasurestep>\n");

					msg.append("		<tempitemcode>");	msg.append(result.getString("tempitemcode"));   msg.append("</tempitemcode>\n");
					msg.append("		<tempcnt>");		msg.append(result.getString("tempcnt"));   		msg.append("</tempcnt>\n");

					//게임정보(시설업글)
					msg.append("		<housestep>");		msg.append(result.getString("housestep"));   	msg.append("</housestep>\n");
					msg.append("		<housestate>");		msg.append(result.getString("housestate"));   	msg.append("</housestate>\n");
					msg.append("		<housetime>");		msg.append(result.getString("housetime").substring(0, 19));   		msg.append("</housetime>\n");
					msg.append("		<tankstep>");		msg.append(result.getString("tankstep"));   	msg.append("</tankstep>\n");
					msg.append("		<tankstate>");		msg.append(result.getString("tankstate"));   	msg.append("</tankstate>\n");
					msg.append("		<tanktime>");		msg.append(result.getString("tanktime").substring(0, 19));   		msg.append("</tanktime>\n");
					msg.append("		<bottlestep>");		msg.append(result.getString("bottlestep"));   	msg.append("</bottlestep>\n");
					msg.append("		<bottlestate>");	msg.append(result.getString("bottlestate"));   	msg.append("</bottlestate>\n");
					msg.append("		<bottletime>");		msg.append(result.getString("bottletime").substring(0, 19));   		msg.append("</bottletime>\n");
					msg.append("		<pumpstep>");		msg.append(result.getString("pumpstep"));   	msg.append("</pumpstep>\n");
					msg.append("		<pumpstate>");		msg.append(result.getString("pumpstate"));   	msg.append("</pumpstate>\n");
					msg.append("		<pumptime>");		msg.append(result.getString("pumptime").substring(0, 19));   		msg.append("</pumptime>\n");
					msg.append("		<transferstep>");	msg.append(result.getString("transferstep"));   msg.append("</transferstep>\n");
					msg.append("		<transferstate>");	msg.append(result.getString("transferstate"));  msg.append("</transferstate>\n");
					msg.append("		<transfertime>");	msg.append(result.getString("transfertime").substring(0, 19));   		msg.append("</transfertime>\n");
					msg.append("		<purestep>");		msg.append(result.getString("purestep"));   	msg.append("</purestep>\n");
					msg.append("		<purestate>");		msg.append(result.getString("purestate"));   	msg.append("</purestate>\n");
					msg.append("		<puretime>");		msg.append(result.getString("puretime").substring(0, 19));   		msg.append("</puretime>\n");
					msg.append("		<freshcoolstep>");	msg.append(result.getString("freshcoolstep"));  msg.append("</freshcoolstep>\n");
					msg.append("		<freshcoolstate>");	msg.append(result.getString("freshcoolstate")); msg.append("</freshcoolstate>\n");
					msg.append("		<freshcooltime>");	msg.append(result.getString("freshcooltime").substring(0, 19));   		msg.append("</freshcooltime>\n");

					//기타정보
					msg.append("		<mboardstate>");	msg.append(result.getString("mboardstate"));   	msg.append("</mboardstate>\n");
					msg.append("		<tutorial>");		msg.append(result.getString("tutorial"));   	msg.append("</tutorial>\n");
					msg.append("		<roulaccprice>");	msg.append(result.getString("roulaccprice"));   msg.append("</roulaccprice>\n");
					msg.append("		<roulaccsale>");	msg.append(result.getString("roulaccsale"));  	msg.append("</roulaccsale>\n");

					msg.append("		<boosteruse>");		msg.append(result.getString("boosteruse"));   	msg.append("</boosteruse>\n");
					msg.append("		<albause>");		msg.append(result.getString("albause"));   		msg.append("</albause>\n");
					msg.append("		<albausesecond>");	msg.append(result.getString("albausesecond")); 	msg.append("</albausesecond>\n");
					msg.append("		<albausethird>");	msg.append(result.getString("albausethird"));  	msg.append("</albausethird>\n");
					msg.append("		<wolfappear>");		msg.append(result.getString("wolfappear"));   	msg.append("</wolfappear>\n");

					//클라이언트정보저장.
					msg.append("		<param0>");			msg.append(result.getString("param0"));   		msg.append("</param0>\n");
					msg.append("		<param1>");			msg.append(result.getString("param1"));   		msg.append("</param1>\n");
					msg.append("		<param2>");			msg.append(result.getString("param2"));   		msg.append("</param2>\n");
					msg.append("		<param3>");			msg.append(result.getString("param3"));   		msg.append("</param3>\n");
					msg.append("		<param4>");			msg.append(result.getString("param4"));   		msg.append("</param4>\n");
					msg.append("		<param5>");			msg.append(result.getString("param5"));   		msg.append("</param5>\n");
					msg.append("		<param6>");			msg.append(result.getString("param6"));   		msg.append("</param6>\n");
					msg.append("		<param7>");			msg.append(result.getString("param7"));   		msg.append("</param7>\n");
					msg.append("		<param8>");			msg.append(result.getString("param8"));   		msg.append("</param8>\n");
					msg.append("		<param9>");			msg.append(result.getString("param9"));   		msg.append("</param9>\n");

					//경쟁모드.
					msg.append("		<bktwolfkillcnt>");	msg.append(result.getString("bktwolfkillcnt")); msg.append("</bktwolfkillcnt>\n");
					msg.append("		<bktsalecoin>");	msg.append(result.getString("bktsalecoin"));   	msg.append("</bktsalecoin>\n");
					msg.append("		<bkheart>");		msg.append(result.getString("bkheart"));   		msg.append("</bkheart>\n");
					msg.append("		<bkfeed>");			msg.append(result.getString("bkfeed"));   		msg.append("</bkfeed>\n");
					msg.append("		<bktsuccesscnt>");	msg.append(result.getString("bktsuccesscnt"));  msg.append("</bktsuccesscnt>\n");
					msg.append("		<bktbestfresh>");	msg.append(result.getString("bktbestfresh"));   msg.append("</bktbestfresh>\n");
					msg.append("		<bktbestbarrel>");	msg.append(result.getString("bktbestbarrel"));  msg.append("</bktbestbarrel>\n");
					msg.append("		<bktbestcoin>");	msg.append(result.getString("bktbestcoin"));   	msg.append("</bktbestcoin>\n");
					msg.append("		<bkbarrel>");		msg.append(result.getString("bkbarrel"));   	msg.append("</bkbarrel>\n");
					msg.append("		<bkcrossnormal>");	msg.append(result.getString("bkcrossnormal"));  msg.append("</bkcrossnormal>\n");
					msg.append("		<bkcrosspremium>");	msg.append(result.getString("bkcrosspremium")); msg.append("</bkcrosspremium>\n");
					msg.append("		<bktsgrade1cnt>");	msg.append(result.getString("bktsgrade1cnt"));	msg.append("</bktsgrade1cnt>\n");
					msg.append("		<bktsgrade2cnt>");	msg.append(result.getString("bktsgrade2cnt"));	msg.append("</bktsgrade2cnt>\n");
					msg.append("		<bktsupcnt>");		msg.append(result.getString("bktsupcnt"));		msg.append("</bktsupcnt>\n");
					msg.append("		<bkbattlecnt>");	msg.append(result.getString("bkbattlecnt"));	msg.append("</bkbattlecnt>\n");
					msg.append("		<bkaniupcnt>");		msg.append(result.getString("bkaniupcnt")); 	msg.append("</bkaniupcnt>\n");
					msg.append("		<bkapartani>");		msg.append(result.getString("bkapartani")); 	msg.append("</bkapartani>\n");
					msg.append("		<bkapartts>");		msg.append(result.getString("bkapartts")); 		msg.append("</bkapartts>\n");
					msg.append("		<bkcomposecnt>");	msg.append(result.getString("bkcomposecnt")); 	msg.append("</bkcomposecnt>\n");

					//학교대항정보.
					msg.append("		<schoolname>");		msg.append(result.getString("schoolname")); 	msg.append("</schoolname>\n");
					msg.append("		<schoolinitdate>");	msg.append(result.getString("schoolinitdate")); msg.append("</schoolinitdate>\n");
					msg.append("		<schoolidx>");		msg.append(result.getString("schoolidx")); 		msg.append("</schoolidx>\n");
					msg.append("		<schoolresult>");	msg.append(result.getString("schoolresult2")); 	msg.append("</schoolresult>\n");

					//에피소드 진행정보.
					msg.append("		<etsalecoin>");		msg.append(result.getString("etsalecoin")); 	msg.append("</etsalecoin>\n");
					msg.append("		<etremain>");		msg.append(result.getString("etremain")); 		msg.append("</etremain>\n");

					//유저랭킹(초기화날짜)
					msg.append("		<userrankinitdate>");msg.append(result.getString("userrankinitdate")); 	msg.append("</userrankinitdate>\n");

					//유저친구 랭킹(지난)
					msg.append("		<lmsalecoin>");		msg.append(result.getString("lmsalecoin")); 	msg.append("</lmsalecoin>\n");
					msg.append("		<lmrank>");			msg.append(result.getString("lmrank")); 		msg.append("</lmrank>\n");
					msg.append("		<lmcnt>");			msg.append(result.getString("lmcnt")); 			msg.append("</lmcnt>\n");
					msg.append("		<l1gameid>");		msg.append(result.getString("l1gameid")); 		msg.append("</l1gameid>\n");
					msg.append("		<l1itemcode>");		msg.append(result.getString("l1itemcode")); 	msg.append("</l1itemcode>\n");
					msg.append("		<l1acc1>");			msg.append(result.getString("l1acc1")); 		msg.append("</l1acc1>\n");
					msg.append("		<l1acc2>");			msg.append(result.getString("l1acc2")); 		msg.append("</l1acc2>\n");
					msg.append("		<l1salecoin>");		msg.append(result.getString("l1salecoin")); 	msg.append("</l1salecoin>\n");
					msg.append("		<l1kakaonickname>");	msg.append(result.getString("l1kakaonickname")); 	msg.append("</l1kakaonickname>\n");
					msg.append("		<l1kakaoprofile>");		msg.append(result.getString("l1kakaoprofile")); 	msg.append("</l1kakaoprofile>\n");

					msg.append("		<l2gameid>");		msg.append(result.getString("l2gameid")); 		msg.append("</l2gameid>\n");
					msg.append("		<l2itemcode>");		msg.append(result.getString("l2itemcode")); 	msg.append("</l2itemcode>\n");
					msg.append("		<l2acc1>");			msg.append(result.getString("l2acc1")); 		msg.append("</l2acc1>\n");
					msg.append("		<l2acc2>");			msg.append(result.getString("l2acc2")); 		msg.append("</l2acc2>\n");
					msg.append("		<l2salecoin>");		msg.append(result.getString("l2salecoin")); 	msg.append("</l2salecoin>\n");
					msg.append("		<l2kakaonickname>");	msg.append(result.getString("l2kakaonickname")); 	msg.append("</l2kakaonickname>\n");
					msg.append("		<l2kakaoprofile>");		msg.append(result.getString("l2kakaoprofile")); 	msg.append("</l2kakaoprofile>\n");

					msg.append("		<l3gameid>");		msg.append(result.getString("l3gameid")); 		msg.append("</l3gameid>\n");
					msg.append("		<l3itemcode>");		msg.append(result.getString("l3itemcode")); 	msg.append("</l3itemcode>\n");
					msg.append("		<l3acc1>");			msg.append(result.getString("l3acc1")); 		msg.append("</l3acc1>\n");
					msg.append("		<l3acc2>");			msg.append(result.getString("l3acc2")); 		msg.append("</l3acc2>\n");
					msg.append("		<l3salecoin>");		msg.append(result.getString("l3salecoin")); 	msg.append("</l3salecoin>\n");
					msg.append("		<l3kakaonickname>");	msg.append(result.getString("l3kakaonickname")); 	msg.append("</l3kakaonickname>\n");
					msg.append("		<l3kakaoprofile>");		msg.append(result.getString("l3kakaoprofile")); 	msg.append("</l3kakaoprofile>\n");

					//합성재가능 시간.
					msg.append("		<bgcomposewt>");	msg.append(result.getString("bgcomposewt").substring(0, 19)); msg.append("</bgcomposewt>\n");
					msg.append("		<bgcomposecc>");	msg.append(result.getInt("bgcomposecc"));    	msg.append("</bgcomposecc>\n");

					//누적정보.
					msg.append("		<bgcomposecnt>");	msg.append(result.getInt("bgcomposecnt"));    	msg.append("</bgcomposecnt>\n");
					msg.append("		<bgtradecnt>");		msg.append(result.getInt("bgtradecnt"));    	msg.append("</bgtradecnt>\n");
					msg.append("		<bgcttradecnt>");	msg.append(result.getInt("bgcttradecnt"));    	msg.append("</bgcttradecnt>\n");

					//누적정보 > 보물뽑기
					msg.append("		<anigrade1cnt>");	msg.append(result.getInt("anigrade1cnt"));    	msg.append("</anigrade1cnt>\n");
					msg.append("		<anigrade2cnt>");	msg.append(result.getInt("anigrade2cnt"));    	msg.append("</anigrade2cnt>\n");
					msg.append("		<anigrade2gauage>");msg.append(result.getInt("anigrade2gauage"));   msg.append("</anigrade2gauage>\n");
					msg.append("		<anigrade4cnt>");	msg.append(result.getInt("anigrade4cnt"));    	msg.append("</anigrade4cnt>\n");
					msg.append("		<anigrade4gauage>");msg.append(result.getInt("anigrade4gauage"));   msg.append("</anigrade4gauage>\n");
					msg.append("		<tsupcnt>");		msg.append(result.getInt("tsupcnt"));   		msg.append("</tsupcnt>\n");

					//누적정보 > 동물뽑기
					msg.append("		<tsgrade1cnt>");	msg.append(result.getInt("tsgrade1cnt"));    	msg.append("</tsgrade1cnt>\n");
					msg.append("		<tsgrade2cnt>");	msg.append(result.getInt("tsgrade2cnt"));    	msg.append("</tsgrade2cnt>\n");
					msg.append("		<tsgrade4cnt>");	msg.append(result.getInt("tsgrade4cnt"));   	msg.append("</tsgrade4cnt>\n");
					msg.append("		<tsgrade2gauage>");	msg.append(result.getInt("tsgrade2gauage"));    msg.append("</tsgrade2gauage>\n");
					msg.append("		<tsgrade4gauage>");	msg.append(result.getInt("tsgrade4gauage"));   	msg.append("</tsgrade4gauage>\n");
					msg.append("		<bgbattlecnt>");	msg.append(result.getInt("bgbattlecnt"));   	msg.append("</bgbattlecnt>\n");
					msg.append("		<bganiupcnt>");		msg.append(result.getInt("bganiupcnt"));   		msg.append("</bganiupcnt>\n");

					//@@@@ start 삭제.
					msg.append("		<bgroulcnt>");		msg.append(result.getInt("anigrade1cnt"));    	msg.append("</bgroulcnt>\n");	//@@@@삭제하기.
					msg.append("		<pmroulcnt>");		msg.append(result.getInt("anigrade2cnt"));    	msg.append("</pmroulcnt>\n");	//@@@@삭제하기.
					msg.append("		<pmgauage>");		msg.append(result.getInt("anigrade2gauage"));   msg.append("</pmgauage>\n");	//@@@@삭제하기.
					msg.append("		<pmroulcnt2>");		msg.append(result.getInt("anigrade4cnt"));    	msg.append("</pmroulcnt2>\n");	//@@@@삭제하기.
					msg.append("		<pmgauage2>");		msg.append(result.getInt("anigrade4gauage"));   msg.append("</pmgauage2>\n");	//@@@@삭제하기.
					//@@@@ end

					//상인정보.
					msg.append("		<trade0>");			msg.append(result.getString("trade0"));   	msg.append("</trade0>\n");
					msg.append("		<trade1>");			msg.append(result.getString("trade1"));   	msg.append("</trade1>\n");
					msg.append("		<trade2>");			msg.append(result.getString("trade2"));   	msg.append("</trade2>\n");
					msg.append("		<trade3>");			msg.append(result.getString("trade3"));   	msg.append("</trade3>\n");
					msg.append("		<trade4>");			msg.append(result.getString("trade4"));   	msg.append("</trade4>\n");
					msg.append("		<trade5>");			msg.append(result.getString("trade5"));   	msg.append("</trade5>\n");
					msg.append("		<trade6>");			msg.append(result.getString("trade6"));   	msg.append("</trade6>\n");

					//야바위 정보.
					msg.append("		<yabauidx>");		msg.append(result.getString("yabauidx"));   msg.append("</yabauidx>\n");
					msg.append("		<yabaustep>");		msg.append(result.getString("yabaustep"));  msg.append("</yabaustep>\n");
					msg.append("		<yabauchange>");	msg.append(result.getString("yabauchange"));msg.append("</yabauchange>\n");

					//황금 상인의 우정포인트값.
					msg.append("		<needfpoint>");		msg.append(result.getString("needfpoint"));msg.append("</needfpoint>\n");

					//합성 메인 기본레벨.
					msg.append("		<anicomposelevel>");msg.append(result.getString("anicomposelevel"));msg.append("</anicomposelevel>\n");

					//목장배틀 자동돌기.
					msg.append("		<farmbattleopenlv>");msg.append(result.getString("farmbattleopenlv"));msg.append("</farmbattleopenlv>\n");

					//새로시작 시간초기화.
					msg.append("		<newstartinitlv>");msg.append(result.getString("newstartinitlv"));msg.append("</newstartinitlv>\n");

					//촉진제보물효과.
					msg.append("		<treasureval>");msg.append(result.getString("treasureval"));msg.append("</treasureval>\n");

					//세션값.
					msg.append("		<sid>");			msg.append(result.getString("sid"));			msg.append("</sid>\n");

					//cashpoint.
					msg.append("		<cashpoint>");		msg.append(result.getString("cashpoint"));		msg.append("</cashpoint>\n");

					//랭킹대전참여팀.
					msg.append("		<rkstartstate>");	msg.append(result.getString("rkstartstate"));	msg.append("</rkstartstate>\n");
					msg.append("		<rkteam>");			msg.append(result.getString("rkteam")); 		msg.append("</rkteam>\n");
					msg.append("		<rksalemoney>");	msg.append(result.getString("rksalemoney")); 	msg.append("</rksalemoney>\n");
					msg.append("		<rksalebarrel>");	msg.append(result.getString("rksalebarrel")); 	msg.append("</rksalebarrel>\n");
					msg.append("		<rkbattlecnt>");	msg.append(result.getString("rkbattlecnt")); 	msg.append("</rkbattlecnt>\n");
					msg.append("		<rkbogicnt>");		msg.append(result.getString("rkbogicnt")); 		msg.append("</rkbogicnt>\n");
					msg.append("		<rkfriendpoint>");	msg.append(result.getString("rkfriendpoint")); 	msg.append("</rkfriendpoint>\n");
					msg.append("		<rkroulettecnt>");	msg.append(result.getString("rkroulettecnt")); 	msg.append("</rkroulettecnt>\n");
					msg.append("		<rkwolfcnt>");		msg.append(result.getString("rkwolfcnt")); 		msg.append("</rkwolfcnt>\n");

					//복귀중인가?
					msg.append("		<rtnstep>");		msg.append(result.getString("rtnstep"));		msg.append("</rtnstep>\n");
					msg.append("		<rtnplaycnt>");		msg.append(result.getString("rtnplaycnt"));		msg.append("</rtnplaycnt>\n");

					//유저배틀정보.
					msg.append("		<trophy>");			msg.append(result.getInt("trophy"));    		msg.append("</trophy>\n");
					msg.append("		<tier>");			msg.append(result.getInt("tier"));    			msg.append("</tier>\n");
					msg.append("		<userbattleanilistidx1>");msg.append(result.getInt("userbattleanilistidx1"));msg.append("</userbattleanilistidx1>\n");
					msg.append("		<userbattleanilistidx2>");msg.append(result.getInt("userbattleanilistidx2"));msg.append("</userbattleanilistidx2>\n");
					msg.append("		<userbattleanilistidx3>");msg.append(result.getInt("userbattleanilistidx3"));msg.append("</userbattleanilistidx3>\n");

					//유저배틀상자.
					msg.append("		<boxslotidx>");		msg.append(result.getInt("boxslotidx"));    	msg.append("</boxslotidx>\n");
					msg.append("		<boxslottime>");	msg.append(result.getString("boxslottime").substring(0, 19));msg.append("</boxslottime>\n");
					msg.append("		<boxslot1>");		msg.append(result.getInt("boxslot1"));    		msg.append("</boxslot1>\n");
					msg.append("		<boxslot2>");		msg.append(result.getInt("boxslot2"));    		msg.append("</boxslot2>\n");
					msg.append("		<boxslot3>");		msg.append(result.getInt("boxslot3"));    		msg.append("</boxslot3>\n");
					msg.append("		<boxslot4>");		msg.append(result.getInt("boxslot4"));    		msg.append("</boxslot4>\n");

					//스킬능력.
					msg.append("		<atk1>");			msg.append(result.getString("atk1"));			msg.append("</atk1>\n");
					msg.append("		<atk2>");			msg.append(result.getString("atk2"));			msg.append("</atk2>\n");
					msg.append("		<atk3>");			msg.append(result.getString("atk3"));			msg.append("</atk3>\n");
					msg.append("		<def1>");			msg.append(result.getString("def1"));			msg.append("</def1>\n");
					msg.append("		<def2>");			msg.append(result.getString("def2"));			msg.append("</def2>\n");
					msg.append("		<def3>");			msg.append(result.getString("def3"));			msg.append("</def3>\n");
					msg.append("		<hp1>");			msg.append(result.getString("hp1"));			msg.append("</hp1>\n");
					msg.append("		<hp2>");			msg.append(result.getString("hp2"));			msg.append("</hp2>\n");
					msg.append("		<hp3>");			msg.append(result.getString("hp3"));			msg.append("</hp3>\n");
					msg.append("		<hptime1>");		msg.append(result.getString("hptime1"));		msg.append("</hptime1>\n");
					msg.append("		<hptime2>");		msg.append(result.getString("hptime2"));		msg.append("</hptime2>\n");
					msg.append("		<hptime3>");		msg.append(result.getString("hptime3"));		msg.append("</hptime3>\n");
					msg.append("		<turn1>");			msg.append(result.getString("turn1"));			msg.append("</turn1>\n");
					msg.append("		<turn2>");			msg.append(result.getString("turn2"));			msg.append("</turn2>\n");
					msg.append("		<turn3>");			msg.append(result.getString("turn3"));			msg.append("</turn3>\n");
					msg.append("		<turntime1>");		msg.append(result.getString("turntime1"));		msg.append("</turntime1>\n");
					msg.append("		<turntime2>");		msg.append(result.getString("turntime2"));		msg.append("</turntime2>\n");
					msg.append("		<turntime3>");		msg.append(result.getString("turntime3"));		msg.append("</turntime3>\n");

					//상인의 신선도 상승.
					msg.append("		<dpstep1>");		msg.append(result.getString("dpstep1"));		msg.append("</dpstep1>\n");
					msg.append("		<dpstep2>");		msg.append(result.getString("dpstep2"));		msg.append("</dpstep2>\n");
					msg.append("		<dpstep3>");		msg.append(result.getString("dpstep3"));		msg.append("</dpstep3>\n");
					msg.append("		<dpstep4>");		msg.append(result.getString("dpstep4"));		msg.append("</dpstep4>\n");
					msg.append("		<dpstep5>");		msg.append(result.getString("dpstep5"));		msg.append("</dpstep5>\n");
					msg.append("		<dpstep6>");		msg.append(result.getString("dpstep6"));		msg.append("</dpstep6>\n");
					msg.append("		<dpstep7>");		msg.append(result.getString("dpstep7"));		msg.append("</dpstep7>\n");
					msg.append("		<dpstep8>");		msg.append(result.getString("dpstep8"));		msg.append("</dpstep8>\n");
					msg.append("		<dpstep9>");		msg.append(result.getString("dpstep9"));		msg.append("</dpstep9>\n");
					msg.append("		<dpstepm>");		msg.append(result.getString("dpstepm"));		msg.append("</dpstepm>\n");

					//룰렛에 대한정보.
					msg.append("		<wheeltodaycnt>");	msg.append(result.getString("wheeltodaycnt"));	msg.append("</wheeltodaycnt>\n");
					msg.append("		<wheelgauage>");	msg.append(result.getString("wheelgauage"));	msg.append("</wheelgauage>\n");
					msg.append("		<wheelfree>");		msg.append(result.getString("wheelfree"));		msg.append("</wheelfree>\n");

					//유저배송정보.
					msg.append("		<phone2>");			msg.append(result.getString("phone2"));			msg.append("</phone2>\n");
					msg.append("		<zipcode>");		msg.append(result.getString("zipcode"));		msg.append("</zipcode>\n");
					msg.append("		<address1>");		msg.append(result.getString("address1"));		msg.append("</address1>\n");
					msg.append("		<address2>");		msg.append(result.getString("address2"));		msg.append("</address2>\n");

					msg.append("	</userinfo>\n");
				}
			}

			//2-3-3. 유저 보유 아이템 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<itemowner>\n");
					msg.append("		<listidx>");		msg.append(result.getString("listidx"));   		msg.append("</listidx>\n");
					msg.append("		<invenkind>");		msg.append(result.getString("invenkind"));   	msg.append("</invenkind>\n");
					msg.append("		<fieldidx>");		msg.append(result.getString("fieldidx"));   	msg.append("</fieldidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));   			msg.append("</cnt>\n");
					msg.append("		<anistep>");		msg.append(result.getString("anistep"));   		msg.append("</anistep>\n");
					msg.append("		<manger>");			msg.append(result.getString("manger"));   		msg.append("</manger>\n");
					msg.append("		<diseasestate>");	msg.append(result.getString("diseasestate"));   msg.append("</diseasestate>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1"));   		msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2"));   		msg.append("</acc2>\n");
					msg.append("		<randserial>");		msg.append(result.getString("randserial"));   	msg.append("</randserial>\n");
					msg.append("		<petupgrade>");		msg.append(result.getString("petupgrade"));   	msg.append("</petupgrade>\n");
					msg.append("		<treasureupgrade>");msg.append(result.getString("treasureupgrade"));msg.append("</treasureupgrade>\n");
					msg.append("		<needhelpcnt>");	msg.append(result.getString("needhelpcnt"));   	msg.append("</needhelpcnt>\n");

					msg.append("		<upcnt>");			msg.append(result.getString("upcnt"));   		msg.append("</upcnt>\n");
					msg.append("		<upstepmax>");		msg.append(result.getString("upstepmax"));   	msg.append("</upstepmax>\n");
					msg.append("		<freshstem100>");	msg.append(result.getString("freshstem100"));  	msg.append("</freshstem100>\n");
					msg.append("		<attstem100>");		msg.append(result.getString("attstem100"));   	msg.append("</attstem100>\n");
					msg.append("		<timestem100>");	msg.append(result.getString("timestem100"));   	msg.append("</timestem100>\n");
					msg.append("		<defstem100>");		msg.append(result.getString("defstem100"));   	msg.append("</defstem100>\n");
					msg.append("		<hpstem100>");		msg.append(result.getString("hpstem100"));   	msg.append("</hpstem100>\n");

					//쿠폰만기일.
					msg.append("		<expirekind>");		msg.append(result.getString("expirekind"));   	msg.append("</expirekind>\n");
					msg.append("		<expiredate>");		msg.append(result.getString("expiredate").substring(0, 19));   	msg.append("</expiredate>\n");
					msg.append("	</itemowner>\n");
				}
			}

			//2-3-3. 유저 경작지.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<seedfield>\n");
					msg.append("		<seedidx>");		msg.append(result.getString("seedidx"));   	msg.append("</seedidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<seedstartdate>");	msg.append(result.getString("seedstartdate").substring(0, 19));  	msg.append("</seedstartdate>\n");
					msg.append("		<seedenddate>");	msg.append(result.getString("seedenddate").substring(0, 19));  		msg.append("</seedenddate>\n");
					msg.append("	</seedfield>\n");
				}
			}


			//2-3-4. 유저 친구정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<userfriend>\n");
					msg.append("		<friendid>");		msg.append(result.getString("friendid"));   	msg.append("</friendid>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode")); 		msg.append("</itemcode>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1"));   		msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2"));   		msg.append("</acc2>\n");
					msg.append("		<state>");			msg.append(result.getString("state"));   		msg.append("</state>\n");
					msg.append("		<senddate>");		msg.append(result.getString("senddate").substring(0, 19));   	msg.append("</senddate>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   		msg.append("</famelv>\n");

					msg.append("		<kakaotalkid>");	msg.append(result.getString("kakaotalkid"));   	msg.append("</kakaotalkid>\n");
					msg.append("		<kakaouserid>");	msg.append(result.getString("kakaouserid"));   	msg.append("</kakaouserid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
					msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));   msg.append("</kakaoprofile>\n");
					msg.append("		<kakaomsgblocked>");msg.append(result.getString("kakaomsgblocked"));msg.append("</kakaomsgblocked>\n");
					msg.append("		<kakaofriendkind>");msg.append(result.getString("kakaofriendkind"));msg.append("</kakaofriendkind>\n");

					msg.append("		<rtnstate>");		msg.append(result.getString("rtnstate"));		msg.append("</rtnstate>\n");
					msg.append("		<rtndate>");		msg.append(result.getString("rtndate").substring(0, 19));msg.append("</rtndate>\n");

					msg.append("		<helpdate>");		msg.append(result.getString("helpdate").substring(0, 19));msg.append("</helpdate>\n");
					msg.append("		<rentdate>");		msg.append(result.getString("rentdate").substring(0, 19));msg.append("</rentdate>\n");
					msg.append("	</userfriend>\n");
				}
			}


			//2-3-4. 유저 친구정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<kakaoinvite>\n");
					msg.append("		<receuuid>");		msg.append(result.getString("receuuid")); 					msg.append("</receuuid>\n");
					msg.append("		<senddate>");		msg.append(result.getString("senddate").substring(0, 19));  msg.append("</senddate>\n");
					msg.append("	</kakaoinvite>\n");
				}
			}

			//2-3-5. 선물정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<giftitem>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));   			msg.append("</idx>\n");
					msg.append("		<giftkind>");		msg.append(result.getString("giftkind"));   	msg.append("</giftkind>\n");
					msg.append("		<message>");		msg.append(result.getString("message"));   		msg.append("</message>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<giftdate>");		msg.append(result.getString("giftdate").substring(0, 10));   	msg.append("</giftdate>\n");
					msg.append("		<giftid>");			msg.append(result.getString("giftid"));   		msg.append("</giftid>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));   			msg.append("</cnt>\n");
					msg.append("	</giftitem>\n");
				}
			}

			////2-3-6-1. 도감 : 마스터 (사용안함)
			//if(cstmt.getMoreResults()){
			//	result = cstmt.getResultSet();
			//	while(result.next()){
			//		msg.append("	<dogammaster>\n");
			//		msg.append("		<dogamidx>");		msg.append(result.getString("dogamidx"));   	msg.append("</dogamidx>\n");
			//		msg.append("		<dogamname>");		msg.append(result.getString("dogamname"));   	msg.append("</dogamname>\n");
			//		msg.append("		<animal0>");		msg.append(result.getString("animal0"));   		msg.append("</animal0>\n");
			//		msg.append("		<animal1>");		msg.append(result.getString("animal1"));   		msg.append("</animal1>\n");
			//		msg.append("		<animal2>");		msg.append(result.getString("animal2"));   		msg.append("</animal2>\n");
			//		msg.append("		<animal3>");		msg.append(result.getString("animal3"));   		msg.append("</animal3>\n");
			//		msg.append("		<animal4>");		msg.append(result.getString("animal4"));   		msg.append("</animal4>\n");
			//		msg.append("		<animal5>");		msg.append(result.getString("animal5"));   		msg.append("</animal5>\n");
			//		msg.append("		<rewarditemcode>");	msg.append(result.getString("rewarditemcode")); msg.append("</rewarditemcode>\n");
			//		msg.append("		<rewardvalue>");	msg.append(result.getString("rewardvalue"));   	msg.append("</rewardvalue>\n");
			//		msg.append("	</dogammaster>\n");
			//	}
			//}

			//2-3-6-2. 펫도감 : 획득한도감
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<dogamlistpet>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("	</dogamlistpet>\n");
				}
			}

			//2-3-6-2. 동물도감 : 획득한도감
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<dogamlist>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("	</dogamlist>\n");
				}
			}

			//2-3-6-3. 동물도감 : 보상받은 도감
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<dogamreward>\n");
					msg.append("		<dogamidx>");		msg.append(result.getString("dogamidx"));   	msg.append("</dogamidx>\n");
					//msg.append("		<getdate>");		msg.append(result.getString("getdate"));   		msg.append("</getdate>\n");
					msg.append("	</dogamreward>\n");
				}
			}

			//2-3-8. 정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<syssinfo>\n");

					//업그레이드맥스
					msg.append("		<housestepmax>");	msg.append(result.getString("housestepmax2"));  msg.append("</housestepmax>\n");
					msg.append("		<pumpstepmax>");	msg.append(result.getString("pumpstepmax2"));  	msg.append("</pumpstepmax>\n");
					msg.append("		<bottlestepmax>");	msg.append(result.getString("bottlestepmax2")); msg.append("</bottlestepmax>\n");
					msg.append("		<transferstepmax>");msg.append(result.getString("transferstepmax2"));msg.append("</transferstepmax>\n");
					msg.append("		<tankstepmax>");	msg.append(result.getString("tankstepmax2"));  	msg.append("</tankstepmax>\n");
					msg.append("		<purestepmax>");	msg.append(result.getString("purestepmax2"));  	msg.append("</purestepmax>\n");
					msg.append("		<freshcoolstepmax>");msg.append(result.getString("freshcoolstepmax2"));msg.append("</freshcoolstepmax>\n");

					//확장맥스
					msg.append("		<invenstepmax>");	msg.append(result.getString("invenstepmax"));  	msg.append("</invenstepmax>\n");
					msg.append("		<invencountmax>");	msg.append(result.getString("invencountmax"));  msg.append("</invencountmax>\n");
					msg.append("		<seedfieldmax>");	msg.append(result.getString("seedfieldmax"));  	msg.append("</seedfieldmax>\n");

					//추가지급
					msg.append("		<pluscashcost>");	msg.append(result.getString("pluscashcost"));  	msg.append("</pluscashcost>\n");
					msg.append("		<plusgamecost>");	msg.append(result.getString("plusgamecost"));  	msg.append("</plusgamecost>\n");
					msg.append("		<plusheart>");		msg.append(result.getString("plusheart"));  	msg.append("</plusheart>\n");
					msg.append("		<plusfeed>");		msg.append(result.getString("plusfeed"));  		msg.append("</plusfeed>\n");
					msg.append("		<plusgoldticket>");	msg.append(result.getString("plusgoldticket")); msg.append("</plusgoldticket>\n");
					msg.append("		<plusbattleticket>");msg.append(result.getString("plusbattleticket"));msg.append("</plusbattleticket>\n");

					//일보상.
					msg.append("		<attend1>");		msg.append(result.getString("attend1"));  		msg.append("</attend1>\n");
					msg.append("		<attend2>");		msg.append(result.getString("attend2"));  		msg.append("</attend2>\n");
					msg.append("		<attend3>");		msg.append(result.getString("attend3"));  		msg.append("</attend3>\n");
					msg.append("		<attend4>");		msg.append(result.getString("attend4"));  		msg.append("</attend4>\n");
					msg.append("		<attend5>");		msg.append(result.getString("attend5"));  		msg.append("</attend5>\n");

					//동물합성 할인가격.
					msg.append("		<composesale>");	msg.append(result.getString("composesale"));  	msg.append("</composesale>\n");
					msg.append("		<iphonecoupon>");	msg.append(result.getString("iphonecoupon"));  	msg.append("</iphonecoupon>\n");

					//kakao.
					msg.append("		<kakaoinviteid>");	msg.append(result.getString("kakaoinviteid"));  msg.append("</kakaoinviteid>\n");
					msg.append("		<kakaoproudid>");	msg.append(result.getString("kakaoproudid"));  	msg.append("</kakaoproudid>\n");
					msg.append("		<kakaoheartid>");	msg.append(result.getString("kakaoheartid"));  	msg.append("</kakaoheartid>\n");
					msg.append("		<kakaohelpid>");	msg.append(result.getString("kakaohelpid"));  	msg.append("</kakaohelpid>\n");

					msg.append("		<kakaoinvite01>");	msg.append(result.getString("kakaoinvite01"));  msg.append("</kakaoinvite01>\n");
					msg.append("		<kakaoinvite02>");	msg.append(result.getString("kakaoinvite02"));  msg.append("</kakaoinvite02>\n");
					msg.append("		<kakaoinvite03>");	msg.append(result.getString("kakaoinvite03"));  msg.append("</kakaoinvite03>\n");
					msg.append("		<kakaoinvite04>");	msg.append(result.getString("kakaoinvite04"));  msg.append("</kakaoinvite04>\n");

					//추천게임 메세지.
					msg.append("		<recommendmsg>");	msg.append(result.getString("recommendmsg"));  	msg.append("</recommendmsg>\n");


					//황금룰렛 세팅값.
					msg.append("		<wheelgauageflag>");msg.append(result.getString("wheelgauageflag")); 	msg.append("</wheelgauageflag>\n");
					msg.append("		<wheelgauagepoint>");msg.append(result.getString("wheelgauagepoint")); 	msg.append("</wheelgauagepoint>\n");
					msg.append("		<wheelgauagemax>");	msg.append(result.getString("wheelgauagemax")); 	msg.append("</wheelgauagemax>\n");

					//msg.append("		<urgency>");		msg.append(result.getString("urgency"));  		msg.append("</urgency>\n");
					msg.append("	</syssinfo>\n");
				}
			}

			//2-3-9. 패키지정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<syspack>\n");
					msg.append("		<idx>");				msg.append(result.getString("idx"));  			msg.append("</idx>\n");
					msg.append("		<packname>");			msg.append(result.getString("packname"));  		msg.append("</packname>\n");
					msg.append("		<pack1>");				msg.append(result.getString("pack1"));  		msg.append("</pack1>\n");
					msg.append("		<pack2>");				msg.append(result.getString("pack2"));  		msg.append("</pack2>\n");
					msg.append("		<pack3>");				msg.append(result.getString("pack3"));  		msg.append("</pack3>\n");
					msg.append("		<pack4>");				msg.append(result.getString("pack4"));  		msg.append("</pack4>\n");
					msg.append("		<pack5>");				msg.append(result.getString("pack5"));  		msg.append("</pack5>\n");
					msg.append("		<cashcostcost>");		msg.append(result.getString("cashcostcost"));	msg.append("</cashcostcost>\n");
					msg.append("		<cashcostper>");		msg.append(result.getString("cashcostper")); 	msg.append("</cashcostper>\n");
					msg.append("		<cashcostsale>");		msg.append(result.getString("cashcostsale"));	msg.append("</cashcostsale>\n");
					msg.append("	</syspack>\n");
				}
			}

			//2-3-5. 랭킹.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<frank>\n");
					msg.append("		<rank>");			msg.append(result.getString("rank"));   		msg.append("</rank>\n");
					msg.append("		<friendid>");		msg.append(result.getString("friendid"));   	msg.append("</friendid>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<acc1>");			msg.append(result.getString("acc1"));   		msg.append("</acc1>\n");
					msg.append("		<acc2>");			msg.append(result.getString("acc2"));   		msg.append("</acc2>\n");
					msg.append("		<ttsalecoin>");		msg.append(result.getString("ttsalecoin"));   	msg.append("</ttsalecoin>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   		msg.append("</famelv>\n");

					msg.append("		<kakaotalkid>");	msg.append(result.getString("kakaotalkid"));   	msg.append("</kakaotalkid>\n");
					msg.append("		<kakaouserid>");	msg.append(result.getString("kakaouserid"));   	msg.append("</kakaouserid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
					msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));   msg.append("</kakaoprofile>\n");
					msg.append("		<kakaomsgblocked>");msg.append(result.getString("kakaomsgblocked"));msg.append("</kakaomsgblocked>\n");
					msg.append("		<kakaofriendkind>");msg.append(result.getString("kakaofriendkind"));msg.append("</kakaofriendkind>\n");
					msg.append("	</frank>\n");
				}
			}

			//농장정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<myfarm>\n");
					msg.append("		<star>");			msg.append(result.getString("star"));   			msg.append("</star>\n");
					msg.append("		<farmidx>");		msg.append(result.getString("farmidx"));   			msg.append("</farmidx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   		msg.append("</itemcode>\n");
					msg.append("		<buystate>");		msg.append(result.getString("buystate"));   		msg.append("</buystate>\n");
					msg.append("		<incomedate>");		msg.append(result.getString("incomedate").substring(0, 19)); msg.append("</incomedate>\n");
					msg.append("		<playcnt>");		msg.append(result.getString("playcnt"));   			msg.append("</playcnt>\n");
					msg.append("	</myfarm>\n");
				}
			}

			//에피소드 컨테스트 결과.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<myepilist>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   		msg.append("</itemcode>\n");
					msg.append("		<etyear>");			msg.append(result.getString("etyear"));   			msg.append("</etyear>\n");
					msg.append("		<etsalecoin>");		msg.append(result.getString("etsalecoin"));   		msg.append("</etsalecoin>\n");
					msg.append("		<etgrade>");		msg.append(result.getString("etgrade"));   			msg.append("</etgrade>\n");
					msg.append("		<etreward1>");		msg.append(result.getString("etreward1"));   		msg.append("</etreward1>\n");
					msg.append("		<etreward2>");		msg.append(result.getString("etreward2"));   		msg.append("</etreward2>\n");
					msg.append("		<etreward3>");		msg.append(result.getString("etreward3"));   		msg.append("</etreward3>\n");
					msg.append("		<etreward4>");		msg.append(result.getString("etreward4"));   		msg.append("</etreward4>\n");
					msg.append("	</myepilist>\n");
				}
			}

			//유저판매랭킹.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<ranksale>\n");
					msg.append("		<rank>");			msg.append(result.getString("rank"));   			msg.append("</rank>\n");
					msg.append("		<anirepitemcode>");	msg.append(result.getString("anirepitemcode"));  	msg.append("</anirepitemcode>\n");
					msg.append("		<ttsalecoin>");		msg.append(result.getString("ttsalecoin"));   		msg.append("</ttsalecoin>\n");
					msg.append("		<gameid>");			msg.append(result.getString("gameid"));   			msg.append("</gameid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));		msg.append("</kakaonickname>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   			msg.append("</famelv>\n");
					msg.append("	</ranksale>\n");
				}
			}

			//유저배틀랭킹.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<rankbattle>\n");
					msg.append("		<rank>");			msg.append(result.getString("rank"));   			msg.append("</rank>\n");
					msg.append("		<anirepitemcode>");	msg.append(result.getString("anirepitemcode"));  	msg.append("</anirepitemcode>\n");
					msg.append("		<trophy>");			msg.append(result.getString("trophy"));   			msg.append("</trophy>\n");
					msg.append("		<tier>");			msg.append(result.getString("tier"));   			msg.append("</tier>\n");
					msg.append("		<gameid>");			msg.append(result.getString("gameid"));   			msg.append("</gameid>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));		msg.append("</kakaonickname>\n");
					msg.append("		<famelv>");			msg.append(result.getString("famelv"));   			msg.append("</famelv>\n");
					msg.append("	</rankbattle>\n");
				}
			}

			//학교결과(학교).
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<srankmaster>\n");
					msg.append("		<dateid>");		msg.append(result.getString("dateid"));   			msg.append("</dateid>\n");
					msg.append("		<schoolrank>");	msg.append(result.getString("schoolrank"));   		msg.append("</schoolrank>\n");
					msg.append("		<schoolname>");	msg.append(result.getString("schoolname"));   		msg.append("</schoolname>\n");
					msg.append("		<schoolidx>");	msg.append(result.getString("schoolidx"));   		msg.append("</schoolidx>\n");
					msg.append("		<cnt>");		msg.append(result.getString("cnt"));   				msg.append("</cnt>\n");
					msg.append("		<totalpoint>");	msg.append(result.getString("totalpoint"));   		msg.append("</totalpoint>\n");
					msg.append("	</srankmaster>\n");
				}
			}

			//학교결과(내소속).
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<srankuser>\n");
					msg.append("		<dateid>");		msg.append(result.getString("dateid"));   			msg.append("</dateid>\n");
					msg.append("		<schoolrank>");	msg.append(result.getString("schoolrank"));   		msg.append("</schoolrank>\n");
					msg.append("		<schoolname>");	msg.append(result.getString("schoolname"));   		msg.append("</schoolname>\n");
					msg.append("		<schoolidx>");	msg.append(result.getString("schoolidx"));   		msg.append("</schoolidx>\n");
					msg.append("		<cnt>");		msg.append(result.getString("cnt"));   				msg.append("</cnt>\n");
					msg.append("		<point>");		msg.append(result.getString("point"));   			msg.append("</point>\n");
					msg.append("		<userrank>");	msg.append(result.getString("userrank"));   		msg.append("</userrank>\n");
					msg.append("		<itemcode1>");	msg.append(result.getString("itemcode1"));   		msg.append("</itemcode1>\n");
					msg.append("		<itemcode2>");	msg.append(result.getString("itemcode2"));   		msg.append("</itemcode2>\n");
					msg.append("		<itemcode3>");	msg.append(result.getString("itemcode3"));   		msg.append("</itemcode3>\n");
					msg.append("	</srankuser>\n");
				}
			}

			//도움준 친구.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<helpfriend>\n");
					msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
					msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));  	msg.append("</kakaoprofile>\n");
					msg.append("	</helpfriend>\n");
				}
			}

			//야바위.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<sysyabau>\n");
					msg.append("		<idx>");				msg.append(result.getString("idx"));  			msg.append("</idx>\n");
					msg.append("		<packname>");			msg.append(result.getString("packname"));  		msg.append("</packname>\n");
					msg.append("		<saleper>");			msg.append(result.getString("saleper")); 		msg.append("</saleper>\n");
					msg.append("		<pack11>");				msg.append(result.getString("pack11"));  		msg.append("</pack11>\n");
					msg.append("		<pack12>");				msg.append(result.getString("pack12"));  		msg.append("</pack12>\n");
					msg.append("		<pack13>");				msg.append(result.getString("pack13"));  		msg.append("</pack13>\n");
					msg.append("		<pack14>");				msg.append(result.getString("pack14"));  		msg.append("</pack14>\n");
					msg.append("		<pack21>");				msg.append(result.getString("pack21"));  		msg.append("</pack21>\n");
					msg.append("		<pack22>");				msg.append(result.getString("pack22"));  		msg.append("</pack22>\n");
					msg.append("		<pack23>");				msg.append(result.getString("pack23"));  		msg.append("</pack23>\n");
					msg.append("		<pack24>");				msg.append(result.getString("pack24"));  		msg.append("</pack24>\n");
					msg.append("		<pack31>");				msg.append(result.getString("pack31"));  		msg.append("</pack31>\n");
					msg.append("		<pack32>");				msg.append(result.getString("pack32"));  		msg.append("</pack32>\n");
					msg.append("		<pack33>");				msg.append(result.getString("pack33"));  		msg.append("</pack33>\n");
					msg.append("		<pack34>");				msg.append(result.getString("pack34"));  		msg.append("</pack34>\n");
					msg.append("		<pack41>");				msg.append(result.getString("pack41"));  		msg.append("</pack41>\n");
					msg.append("		<pack42>");				msg.append(result.getString("pack42"));  		msg.append("</pack42>\n");
					msg.append("		<pack43>");				msg.append(result.getString("pack43"));  		msg.append("</pack43>\n");
					msg.append("		<pack44>");				msg.append(result.getString("pack44"));  		msg.append("</pack44>\n");
					msg.append("		<pack51>");				msg.append(result.getString("pack51"));  		msg.append("</pack51>\n");
					msg.append("		<pack52>");				msg.append(result.getString("pack52"));  		msg.append("</pack52>\n");
					msg.append("		<pack53>");				msg.append(result.getString("pack53"));  		msg.append("</pack53>\n");
					msg.append("		<pack54>");				msg.append(result.getString("pack54"));  		msg.append("</pack54>\n");
					msg.append("		<pack61>");				msg.append(result.getString("pack61"));  		msg.append("</pack61>\n");
					msg.append("		<pack62>");				msg.append(result.getString("pack62"));  		msg.append("</pack62>\n");
					msg.append("		<pack63>");				msg.append(result.getString("pack63"));  		msg.append("</pack63>\n");
					msg.append("		<pack64>");				msg.append(result.getString("pack64"));  		msg.append("</pack64>\n");
					msg.append("	</sysyabau>\n");
				}
			}


			//보유효과 보물보상.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<tsreffect>\n");
					msg.append("		<itemcode>");	msg.append(result.getString("itemcode"));	msg.append("</itemcode>\n");
					msg.append("		<cnt>");		msg.append(result.getString("cnt")); 		msg.append("</cnt>\n");
					msg.append("	</tsreffect>\n");
				}
			}


			//동물뽑기 가격정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<sysroul>\n");
					msg.append("		<roulgrade1gamecost>");	msg.append(result.getString("roulgrade1gamecost"));	msg.append("</roulgrade1gamecost>\n");
					msg.append("		<roulgrade1heart>");	msg.append(result.getString("roulgrade1heart")); 	msg.append("</roulgrade1heart>\n");
					msg.append("		<roulgrade2cashcost>");	msg.append(result.getString("roulgrade2cashcost"));	msg.append("</roulgrade2cashcost>\n");
					msg.append("		<roulgrade4cashcost>");	msg.append(result.getString("roulgrade4cashcost"));	msg.append("</roulgrade4cashcost>\n");
					msg.append("	</sysroul>\n");
				}
			}

			//동물뽑기 마스터 정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<pminfo>\n");
					msg.append("		<roulsaleflag>");	msg.append(result.getString("roulsaleflag2"));  	msg.append("</roulsaleflag>\n");
					msg.append("		<roulsalevalue>");	msg.append(result.getString("roulsalevalue"));  	msg.append("</roulsalevalue>\n");

					msg.append("		<roulstart>");		msg.append(result.getString("roulstart").substring(0, 19)); 	msg.append("</roulstart>\n");
					msg.append("		<roulend>");		msg.append(result.getString("roulend").substring(0, 19)); 		msg.append("</roulend>\n");

					msg.append("		<roulflag>");		msg.append(result.getString("roulflag2"));  		msg.append("</roulflag>\n");
					msg.append("		<roulani1>");		msg.append(result.getString("roulani1"));  			msg.append("</roulani1>\n");
					msg.append("		<roulani2>");		msg.append(result.getString("roulani2")); 			msg.append("</roulani2>\n");
					msg.append("		<roulani3>");		msg.append(result.getString("roulani3"));  			msg.append("</roulani3>\n");
					msg.append("		<roulreward1>");	msg.append(result.getString("roulreward1"));		msg.append("</roulreward1>\n");
					msg.append("		<roulreward2>");	msg.append(result.getString("roulreward2"));		msg.append("</roulreward2>\n");
					msg.append("		<roulreward3>");	msg.append(result.getString("roulreward3"));		msg.append("</roulreward3>\n");
					msg.append("		<roulrewardcnt1>");	msg.append(result.getString("roulrewardcnt1"));		msg.append("</roulrewardcnt1>\n");
					msg.append("		<roulrewardcnt2>");	msg.append(result.getString("roulrewardcnt2"));		msg.append("</roulrewardcnt2>\n");
					msg.append("		<roulrewardcnt3>");	msg.append(result.getString("roulrewardcnt3"));		msg.append("</roulrewardcnt3>\n");

					msg.append("		<roultimeflag>");	msg.append(result.getString("roultimeflag2"));  	msg.append("</roultimeflag>\n");
					msg.append("		<roultimetime1>");	msg.append(result.getString("roultimetime1"));  	msg.append("</roultimetime1>\n");
					msg.append("		<roultimetime2>");	msg.append(result.getString("roultimetime2"));  	msg.append("</roultimetime2>\n");
					msg.append("		<roultimetime3>");	msg.append(result.getString("roultimetime3"));  	msg.append("</roultimetime3>\n");
					msg.append("		<roultimetime4>");	msg.append(result.getString("roultimetime4"));  	msg.append("</roultimetime4>\n");

					msg.append("		<pmgauageflag>");	msg.append(result.getString("pmgauageflag2"));  	msg.append("</pmgauageflag>\n");
					msg.append("		<pmgauagepoint>");	msg.append(result.getString("pmgauagepoint"));  	msg.append("</pmgauagepoint>\n");
					msg.append("		<pmgauagemax>");	msg.append(result.getString("pmgauagemax"));  		msg.append("</pmgauagemax>\n");
					msg.append("	</pminfo>\n");
				}
			}

			//보물뽑기 가격정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<systreasure>\n");
					msg.append("		<tsgrade1gamecost>");	msg.append(result.getString("tsgrade1gamecost"));	msg.append("</tsgrade1gamecost>\n");
					msg.append("		<tsgrade1heart>");		msg.append(result.getString("tsgrade1heart"));		msg.append("</tsgrade1heart>\n");
					msg.append("		<tsgrade2cashcost>");	msg.append(result.getString("tsgrade2cashcost"));	msg.append("</tsgrade2cashcost>\n");
					msg.append("		<tsgrade4cashcost>");	msg.append(result.getString("tsgrade4cashcost"));	msg.append("</tsgrade4cashcost>\n");
					msg.append("	</systreasure>\n");
				}
			}

			//보물뽑기 마스터 정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<tsinfo>\n");
					msg.append("		<tssaleflag>");		msg.append(result.getString("roulsaleflag2"));  	msg.append("</tssaleflag>\n");
					msg.append("		<tssalevalue>");	msg.append(result.getString("roulsalevalue"));  	msg.append("</tssalevalue>\n");

					msg.append("		<tsstart>");		msg.append(result.getString("roulstart").substring(0, 19)); 	msg.append("</tsstart>\n");
					msg.append("		<tsend>");			msg.append(result.getString("roulend").substring(0, 19)); 		msg.append("</tsend>\n");

					msg.append("		<tsflag>");			msg.append(result.getString("roulflag2"));  		msg.append("</tsflag>\n");
					msg.append("		<tsani1>");			msg.append(result.getString("roulani1"));  			msg.append("</tsani1>\n");
					msg.append("		<tsani2>");			msg.append(result.getString("roulani2")); 			msg.append("</tsani2>\n");
					msg.append("		<tsani3>");			msg.append(result.getString("roulani3"));  			msg.append("</tsani3>\n");
					msg.append("		<tsreward1>");		msg.append(result.getString("roulreward1"));		msg.append("</tsreward1>\n");
					msg.append("		<tsreward2>");		msg.append(result.getString("roulreward2"));		msg.append("</tsreward2>\n");
					msg.append("		<tsreward3>");		msg.append(result.getString("roulreward3"));		msg.append("</tsreward3>\n");
					msg.append("		<tsrewardcnt1>");	msg.append(result.getString("roulrewardcnt1"));		msg.append("</tsrewardcnt1>\n");
					msg.append("		<tsrewardcnt2>");	msg.append(result.getString("roulrewardcnt2"));		msg.append("</tsrewardcnt2>\n");
					msg.append("		<tsrewardcnt3>");	msg.append(result.getString("roulrewardcnt3"));		msg.append("</tsrewardcnt3>\n");

					msg.append("		<tstimeflag>");		msg.append(result.getString("roultimeflag2"));  	msg.append("</tstimeflag>\n");
					msg.append("		<tstimetime1>");	msg.append(result.getString("roultimetime1"));  	msg.append("</tstimetime1>\n");
					msg.append("		<tstimetime2>");	msg.append(result.getString("roultimetime2"));  	msg.append("</tstimetime2>\n");
					msg.append("		<tstimetime3>");	msg.append(result.getString("roultimetime3"));  	msg.append("</tstimetime3>\n");
					msg.append("		<tstimetime4>");	msg.append(result.getString("roultimetime4"));  	msg.append("</tstimetime4>\n");

					msg.append("		<tspmgauageflag>");	msg.append(result.getString("pmgauageflag2"));  	msg.append("</tspmgauageflag>\n");
					msg.append("		<tspmgauagepoint>");msg.append(result.getString("pmgauagepoint")); 		msg.append("</tspmgauagepoint>\n");
					msg.append("		<tspmgauagemax>");	msg.append(result.getString("pmgauagemax"));  		msg.append("</tspmgauagemax>\n");

					msg.append("		<tsupgradesaleflag>");msg.append(result.getString("tsupgradesaleflag2"));msg.append("</tsupgradesaleflag>\n");
					msg.append("		<tsupgradesalevalue>");msg.append(result.getString("tsupgradesalevalue"));msg.append("</tsupgradesalevalue>\n");
					msg.append("	</tsinfo>\n");
				}
			}

			//생애첫결제정보.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<cashfirsttime>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));		msg.append("</itemcode>\n");
					msg.append("	</cashfirsttime>\n");
				}
			}

			//무료룰렛.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<wheelfreeinfo>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));			msg.append("</idx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));		msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));			msg.append("</cnt>\n");
					msg.append("	</wheelfreeinfo>\n");
				}
			}

			//유료룰렛.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<wheelcashinfo>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));			msg.append("</idx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));		msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));			msg.append("</cnt>\n");
					msg.append("	</wheelcashinfo>\n");
				}
			}

			//vip info.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<vipinfo>\n");
					msg.append("		<vip_grade>");		msg.append(result.getString("vip_grade"));		msg.append("</vip_grade>\n");
					msg.append("		<vip_cashpoint>");	msg.append(result.getString("vip_cashpoint"));	msg.append("</vip_cashpoint>\n");
					msg.append("		<vip_cashplus>");	msg.append(result.getString("vip_cashplus"));	msg.append("</vip_cashplus>\n");
					msg.append("		<vip_gamecost>");	msg.append(result.getString("vip_gamecost"));	msg.append("</vip_gamecost>\n");
					msg.append("		<vip_heart>");		msg.append(result.getString("vip_heart"));		msg.append("</vip_heart>\n");
					msg.append("		<vip_animal10>");	msg.append(result.getString("vip_animal10"));	msg.append("</vip_animal10>\n");
					msg.append("		<vip_wheel10>");	msg.append(result.getString("vip_wheel10"));	msg.append("</vip_wheel10>\n");
					msg.append("		<vip_treasure10>");	msg.append(result.getString("vip_treasure10"));	msg.append("</vip_treasure10>\n");
					msg.append("		<vip_box>");		msg.append(result.getString("vip_box"));		msg.append("</vip_box>\n");
					msg.append("		<vip_fbplus>");		msg.append(result.getString("vip_fbplus"));		msg.append("</vip_fbplus>\n");
					msg.append("	</vipinfo>\n");
				}
			}

			//랭킹대전 이름.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<rkcolumname>\n");
					msg.append("		<rkname1>");		msg.append(result.getString("rkname1"));		msg.append("</rkname1>\n");
					msg.append("		<rkname2>");		msg.append(result.getString("rkname2"));		msg.append("</rkname2>\n");
					msg.append("		<rkname3>");		msg.append(result.getString("rkname3"));		msg.append("</rkname3>\n");
					msg.append("		<rkname4>");		msg.append(result.getString("rkname4"));		msg.append("</rkname4>\n");
					msg.append("		<rkname5>");		msg.append(result.getString("rkname5"));		msg.append("</rkname5>\n");
					msg.append("		<rkname6>");		msg.append(result.getString("rkname6"));		msg.append("</rkname6>\n");
					msg.append("		<rkname7>");		msg.append(result.getString("rkname7"));		msg.append("</rkname7>\n");
					msg.append("		<rking>");			msg.append(result.getString("rking"));			msg.append("</rking>\n");
					msg.append("	</rkcolumname>\n");
				}
			}
			//랭킹대전 설명.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<rkinfodata>\n");
					msg.append("		<rkinfo>");			msg.append(result.getString("rkinfo"));			msg.append("</rkinfo>\n");
					msg.append("	</rkinfodata>\n");
				}
			}

			//2-3-4. 홀짝랭킹(현재)
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<rkcurrank>\n");
					msg.append("		<rkdateid8>");		msg.append(result.getString("rkdateid8"));   	msg.append("</rkdateid8>\n");
					msg.append("		<rkteam1>");		msg.append(result.getString("rkteam1"));   		msg.append("</rkteam1>\n");
					msg.append("		<rkteam0>");		msg.append(result.getString("rkteam0"));   		msg.append("</rkteam0>\n");
					msg.append("		<rksalemoney>");	msg.append(result.getString("rksalemoney"));   	msg.append("</rksalemoney>\n");
					msg.append("		<rksalebarrel>");	msg.append(result.getString("rksalebarrel"));   msg.append("</rksalebarrel>\n");
					msg.append("		<rkbattlecnt>");	msg.append(result.getString("rkbattlecnt"));   	msg.append("</rkbattlecnt>\n");
					msg.append("		<rkbogicnt>");		msg.append(result.getString("rkbogicnt"));   	msg.append("</rkbogicnt>\n");
					msg.append("		<rkfriendpoint>");	msg.append(result.getString("rkfriendpoint"));  msg.append("</rkfriendpoint>\n");
					msg.append("		<rkroulettecnt>");	msg.append(result.getString("rkroulettecnt"));  msg.append("</rkroulettecnt>\n");
					msg.append("		<rkwolfcnt>");		msg.append(result.getString("rkwolfcnt"));   	msg.append("</rkwolfcnt>\n");

					msg.append("		<rksalemoney2>");	msg.append(result.getString("rksalemoney2"));   msg.append("</rksalemoney2>\n");
					msg.append("		<rksalebarrel2>");	msg.append(result.getString("rksalebarrel2"));  msg.append("</rksalebarrel2>\n");
					msg.append("		<rkbattlecnt2>");	msg.append(result.getString("rkbattlecnt2"));   	msg.append("</rkbattlecnt2>\n");
					msg.append("		<rkbogicnt2>");		msg.append(result.getString("rkbogicnt2"));   	msg.append("</rkbogicnt2>\n");
					msg.append("		<rkfriendpoint2>");	msg.append(result.getString("rkfriendpoint2")); msg.append("</rkfriendpoint2>\n");
					msg.append("		<rkroulettecnt2>");	msg.append(result.getString("rkroulettecnt2")); msg.append("</rkroulettecnt2>\n");
					msg.append("		<rkwolfcnt2>");		msg.append(result.getString("rkwolfcnt2"));   	msg.append("</rkwolfcnt2>\n");
					msg.append("	</rkcurrank>\n");
				}
			}

			//2-3-4. 홀짝랭킹(지난)
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<rklaterank>\n");
					msg.append("		<rkdateid8>");		msg.append(result.getString("rkdateid8"));   	msg.append("</rkdateid8>\n");
					msg.append("		<rkteam1>");		msg.append(result.getString("rkteam1"));   		msg.append("</rkteam1>\n");
					msg.append("		<rkteam0>");		msg.append(result.getString("rkteam0"));   		msg.append("</rkteam0>\n");
					msg.append("		<rksalemoney>");	msg.append(result.getString("rksalemoney"));   	msg.append("</rksalemoney>\n");
					msg.append("		<rksalebarrel>");	msg.append(result.getString("rksalebarrel"));   msg.append("</rksalebarrel>\n");
					msg.append("		<rkbattlecnt>");		msg.append(result.getString("rkbattlecnt"));   	msg.append("</rkbattlecnt>\n");
					msg.append("		<rkbogicnt>");		msg.append(result.getString("rkbogicnt"));   	msg.append("</rkbogicnt>\n");
					msg.append("		<rkfriendpoint>");	msg.append(result.getString("rkfriendpoint"));  msg.append("</rkfriendpoint>\n");
					msg.append("		<rkroulettecnt>");	msg.append(result.getString("rkroulettecnt"));  msg.append("</rkroulettecnt>\n");
					msg.append("		<rkwolfcnt>");		msg.append(result.getString("rkwolfcnt"));   	msg.append("</rkwolfcnt>\n");

					msg.append("		<rksalemoney2>");	msg.append(result.getString("rksalemoney2"));   msg.append("</rksalemoney2>\n");
					msg.append("		<rksalebarrel2>");	msg.append(result.getString("rksalebarrel2"));  msg.append("</rksalebarrel2>\n");
					msg.append("		<rkbattlecnt2>");	msg.append(result.getString("rkbattlecnt2"));   	msg.append("</rkbattlecnt2>\n");
					msg.append("		<rkbogicnt2>");		msg.append(result.getString("rkbogicnt2"));   	msg.append("</rkbogicnt2>\n");
					msg.append("		<rkfriendpoint2>");	msg.append(result.getString("rkfriendpoint2")); msg.append("</rkfriendpoint2>\n");
					msg.append("		<rkroulettecnt2>");	msg.append(result.getString("rkroulettecnt2")); msg.append("</rkroulettecnt2>\n");
					msg.append("		<rkwolfcnt2>");		msg.append(result.getString("rkwolfcnt2"));   	msg.append("</rkwolfcnt2>\n");
					msg.append("	</rklaterank>\n");
				}
			}

			//짜요장터 짜요쿠폰조각 룰렛.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<zcpinfo>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));			msg.append("</idx>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));		msg.append("</itemcode>\n");
					msg.append("		<cnt>");			msg.append(result.getString("cnt"));			msg.append("</cnt>\n");
					msg.append("	</zcpinfo>\n");
				}
			}

			//짜요장터 템정보..
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<zcpmarket>\n");
					msg.append("		<idx>");			msg.append(result.getString("idx"));			msg.append("</idx>\n");
					msg.append("		<kind>");			msg.append(result.getString("kind"));			msg.append("</kind>\n");
					msg.append("		<title>");			msg.append(result.getString("title"));			msg.append("</title>\n");
					msg.append("		<zcpfile>");		msg.append(result.getString("zcpfile"));		msg.append("</zcpfile>\n");
					msg.append("		<zcpurl>");			msg.append(result.getString("zcpurl"));			msg.append("</zcpurl>\n");
					msg.append("		<bestmark>");		msg.append(result.getString("bestmark"));		msg.append("</bestmark>\n");
					msg.append("		<newmark>");		msg.append(result.getString("newmark"));		msg.append("</newmark>\n");
					msg.append("		<needcnt>");		msg.append(result.getString("needcnt"));		msg.append("</needcnt>\n");
					msg.append("		<firstcnt>");		msg.append(result.getString("firstcnt"));		msg.append("</firstcnt>\n");
					msg.append("		<balancecnt>");		msg.append(result.getString("balancecnt"));		msg.append("</balancecnt>\n");
					msg.append("		<commentsimple>");	msg.append(result.getString("commentsimple"));	msg.append("</commentsimple>\n");
					msg.append("		<commentdesc>");	msg.append(result.getString("commentdesc"));	msg.append("</commentdesc>\n");
					msg.append("		<expiredate>");		msg.append(result.getString("expiredate"));		msg.append("</expiredate>\n");
					msg.append("	</zcpmarket>\n");
				}
			}

		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n market=" 	+ market);
		DEBUG_LOG_STR.append("\r\n version=" 	+ version);
		DEBUG_LOG_STR.append("\r\n kakaoprofile="+ kakaoprofile);
		DEBUG_LOG_STR.append("\r\n kakaomsgblocked="+ kakaomsgblocked);
		System.out.println(DEBUG_LOG_STR.toString());
	}


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
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
