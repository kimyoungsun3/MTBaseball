#if UNITY_EDITOR
	#define NET_DEBUG_MODE
#endif

using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

public class NetworkManager : MonoBehaviour {
	public static NetworkManager ins;
	[HideInInspector] public int nConnectState;
	private string url, urlbase;
	private WWW www;

	public static string strCreateID,
				  		 strCreatePW,
				 		 strPhoneNumber 	= null,
				 		 strPhoneNumberC 	= null;

	void Awake()
	{	
		ins 	= this;
		urlbase = Protocol.SERVER;		
		if ( Protocol.BUILD_MODE != Protocol.BUILD_MODE_REAL )
		{
			Debug.LogWarning(" 현재 디버그 모드입니다.");
		}
		nConnectState = Protocol.CONNECT_STATE_NON;
	}

	#if NET_DEBUG_MODE
	private string strDebugMsg = "";
	private bool bNetDebug = false;
	void OnGUI(){
		//int _idx = 0;
		string _str;
		int _px = 10, _py = 10, _dx = 150, _dy = 40;
		Rect _rl;

		//netstate
		_str = "cs:" + nConnectState + " " + strDebugMsg + "[" + strPhoneNumber + ":" + strPhoneNumberC + "]";
		_rl = new Rect(_px, _py, Screen.width, _dy);
		GUI.Label(_rl, _str);

		_str = "NET on/off";
		_rl = new Rect(Screen.width - 100, Screen.height * 0.5f, 100, 40);
		if(GUI.Button(_rl, _str))bNetDebug = !bNetDebug;
		if(bNetDebug)return;

		//PTC_CREATEID
		_str = "PTC_CREATEID";
		_py += _dy;
		_rl = new Rect(_px, _py, _dx, _dy);
		if (GUI.Button (_rl, _str)) {
			sendCode (Protocol.PTC_CREATEID, null);
			strCreateID 		= "mtbaseballid";
			strCreatePW 		= SSUtil.setPassword( "a1s2d3f4" );
			strPhoneNumber		= "01012345678";
			strPhoneNumberC		= SSUtil.setPhoneNumber(strPhoneNumber);
			Debug.Log ("strCreateID:" + strCreateID);
			Debug.Log ("strCreatePW:" + strCreatePW);
			Debug.Log ("strPhoneNumber:" + strPhoneNumber);
			Debug.Log ("strPhoneNumberC:" + strPhoneNumberC);
		}

		_str = "PTC_LOGIN";
		_py += _dy;
		_rl = new Rect(_px, _py, _dx, _dy);
		if (GUI.Button (_rl, _str)) {
			sendCode (Protocol.PTC_LOGIN, null);
		}

		_str = "PTC_SERVERTIME";
		_py += _dy;
		_rl = new Rect(_px, _py, _dx, _dy);
		if (GUI.Button (_rl, _str)) {
			sendCode (Protocol.PTC_SERVERTIME, null);
		}
	}
	#endif
	
	//--------------------------------------------
	// [C -> S]
	// 1. Client -> Server 데이타 요청
	// 호출방법 : NetworkManager.Ins.sendCode
	// 멀티 호출이 가능함.
	//
	// _code			: 코드.
	// VOID_FUN_INTINT	: 응답후 함수(delegate (int, int)) 2개의 파라미터를 받을 수 있음...
	// _bPopup			: 팝업을 띄울것인가?
	//--------------------------------------------
	public bool sendCode( int _code, VOID_FUN_INTINT _onResult )
	{
		WWWForm _form = new WWWForm();
		nConnectState = Protocol.CONNECT_STATE_TRY;
		
		switch(_code)
		{
		case Protocol.PTC_CREATEID:
			{
				#if NET_DEBUG_MODE
				Debug.Log("[C -> S] PTC_CREATEID");
				#endif
				//1. make URL
				url = urlbase + Protocol.PTC_CREATEID;

				//2. setting form
				_form.AddField("gameid", strCreateID);
				_form.AddField("password", strCreatePW);
				_form.AddField("version", "" + Protocol.VERSION);
				_form.AddField("phone", strPhoneNumberC);

				//3. sending
				#if NET_DEBUG_MODE
				Debug.Log(" _form:" + SSUtil.getString(_form.data));
				#endif
				StartCoroutine(Handle(new WWW(url, _form ), _onResult));
			}
			break;

		case Protocol.PTC_LOGIN:		
			{			
				#if NET_DEBUG_MODE			
				Debug.Log("[C -> S] PTC_LOGIN");			
				#endif
			
				//1. make URL			
				url = urlbase + Protocol.PTG_LOGIN;			
			
				//2. setting form
				strCreateID = "";
				strCreatePW = "";
				_form.AddField("gameid", strCreateID);			
				_form.AddField("password", strCreatePW);	
			
				//3. sending			
				#if NET_DEBUG_MODE			
				Debug.Log(" _form:" + SSUtil.getString(_form.data));			
				#endif
				StartCoroutine( Handle( new WWW( url, _form ), _onResult ) );
			}
			break;
		case Protocol.PTC_SERVERTIME:
			{
				#if NET_DEBUG_MODE
				Debug.Log("[C -> S] PTC_SERVERTIME");
				#endif
				//1. make URL
				url = urlbase + Protocol.PTG_SERVERTIME;

				//2. setting form
				_form.AddField("gameid", strCreateID);
				_form.AddField("password", strCreatePW);

				//3. sending
				#if NET_DEBUG_MODE
				Debug.Log(" _form:" + SSUtil.getString(_form.data));
				#endif
				StartCoroutine(Handle(new WWW(url, _form ), _onResult));
			}
			break;
		default:
			Debug.LogError("[error][C -> S] #### error");	
			if ( _onResult != null )
			{
				_onResult ( Protocol.CONNECT_STATE_FAIL , Protocol.CONNECT_STATE_FAIL );
			}
			break;
		}		
		return true;
	}
	

