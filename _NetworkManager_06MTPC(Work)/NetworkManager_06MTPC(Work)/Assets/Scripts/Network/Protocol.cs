#define BUILD_MODE_REAL
//#define BUILD_MODE_DEBUG

#define SERVER_MODE_TEST_FREE
//#define SERVER_MODE_REAL_FREE

using UnityEngine;
using System.Collections;

public class Protocol{
	#region MARKET_MODE
	/////////////////////////////////////////////////////////////////////
	//	
	/////////////////////////////////////////////////////////////////////
	public const int 	VERSION			= 100;			
	public const int 	VERSION_CODE	= 1;
	public const string MARKET_BRANCH	= "pc";
	#endregion

	/////////////////////////////////////////////////////////
	/// 기존정의값.
	public const int 	AGREEMENT_KO				= 0,	//한글 약관동의.
					 	AGREEMENT_EN 				= 1;	//영문 약관동의.

	public const float LIMIT_CONNECT_TIME 			= 30f;	//40초.
	public const string NULL_VALUE_STR				= "-1";

	// 개인 사용.
	public const int BUILD_MODE_REAL 				= 1;
	public const int BUILD_MODE_DEBUG 				= 2;
	#if BUILD_MODE_REAL
		public const int 	BUILD_MODE		= Protocol.BUILD_MODE_REAL;
	#elif BUILD_MODE_DEBUG
		public const int 	BUILD_MODE		= Protocol.BUILD_MODE_DEBUG;
	#endif



	#region SERVER_MODE
	/////////////////////////////////////////////////////////////////////
	//	실서버와 테스트서버
	/////////////////////////////////////////////////////////////////////
	#if SERVER_MODE_TEST_FREE
		public const string SERVER 			= "http://49.247.202.212:8086/GameMTBaseball/" + MARKET_BRANCH + "/";		
	#elif SERVER_MODE_REAL_FREE
		public const string SERVER 			= "http://127.0.0.1:8086/GameMTBaseball/" + MARKET_BRANCH + "/";
	#endif
	#endregion

	/////////////////////////////////////////////////////////////////////
	//  Client -> Server Request.
	//  PTC_XXX	: Client -> Server
	//  PTS_XXX	: Client <- Server
	/////////////////////////////////////////////////////////////////////
	#region PTC, PTS
	public const int 	
						PTC_CREATEID		= 0,	//createid.jsp
						PTS_CREATEID		= 0,

						PTC_LOGIN			= 1,	//login.jsp
						PTS_LOGIN			= 1,

						PTC_SERVERTIME		= 208,	//servertime.jsp
						PTS_SERVERTIME		= 208,

						PTC_XXXXX			= 99,	
						PTS_XXXXX			= 99;
	#endregion


	/////////////////////////////////////////////////////////////////////
	//  Client -> Server Request. PagetName
	/////////////////////////////////////////////////////////////////////
	#region PTG
	public const string	
						PTG_CREATEID		= "createid.jsp",
						PTG_LOGIN			= "login.jsp",
						PTG_SERVERTIME		= "servertime.jsp",


						PTG_XXXXX			= "_xxxxx.jsp";

	#endregion

	/////////////////////////////////////////////////////////////////////
	//  //Clinet <- Server Response.(Result)
	/////////////////////////////////////////////////////////////////////
	#region RESULT_CODE
	public const int 	RESULT_SUCCESS 						=  1,	//일반성공.
						RESULT_ERROR						= -1,	//일반실패.

						//가입 오류.
						RESULT_ERROR_ID_DUPLICATE			= -2,
						RESULT_ERROR_ID_CREATE_MAX			= -3,

						//로그인 오류.
						RESULT_ERROR_BLOCK_USER 			= -11, 		//블럭유저 > 팝업처리후 인트로로 빼버린다.
						RESULT_ERROR_NOT_FOUND_GAMEID		= -13,		//해당유저를 찾지 못함.
						RESULT_ERROR_NOT_FOUND_PASSWORD		= -17,
						RESULT_ERROR_SERVER_CHECKING		= -14,		//서버를 점검하고 있다.
						RESULT_NEWVERION_CLIENT_DOWNLOAD 	= -15,		//신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
						RESULT_NEWVERION_FILE_DOWNLOAD 		= -16, 		//신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
						RESULT_ERROR_NOT_FOUND_PHONE		= -76,

