<%
				 int 	PTC_NOTICE			= 0,	//notice.jsp
						PTS_NOTICE			= 0,						
						PTC_CREATEID		= 1,	//createid.jsp
						PTS_CREATEID		= 1,						
						PTC_LOGIN			= 2,	//login.jsp
						PTS_LOGIN			= 2,					
						PTC_SERVERTIME		= 3,	//servertime.jsp
						PTS_SERVERTIME		= 3,			
						PTC_USERPARAM		= 4,	//userparam.jsp
						PTS_USERPARAM		= 4,
						PTC_GIFTGAIN		= 21, 	//giftgain.jsp
						PTS_GIFTGAIN		= 21,
						PTC_SYSINQUIRE		= 22, 	//sysinquire.jsp
						PTS_SYSINQUIRE		= 22,
						PTC_KCHECKNN		= 23, 	//kchecknn.jsp
						PTS_KCHECKNN		= 23,
						
						PTC_SGREADY			= 31, 	//sgready.jsp  
						PTS_SGREADY			= 31,
						PTC_SGBET			= 32, 	//sgbet.jsp
						PTS_SGBET			= 32,
						PTC_SGRESULT		= 33, 	//sgresult.jsp
						PTS_SGRESULT		= 33,	
						
						PTC_PTREADY			= 34, 	//ptready.jsp  
						PTS_PTREADY			= 34,
						PTC_PTBET			= 35, 	//ptbet.jsp
						PTS_PTBET			= 35,
						PTC_PTRESULT		= 36, 	//ptresult.jsp
						PTS_PTRESULT		= 36,	
						
						PTC_GAMERECORD		= 37, 	//gamerecord.jsp
						PTS_GAMERECORD		= 37,	
						
						PTC_ITEMCHANGE		= 40, 	//itemchange.jsp
						PTS_ITEMCHANGE		= 40,							
						PTC_ITEMBUY			= 41, 	//itembuy.jsp
						PTS_ITEMBUY			= 41,								
						PTC_ITEMOPEN		= 42, 	//itemopen.jsp
						PTS_ITEMOPEN		= 42,			
															
												
						PTC_XXXXX			= 99,
						PTS_XXXXX			= 99;	//_xxxxx.jsp





	String strIP = request.getLocalAddr();
	String strPort;
	//if(strIP.equals("192.168.0.11")){
	//	strIP = "49.247.202.212";
	//	strPort = "8086";
	//}else{
	//	strIP = "49.247.202.212";
	//	strPort = "8086";
	//}
	strIP = "49.247.202.212"; 
	strPort = "8086";

	boolean DEBUG_LOG_PARAM = false;
	StringBuffer DEBUG_LOG_STR	= new StringBuffer();

%>