	//--------------------------------------------
	//[C <- S]
	// 2. 보내온 데이타는 data, fun으로 구성됨.
	//--------------------------------------------
	public int parseCode( string _xml ){		
		//1. 변수 선언 및 할당.
		SSParser _parser = new SSParser ();

		//Debug.Log ( _xml );

		_parser.parsing(_xml, "result");
		_parser.next();
		
		int _code 		= _parser.getInt("code");	
		int _resultcode = _parser.getInt("resultcode");
		string _msg 	= _parser.getString("resultmsg");


		//3. 내부 코드.
		switch(_code)
		{
		case Protocol.PTS_SERVERTIME:
			{
				#if NET_DEBUG_MODE	
				Debug.Log("[C <- S] PTS_SERVERTIME _resultcode:" + _resultcode + " _msg:" + _msg + "\n" + _xml);			
				#endif

				switch(_resultcode){
				case Protocol.RESULT_SUCCESS:
					#if NET_DEBUG_MODE
					Debug.Log(" > 서버시간 > 성공.");				
					#endif

					//현재 서버 시간 2014-11-14 10:49:57.				
					//Callendar.SetServerTime( DateTime.Parse( parser.getString("curdate") ) );				
					break;
				default:
					#if NET_DEBUG_MODE
					Debug.Log(" > 서버시간 실패. > 팝업처리.");
					#endif
					break;				
				}
			}
			break;
		case Protocol.PTS_CREATEID:
			#if NET_DEBUG_MODE
			Debug.Log("[C <- S] PTS_CREATEID _resultcode:" + _resultcode + " _msg:" + _msg + "\n" + _xml);
			#endif
			
			switch(_resultcode){
			case Protocol.RESULT_SUCCESS:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_CREATEID > success");
				#endif

				//1. 서버에서 생성된 게스트 아이디 받기.
				strCreateID = _parser.getString("gameid");
				strCreatePW = _parser.getString("password");			//패스워드를 보내준것으로 새팅해야한다.
				SaveIdPwToLocalDB(strCreateID, strCreatePW);

				break;
			case Protocol.RESULT_ERROR_ID_DUPLICATE:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_CREATEID > error > 아이디 중복");
				#endif
				break;
			default:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_CREATEID > error > not found error");
				#endif
				break;
			}
			break;
		case Protocol.PTS_LOGIN:
			#if NET_DEBUG_MODE
			Debug.Log("[C <- S] PTS_LOGIN _resultcode:" + _resultcode + " _msg:" + _msg + "\n" + _xml);
			#endif

			switch(_resultcode)
			{
			case Protocol.RESULT_SUCCESS:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_LOGIN > success");
				#endif

				GameData.pathUrl = _parser.getString("patchurl");	//패치URLDebug.Log ( parser.getString("patchurl") );.
				//현재 서버 시간 2014-11-14 10:49:57.
				//Callendar.SetServerTime( DateTime.Parse( parser.getString("curdate") ) );

				//유져인포.
				_parser.parsing ( _xml , "userinfo" );

				if (_parser.next ())
				{
					//UserData.ins.cashcost = parser.getInt ( "cashcost" );
				}

				//선물정보.
				//GameData.ReadGiftItem ( parser , _xml , "giftitem" );

				//현재대전내용(1건).
				//UserData.battleRnk_current.Parser(parser, _xml, "rkcurrank");
				break;
			case Protocol.RESULT_ERROR_SERVER_CHECKING:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_LOGIN > error > 시스템 점검중입니다. > 게임 종료.");
				#endif
				break;
			case Protocol.RESULT_ERROR_NOT_FOUND_GAMEID:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_LOGIN > error > 아이디를 확인해라 > 다시 로그인.");
				#endif
				break;
			case Protocol.RESULT_NEWVERION_CLIENT_DOWNLOAD:		
//				Debug.Log ( parser.getString("patchurl") );
				GameData.pathUrl = _parser.getString("patchurl");		//패치URL.
				#if NET_DEBUG_MODE
				Debug.Log("PTS_LOGIN > error > 클라이언트가 새로나왔습니다. > 다시 받아주세요.");
				#endif
				break;
			case Protocol.RESULT_ERROR_BLOCK_USER:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_LOGIN > error > 블럭된 계정입니다. > 다시 로그인.");
				#endif

				break;
			default:
				#if NET_DEBUG_MODE
				Debug.Log("PTS_LOGIN > error > not found error");
				#endif
				break;
			}
			break;
		
		default:
			Debug.LogError("[error]:[C -> S] not define code\n" + _xml);
			break;
		}

		return _resultcode;
	}

