<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
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


	//1. 데이타 받기
	String gameid 		= util.getParamStr(request, "gameid", "gameid");
	String password 	= util.getParamStr(request, "password", "password");
	String mode 		= util.getParamStr(request, "mode", "1");
	String randserial 	= util.getParamStr(request, "randserial", "-1");

	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n &mode=" 		+ mode);
		DEBUG_LOG_STR.append("\r\n &randserial="+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		//2. 데이타 조작
		//exec spu_RoulTreasureBuyNew 'xxxx2', '049000s1i0n7t8445289', 1, 7721, -1			-- 일반뽑기
		//exec spu_RoulTreasureBuyNew 'xxxx2', '049000s1i0n7t8445289', 2, 7723, -1			-- 루비뽑기
		//exec spu_RoulTreasureBuyNew 'xxxx2', '049000s1i0n7t8445289', 4, 7725, -1			-- 루비뽑기 10 + 1
		query.append("{ call spu_RoulTreasureBuyNew (?, ?, ?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, mode);
		cstmt.setString(idxColumn++, randserial);
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
		msg.append("		<code>");			msg.append(PTS_TREASUREBUY); 					msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    						msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append("(DB)" + resultMsg.toString());    	msg.append("</resultmsg>\n");
		msg.append("		<gamecost>");		msg.append(result.getInt("gamecost"));    		msg.append("</gamecost>\n");
		msg.append("		<cashcost>");		msg.append(result.getInt("cashcost"));    		msg.append("</cashcost>\n");
		msg.append("		<heart>");			msg.append(result.getInt("heart"));    			msg.append("</heart>\n");
		msg.append("		<feed>");			msg.append(result.getInt("feed"));    			msg.append("</feed>\n");
		msg.append("		<roul1>");			msg.append(result.getInt("roul1"));    			msg.append("</roul1>\n");
		msg.append("		<roul2>");			msg.append(result.getInt("roul2"));    			msg.append("</roul2>\n");
		msg.append("		<roul3>");			msg.append(result.getInt("roul3"));    			msg.append("</roul3>\n");
		msg.append("		<roul4>");			msg.append(result.getInt("roul4"));    			msg.append("</roul4>\n");
		msg.append("		<roul5>");			msg.append(result.getInt("roul5"));    			msg.append("</roul5>\n");
		msg.append("		<roul6>");			msg.append(result.getInt("roul6"));    			msg.append("</roul6>\n");
		msg.append("		<roul7>");			msg.append(result.getInt("roul7"));    			msg.append("</roul7>\n");
		msg.append("		<roul8>");			msg.append(result.getInt("roul8"));    			msg.append("</roul8>\n");
		msg.append("		<roul9>");			msg.append(result.getInt("roul9"));    			msg.append("</roul9>\n");
		msg.append("		<roul10>");			msg.append(result.getInt("roul10"));    		msg.append("</roul10>\n");
		msg.append("		<roul11>");			msg.append(result.getInt("roul11"));    		msg.append("</roul11>\n");
		msg.append("		<checkani>");		msg.append(result.getInt("checkani"));    		msg.append("</checkani>\n");
		msg.append("		<checkreward>");	msg.append(result.getInt("checkreward"));    	msg.append("</checkreward>\n");
		msg.append("		<checkrewardcnt>");	msg.append(result.getInt("checkrewardcnt"));    msg.append("</checkrewardcnt>\n");
		msg.append("		<tsgrade1cnt>");	msg.append(result.getInt("tsgrade1cnt"));    	msg.append("</tsgrade1cnt>\n");
		msg.append("		<tsgrade2cnt>");	msg.append(result.getInt("tsgrade2cnt"));    	msg.append("</tsgrade2cnt>\n");
		msg.append("		<tsgrade2gauage>");	msg.append(result.getInt("tsgrade2gauage"));   	msg.append("</tsgrade2gauage>\n");
		msg.append("		<tsgrade4cnt>");	msg.append(result.getInt("tsgrade4cnt"));    	msg.append("</tsgrade4cnt>\n");
		msg.append("		<tsgrade4gauage>");	msg.append(result.getInt("tsgrade4gauage"));	msg.append("</tsgrade4gauage>\n");
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

	    	//2. 유저 보유 선물리스트
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
					msg.append("		<tspmgauagepoint>");	msg.append(result.getString("pmgauagepoint")); 	msg.append("</tspmgauagepoint>\n");
					msg.append("		<tspmgauagemax>");	msg.append(result.getString("pmgauagemax"));  		msg.append("</tspmgauagemax>\n");

					msg.append("		<tsupgradesaleflag>");msg.append(result.getString("tsupgradesaleflag2"));msg.append("</tsupgradesaleflag>\n");
					msg.append("		<tsupgradesalevalue>");msg.append(result.getString("tsupgradesalevalue"));msg.append("</tsupgradesalevalue>\n");
					msg.append("	</tsinfo>\n");
				}
			}

			//뽑기 이벤트결과.
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				while(result.next()){
					msg.append("	<eventresultts>\n");
					msg.append("		<checkts>");		msg.append(result.getString("checkani"));  			msg.append("</checkts>\n");
					msg.append("		<checkreward>");	msg.append(result.getString("checkreward"));  		msg.append("</checkreward>\n");
					msg.append("		<checkrewardcnt>");	msg.append(result.getString("checkrewardcnt"));  	msg.append("</checkrewardcnt>\n");
					msg.append("	</eventresultts>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);

		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n gameid=" 	+ gameid);
		DEBUG_LOG_STR.append("\r\n &password=" 	+ password);
		DEBUG_LOG_STR.append("\r\n &mode=" 		+ mode);
		DEBUG_LOG_STR.append("\r\n &randserial="+ randserial);
		System.out.println(DEBUG_LOG_STR.toString());
	}

    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
