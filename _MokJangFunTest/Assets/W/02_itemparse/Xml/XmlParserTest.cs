#define DEBUG_ON
using UnityEngine;
using System.Collections;
using System.Xml;
//using System;
//using System.Collections.Generic ;
//using System.IO ;
//using System.Text;

public class XmlParserTest : MonoBehaviour {
	private SSParser parser = new SSParser();
	#if DEBUG_ON
		private string strItem;
		private string text = "", text2 = "", text3 = "";
		public GUISkin skin;
		private string strTest = "<?xml version=\"1.0\" encoding=\"utf-8\"?><rows><equipment><resultcode>1111</resultcode></equipment></rows>";
	#endif
	
	void Awake(){
		//read item info and setting 		
		strItem = SSUtil.load("txt/iteminfo");		
		
		//iteminfo
		text += "[ItemInfo file equipment]\n";		
		parser.parsing(strItem, "equipment");		
		while(parser.next()){
			text += parser.getInt("itemcode")
			          +":"+ parser.getInt("kind")
			          //+":"+ parser.getInt("sex")
			          +":"+ parser.getString("name")
			          //+":"+ parser.getInt("setcode")
			          //+":"+ parser.getString("filename")
			          //+":"+ parser.getString("color")
			          +":"+ parser.getInt("iconindex")
			          +":"+ parser.getInt("power")
			          +":"+ parser.getFloat("degree")
			          //+":"+ parser.getInt("pitcherhp")
			          //+":"+ parser.getInt("period")
			          //+":"+ parser.getInt("setpower")
			          //+":"+ parser.getFloat("setdegree")
			          +":"+ parser.getInt("setpitcherhp")
			          +":"+ parser.getInt("silverball")
			          //+":"+ parser.getInt("goldball")
			          //+":"+ parser.getInt("soulball")
			          //+":"+ parser.getString("description")
					  + "\n"
					  ;
		}
		
		text += "\n[ItemInfo file stadium]\n";
		parser.parsing("stadium");
		while(parser.next()){
			text += parser.getInt("itemcode")
			          +":"+ parser.getInt("kind")
			          //+":"+ parser.getInt("sex")
			          +":"+ parser.getString("name")
					  + "\n"
					  ;
		}
		
		parser.parsing("upgrade");
		parser.parsing("ballnode");
		parser.parsing("actmax");
		parser.parsing("actcount");
		parser.parsing("potion");
		parser.parsing("emblem");
		parser.parsing("trailitem");
		
		
		//서버에서 받은 데이타가지고 필터하기 
		text += "\n[Web read]\n";
		parser.parsing(strTest, "equipment");		
		while(parser.next()){
			text += parser.getInt("resultcode22")
					  + "\n"
					  ;
		}
		text2 = text;
		
	}
	
	int nStep = 0;
	void Update(){
		if(bPause)return;
		switch(nStep){
			case 0:
				strItem = SSUtil.load("txt/iteminfo");		
				break;
			default:
				{
					int idx = 0;
					float[] _t = new float[10];
					
					_t[idx++] = Time.realtimeSinceStartup;
					parser.parsing(strItem, "equipment");			
					_t[idx++] = Time.realtimeSinceStartup;			
					parser.parsing("upgrade");
					_t[idx++] = Time.realtimeSinceStartup;
					parser.parsing("ballnode");
					_t[idx++] = Time.realtimeSinceStartup;
					parser.parsing("actmax");
					_t[idx++] = Time.realtimeSinceStartup;
					parser.parsing("actcount");
					_t[idx++] = Time.realtimeSinceStartup;
					parser.parsing("potion");
					_t[idx++] = Time.realtimeSinceStartup;
					parser.parsing("emblem");
					_t[idx++] = Time.realtimeSinceStartup;
					//Debug.Log("1:" + Time.realtimeSinceStartup);
					//for(int i = 0; i < 100000000; i++);
					//Debug.Log("2:" + Time.realtimeSinceStartup);
					parser.parsing("trailitem");
					_t[idx++] = Time.realtimeSinceStartup;
			
					text3 = "\n";
					for(int i = 1; i < idx; i++){
						//Debug.Log("["+i+"]:" + _t[i] + ":" + _t[i - 1]);
						text3 += "["+i+"]:"+ _t[i] + ":" + _t[i - 1] + " >" + (_t[i] - _t[i-1]) + "\n";
					}
				}
				break;
		}
		
		text = text2 + text3;
		nStep++;
	}
	
	bool bPause = false;
	void OnGUI(){
	    GUILayout.Label(text, skin.label);
		if(GUI.Button(new Rect(Screen.width - 100, 10, 100, 50), "Pause")){
			bPause = !bPause;
		}
	}
}
