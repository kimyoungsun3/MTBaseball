package org.apache.jsp.goo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;

public final class wheel_jsp extends org.apache.jasper.runtime.HttpJspBase
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
	String mode			= util.getParamStr(request, "mode", "20");
	String usedcashcost	= util.getParamStr(request, "usedcashcost", "300");
	String randserial 	= util.getParamStr(request, "randserial", "-1");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n mode="		+ mode);
		DEBUG_LOG_STR.append("\r\n usedcashcost="+ usedcashcost);
		DEBUG_LOG_STR.append("\r\n randserial="	+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 20,   0, 7776, -1			-- 일일회전판(20)    MODE_WHEEL_NORMAL
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 300, 7777, -1			-- 결정회전판(21)    MODE_WHEEL_PREMINUM
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 270, 7779, -1			-- 결정회전판(21)    MODE_WHEEL_PREMINUM
		//exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 22,   0, 7778, -1			-- 황금무료(22)  	 MODE_WHEEL_PREMINUMFREE
		query.append("{ call dbo.spu_Wheel (?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, mode);
		cstmt.setString(idx++, usedcashcost);
		cstmt.setString(idx++, randserial);
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
		msg.append("		<code>");			msg.append(PTS_WHEEL); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    	msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));  msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));  msg.append("</gamecost>\n");

		msg.append("		<rewardidx>");		msg.append(result.getInt("rewardidx"));  msg.append("</rewardidx>\n");
		msg.append("		<rewarditemcode>");	msg.append(result.getInt("rewarditemcode"));msg.append("</rewarditemcode>\n");
		msg.append("		<rewardcnt>");		msg.append(result.getInt("rewardcnt"));  msg.append("</rewardcnt>\n");

		msg.append("		<wheeltodaycnt>");	msg.append(result.getInt("wheeltodaycnt")); msg.append("</wheeltodaycnt>\n");
		msg.append("		<wheelgauage>");	msg.append(result.getInt("wheelgauage"));msg.append("</wheelgauage>\n");
		msg.append("		<wheelfree>");		msg.append(result.getInt("wheelfree"));  msg.append("</wheelfree>\n");

		msg.append("		<wheelgauageflag>");msg.append(result.getInt("wheelgauageflag")); msg.append("</wheelgauageflag>\n");
		msg.append("		<wheelgauagepoint>");msg.append(result.getInt("wheelgauagepoint"));msg.append("</wheelgauagepoint>\n");
		msg.append("		<wheelgauagemax>");	msg.append(result.getInt("wheelgauagemax"));  msg.append("</wheelgauagemax>\n");

		msg.append("		<rkteam>");			msg.append(result.getInt("rkteam"));  		msg.append("</rkteam>\n");
		msg.append("		<rkstartstate>");	msg.append(result.getInt("rkstartstate"));  msg.append("</rkstartstate>\n");

		msg.append("	</result>\n");

		if(resultCode == 1){
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

		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n mode="		+ mode);
		DEBUG_LOG_STR.append("\r\n usedcashcost="+ usedcashcost);
		DEBUG_LOG_STR.append("\r\n randserial="	+ randserial);
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
