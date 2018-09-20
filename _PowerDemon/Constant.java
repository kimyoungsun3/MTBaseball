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


	public final static int LOTTO_MODE_READ 		= 1;
	public final static int LOTTO_MODE_WRITE 		= 2;


	public final static String ADMIN_KEY			= "ddd606f85a057f556194531400cc88d4";
	public final static String KAKAOSERVER			= "http://www.nlotto.co.kr/gameInfo.do?method=powerWinNoList";
	public final static String KAKAO_OK_MSG			= "{\"code\":200,\"msg\":\"Payment Log submitted\"}";


	public final static String DB_DRIVER 			= "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public final static String DB_PUB_TEST 			= "jdbc:sqlserver://49.247.202.212:1433;databaseName=GameMTBaseball;user=gamemtbaseball;password=a1s2d3f4";
	public final static String DB_PUB_REAL 			= "jdbc:sqlserver://49.247.202.212:1433;databaseName=GameMTBaseball;user=gamemtbaseball;password=a1s2d3f4";
}
