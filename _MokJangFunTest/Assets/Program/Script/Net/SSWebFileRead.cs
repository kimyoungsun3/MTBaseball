#if UNITY_EDITOR
	#define DEBGU_MODEx
#endif

using UnityEngine;
using System.Collections;
using System;
using System.IO;

public class SSWebFileRead: MonoBehaviour {
	private string strURL		= "http://210.123.107.7:40002/Game4/_ad/20121212.png";
	private Texture2D tex2D 	= null;


	#if DEBGU_MODE
	void OnGUI (){
		int _sx = 5, _dx = 150;
		int _py = 10, _dy = 40;
		string _str;
		Rect _r;

		//디버그화면 출력하기.
		if (GUI.Button (new Rect (_sx, _py, _dx, _dy), "Read/Web")) {
			StartCoroutine(readFile(strURL));
		}
		_py += _dy;
	}
	#endif

	/////////////////////////////////////////////////
	//URL를 던지면 폴더 검사후
	//없으면 > 다운로드	> 세팅.
	//있으면 > 로딩 		> 세팅.
	/////////////////////////////////////////////////
	public void setAd(string _strURL){
		#if DEBGU_MODE
			Debug.Log("setAd:" + _strURL);
		#endif
		strURL = _strURL;
		StartCoroutine(readFile(strURL));
	}

	private IEnumerator readFile(string _strURL){
		string[] _ss = _strURL.Split('/');
		string _strFileName = "/" + _ss[_ss.Length - 1];
		string _strPath = Application.persistentDataPath;
		string _strPathFile = Application.persistentDataPath + _strFileName;

		#if DEBGU_MODE
			Debug.Log("1:" + _strURL);
			Debug.Log("2:" + _strFileName);;
			Debug.Log("3:" + _strPath);
			Debug.Log("4:" + _strPathFile);
			//_strURL:http://images.earthcam.com/ec_metros/ourcams/fridays.jpg
			//_strFileName:/fridays.jpg
			//_strPath:
			//	Android
			//		sdcard/..../com/sangsangdigital/wwwfileread/file
			//	PC
			//		C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler
			//_strPathFile:C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler/fridays.jpg
		#endif

		//1. 폴더가 존재하는가?.
		#if DEBGU_MODE
			Debug.Log("10:폴더존재 유무 검사.");
		#endif
		if (!System.IO.Directory.Exists(_strPath)){
			#if DEBGU_MODE
				Debug.Log("11: 없음 > 생성.");
			#endif
			System.IO.Directory.CreateDirectory(_strPath);
		}else{
			#if DEBGU_MODE
				Debug.Log("12: 있음 > 패스.");
			#endif
		}

		//2. 로컬에 파일이 존재하는가?.
		#if DEBGU_MODE
			Debug.Log("20:로컬에 파일 존재 검사.?");
		#endif
		if (!System.IO.File.Exists(_strPathFile)){
			//////////////////////////////////////////////////
			//3-2. 파일이 존재안함 > 웹다운로드.
			//////////////////////////////////////////////////
			#if DEBGU_MODE
				Debug.Log("311: > 파일없음 > 웹다운로드. _strURL:" + _strURL);
			#endif
			WWW _w = new WWW(_strURL);
			yield return _w;
			#if DEBGU_MODE
				Debug.Log("321: > 다운완료 > _w:" + _w.bytes.Length);
				Debug.Log("322: > 다운완료 > _w:" + _w.error);
			#endif

			//////////////////////////////////////////////////
			//3-3. 정상다운로드 > 세이브하기.
			//////////////////////////////////////////////////
			if( _w.error == null ){
				#if DEBGU_MODE
					Debug.Log("331: > 정상다운, 세이브하기 > _strPathFile:" + _strPathFile);
				#endif

				System.IO.FileStream _fs = new System.IO.FileStream(_strPathFile, System.IO.FileMode.Create);
				_fs.Write(_w.bytes, 0, _w.bytes.Length);
				_fs.Close();
				#if DEBGU_MODE
					Debug.Log("332: > 세이브하기 > ok");
				#endif
			}

			//////////////////////////////////////////////////
			//3-4. www 세팅후 정리.
			//////////////////////////////////////////////////
			if(_w != null){
				#if DEBGU_MODE
					Debug.Log("341: > 이미지 광고 할당. _w:" + _w.bytes.Length);
				#endif

				//텍스쳐일 경우.
				renderer.material.mainTexture = _w.texture;

				_w.Dispose();
				_w = null;
				#if DEBGU_MODE
					Debug.Log("342: > www all clear");
				#endif
			}

		}else{
			//////////////////////////////////////////////////
			//4-2. 파일 읽기 > 경로설정.
			//////////////////////////////////////////////////
			#if DEBGU_MODE
				Debug.Log("41: > 로컬에 파일존재. > read");
				//Debug.Log(Application.persistentDataPath);	//이걸로 통일됨.
				//Debug.Log(Application.dataPath);				//번들용.
			#endif

			#if UNITY_EDITOR
				_strFileName = "file://c://" + Application.persistentDataPath + _strFileName;
				#if DEBGU_MODE
					Debug.Log("421: > UNITY_EDITOR > read:" + _strFileName);
				#endif
			#elif UNITY_ANDROID || UNITY_IPHONE
				_strFileName = "file://" + Application.persistentDataPath + _strFileName;
				#if DEBGU_MODE
					Debug.Log("422: > UNITY_ANDROID, UNITY_IPHONE > read:" + _strFileName);
				#endif
			#elif UNITY_WEBPLAYER
				_strFileName = _strURL;
				#if DEBGU_MODE
					Debug.Log("423: > UNITY_WEBPLAYER > read:" + _strFileName);
				#endif
			#else
				_strFileName = "file://c://" + Application.persistentDataPath + _strFileName;
				#if DEBGU_MODE
					Debug.Log("424: > ETC > read:" + _strFileName);
				#endif
			#endif

			//////////////////////////////////////////////////
			//4-3. 파일 읽기.
			//////////////////////////////////////////////////
			WWW _w = new WWW(_strFileName);
			yield return _w;

			#if DEBGU_MODE
				//Debug.Log("431: > _w:" + _w.text);
				Debug.Log("432: > _w:" + _w.bytes.Length);
				Debug.Log("433: > _w:" + _w.error);
				//Debug.Log("434: > _w:" + _w.texture);
				//Debug.Log("435: > _w:" + _w.movie);	//모바일에서는 지원안함.
				Debug.Log("436: > _w:" + _w.isDone);
				//Debug.Log("437: > _w:" + _w.progress);
				//Debug.Log("438: > _w:" + _w.uploadProgress);
				Debug.Log("439: > _w:" + _w.url);
				//PC
				//file://c://C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler/fridays.jpg
				//Debug.Log("43: > _w:" + _w.assetBundle);
				//Debug.Log("430: > _w:" + _w.threadPriority);
			#endif


			//////////////////////////////////////////////////
			//4-4. www 세팅후 정리.
			//////////////////////////////////////////////////
			if(_w != null){
				#if DEBGU_MODE
					Debug.Log("441: > material setting _w:" + _w.bytes.Length);
				#endif

				//텍스쳐일 경우.
				renderer.material.mainTexture = _w.texture;

				_w.Dispose();
				_w = null;
				#if DEBGU_MODE
					Debug.Log("442: > www all clear");
				#endif
			}
		}
	}
}
