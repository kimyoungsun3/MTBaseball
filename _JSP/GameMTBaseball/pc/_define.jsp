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