	[HideInInspector] public int debug 			= 0;
	[HideInInspector] public float debugDelay 	= 0f;
	[HideInInspector] public int debugErrCode 	= 0;

	public IEnumerator Handle(WWW _www, VOID_FUN_INTINT _onResult )
	{
		if ( debug > 0 )
		{
			Debug.Log("test fail net("+debug+")");
			
			debug--;

			yield return new WaitForSeconds(debugDelay);

			if ( _onResult != null ) {
				_onResult ( Protocol.CONNECT_STATE_SUCCESS , debugErrCode );
			}

			StartCoroutine ( DealyKill ( _www ) );
		}
		else 
		{
			float _timeOut = Time.realtimeSinceStartup + Protocol.LIMIT_CONNECT_TIME;

			while( !_www.isDone && Time.realtimeSinceStartup < _timeOut && string.IsNullOrEmpty( _www.error ) ){
				nConnectState = Protocol.CONNECT_STATE_WAIT;	
				yield return 0;
			}

			if( string.IsNullOrEmpty( _www.error ) && _www.isDone)
			{
				nConnectState = Protocol.CONNECT_STATE_SUCCESS;
				int _detail = parseCode ( _www.text.Trim() );

				if ( _onResult != null ) {
					_onResult ( Protocol.CONNECT_STATE_SUCCESS , _detail );
				}

				_www.Dispose();
			}
			else if(Time.realtimeSinceStartup >= _timeOut)
			{
				nConnectState = Protocol.CONNECT_STATE_TIMEOVER;
				if ( _onResult != null ) {
					_onResult ( Protocol.CONNECT_STATE_FAIL , Protocol.CONNECT_STATE_FAIL );
				}

				StartCoroutine ( DealyKill ( _www ) );
			}
			else 
			{
				nConnectState = Protocol.CONNECT_STATE_FAIL;
				Debug.Log("err connect");

				if ( _onResult != null ) {
					_onResult ( Protocol.CONNECT_STATE_FAIL , Protocol.CONNECT_STATE_FAIL );
				}

				StartCoroutine ( DealyKill ( _www ) );
			}
		}
	}

	private IEnumerator DealyKill ( WWW _www )
	{
		while ( _www.isDone == false  ) 
		{
			yield return null;
		}
		
		_www.Dispose ();
	}

	private const string KEY_ID = "laDjeijfsS";
	private const string KEY_PW = "v209Z78as34S";
	public static void SaveIdPwToLocalDB( string _id, string _pw )
	{
		PlayerPrefs.SetString(KEY_ID, _id);
		PlayerPrefs.SetString(KEY_PW, _pw);
		PlayerPrefs.Save();
	}
	public static void ClearIdPw()
	{
		PlayerPrefs.SetString(KEY_ID, Constant.NULL_STRING);
		PlayerPrefs.SetString(KEY_PW, Constant.NULL_STRING);
		PlayerPrefs.Save();
	}
}
































