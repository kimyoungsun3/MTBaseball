/////////////////////////////////////////
//	수정일 		: 2013-07-22
//	수정내용 	: NGUI Object Destroy
/////////////////////////////////////////

//#define DEBUG_ON
using UnityEngine;
using System.Collections;

public class SSUtil{
	public static System.Text.Encoding enc = System.Text.Encoding.ASCII;

	/// <summary>
	/// read xml, txt file(Resources)
	/// </summary>
	public static string load(string _file){
		#if DEBUG_ON
			Debug.Log("SSUtil load _file:" + _file);
		#endif

		//1. file read and return
		TextAsset _textAsset = (TextAsset)Resources.Load(_file);
		return _textAsset.text;
	}

	///// <summary>
	/////	2012-06-09 마스크 데이타를 필터하고 싶을 때 사용한다.
	///// _kind : 데이타 테이블에서 읽어들인 값을 넣는다.
	///// _mask : 남자(1), 여자(2), 카일(4), 고스트(8)
	/////         public static int ITEM_SEX_MALE		= 0x1;
	/////         public static int ITEM_SEX_FEMALE	= 0x2;
	/////         public static int ITEM_SEX_KAIL		= 0x4;
	/////         public static int ITEM_SEX_GHOST	= 0x8;
	///// 예) 현제 아이템이 남자용인가?
	/////     if(SSUtil.getMask(1, ITEM_SEX_MALE) > 0)
	///// 			남자용이 맞음.
	///// 	else
	///// 			남자용이 아님.
	///// </summary>
    //
	//public static int getMask(int _kind, int _mask){
	//	return _kind & _mask;
	//}

	/////////////////////////////////////////////////////
	//	NGUI GameObject Destroy.
	//	NGUI오브젝트를 직접 삭제거하면 오류가 발생함.(내부적으로 UnityEngine.Object.DestroyImmediate)
	// 	그래서 FixedUpdate, Update > 후에 파괴하기 (WaitForEndOfFrame)
	//
	//	사용법
	//			GameObject go;
	//			.....
	//			StartCoroutine(SSUtil.DestroyNGUI(go));
	/////////////////////////////////////////////////////
	public static IEnumerator DestroyNGUI(GameObject _go){
		yield return new WaitForEndOfFrame();
		UnityEngine.Object.Destroy(_go);
	}

	/// ////////////////////////////////////////////////////////////////////
	//_strName		: /tmp_1366364214754.png
	//_strURL		: http://images.earthcam.com/ec_metros/ourcams/tmp_1366364214754.png
	//_strPathFolder:
	//	Android		  /mnt/sdcard/Android/data/com.sangsangdigital.farmtycoongg/files
	//	PC			  C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler
	//_strPathFile	:
	//	Android		  /mnt/sdcard/Android/data/com.sangsangdigital.farmtycoongg/files/tmp_1366364214754.png
	//	PC			  C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler/tmp_1366364214754.png
	/// ////////////////////////////////////////////////////////////////////
	public static string getDataPath(string _strName){
		return Application.persistentDataPath + "/" + _strName;
	}

	public static string getDataPathProtocol(string _strName){
		#if UNITY_EDITOR
			_strName = "file://c://" + Application.persistentDataPath + "/" + _strName;
		#elif UNITY_ANDROID || UNITY_IPHONE
			_strName = "file://" + Application.persistentDataPath + "/" + _strName;
		#elif UNITY_WEBPLAYER
			_strName = _strURL;
		#else
			_strName = "file://c://" + Application.persistentDataPath + "/" + _strName;
		#endif


		return _strName;
	}


	////////////////////////////////////////////////////////////////////////////////////////////
	/// 패스워드 암호화.
	////////////////////////////////////////////////////////////////////////////////////////////
	public static string getGuestPassword(){
		string _password = "";

		for(int i = 0; i < 8; i++){
			if(i%2 == 0){
				_password += Random.Range(0, 10);
			}else{
				_password += (char)(97 + Random.Range(0, 25));
			}
		}

		//Debug.Log("_password:" + _password);
		//return setPassword(_password);
		return _password;
	}

