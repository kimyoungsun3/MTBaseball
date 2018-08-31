#define DEBUG_ON
using UnityEngine;
using System.Collections;
using System.Xml;
//using System;
//using System.Collections.Generic ;
//using System.IO ;
//using System.Text;

public class XmlParserTest2 : MonoBehaviour {
	private SSParser parserHelp = new SSParser();
	private SSParser parserMini = new SSParser();
	private SSParser parser = new SSParser();
	#if DEBUG_ON
		private string strItem;
	#endif
	
	void Awake(){
		/*
		//help
		strItem = SSUtil.load("txt/help");
		parserHelp.parsing(strItem, "row");
		
		//1. 직접지정방식.
		Debug.Log(parserHelp.getStringRow(0, "title"));
		Debug.Log(parserHelp.getStringRow(1, "title"));
		Debug.Log(parserHelp.getStringNext("title"));
		
		//2. 있는 만큼 빼기.
		while(parserHelp.next()){
			Debug.Log(parserHelp.getString("title"));
		}
		
		//mini help
		strItem = SSUtil.load("txt/help2");		
		parserMini.parsing(strItem, "row");	
		while(parserMini.next()){
			Debug.Log(parserMini.getString("content"));
		}
		/**/
		
		//iteminfo
		strItem = SSUtil.load("txt/iteminfo");
		
		parser.parsing(strItem, "animal");
		while(parser.next()){
			Debug.Log(
			          " itemcode:" + parser.getString("itemcode")
			          + " category:" + parser.getString("category")
			          + " equpslot:" + parser.getString("equpslot")
			          + " itemname:" + parser.getString("itemname")
			          + " activate:" + parser.getString("activate")
			          + " toplist:" + parser.getString("toplist")
			          + " grade:" + parser.getString("grade")
			          + " discount:" + parser.getString("discount"));
		}
		
		//gameinfo
		
		strItem = SSUtil.load("txt/gameinfo");
		
		parser.parsing(strItem, "dealer");
		while(parser.next()){
			Debug.Log(
			          " dealercode:" + parser.getString("dealercode")
			          + " selectlv:" + parser.getString("selectlv")
			          + " dealername:" + parser.getString("dealername")
			          + " disalv:" + parser.getString("disalv")
			          + " basefresh:" + parser.getString("basefresh")
			          + " baseexchange:" + parser.getString("baseexchange")
			          );
		}
		
		parser.parsing(strItem, "color");
		parser.parsing(strItem, "gradename");
	}
	
	void Update(){}
}
