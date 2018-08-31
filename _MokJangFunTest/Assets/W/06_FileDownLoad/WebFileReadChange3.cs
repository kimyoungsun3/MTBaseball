using UnityEngine;
using System.Collections;
using System;
using System.IO;

public class WebFileReadChange3: MonoBehaviour {
	string strFileName, strURL;
	
	void Start(){
		
		//strFileName = "/fridays.jpg";
		//strURL = "http://images.earthcam.com/ec_metros/ourcams" + strFileName;
			
		strFileName = "/unity-icon.jpg";
		strURL = "http://info.unity3d.com/rs/unity3d/images" + strFileName;
	}
	
	void OnGUI (){
		int _sx = 5, _dx = 150;
		int _py = 10, _dy = 40;
		string _str;
		Rect _r;
		
		//디버그화면 출력하기.
		if (GUI.Button (new Rect (_sx, _py, _dx, _dy), "Read/Web")) {
			StartCoroutine(readFile(strURL, strFileName));
		}
		_py += _dy;
	}
		
	
	public IEnumerator readFile(string _strURL, string _strFileName){
		string _strPath = Application.persistentDataPath;
		//string _strPathFile = Application.persistentDataPath + _strFileName;
		string _strPathFile = Application.persistentDataPath + _strFileName;
		//WWW _w = null;
		
		Debug.Log("1:"
		          + " _strURL:" + _strURL
		          + " _strFileName:" + _strFileName
		          + " _strPath:" + _strPath
		          + " _strPathFile:" + _strPathFile);
		//_strURL:http://images.earthcam.com/ec_metros/ourcams/fridays.jpg 
		//_strFileName:/fridays.jpg 
		//_strPath:C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler 
		//_strPathFile:C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler/fridays.jpg
		
		//1. 폴더가 존재하는가?.
		if (!System.IO.Directory.Exists(_strPath)){
			Debug.Log("21:folder create");
			System.IO.Directory.CreateDirectory(_strPath);
		}else{
			Debug.Log("22:folder exists");
		}
		
		//2. 로컬에 파일이 존재하는가?.
		if (!System.IO.File.Exists(_strPathFile)){ 
			//1-2. 파일이 존재안함.
			Debug.Log("31:file not exists > web file down:" + _strURL);
			//http://images.earthcam.com/ec_metros/ourcams/fridays.jpg
			WWW _w = new WWW(_strURL);
			Debug.Log("32:web download wait");
			yield return _w;
			Debug.Log("_w:" + _w.bytes.Length);
			Debug.Log("33: > " + _w.error);
			Debug.Log("_w:" + _w.bytes.Length);
			
			if( _w.error == null ){
				Debug.Log("34: download ok and save > try");
				Debug.Log("_strPathFile:" + _strPathFile);
				System.IO.FileStream _fs = new System.IO.FileStream(_strPathFile, System.IO.FileMode.Create);
				Debug.Log("342:");
				_fs.Write(_w.bytes, 0, _w.bytes.Length); 
				Debug.Log("343:");
				_fs.Close();
				Debug.Log("35: save > ok");
			}
			
			//3. www종료.
			if(_w != null){
				Debug.Log("36: www dispose");
				_w.Dispose();
				_w = null;
			}
        }
		
		//3. 파일 읽기.
		if(System.IO.File.Exists(_strPathFile)){
			Debug.Log("41: file read try");
			//_w = new WWW("file://" + _strPathFile);
			//_w = new WWW(_strPathFile);
			//_w = new WWW(_strFileName);
			
			Debug.Log(Application.persistentDataPath);
			Debug.Log(Application.dataPath);
			
			string _sss;
			#if UNITY_EDITOR
				//PC, Editor
				_sss = "file://c://" + Application.persistentDataPath + _strFileName;
			#elif UNITY_ANDROID || UNITY_IPHONE
				_sss = "file://" + Application.persistentDataPath + _strFileName;
			#elif UNITY_WEBPLAYER
				_sss = _strURL;
			#else 
				_sss = "file://c://" + Application.persistentDataPath + _strFileName;
			#endif
						
			Debug.Log(_sss);
			WWW _w = new WWW(_sss);
			Debug.Log("42:");
			yield return _w;
			Debug.Log("43: > _w:" + _w.text);
			Debug.Log("43: > _w:" + _w.bytes);
			Debug.Log("43: > _w:" + _w.error);
			Debug.Log("43: > _w:" + _w.texture);
			//Debug.Log("43: > _w:" + _w.movie);	//모바일에서는 지원안함.
			Debug.Log("43: > _w:" + _w.isDone);
			Debug.Log("43: > _w:" + _w.progress);
			Debug.Log("43: > _w:" + _w.uploadProgress);
			Debug.Log("43: > _w:" + _w.url);
			//PC
			//file://c://C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler/fridays.jpg
			//Debug.Log("43: > _w:" + _w.assetBundle);
			Debug.Log("43: > _w:" + _w.threadPriority);
			
			if(_w != null){
				
				Debug.Log("51:material setting");
				Debug.Log("_w:" + _w.bytes.Length);
				//오디오 일경우. 
				//audio.clip = _w.audioClip;
				
				//텍스쳐일 경우.
				renderer.material.mainTexture = _w.texture;	
				Debug.Log("52:");
			}
		}
	}
}
