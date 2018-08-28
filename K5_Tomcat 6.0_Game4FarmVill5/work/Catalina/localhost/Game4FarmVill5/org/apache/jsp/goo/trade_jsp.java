package org.apache.jsp.goo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;

public final class trade_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


	//UltraEdit 파일포맷을 변경하면 된다.
	//파일 > 변환 > (ASCII -> Unicode)
	//파일 > 변환 > (UTF-8 -> Unicode)


	public int getInt(String _str, int _idx, int _size){
		int _rtn = 0;
		int _len = _str.length();
		if(_len >= _idx + _size){
			try{
				_rtn = Integer.parseInt(_str.substring(_idx, _idx + _size));
			}catch(Exception e){
			}

		}
		return _rtn;
	}

	public int getIntFromFloat(String _str){
		int _rtn = 0;
		try{
			_rtn = (int)Float.parseFloat(_str);
		}catch(Exception e){

		}
		return _rtn;
	}
	public String getString(String _str, int _idx, int _size){
		String _rtn = "";
		int _len = _str.length();
		if(_len >= _idx + _size){
			_rtn = _str.substring(_idx, _idx + _size);
		}
		return _rtn;
	}

	public byte getByte(byte _data, int _loop){
		int _tmp = (int)_data;
		if(_tmp >= 48 && _tmp <= 57){
			_tmp -= _loop;
			if(_tmp < 48)_tmp += 10;
		}else if(_tmp >= 65 && _tmp <= 90){
			_tmp -= _loop;
			if(_tmp < 65)_tmp += 26;
		}else if(_tmp >= 97 && _tmp <= 122){
			_tmp -= _loop;
			if(_tmp < 97)_tmp += 26;
		}else{
			_tmp += _loop;
		}

		return (byte)_tmp;
	}

	public byte getByte2(byte _data, int _loop){
		int _tmp = (int)_data;
		if(_tmp >= 48 && _tmp <= 57){
			_tmp -= _loop;
			if(_tmp < 48)_tmp += 10;
		}else if(_tmp >= 65 && _tmp <= 90){
			_tmp -= _loop;
			if(_tmp < 65)_tmp += 26;
		}else if(_tmp >= 97 && _tmp <= 122){
			_tmp -= _loop;
			if(_tmp < 97)_tmp += 26;
		//}else{
		//	_tmp += _loop;
		}

		return (byte)_tmp;
	}

	public String getDencode2(String _str, int _checkLen){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_size = getInt(_str, 0, 3);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = "-2";
			}else{
				_str = getString(_str, 3, _size);
			}

			//out.print(" _len:" + _len);
			//out.print(" _loop:" + _loop);
			//out.print(" _size:" + _size);
			//out.print(" _sum:" + _sum);
			//out.print(" _sum2:" + _sum2);
			//out.print(" _str:" + _str);
			//out.print(" gmode:" + gmode);
		}
		return _str;
	}

	public String getDencode32(int _crypt, String _str, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_crypt == 1){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte2(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_size = getInt(_str, 0, 3);
			if(_size <= 0){
				_str = "";
			}else{
				_str = getString(_str, 3, _size);
			}

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}
			//_str = "_loop:" + _loop
			//		+ " _size:" + _size
			//		+ " _str:[" + _str + "]"
			//		+ " _len2:" + _len2
			//		+ " _sum2:" + _sum2
			//		+ " _sum:" + _sum;
		}
		return _str;
	}

	public String getDencode4(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 3);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 3, _size);
			}
		}
		return _str;
	}

	public String getDencode5(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 4, 4);
			_str = getString(_str, 1, _len - (1+4));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 4);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 4, _size);
			}
		}
		return _str;
	}


	public String getDencode6(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _loop1, _loop2, _size;
		int _key, _key2, _key3;
		byte _sum, _sum2;
		byte[] gsbByte;
		_len = _str.length();

		if(_len >= _checkLen){
			_loop1 = getInt(_str, 0, 1);
			_loop2 = getInt(_str, 1, 1);
			_key3 = getInt(_str, _len - 4, 4)/3;
			_sum = (byte)getInt(_str, _len - 8, 4);
			_str = getString(_str, 4, _len - (4+4+4));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				_loop = i%2==0?_loop1:_loop2;

				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 4);
			_key = getInt(_str, 4, 4);
			_key2 = getInt(_str, _str.length() - 4, 4)/2;

			if(_sum != _sum2 || _key != _key2 || _key != _key3){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 8, _size);
			}
		}
		return _str;
	}


  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/goo/_define.jsp");
    _jspx_dependants.add("/goo/_checkfun.jsp");
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
      out.write("\r\n");
      out.write("\r\n");
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
	boolean	DEBUG_CHECK			= false;
	//DEBUG_LOG_PARAM				= false; 

	//1-2. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	String userinfo		= util.getParamStr(request, "userinfo", "");
	String aniitem		= util.getParamStr(request, "aniitem", "");
	String cusitem		= util.getParamStr(request, "cusitem", "");
	String tradeinfo	= util.getParamStr(request, "tradeinfo", "");
	String paraminfo	= util.getParamStr(request, "paraminfo", "");
	int crypt			= util.getParamInt(request, "crypt", -1);

	if(crypt == 2){
		crypt 		= 1;

		userinfo 	= getDencode32(crypt, userinfo, "");
		aniitem 	= aniitem;
		cusitem 	= getDencode32(crypt, cusitem, "");
		tradeinfo 	= getDencode32(crypt, tradeinfo, "");
		paraminfo 	= getDencode32(crypt, paraminfo, "");
	}else if(crypt == 1){
		crypt 		= 1;
	}else{
		userinfo 	= getDencode32(crypt, userinfo, "");	//999까지만 허용한다.
		aniitem 	= getDencode32(crypt, aniitem, "");
		cusitem 	= getDencode32(crypt, cusitem, "");
		tradeinfo 	= getDencode32(crypt, tradeinfo, "");
		paraminfo 	= getDencode32(crypt, paraminfo, "");
	}
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n &gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n &userinfo=" 	+ userinfo);
		DEBUG_LOG_STR.append("\r\n &aniitem=" 	+ aniitem);
		DEBUG_LOG_STR.append("\r\n &cusitem=" 	+ cusitem);
		DEBUG_LOG_STR.append("\r\n &tradeinfo=" + tradeinfo);
		DEBUG_LOG_STR.append("\r\n &paraminfo=" + paraminfo);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_GameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;',
		//												'1:5,1,1;3:5,23,0;4:5,25,-1;',
		//												--'1:22,333,4444;55555:666666,7777777,88888888;7777777:666666,55555,-1;',
		//												'14:1;15:1;16:1;',
		//												'0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:110;  40:-1;',
		//												-1										-- 필드없음.

		query.append("{ call dbo.spu_GameTrade (?, ?, ?, ?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idx++, gameid);
		cstmt.setString(idx++, password);
		cstmt.setString(idx++, userinfo);
		cstmt.setString(idx++, aniitem);
		cstmt.setString(idx++, cusitem);
		cstmt.setString(idx++, tradeinfo);
		cstmt.setString(idx++, paraminfo);
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

		if(DEBUG_CHECK && resultCode == -122){
			DEBUG_LOG_STR.append(this);
			DEBUG_LOG_STR.append("\r\n gameid=" + gameid);
			DEBUG_LOG_STR.append("\r\n password=" + password);
			DEBUG_LOG_STR.append("\r\n userinfo=" + userinfo);
			DEBUG_LOG_STR.append("\r\n aniitem=" + aniitem);
			DEBUG_LOG_STR.append("\r\n cusitem=" + cusitem);
			DEBUG_LOG_STR.append("\r\n tradeinfo=" + tradeinfo);
			DEBUG_LOG_STR.append("\r\n paraminfo=" + paraminfo);
			System.out.println(DEBUG_LOG_STR.toString());
		}


		msg.append("	<result>\n");
		msg.append("		<code>");			msg.append(PTS_TRADE); 							msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(result.getString(2));    			msg.append("</resultmsg>\n");
		msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
		msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));   	msg.append("</gamecost>\n");
		msg.append("		<feed>");			msg.append(result.getString("feed"));   		msg.append("</feed>\n");
		msg.append("		<heart>");			msg.append(result.getString("heart"));   		msg.append("</heart>\n");
		msg.append("		<fpoint>");			msg.append(result.getString("fpoint"));   		msg.append("</fpoint>\n");
		msg.append("		<goldticket>");		msg.append(result.getInt("goldticket"));    	msg.append("</goldticket>\n");
		msg.append("		<goldticketmax>");	msg.append(result.getInt("goldticketmax"));    	msg.append("</goldticketmax>\n");
		msg.append("		<goldtickettime>");	msg.append(result.getString("goldtickettime").substring(0, 19));msg.append("</goldtickettime>\n");
		msg.append("		<battleticket>");	msg.append(result.getInt("battleticket"));    	msg.append("</battleticket>\n");
		msg.append("		<battleticketmax>");msg.append(result.getInt("battleticketmax"));   msg.append("</battleticketmax>\n");
		msg.append("		<battletickettime>");msg.append(result.getString("battletickettime").substring(0, 19));msg.append("</battletickettime>\n");
		msg.append("		<comreward>");		msg.append(result.getString("comreward"));   	msg.append("</comreward>\n");
		msg.append("		<tradefailcnt>");	msg.append(result.getString("tradefailcnt"));   msg.append("</tradefailcnt>\n");
		msg.append("		<tradecnt>");		msg.append(result.getString("tradecnt"));   	msg.append("</tradecnt>\n");
		msg.append("		<prizecnt>");		msg.append(result.getString("prizecnt"));   	msg.append("</prizecnt>\n");
		msg.append("		<tradesuccesscnt>");msg.append(result.getString("tradesuccesscnt"));msg.append("</tradesuccesscnt>\n");
		msg.append("		<tradeclosedealer>");msg.append(result.getString("tradeclosedealer"));msg.append("</tradeclosedealer>\n");
		msg.append("		<bgcttradecnt>");	msg.append(result.getString("bgcttradecnt"));   msg.append("</bgcttradecnt>\n");

		//동물로 얻는 하트량.
		msg.append("		<plusheartcow>");	msg.append(result.getString("plusheartcow"));   msg.append("</plusheartcow>\n");
		msg.append("		<plusheartsheep>");	msg.append(result.getString("plusheartsheep")); msg.append("</plusheartsheep>\n");
		msg.append("		<plusheartgoat>");	msg.append(result.getString("plusheartgoat"));  msg.append("</plusheartgoat>\n");

		msg.append("		<qtsalebarrel>");	msg.append(result.getString("qtsalebarrel"));   msg.append("</qtsalebarrel>\n");
		msg.append("		<qtsalecoin>");		msg.append(result.getString("qtsalecoin"));   	msg.append("</qtsalecoin>\n");
		msg.append("		<qtfame>");			msg.append(result.getString("qtfame"));   		msg.append("</qtfame>\n");
		msg.append("		<qtfeeduse>");		msg.append(result.getString("qtfeeduse"));   	msg.append("</qtfeeduse>\n");
		msg.append("		<qttradecnt>");		msg.append(result.getString("qttradecnt"));   	msg.append("</qttradecnt>\n");
		msg.append("		<qtsalecoinbest>");	msg.append(result.getString("qtsalecoinbest")); msg.append("</qtsalecoinbest>\n");

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

		//에피소드보상.
		msg.append("		<etgrade>");		msg.append(result.getString("etgrade")); 		msg.append("</etgrade>\n");
		msg.append("		<etsalecoin>");		msg.append(result.getString("etsalecoin"));		msg.append("</etsalecoin>\n");
		msg.append("		<etremain>");		msg.append(result.getString("etremain")); 		msg.append("</etremain>\n");

		//야바위 정보.
		msg.append("		<yabauidx>");		msg.append(result.getString("yabauidx"));  		msg.append("</yabauidx>\n");
		msg.append("		<yabaustep>");		msg.append(result.getString("yabaustep")); 	 	msg.append("</yabaustep>\n");
		msg.append("		<yabauchange>");	msg.append(result.getString("yabauchange"));	msg.append("</yabauchange>\n");

		//황금 상인의 우정포인트값.
		msg.append("		<needfpoint>");		msg.append(result.getString("needfpoint"));		msg.append("</needfpoint>\n");

		//세션값.
		msg.append("		<sid>");			msg.append(result.getString("sid"));			msg.append("</sid>\n");

		//복귀유저.
		msg.append("		<rtnstep>");		msg.append(result.getString("rtnstep"));		msg.append("</rtnstep>\n");
		msg.append("		<rtnplaycnt>");		msg.append(result.getString("rtnplaycnt"));		msg.append("</rtnplaycnt>\n");
		msg.append("		<rtnreward>");		msg.append(result.getString("rtnreward"));		msg.append("</rtnreward>\n");

		//짜요쿠폰룰렛.
		msg.append("		<zcpchance>");		msg.append(result.getString("zcpchance"));		msg.append("</zcpchance>\n");

		msg.append("	</result>\n");

		if(resultCode == 1){
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

			//2-3-5. 광고정보
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<adlist>\n");
					msg.append("		<otherid>");		msg.append(result.getString("nickname"));  		msg.append("</otherid>\n");
					msg.append("		<mode>");			msg.append(result.getString("mode"));   		msg.append("</mode>\n");
					msg.append("		<itemcode>");		msg.append(result.getString("itemcode"));   	msg.append("</itemcode>\n");
					msg.append("		<comment>");		msg.append(result.getString("comment"));   		msg.append("</comment>\n");
					msg.append("	</adlist>\n");
				}
			}

			////2-3-5. 학교랭킹.
			//if(cstmt.getMoreResults()){
			//	result = cstmt.getResultSet();
			//	while(result.next()){
			//		msg.append("	<schooltop>\n");
			//		msg.append("		<schoolrank>");		msg.append(result.getString("schoolrank"));   	msg.append("</schoolrank>\n");
			//		msg.append("		<schoolidx>");		msg.append(result.getString("schoolidx"));    	msg.append("</schoolidx>\n");
			//		msg.append("		<schoolname>");		msg.append(result.getString("schoolname"));    	msg.append("</schoolname>\n");
			//		msg.append("		<schoolarea>");		msg.append(result.getString("schoolarea"));    	msg.append("</schoolarea>\n");
			//		msg.append("		<schoolkind>");		msg.append(result.getString("schoolkind"));    	msg.append("</schoolkind>\n");
			//		msg.append("		<cnt>");			msg.append(result.getString("cnt"));    		msg.append("</cnt>\n");
			//		msg.append("		<totalpoint>");		msg.append(result.getString("totalpoint"));    	msg.append("</totalpoint>\n");
			//		msg.append("	</schooltop>\n");
			//	}
			//}
            //
			////2-3-5. 학교랭킹(서브).
			//if(cstmt.getMoreResults()){
			//	result = cstmt.getResultSet();
			//	while(result.next()){
			//		msg.append("	<schoolusertop>\n");
			//		msg.append("		<userrank>");	msg.append(result.getString("userrank"));   msg.append("</userrank>\n");
			//		msg.append("		<gameid>");		msg.append(result.getString("gameid"));   	msg.append("</gameid>\n");
			//		msg.append("		<point>");		msg.append(result.getString("point"));   	msg.append("</point>\n");
			//		msg.append("		<schoolname>");	msg.append(result.getString("schoolname")); msg.append("</schoolname>\n");
			//		msg.append("		<schoolidx>");	msg.append(result.getString("schoolidx"));  msg.append("</schoolidx>\n");
			//		msg.append("		<itemcode>");	msg.append(result.getString("itemcode"));  	msg.append("</itemcode>\n");
			//		msg.append("		<acc1>");		msg.append(result.getString("acc1"));  		msg.append("</acc1>\n");
			//		msg.append("		<acc2>");		msg.append(result.getString("acc2"));  		msg.append("</acc2>\n");
            //
			//		//msg.append("		<kakaotalkid>");	msg.append(result.getString("kakaotalkid"));   	msg.append("</kakaotalkid>\n");
			//		//msg.append("		<kakaouserid>");	msg.append(result.getString("kakaouserid"));   	msg.append("</kakaouserid>\n");
			//		msg.append("		<kakaonickname>");	msg.append(result.getString("kakaonickname"));  msg.append("</kakaonickname>\n");
			//		msg.append("		<kakaoprofile>");	msg.append(result.getString("kakaoprofile"));   msg.append("</kakaoprofile>\n");
			//		//msg.append("		<kakaomsgblocked>");msg.append(result.getString("kakaomsgblocked"));msg.append("</kakaomsgblocked>\n");
			//		//msg.append("		<kakaofriendkind>");msg.append(result.getString("kakaofriendkind"));msg.append("</kakaofriendkind>\n");
			//		msg.append("	</schoolusertop>\n");
			//	}
			//}

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

			//정책지원금.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<syssupportmsg>\n");
					msg.append("		<groupline>");		msg.append(result.getString("groupline"));	msg.append("</groupline>\n");
					msg.append("		<msg>");			msg.append(result.getString("msg")); 		msg.append("</msg>\n");
					msg.append("	</syssupportmsg>\n");
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

			//2-3-5. 에피소드 > 데이타 출력..
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<etrewardinfo>\n");
					msg.append("		<etsalecoin>");		msg.append(result.getString("etsalecoin"));		msg.append("</etsalecoin>\n");
					msg.append("		<etcheckresult1>");	msg.append(result.getString("etcheckresult1"));	msg.append("</etcheckresult1>\n");
					msg.append("		<etcheckresult2>");	msg.append(result.getString("etcheckresult2"));	msg.append("</etcheckresult2>\n");
					msg.append("		<etcheckresult3>");	msg.append(result.getString("etcheckresult3"));	msg.append("</etcheckresult3>\n");
					msg.append("		<etgrade>");		msg.append(result.getString("etgrade"));   		msg.append("</etgrade>\n");
					msg.append("		<etitemcode>");		msg.append(result.getString("etitemcode"));   	msg.append("</etitemcode>\n");
					msg.append("		<etreward1>");		msg.append(result.getString("etreward1"));   	msg.append("</etreward1>\n");
					msg.append("		<etreward2>");		msg.append(result.getString("etreward2"));   	msg.append("</etreward2>\n");
					msg.append("		<etreward3>");		msg.append(result.getString("etreward3"));   	msg.append("</etreward3>\n");
					msg.append("		<etreward4>");		msg.append(result.getString("etreward4"));   	msg.append("</etreward4>\n");
					msg.append("	</etrewardinfo>\n");
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
		DEBUG_LOG_STR.append("\r\n gameid=" + gameid);
		DEBUG_LOG_STR.append("\r\n password=" + password);
		DEBUG_LOG_STR.append("\r\n userinfo=" + userinfo);
		DEBUG_LOG_STR.append("\r\n aniitem=" + aniitem);
		DEBUG_LOG_STR.append("\r\n cusitem=" + cusitem);
		DEBUG_LOG_STR.append("\r\n tradeinfo=" + tradeinfo);
		DEBUG_LOG_STR.append("\r\n paraminfo=" + paraminfo);
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
