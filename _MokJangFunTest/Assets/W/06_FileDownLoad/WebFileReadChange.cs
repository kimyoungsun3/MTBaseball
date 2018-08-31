using UnityEngine;
using System.Collections;
using System;
using System.IO;

public class WebFileReadChange : MonoBehaviour {
	public string url = "http://images.earthcam.com/ec_metros/ourcams/fridays.jpg";

	IEnumerator Start(){
		//설정을 바꿔둬야한다.
		//File > Build Settings > Player setting > Other Settings > Write Access > External(SDCard)
		//그래야만이 설정을 바꿔준다.
		Debug.Log("web loading");
		WWW _w = new WWW(url);
		yield return _w;
		Debug.Log(" > change texture");
		renderer.material.mainTexture = _w.texture;
		
		Debug.Log("root:" + Application.persistentDataPath);		
 		string path = Application.persistentDataPath + "/ttt"; 
		string file = "/fridays.jpg";
		
  		if (!File.Exists(path + file)){ 
            Directory.CreateDirectory(path); 
        }   
        
		FileStream fs = new FileStream(path + file, FileMode.Create); 
		fs.Write(_w.bytes, 0, _w.bytes.Length); 
		fs.Close(); // fileStream 종료
		/**/
	}
	
	void Update(){
		float _lr = Input.GetAxis("Horizontal");
		float _move = Input.GetAxis("Vertical");
		transform.Rotate(new Vector3(0, _lr, 0));
		transform.Translate(new Vector3(0, 0, _move));
	}
}
