<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.simple.*"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%>
<%@include file="_checkfun2.jsp"%> 

<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;
	boolean DEBUG				= false;
	boolean DEBUG2				= false;
	DEBUG_LOG_PARAM 			= false;

	/////////////////////////////////////////////////
	//	iPhone 데이타
	//	com.sangsangdigital.farmip
	//	com.pictosoft.farmtycoon.apple
	/////////////////////////////////////////////////
	String striPhonePackageName[] = {
						//"sangsangdigital.com.homerunleague",					//야구.
						//"com.sangsangdigital.farmip",							//목장.
						//"com.pictosoft.farmtycoon.apple",
						"com.marbles.farmvill5ip"								//목장5.
	};
	String striPhoneListName[] = {
						//"199",	"homerungold_15", 			"638657470",	//야구.
						//"499",	"homerungold_55",  			"638657906",
						//"899",	"homerungold_114",  		"638657925",
						//"2699",	"homerungold_400",  		"638658016",
						//"4599",	"homerungold_635",  		"638658206",
						//"8999",	"homerungold_1320",  		"638658446",
						"299",		"farm_3300", 				"792552120",	//목장5.
						"499",		"farm_5500",  				"792552123",
						"999",		"farm_11000",  				"792552130",
						"2999",		"farm_33000",  				"792552166",
						"4999",		"farm_55000",  				"792552168",
						"9999",		"farm_110000",  			"792552170"
	};

	/////////////////////////////////////////////////
	//	Android Googel 데이타
	//	com.sangsangdigital.farmgg
	/////////////////////////////////////////////////
	String strAndroidPackageName[] = {
						//"com.sangsangdigital.homerunleaguegg",				//야구.
						"com.sangsangdigital.farmgg",							//목장T.
						"com.sangsangdigital.farmggtest",
						"com.marbles.farmvill5gg"								//목장5.
	};
	String strAndroidListName[] = {
						//"2000",	"homerun_1500",		"turn_homerun_1500",	//야구.
						//"5000",	"homerun_5000",		"turn_homerun_5000",
						//"9900",	"homerun_9900",		"turn_homerun_9900",
						//"29000",	"homerun_29000",	"turn_homerun_29000",
						//"55000",	"homerun_50000",	"turn_homerun_50000",
						//"99000",	"homerun_99000",	"turn_homerun_99000",

						"3300",		"farm_3300",		"farm2_3300",			//목장.
						"5500",		"farm_5500",		"farm2_5500",
						"11000",	"farm_11000",		"farm2_11000",
						"33000",	"farm_33000",		"farm2_33000",
						"55000",	"farm_55000",		"farm2_55000",
						"110000",	"farm_110000",		"farm2_110000"
	};
	String strAndroidReceiptCode[] = {
						"GPA.",													//신규.
						"12999763169054705758."									//목장T.
	};

	/////////////////////////////////////////////////////////
	//	SKT
	//	com.marbles.farmvill5sk
	/////////////////////////////////////////////////////////
	String strSKTAIDList[] = {
						"OA00646546",					//야구.
						"OA00652027",					//목장.
						"OA00700316"					//K5
	};
	int nSKTMoneyList[] = {						//가격
						3300,
						5500,
						11000,
						33000,
						55000,
						110000
	};
	String strSKTPIDList[] = {
						//상상					픽토
						"0910047079", 			"0910007674",
						"0910047080",  			"0910007676",
						"0910047081",  			"0910007677",
						"0910047082",  			"0910007678",
						"0910047083",  			"0910007679",
						"0910047084",  			"0910007680"
	};
	/////////////////////////////////////////////////////////
	//	NHN
	//	com.sangsangdigital.farmnhn
	/////////////////////////////////////////////////////////
	//String strNHNAIDList[] = {
	//					"TCTK407241403247287967"		//목장.
	//};
	//int nNHNMoneyList[] = {						//가격
	//					1100,
	//					5500,
	//					9900,
	//					33000,
	//					55000,
	//					99000
	//};
	//String strNHNPIDList[] = {
	//					//픽토
	//					"1000007929",
	//					"1000007928",
	//					"1000007927",
	//					"1000007926",
	//					"1000007925",
	//					"1000007924"
	//};

	int summary 		= 0;

	//1. 데이타 받기
	int mode			= util.getParamInt(request, "mode", 	1);
	String gameid 		= util.getParamStr(request, "gameid", 	"");
	String password		= util.getParamStr(request, "password", "");
	String giftid 		= util.getParamStr(request, "giftid", 	"");

	int market			= util.getParamInt(request, "market", 	1);
	int itemcode		= util.getParamInt(request, "itemcode", 0);
	String cashcost		= util.getParamStr(request, "cashcost", "0");
	String cash			= util.getParamStr(request, "cash", 	"0");
	int cashcost2		= 0;
	int cash2			= 0;
	String ucode		= util.getParamStr(request, "ucode", 	"");
	String kakaogameid	= util.getParamStr(request, "kakaogameid", "");

	String ikind		= util.getParamStr(request, "ikind", 	"");	//iPhone(sandbox, real), google( )
	String acode		= util.getParamStr(request, "acode", 	"");
	String idata		= util.getParamStr(request, "idata", 	"");
	String idata2		= util.getParamStr(request, "idata2", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n?mode=" 			+ mode);
		DEBUG_LOG_STR.append("\r\n&gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n&giftid=" 		+ giftid);
		DEBUG_LOG_STR.append("\r\n&password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n&market=" 		+ market);

		DEBUG_LOG_STR.append("\r\n&itemcode=" 		+ itemcode);
		DEBUG_LOG_STR.append("\r\n&cashcost=" 		+ cashcost);
		DEBUG_LOG_STR.append("\r\n&cash=" 			+ cash);
		DEBUG_LOG_STR.append("\r\n&ucode=" 			+ ucode);
		DEBUG_LOG_STR.append("\r\n&kakaogameid=" 	+ kakaogameid);

		DEBUG_LOG_STR.append("\r\n&ikind=" 			+ ikind);
		DEBUG_LOG_STR.append("\r\n&acode=" 			+ acode);
		DEBUG_LOG_STR.append("\r\n&idata=" 			+ idata);
		DEBUG_LOG_STR.append("\r\n&idata2=" 		+ idata2);

		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		if(DEBUG)System.out.println("[Input Data]<br>"
							+ "mode:" + mode + " <br>"
							+ " gameid:" + gameid + " <br>"
							+ " giftid:" + giftid + " <br>"
							+ " password:" + password + " <br>"
							+ " acode:" + acode + " <br>"
							+ " ucode:" + ucode + " <br>"
							+ " market:" + market + " <br>"
							+ " itemcode:" + itemcode + " <br>"
							+ " cash:" + cash + " <br>"
							+ " cashcost:" + cashcost + " <br>"
							+ " ikind:" + util.getParamStr(request, "ikind", "") + " <br>"
							+ "==============================================<br>");

		//구매한 골든볼. 캐쉬.
		cashcost 	= getDencode4(cashcost, 	14+14, "-1");
		cash 		= getDencode4(cash, 		14+14, "-2");
		if(DEBUG)System.out.println("cashcost:" + cashcost + ", cash:" + cash + "<br>");

		if(ucode == null){
			if(DEBUG)System.out.println(" > ucode is null<br>");
			summary = 0;
		}else if(ucode.length() < (3+1+8+4+14+2+3)){
			//유효하지 않는 길이도 리턴한다.
			if(DEBUG)System.out.println(" > size lack:" + ucode.length() + "<br>");
			summary = 0;
		}else{
			//유효성검사
			//out.println("3");
			int _len = ucode.length();
			int _loop = getInt(ucode, 3, 1);
			byte _sum = (byte)getInt(ucode, _len - 3, 3);
			String ucode2 = getString(ucode, 4, _len - (3+1+3));
			byte[] ucodeByte = ucode2.getBytes();
			int _len2 = ucodeByte.length;
			byte _sum2 = 0;
			for(int i = 0; i < _len2; i++){
				ucodeByte[i] = getByte(ucodeByte[i], _loop);
				_sum2 += ucodeByte[i];
			}

			//서머리검사
			if(_sum != _sum2){
				summary = 0;
			}else{
				summary = 1;
			}
			String ucode3 = new String(ucodeByte);
			//골드와 캐쉬
			cash2 = getInt(ucode3, 0, 8) - 12345678;
			cashcost2 = getInt(ucode3, 8, 8) - 87654321;

			if(DEBUG)System.out.println("[ucode(parsing)]:" + ucode + "<br>"
								+ " _loop:" + _loop + "<br>"
								//+ " " + getString(ucode, _len - 3, 3) + "<br>"
								+ " _sum:" + _sum + "<br>"
								+ " _sum2:" + _sum2 + "<br>"
								+ " ucode2:" + ucode2 + "<br>"
								+ " ucode3:" + ucode3 + "<br>"
								+ " summary1:" + summary + "<br>"
								+ " _len:" + _len + "<br>"
								+ " _len2:" + _len2 + "<br>"
								+ " cash2:" + cash2 + "<br>"
								+ " cashcost2:" + cashcost2 + "<br>"
								+ " cash:" + cash + "<br>"
								+ " cashcost:" + cashcost + "<br>"
								+ "===========================================<br>");
		}


		if(market == IPHONE){
			if(DEBUG)System.out.println("[iPhone]<br>");

			if(!ikind.equals("")){
				//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
				//2. iPhone에서 보내진 데이타를 넘겨서 > URL포팅해서 전달 > Apple에 인증
				if(DEBUG)System.out.println(" > ikind:"+ikind+"<br>");
				if(DEBUG)System.out.println(" > idata:"+idata+"<br>");
				idata2 = callAppleSite(ikind, idata);
				if(DEBUG)System.out.println(" > idata2:"+idata2+"<br>");
				if(DEBUG)System.out.println(" > cash:"+cash+"<br>");
				if(DEBUG)System.out.println(" > striPhonePackageName:"+striPhonePackageName[0]+"<br>");
				if(DEBUG)System.out.println(" > striPhoneListName:"+striPhoneListName[0]+"<br>");

				//3. 데이타 파싱하기
				boolean biPhoneState = getiPhoneSuccess(idata2, cash, striPhonePackageName, striPhoneListName);
				if(!biPhoneState){
					if(DEBUG)System.out.println(" > iPhone idata2 error<br>");
					summary = 0;
				}else{
					acode = getiPhoneInfo(idata2, "original_transaction_id");
					if(DEBUG)System.out.println(" > acode:" + acode);
				}
			}else{
				if(DEBUG)System.out.println(" > iPhone iKind Empty error<br>");
				summary = 0;
			}
		}else if(market == SKT){
			if(DEBUG)System.out.println("[SKT]<br>");

			if(!ikind.equals("")){
				//0. txid을 받아오기.
				acode = getSKTtxid(idata);
				if(DEBUG)System.out.println("idata:" + idata);
				if(DEBUG)System.out.println("acode:" + acode);
				if(DEBUG)System.out.println("ikind:" + ikind);

				//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
				//2. SKT에서 보내진 데이타를 넘겨서 > URL포팅해서 전달 > SKT에 인증
				idata2 = callSKTSite(ikind, idata);
				if(DEBUG)System.out.println("idata2:" + idata2);

				//3. 데이타 파싱하기
				boolean _bSKTState = getSKTSuccess(idata2, Integer.parseInt(cash), strSKTAIDList, nSKTMoneyList, strSKTPIDList);
				if(!_bSKTState){
					if(DEBUG)System.out.println(" > SKT idata2 error<br>");
					summary = 0;
				}
			}else{
				if(DEBUG)System.out.println(" > SKT iKind Empty error<br>");
				summary = 0;
			}
		//}else if(market == NHN){
		//	if(DEBUG)System.out.println("[NHN]<br>");
		//	//ikind		: TEST, REAL
		//	//acode		: 1004745009
		//	//idata		: {"receipt":{"extra":"extra","environment":"TEST","paymentSeq":"1004745009","productCode":"1000007929","paymentTime":1404129513498,"approvalStatus":"APPROVED"},"nonce":7433694377350428587}
		//	//idata2	: {"signature":"isGg3PAYv2R\/BqJbvITBeGmRiUWq5vnmP4UE0vBDmHOWgep79agQugScVYSH9Ctg5dRganZ5Li39\/tdDB2\/gKIeuMgQV1cSFTYqKgDHbW9PNAfakTt9zWB+csGRlCPvl4iEWWeqfQL4oEv54DDsQRXhmbS+S1n3C3HnSXtbzZFY="}
        //
		//	if(!ikind.equals("")){
		//		//0. 데이타를 그대로 받음.
		//		if(DEBUG)System.out.println("ikind:" + ikind);
		//		if(DEBUG)System.out.println("acode:" + acode);
		//		if(DEBUG)System.out.println("idata:" + idata);
		//		if(DEBUG)System.out.println("idata2:" + idata2);
        //
		//		//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
		//		//2. 데이타 파싱하기
		//		boolean _bNHNState = getNHNSuccess(idata2, strNHNPIDList, acode);
		//		if(!_bNHNState){
		//			if(DEBUG)System.out.println(" > NHN idata2 error<br>");
		//			summary = 0;
		//		}
		//	}else{
		//		if(DEBUG)System.out.println(" > NHN iKind Empty error<br>");
		//		summary = 0;
		//	}
		}else if(market == GOOGLE){
			//http://203.234.238.249:40009/Game4Farm/goo/cashbuy.jsp?mode=1&gameid=xxxx2&giftid=&password=049000s1i0n7t8445289&ucode=41767890323443210907dddd88679776060099800130&market=5&itemcode=5000&cash=4448644482164575548488776181&cashcost=8880086160708919982822110190&ikind=GoogleID&idata2=12999763169054705758.1319607302512252&acode={ "receipt":{"orderId":"12999763169054705758.1319607302512252","packageName":"com.sangsangdigital.homerunleagueggtest3","productId":"homerun_1500","purchaseTime":1378184267000,"purchaseState":0,"purchaseToken":"gqzrcllpeiqlbfgpkxuhrcon.AO-J1Oy4jD7ZPpMeuhB9YwlYiqlc-K8GShu6uPG0aTDZzFfvRxXWF6-ucThc6F6gUkVuyZvrxwqp0KG2wetmZvLvP2JgD3eR4J9a_6yd4CQSScMcqwVgNpCAXPmRBxuLIzKTHZeDdqCUq2WS0OhkIDze8kVIGI0fCA"}, "status":0}
			//http://203.234.238.249:40009/Game4Farm/goo/cashbuy.jsp?mode=1&gameid=xxxx2&giftid=&password=049000s1i0n7t8445289&ucode=41767890323443210907dddd88679776060099800130&market=5&itemcode=5000&cash=4448644482164575548488776181&cashcost=8880086160708919982822110190&ikind=googlekw&acode=12999763169054705758.1319607302512252&idata2={ "receipt":{"orderId":"12999763169054705758.1319607302512252","packageName":"com.sangsangdigital.homerunleagueggtest3","productId":"homerun_1500","purchaseTime":1378184267000,"purchaseState":0,"purchaseToken":"gqzrcllpeiqlbfgpkxuhrcon.AO-J1Oy4jD7ZPpMeuhB9YwlYiqlc-K8GShu6uPG0aTDZzFfvRxXWF6-ucThc6F6gUkVuyZvrxwqp0KG2wetmZvLvP2JgD3eR4J9a_6yd4CQSScMcqwVgNpCAXPmRBxuLIzKTHZeDdqCUq2WS0OhkIDze8kVIGI0fCA"}, "status":0}
			//http://203.234.238.249:40009/Game4Farm/goo/cashbuy.jsp?mode=1&gameid=xxxx2&password=049000s1i0n7t8445289&giftid=&kakaogameid=91188455545412240&ikind=googlekw&acode=12999763169054705758.1324208103674906&idata=&idata2=%7b+%22receipt%22%3a%7b%22orderId%22%3a%2212999763169054705758.1323631300639409%22%2c%22packageName%22%3a%22com.sangsangdigital.mokjanggg%22%2c%22productId%22%3a%22farm_9900%22%2c%22purchaseTime%22%3a1383720381901%2c%22purchaseState%22%3a0%2c%22developerPayload%22%3a%22optimus%22%2c%22purchaseToken%22%3a%22zmjsgzkhoqngotpchnghpmql.AO-J1Oym516yHp58m15m_oBuGauSWSDajCx5zYnlBmVXjH8lHDv2X-ZXRDE7cuZV9UdZ82VPgDw795V6jVYSV4mmJpJ3y1pxoUXACa-5uAto9CeCBTYzePTPcrbIK4jUdP_592FNuE3I%22%7d%2c+%22status%22%3a0%7d&ucode=21256789122332109888cccc77569586550600348142&market=5&itemcode=5000&cash=7771887713897817087728225180&cashcost=8880900703408928198839336192

			if(DEBUG)System.out.println("[Google]<br>");

			if(ikind.equals("googlekw")){
				//1. json형태 데이타를 받기.
				//3. 데이타 파싱하기
				if(DEBUG)System.out.println(" market:" + market + "<br>"
									+ " idata:" + idata + "<br>"
									+ " cash:" + cash + "<br>"
									+ " strAndroidPackageName:" + strAndroidPackageName + "<br>"
									+ " strAndroidListName:" + strAndroidListName + "<br>");


				boolean bGoogleState = getGoogleSuccess(market, idata2, cash, strAndroidPackageName, strAndroidListName);
				if(DEBUG)System.out.println(" > bGoogleState:" + bGoogleState + "<br>");

				if(!bGoogleState){
					if(DEBUG)System.out.println(" > Google bGoogleState error<br>");
					summary = 0;
				}

				//인증키 검사하기.
				int _len = strAndroidReceiptCode.length;
				int _check = 0;
				for(int i = 0; i < _len; i++){
					if(acode.indexOf(strAndroidReceiptCode[i]) == 0){
						_check++;
						break;
					}
				}

				if(_check == 0){
					if(DEBUG)System.out.println(" > Google ReceiptCode error<br>");
					summary = 0;
				}
			}else{
				if(DEBUG)System.out.println(" > Google GoogleID Empty error<br>");
				summary = 0;
			}
		}else{
			if(DEBUG)System.out.println("[SKT]<br>");
		}

		if(DEBUG2)System.out.println(
							"mode:" + mode
							+ " gameid:" +  gameid
							+ " giftid:" +  giftid
							+ " password:" +  password
							+ " acode:" +  acode
							+ " ucode:" +  ucode
							+ " market:" +  market
							+ " summary:" +  summary
							+ " itemcode:" +  itemcode
							+ " cashcost:" +  cashcost
							+ " cash:" +  cash
							+ " cashcost2:" +  cashcost2
							+ " cash2:" +  cash2
							+ " ikind:" +  ikind
							+ " idata:" +  idata
							+ " idata2:" +  idata2
							+ " kakaogameid:" + kakaogameid
							);

		//2. 데이타 조작
		//exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945c2', 5, 1, 5000, 20,    2000, 20,    2000, '', '', '', -1	-- 구매
		//exec spu_CashBuy 2, 'xxxx3', 'xxxx2', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d2', 5, 1, 5000, 20,    2000, 20,    2000, '', '', '', -1	-- 선물
		query.append("{ call dbo.spu_CashBuy (?, ?, ?, ?, ?, 	?, ?, ?, ?, ?, 	?, ?, ?, ?, ?, 	?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setInt(idxColumn++, mode);
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, giftid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, acode);
		cstmt.setString(idxColumn++, ucode);
		cstmt.setInt(idxColumn++, market);
		cstmt.setInt(idxColumn++, summary);
		cstmt.setInt(idxColumn++, itemcode);
		cstmt.setString(idxColumn++, cashcost);
		cstmt.setString(idxColumn++, cash);
		cstmt.setInt(idxColumn++, cashcost2);
		cstmt.setInt(idxColumn++, cash2);
		cstmt.setString(idxColumn++, ikind);
		cstmt.setString(idxColumn++, idata);
		cstmt.setString(idxColumn++, idata2);
		cstmt.setString(idxColumn++, kakaogameid);
		cstmt.registerOutParameter(idxColumn++, Types.INTEGER);

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			resultMsg.append(result.getString(2));
		}

		msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
		msg.append("<rows>\n");
		msg.append("	<result>\n");
		msg.append("		<code>");			msg.append(PTS_CASHBUY); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());		msg.append("</resultmsg>\n");
		msg.append("	</result>\n");


	    //행동력 데이타를 갱신해준다.
		if(resultCode == 1){
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<cashbuy>\n");
					msg.append("		<gameid>");			msg.append(result.getString("gameid"));   		msg.append("</gameid>\n");
					msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
					msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));    	msg.append("</gamecost>\n");
					msg.append("		<heart>");			msg.append(result.getString("heart"));    		msg.append("</heart>\n");
					msg.append("		<feed>");			msg.append(result.getString("feed"));    		msg.append("</feed>\n");

					msg.append("		<cashpoint>");		msg.append(result.getString("cashpoint"));    	msg.append("</cashpoint>\n");
					msg.append("	</cashbuy>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);
		DEBUG_LOG_STR.append(this);

		DEBUG_LOG_STR.append("\r\n?mode=" 			+ mode);
		DEBUG_LOG_STR.append("\r\n&gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n&password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n&giftid=" 		+ giftid);

		DEBUG_LOG_STR.append("\r\n&market=" 		+ market);
		DEBUG_LOG_STR.append("\r\n&itemcode=" 		+ itemcode);
		DEBUG_LOG_STR.append("\r\n&cashcost=" 		+ cashcost);
		DEBUG_LOG_STR.append("\r\n&cash=" 			+ cash);
		DEBUG_LOG_STR.append("\r\n&ucode=" 			+ ucode);
		DEBUG_LOG_STR.append("\r\n&kakaogameid=" 	+ kakaogameid);

		DEBUG_LOG_STR.append("\r\n&ikind=" 			+ ikind);
		DEBUG_LOG_STR.append("\r\n&acode=" 			+ acode);
		DEBUG_LOG_STR.append("\r\n&idata="	 		+ idata);
		DEBUG_LOG_STR.append("\r\n&idata2=" 		+ idata2);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/**/


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
