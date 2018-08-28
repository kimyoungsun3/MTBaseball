public class Constant{

	/////////////////////////////////////////////////////////////
	//일반 상수값들
	public final static boolean DEBUG_MODE 			= true;
	public final static boolean DEBUG_PARAM			= false;
	public final static boolean DEBUG_RECE			= false;
	public final static boolean DEBUG_MODE9			= false;
	public final static boolean DEBUG_DBCONNECT 	= false;

	public final static int CONNECT_MODE_TEST		= 2;
	public final static int CONNECT_MODE_REAL 		= 3;

	public final static int KAKAO_MODE_LIST 		= 1;
	public final static int KAKAO_MODE_SENDED 		= 2;

	//public final static String CLIENT_ID			= "f96bbc532e14acdc6557edff72662fc6";
	public final static String ADMIN_KEY			= "ddd606f85a057f556194531400cc88d4";
	public final static String KAKAOSERVER			= "https://game-api.kakao.com/playgame/v2/payment/log";
	public final static String KAKAO_OK_MSG			= "{\"code\":200,\"msg\":\"Payment Log submitted\"}";

	public final static int SKT 					= 1;
	public final static int GOOGLE 					= 5;
	public final static int IPHONE 					= 7;

	public final static String DB_DRIVER 			= "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public final static String DB_PUB_TEST 			= "jdbc:sqlserver://192.168.0.11:1433;databaseName=Game4Farmvill5;user=game4farm;password=a1s2d3f4";
	public final static String DB_PUB_REAL 			= "jdbc:sqlserver://175.117.144.239:1433;databaseName=Game4Farmvill5;user=game4farm;password=a1s2d3f4";
}
