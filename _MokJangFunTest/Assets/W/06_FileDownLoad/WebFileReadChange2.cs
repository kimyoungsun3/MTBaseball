using UnityEngine;
using System.Collections;
using System;
using System.IO;

public class WebFileReadChange2: MonoBehaviour {
	void OnGUI (){
		int _sx = 5, _dx = 150;
		int _py = 10, _dy = 40;
		string _str;
		Rect _r;
		
		//디버그화면 출력하기.
		if (GUI.Button (new Rect (_sx, _py, _dx, _dy), "Read/Web")) {
			StartCoroutine(downloadFile());
		}
		_py += _dy;
	}
		
	
	IEnumerator downloadFile(){
		string _strURL = "http://images.earthcam.com/ec_metros/ourcams/fridays.jpg";
		string _strPath = Application.persistentDataPath;
		string _strFileName = "/fridays.jpg";
		Debug.Log("1");
		Debug.Log("_strURL:" + _strURL);
		//http://images.earthcam.com/ec_metros/ourcams/fridays.jpg
		WWW _w = new WWW(_strURL);
		Debug.Log("2");
		yield return _w;
		Debug.Log("3:"+_strPath);
		//C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler
		
		//1. 폴더가 존재하는가?.
		if (!System.IO.Directory.Exists(_strPath)){
			Debug.Log("41:folder create");
			System.IO.Directory.CreateDirectory(_strPath);
		}else{
			Debug.Log("42:folder exists");
		}
		
		//2. 파일이 존재하는가?.
		_strPath += _strFileName;
		Debug.Log("5:" + _strPath);
		//C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler/fridays.jpg
		if (!System.IO.File.Exists(_strPath)){ 
			Debug.Log("51:file not exists > create");
			Debug.Log("_strPath:" + _strPath);
			//C:/Documents and Settings/Administrator/Local Settings/Application Data/SangSangDigital/wwwwebhandler/fridays.jpg
			System.IO.FileStream _fs = new System.IO.FileStream(_strPath, System.IO.FileMode.Create);
			Debug.Log("52:");
			_fs.Write(_w.bytes, 0, _w.bytes.Length); 
			Debug.Log("53:");
			_fs.Close();
			Debug.Log("54:");
        }else{
			Debug.Log("52:file exists");
		}
		
		//3. www종료
		if(_w != null){
			Debug.Log("61:www dispose");
			_w.Dispose();
			Debug.Log("62:www dispose");
			_w = null;
		}
		
	}
}
