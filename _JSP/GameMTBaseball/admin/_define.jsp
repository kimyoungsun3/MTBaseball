<%@include file="_constant.jsp"%>
<%
	String pwdateid = "1234";
	int YEAR = 2018;
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
	if(strIP.equals("172.16.0.5")){
		strIP = "49.247.202.212";
		strPort = "8086";
		strServerName = "<font size=10 color=gray>[K6(MT야구)(Test)]</font>";
		bRealServer = false;
	}else{
		strIP = "49.247.202.212";
		strPort = "8086";
		strServerName = "<font size=10 color=red>[K6(MT야구)(Real)]</font>";
		bRealServer = true;
	}
	String imgroot	= "http://" + strIP + ":" + strPort + "/GameMTBaseball/admin/item";
	//페이지 기능에 사용되는 변수

%><br><br>
<center>
<%=strServerName%><font size=10 color=blue><a href=_admin.jsp>[메인]</a></font>
</center>