	public static string setPassword(string _password){
		System.Text.UTF8Encoding _encoding = new System.Text.UTF8Encoding();
		int _len = _password.Length;
		int _lenMax = 20+1;
		int _lenMarge = _lenMax - _len;
  		byte[] _arr = _encoding.GetBytes(_password);
		int _tmp, _loop, i;
		byte _sum = 0;
		bool _bSwitch = false;

		for(int k = 0; k < _lenMarge; ++k){
			//1. password reparsing.
			_arr = _encoding.GetBytes(_password);
			_sum = 0;

			//2. sum data.
			for(i = 0; i < _len; i++){
				_sum += _arr[i];
			}
			_loop = _sum % 10;
			if(_loop == 0){
				_loop = 4;
			//}else if(_loop == 5){
			//	_loop = 6;
			}

			//3. loop > jump
			for(i = 0; i < _len; i++){
				_loop = 10 - _loop;
				_tmp = (int)_arr[i];
				if(_tmp >= 48 && _tmp <= 57){
					_tmp += _loop;
					if(_tmp > 57)_tmp -= 10;
				}else if(_tmp >= 65 && _tmp <= 90){
					_tmp += _loop;
					if(_tmp > 90)_tmp -= 26;
				}else if(_tmp >= 97 && _tmp <= 122){
					_tmp += _loop;
					if(_tmp > 122)_tmp -= 26;
				}else{
					_tmp += _loop;
				}
				_arr[i] = (byte)_tmp;
			}
			_password = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);

			//4. 추가문자열 만들기.
			if(_password.Length < _lenMax - 1){
				if(_bSwitch){
					_password = _password + _loop;
				}else{
					_password = _loop + _password;
				}
				_bSwitch = !_bSwitch;
			}
			//Debug.Log(_password);
		}