						//게임중에 부족.
						RESULT_ERROR_CASHCOST_LACK			= -22,	//골드가 부족하다.
						RESULT_ERROR_ITEM_LACK				= -23,	//아이템이부족하다.

						//아이템 구매, 변경.
						RESULT_ERROR_BUY_ALREADY			= -31,  //이미 구매했습니다.
						RESULT_ERROR_NOT_HAVE				= -32,  //보유하지 않고 있다.
						RESULT_ERROR_UPGRADE_FULL			= -35,	//업그레이드가 풀로되었다.
						RESULT_ERROR_ITEM_NOSALE_KIND		= -37,	//판매하지 않는 아이템.

						//아이템 선물.
						RESULT_ERROR_NOT_FOUND_ITEMCODE 	= -50,	//아이템코드못찾음.
						RESULT_ERROR_GIFTITEM_NOT_FOUND		= -51,	//선물아이템을 못찾음.
						RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52,	//선물을 이미 가져감.
						RESULT_ERROR_NOT_FOUND_GIFTID		= -75,	//캐쉬 > 선물할 아이디를 못찾음.

						//기타오류.
						RESULT_ERROR_RESULT_COPY			= -53,	//결과카피시도.
						RESULT_ERROR_NOT_SUPPORT_MODE		= -70,	//지원하지않는모드.
						RESULT_ERROR_NOT_FOUND_OTHERID		= -83,	//
						RESULT_ERROR_DOUBLE_RANDSERIAL		= -111,	//랜덤시리얼 중복.
						RESULT_ERROR_ITEMCOST_WRONG			= -113, //아이템 가격이 이상함.
						RESULT_ERROR_LISTIDX_NOT_FOUND		= -114, //리스트 번호를 못찾음.
						RESULT_ERROR_NOT_ENOUGH				= -115,	//무엇인가 충분하지 않음.
						RESULT_ERROR_PARAMETER				= -122, //파라미터오류.
						RESULT_ERROR_TIME_REMAIN			= -123, //아직 시간이 남음.
						RESULT_ERROR_CANNT_CHANGE			= -146, //무엇인가를 변경할 수 없습니다.
						RESULT_ERROR_WAIT_RETURN			= -148,	//요청 대기중입니다.
						RESULT_ERROR_SESSION_ID_EXPIRE		= -150,	//세션이 만료되었습니다.WWW

						RESULT_XXXXXX						= -999;
	#endregion

	
	#region 정의값들.
	public const int 	CONNECT_STATE_NON					= 0,
						CONNECT_STATE_TRY					= 1,
						CONNECT_STATE_WAIT					= 2,
						CONNECT_STATE_TIMEOVER				= 3,
						CONNECT_STATE_SUCCESS				= 10,
						CONNECT_STATE_FAIL					= -1;
	
	public const int 	//게임서버 상태값.
					 	SYSTEM_CHECK_SERVICE				= 0,	//게임서버 서비스.
					 	SYSTEM_CHECK_CHECKING				= 1,	//        점검중.	

						//선물 종류.
						GIFTLIST_GIFT_KIND_MESSAGE			= 1,	//선물(메세지).
						GIFTLIST_GIFT_KIND_GIFT				= 2,	//선물(아이템).
						GIFTLIST_GIFT_KIND_MESSAGE_DEL		= -1,	//메세지 삭제.
						GIFTLIST_GIFT_KIND_GIFT_DEL			= -2,	//선물 삭제(안받고 삭제).
						GIFTLIST_GIFT_KIND_GIFT_GET			= -3,	//선물 받기(해당템만 전송).
						GIFTLIST_GIFT_KIND_GIFT_SELL		= -4,	//선물 바로판매.
						GIFTLIST_GIFT_KIND_LIST				= -5,	//리스트.

						MODE_RETURN_STATE_NON				= 0, 	// 활동.
						MODE_RETURN_STATE_SENDED			= 1, 	// 이미요청.		
						MODE_RETURN_STATE_LONG				= 2, 	// 장기미접속.


						XXXXXXXXXXXXXXXXXXXXXXXXXX			= -1;
		
	#endregion
}