		return _password;
	}

	public static string saveLocalPassword(string _password){
		//Debug.Log("org:" + _password);
		//a1s2d3f4				< 유저.
		//049000s1i0n7t8445289	< 메모리.
		//0470804120n9t04s5i89	< 세이브.
		if(_password == "-1"){
			return _password;
		}

		System.Text.UTF8Encoding _encoding = new System.Text.UTF8Encoding();
		int _len = _password.Length - 1;
		int _len2 = _len/2;
		byte[] _arr = _encoding.GetBytes(_password);
		byte _tmp;
		//Debug.Log("_len:" + _len + ", _len2:" + _len2);
		for(int i = 0; i < _len2; i+=2){
			_tmp = _arr[i];
			_arr[i] = _arr[_len2 + i];
			_arr[_len2 + i]  =_tmp;
		}

		_password = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		//Debug.Log("chn:" + _password);
		return _password;
	}



	////////////////////////////////////////////////////////////////////////////////////////////
	/// <summary>
	/// 결제 암호화.
	/// </summary>
	////////////////////////////////////////////////////////////////////////////////////////////
	public static string setCashEncode(string _strGameid, int _cash, int _goldball){
		string _strRtn = "";
		string _strCash = "";
		string _strGoldball = "";
		string _strSum = "";
		int _len, _loop;


		//1. loop.
		_loop = Random.Range(1, 10);
		_strRtn += _loop;
		#if DEBUG_ON
			Debug.Log("_loop:" + _loop);
		#endif

		//2. cash
		_cash = (_cash + 12345678);
		_strCash = "" + _cash;
		_len = _strCash.Length;
		#if DEBUG_ON
			Debug.Log("_strCashS:" + _strCash + "(" + (_cash - 12345678) + ")");
		#endif
		while(_len < 8){
			_strCash = "0" + _strCash;
			++_len;
		}
		_strRtn += _strCash;
		#if DEBUG_ON
			Debug.Log("_strCashE:" + _strCash);
		#endif

		//2-2. goldball
		_goldball = (_goldball + 87654321);
		_strGoldball = "" + _goldball;
		_len = _strGoldball.Length;
		#if DEBUG_ON
			Debug.Log("_strGoldballS:" + _strGoldball+  "(" + (_goldball - 87654321) + ")");
		#endif
		while(_len < 8){
			_strGoldball = "0" + _strGoldball;
			++_len;
		}
		_strRtn += _strGoldball;
		#if DEBUG_ON
			Debug.Log("_strGoldballE:" + _strGoldball);
		#endif

		//3. id.
		_strRtn += _strGameid;

		//4. current date.
		string _time = System.DateTime.Now.ToString("yyyyMMddhhmmss") + Random.Range(10, 99);
		_strRtn += _time;
		#if DEBUG_ON
			Debug.Log("_time:" + _time);
		#endif

		//5. summar
		#if DEBUG_ON
			Debug.Log("o:[" + _strRtn+"]");
		#endif

		System.Text.UTF8Encoding _encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = _encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 1; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else{
				_tmp += _loop;
			}
			_arr[i] = (byte)_tmp;
		}

		_strSum = "" + _sum;
		_len = _strSum.Length;
		#if DEBUG_ON
			Debug.Log("_strSumS:" + _strSum);
		#endif
		while(_len < 3){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("_strSumE:" + _strSum);
		#endif

		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("c:[" + _strRtn+"]");
		#endif

		_strRtn = _strRtn + _strSum;

		#if DEBUG_ON
			Debug.Log("d:[" + _strRtn+"]");
		#endif

		//6. dummy 3byte
		_strRtn = Random.Range(100, 999) + _strRtn;


		return _strRtn;
	}


	////////////////////////////////////////////////////////////////////////////////////////////
	public static int getInt(string _param){

		if(_param == null){
			return -1;
		}else{
			int _rtn = -1;
			try{
				_rtn = System.Convert.ToInt32(_param);
			}catch(System.FormatException e){
				//#if DEBUG_ON
					Debug.LogError("#### SSUtil getInt error("+_param+"):" + e);
				//#endif
			}
			return _rtn;
		}
	}

	public static int getInt(string _param, int _startIdx, int _len){
		if(_param == null){
			return -1;
		}else if(_param.Length < _startIdx + _len){
			return -1;
		}else{
			int _rtn = -1;
			try{
				_rtn = System.Convert.ToInt32(_param.Substring(_startIdx, _len));
			}catch(System.FormatException e){
				//#if DEBUG_ON
					Debug.LogError("#### SSUtil getInt error("+_param+"):" + e);
				//#endif
			}
			return _rtn;
		}
	}

	public static long getLong(string _param){
		if(_param == null){
			return -1;
		}else{
			long _rtn = -1;
			try{
				_rtn = System.Convert.ToInt64(_param);
			}catch(System.FormatException e){
				//#if DEBUG_ON
					Debug.LogError("#### SSUtil getInt error("+_param+"):" + e);
				//#endif
			}
			return _rtn;
		}
	}

	public static string getString(byte[] _b){
		return enc.GetString(_b);
	}

	public static bool isURL(string _url){
		_url = _url.Trim();
		if(_url.IndexOf("http://") == 0){
			return true;
		}else{
			return false;
		}
	}

	//배틀머니, 스프린트 > 값을 암호화.
	//핸드폰 번호를 암호화.
	public static string setEncode2(string _str){
		string _strRtn = "";
		string _strSum = "";
		int _len, _loop;

		//1. loop(1)
		_loop = Random.Range(1, 10);
		_strRtn += _loop;
		#if DEBUG_ON
			Debug.Log("1:[" + _strRtn+"]");
		#endif

		//2. size(3)
		_len = (_str.Length + "").Length;
		while(_len < 3){
			_strRtn += "0";
			++_len;
		}
		_strRtn += _str.Length;
		#if DEBUG_ON
			Debug.Log("2:[" + _strRtn+"]");
		#endif

		//3. data(x)
		_strRtn += _str;
		#if DEBUG_ON
			Debug.Log("3:[" + _strRtn+"]");
		#endif

		//4. empty random (1 + 3 + x + y = 20)
		_len = _strRtn.Length;
		while(_len <= 20){
			//if(_len%2 == 0){
			//	_strRtn += Random.Range(0, 10);
			//}else{
			//	_strRtn += (char)(97 + Random.Range(0, 25));
			//}
			_strRtn += Random.Range(0, 10);
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif

		//5. data mix
		System.Text.UTF8Encoding _encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = _encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 1; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else{
				_tmp += _loop;
			}
			_arr[i] = (byte)_tmp;
		}

		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("5:[" + _strRtn+"]");
		#endif

		//6. sum(3)
		_strSum = "" + _sum;
		_len = _strSum.Length;
		while(_len < 3){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("_strSum:" + _strSum);
		#endif

		_strRtn = _strRtn + _strSum;
		/**/

		return _strRtn;
	}

	//배틀기탐 정보.
	public static string setEncode3(string _str){
		string _strRtn = "";
		string _strSum = "";
		int _len, _loop;

		//1. loop(1)
		_loop = Random.Range(1, 10);
		_strRtn += _loop;
		#if DEBUG_ON
			Debug.Log("1:[" + _strRtn+"]");
		#endif

		//2. size(3)
		_len = (_str.Length + "").Length;
		while(_len < 3){
			_strRtn += "0";
			++_len;
		}
		_strRtn += _str.Length;
		#if DEBUG_ON
			Debug.Log("2:[" + _strRtn+"]");
		#endif

		//3. data(x)
		_strRtn += _str;
		#if DEBUG_ON
			Debug.Log("3:[" + _strRtn+"]");
		#endif

		//4. empty random (1 + 3 + x + y = 20)
		_len = _strRtn.Length;
		while(_len <= 10){
			//if(_len%2 == 0){
			//	_strRtn += Random.Range(0, 10);
			//}else{
			//	_strRtn += (char)(97 + Random.Range(0, 25));
			//}
			_strRtn += Random.Range(0, 10);
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif

		//5. data mix
		System.Text.UTF8Encoding _encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = _encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 1; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else{
				_tmp += _loop;
			}
			_arr[i] = (byte)_tmp;
		}

		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("5:[" + _strRtn+"]");
		#endif

		//6. sum(3)
		_strSum = "" + _sum;
		_len = _strSum.Length;
		while(_len < 3){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("_strSum:" + _strSum);
		#endif

		_strRtn = _strRtn + _strSum;
		/**/

		return _strRtn;
	}

	//배틀기탐 정보.
	public static string setEncode4(string _str){
		string _strRtn = "";
		string _strSum = "";
		int _len, _loop;

		//1. loop(1)
		_loop = Random.Range(1, 10);
		_strRtn += _loop;
		#if DEBUG_ON
			Debug.Log("1:[" + _strRtn+"]");
		#endif

		//2. size(3)
		_len = (_str.Length + "").Length;
		while(_len < 3){
			_strRtn += "0";
			++_len;
		}
		_strRtn += _str.Length;
		#if DEBUG_ON
			Debug.Log("2:[" + _strRtn+"]");
		#endif

		//3. data(x)
		_strRtn += _str;
		#if DEBUG_ON
			Debug.Log("3:[" + _strRtn+"]");
		#endif

		//4. empty random (1 + 3 + x + y = 20)
		_len = _strRtn.Length;
		while(_len <= 10){
			//if(_len%2 == 0){
			//	_strRtn += Random.Range(0, 10);
			//}else{
			//	_strRtn += (char)(97 + Random.Range(0, 25));
			//}
			_strRtn += Random.Range(0, 10);
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif


		//4. current date.
		string _time = System.DateTime.Now.ToString("yyyyMMddhhmmss");
		_strRtn += _time;
		#if DEBUG_ON
			Debug.Log("_time:" + _time);
		#endif

		//5. data mix
		System.Text.UTF8Encoding _encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = _encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 1; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else{
				_tmp += _loop;
			}
			_arr[i] = (byte)_tmp;
		}

		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("5:[" + _strRtn+"]");
		#endif

		//6. sum(3)
		_strSum = "" + _sum;
		_len = _strSum.Length;
		while(_len < 3){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("_strSum:" + _strSum);
		#endif

		_strRtn = _strRtn + _strSum;
		/**/

		return _strRtn;
	}

	//sms sendkey.
	//phone > phone + day > encoding
	//
	public static string setEncode5(string _str){
		string _strRtn = "";
		string _strSum = "";
		int _len, _loop;

		//1. loop(1)
		_loop = Random.Range(1, 10);
		_strRtn += _loop;
		#if DEBUG_ON
			Debug.Log("1:[" + _strRtn+"]");
		#endif

		//2. size(3)
		_len = (_str.Length + "").Length;
		while(_len < 4){
			_strRtn += "0";
			++_len;
		}
		_strRtn += _str.Length;
		#if DEBUG_ON
			Debug.Log("2:[" + _strRtn+"]");
		#endif

		//3. data(x)
		_strRtn += _str;
		#if DEBUG_ON
			Debug.Log("3:[" + _strRtn+"]");
		#endif

		//4. empty random (1 + 3 + x + y = 20)
		_len = _strRtn.Length;
		while(_len <= 16){
			//if(_len%2 == 0){
			//	_strRtn += Random.Range(0, 10);
			//}else{
			//	_strRtn += (char)(97 + Random.Range(0, 25));
			//}
			_strRtn += Random.Range(0, 10);
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif


		//4. current date.
		string _time = System.DateTime.Now.ToString("yyyyMMddhhmmss");
		_strRtn += _time;
		#if DEBUG_ON
			Debug.Log("_time:" + _time);
		#endif

		//5. data mix
		System.Text.UTF8Encoding _encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = _encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 1; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else{
				_tmp += _loop;
			}
			_arr[i] = (byte)_tmp;
		}

		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("5:[" + _strRtn+"]");
		#endif

		//6. sum(3)
		_strSum = "" + _sum;
		_len = _strSum.Length;
		while(_len < 4){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("_strSum:" + _strSum);
		#endif

		_strRtn = _strRtn + _strSum;
		/**/

		return _strRtn;
	}


	//sms sendkey.
	//phone > phone + day > encoding
	public static string setEncode6(string _str){
		string _strRtn = "";
		string _strSum = "";
		int _len, _loop, _loop1, _loop2;
		int _key = Random.Range(1000, 3333);

		//1. loop(1)
		_loop = Random.Range(1, 10);
		_loop1 = Random.Range(1, 10);
		_loop2 = Random.Range(1, 10);
		_strRtn += _loop1;
		_strRtn += _loop2;
		_strRtn += Random.Range(1, 10);
		_strRtn += Random.Range(1, 10);
		#if DEBUG_ON
			Debug.Log("1:[" + _strRtn+"]");
		#endif

		//2. size(3)
		_len = (_str.Length + "").Length;
		while(_len < 4){
			_strRtn += "0";
			++_len;
		}
		_strRtn += _str.Length;
		#if DEBUG_ON
			Debug.Log("2:[" + _strRtn+"]");
		#endif

		//3. 랜덤키.
		_strRtn += _key;
		#if DEBUG_ON
			Debug.Log("3:[" + _strRtn+"]");
		#endif

		//4. data(x)
		_strRtn += _str;
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif

		//4. empty random (1 + 3 + x + y = 20)
		_len = _strRtn.Length;
		while(_len < (12+20)){
			//if(_len%2 == 0){
			//	_strRtn += Random.Range(0, 10);
			//}else{
			//	_strRtn += (char)(97 + Random.Range(0, 25));
			//}
			_strRtn += Random.Range(0, 10);
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif

		//5. 랜덤키.
		_strRtn += (_key*2);
		#if DEBUG_ON
			Debug.Log("5:[" + _strRtn+"]");
		#endif


		//6. current date.
		string _time = System.DateTime.Now.ToString("yyyyMMddhhmmss");
		_strRtn += _time;
		#if DEBUG_ON
			Debug.Log("6:[" + _time+"]");
			Debug.Log("6:[" + _strRtn+"]");
		#endif


		//7. data mix
		System.Text.UTF8Encoding _encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = _encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 4; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_loop = (i%2 == 0)?_loop1:_loop2;

			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else{
				_tmp += _loop;
			}
			_arr[i] = (byte)_tmp;
		}

		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("7:[" + _strRtn+"]");
		#endif

		//8. sum(4)
		_strSum = "" + _sum;
		_len = _strSum.Length;
		while(_len < 4){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("8 _strSum:" + _strSum);
		#endif
		_strRtn = _strRtn + _strSum;
		#if DEBUG_ON
			Debug.Log("9:" + _strRtn);
		#endif

		//10. 랜덤키.
		_strRtn += (_key*3);
		#if DEBUG_ON
			Debug.Log("10:" + _strRtn);
		#endif
		/**/

		return _strRtn;
	}


	public static string getCheckPhoneNum(string _str){
		return _str.Replace("+82", "0");
	}


	//3. 시간차 구하기.
	// 어떤 시간이 넣으면 현재 시간을 지나갔는가?
	// true 	: 지정 시간지남.	> 일반모드.
	//false 	: 아직 시간남음. 	> x2모드.
	public static bool isPassedDate(string _strStartDate){
		System.DateTime _dtPoint = System.DateTime.Parse(_strStartDate);
		System.DateTime _dtNow = System.DateTime.Now;
		System.TimeSpan _sp = _dtNow - _dtPoint;

		return _sp.Milliseconds < 0 ? true : false;
	}

	public static int getRandom(int _start, int _end){
		return Random.Range(_start, _end);
	}

	/*
	//전화번호:이동거리(m):성수개수:자석보유:바나나개수:에너지음료:군두운대여:신발단계:깃털단계:사신거리: > encoding
	public static string setEncode7(string _str){
		string _strRtn = "";
		string _strSum = "";
		int _len, _loop, _loop1, _loop2;
		int _key = Random.Range(1000, 3333);

		//1. loop(1)
		_loop = Random.Range(1, 10);
		_loop1 = Random.Range(1, 10);
		_loop2 = Random.Range(1, 10);
		_strRtn += _loop1;
		_strRtn += _loop2;
		_strRtn += Random.Range(1, 10);
		_strRtn += Random.Range(1, 10);
		#if DEBUG_ON
			Debug.Log("1:[" + _strRtn+"]");
		#endif

		//2. size(3)
		_len = (_str.Length + "").Length;
		while(_len < 4){
			_strRtn += "0";
			++_len;
		}
		_strRtn += _str.Length;
		#if DEBUG_ON
			Debug.Log("2:[" + _strRtn+"]");
		#endif

		//3. 랜덤키.
		_strRtn += _key;
		#if DEBUG_ON
			Debug.Log("3:[" + _strRtn+"]");
		#endif

		//4. data(x)
		_strRtn += _str;
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif

		//5. 랜덤키.
		_strRtn += (_key*2);
		#if DEBUG_ON
			Debug.Log("5:[" + _strRtn+"]");
		#endif

		//6. current date.
		string _time = System.DateTime.Now.ToString("yyyyMMddhhmmss");
		_strRtn += _time;
		#if DEBUG_ON
			Debug.Log("6:[" + _time+"]");
			Debug.Log("6:[" + _strRtn+"]");
		#endif


		//7. data mix
		System.Text.UTF8Encoding _encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = _encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 4; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_loop = (i%2 == 0)?_loop1:_loop2;

			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else if(_tmp == 64){
				_tmp = Random.Range(58, 62+1);
			}
			_arr[i] = (byte)_tmp;
		}

		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("7:[" + _strRtn+"]");
		#endif

		//8. sum(4)
		_strSum = "" + _sum;
		_len = _strSum.Length;
		while(_len < 4){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("8 _strSum:" + _strSum);
		#endif
		_strRtn = _strRtn + _strSum;
		#if DEBUG_ON
			Debug.Log("9:" + _strRtn);
		#endif

		//10. 랜덤키.
		_strRtn += (_key*3);
		#if DEBUG_ON
			Debug.Log("_key3:" + (_key*3));
		#endif

		return _strRtn;
	}

	public static string getDecode7(string _str){
		string _strRtn = "";
		//string _strSum = "";
		int _len, _loop, _loop1, _loop2;
		int _key, _key2, _key3;
		int _idx = 0;
		byte _sum = 0, _sum2 = 0;

		//1. loop(1)
		_loop1 = getInt(_str, _idx    , 1);
		_loop2 = getInt(_str, _idx + 1, 1);
		_idx += 4;
		#if DEBUG_ON
			Debug.Log("_loop1:" + _loop1 + ", _loop2:" + _loop2);
		#endif


		//7. data mix
		System.Text.UTF8Encoding _encoding = new System.Text.UTF8Encoding();
		_len = _str.Length - 8;
    	byte[] _arr = _encoding.GetBytes(_str);
		int _tmp;
		for(int i = 4; i < _len; i++){
			_loop = (i%2 == 0)?_loop1:_loop2;

			_tmp = (int)_arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp -= _loop;
				if(_tmp < 48)_tmp += 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp -= _loop;
				if(_tmp < 65)_tmp += 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp -= _loop;
				if(_tmp < 97)_tmp += 26;
			}else if(_tmp >= 58 && _tmp <= 62){
				_tmp = 64;
			}
			_arr[i] = (byte)_tmp;
			_sum += _arr[i];
		}

		_str = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("_str:" + _str);
		#endif

		//2. size(3)
		_len = getInt(_str, _idx, 4);
		_idx += 4;
		#if DEBUG_ON
			Debug.Log("_len:" + _len);
		#endif

		//3. 랜덤키.
		_key = getInt(_str, _idx, 4);
		_idx += 4;
		#if DEBUG_ON
			Debug.Log("_key:" + _key);
		#endif

		//4. data(x)
		_strRtn = _str.Substring(_idx, _len);
		_idx += _len;
		#if DEBUG_ON
			Debug.Log("4:[" + _strRtn+"]");
		#endif

		//5. 랜덤키.
		_key2 = getInt(_str, _idx, 4);
		_idx += 4;
		#if DEBUG_ON
			Debug.Log("_key2:" + _key2);
		#endif

		//6. current date.
		_idx += 14;
		//string _time = System.DateTime.Now.ToString("yyyyMMddhhmmss");
		//_strRtn += _time;
		//#if DEBUG_ON
		//	Debug.Log("6:[" + _time+"]");
		//	Debug.Log("6:[" + _strRtn+"]");
		//#endif

		//8. sum(4)
		_sum2 = (byte)getInt(_str, _idx, 4);
		_idx += 4;
		#if DEBUG_ON
			Debug.Log("_sum2:" + _sum2);
		#endif

		//10. 랜덤키.
		_key3 = getInt(_str, _idx, 4);
		_idx += 4;
		#if DEBUG_ON
			Debug.Log("_key3:" + _key3);
		#endif

		if(_sum != _sum2 || _key != _key2/2 || _key != _key3/3){
			return "-1";
		}else{
			return _strRtn;
		}
	}
	/**/
}

