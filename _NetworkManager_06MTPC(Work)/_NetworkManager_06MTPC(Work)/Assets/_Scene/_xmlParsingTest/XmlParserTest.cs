#define DEBUG_ON
using UnityEngine;
using System.Collections;
using System.Xml;

public class XmlParserTest : MonoBehaviour {
	private SSParser parserItemInfo = new SSParser();
	private SSParser parserGameInfo = new SSParser();
	private SSParser parserToolTip = new SSParser();
	private SSParser parserServer = new SSParser();
	private string strFileData;
	private string text = "";
	private string strServerData = 
		"<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
			"<rows>" +
				"<equipment>" +
					"<resultcode>" +
						"1111" +
					"</resultcode>" +
				"</equipment>" +
			"</rows>";

	void Start(){
		//-----------------------------------------
		//ItemInfo Read
		//read item info and setting 		
		// 1. 처음 xml으면 파서에 넣어준후에 파싱하면된다.
		//    strItemInfo = SSUtil.load("txt/iteminfo");	
		//    parserItemInfo.parsing(strItemInfo, "wearpart");		
		// 2. 두번째 파트는 파트 이름만 넣어준면된다.
		//    parserItemInfo.parsing("piecepart");
		//    parserItemInfo.parsing("advicebox");
		//    parserItemInfo.parsing("wearbox");
		//    parserItemInfo.parsing("piecebox");
		//-----------------------------------------
		text = "[ItemInfo file]\n";	

		strFileData = SSUtil.load("txt/iteminfo");		
		parserItemInfo.parsing(strFileData, "wearpart");		
		while(parserItemInfo.next()){
			text += parserItemInfo.getInt("itemcode")
				+":"+ parserItemInfo.getInt("category")
				+":"+ parserItemInfo.getInt("subcategory")
				+":"+ parserItemInfo.getString("itemname")
				+":"+ parserItemInfo.getInt("activate")
				+":"+ parserItemInfo.getString("description")
				+":"+ parserItemInfo.getInt("setcode")
				+ "\n";
		}
		Debug.Log (text);	

		text = "";
		parserItemInfo.parsing("piecepart");
		while(parserItemInfo.next()){
			text += parserItemInfo.getInt("itemcode")
				+":"+ parserItemInfo.getInt("category")				
				+":"+ parserItemInfo.getInt("subcategory")
				+":"+ parserItemInfo.getString("itemname")
				+":"+ parserItemInfo.getInt("activate")
				+":"+ parserItemInfo.getString("description")
				+ "\n";
		}
		Debug.Log (text);	

		text = "";
		parserItemInfo.parsing("piecebox");
		while(parserItemInfo.next()){
			text += parserItemInfo.getInt("itemcode")
				+":"+ parserItemInfo.getInt("category")				
				+":"+ parserItemInfo.getInt("subcategory")
				+":"+ parserItemInfo.getString("itemname")
				+":"+ parserItemInfo.getInt("activate")
				+":"+ parserItemInfo.getString("description")
				+":"+ parserItemInfo.getInt("additemcode")
				+ "\n";
		}
		Debug.Log (text);	

		//-----------------------------------------
		//gameinfo Read
		// 1. 처음 xml으면 파서에 넣어준후에 파싱하면된다.
		//    strFileData = SSUtil.load("txt/gameinfo");	
		//    parserGameInfo.parsing(strFileData, "dealinfo");		
		// 2. 두번째 파트는 파트 이름만 넣어준면된다.
		//    parserGameInfo.parsing("color");
		//    parserGameInfo.parsing("stbody");
		//-----------------------------------------
		text = "[gameinfo]\n";

		strFileData = SSUtil.load("txt/gameinfo");	
		parserGameInfo.parsing(strFileData, "dealinfo");	
		while(parserGameInfo.next()){
			text += parserGameInfo.getInt("syscode")
				+":"+ parserGameInfo.getInt("fameofdealok")				
				+":"+ parserGameInfo.getInt("fameofbarrelfail")
				+ "\n";
		}
		Debug.Log (text);	

		text = "";
		parserGameInfo.parsing("color");	
		while(parserGameInfo.next()){
			text += parserGameInfo.getInt("syscode")
				+":"+ parserGameInfo.getInt("colorcode")				
				+":"+ parserGameInfo.getInt("r")			
				+":"+ parserGameInfo.getInt("g")			
				+":"+ parserGameInfo.getInt("b")
				+ "\n";
		}
		Debug.Log (text);	

		//-----------------------------------------
		//tooltip Read
		// 1. 처음 xml으면 파서에 넣어준후에 파싱하면된다.
		//    strFileData = SSUtil.load("txt/tooltip");	
		//    parserToolTip.parsing(strFileData, "tooltip");		
		// 2. 두번째 파트는 파트 이름만 넣어준면된다. 없어서 패스...
		//-----------------------------------------
		text = "[tooltip]\n";

		strFileData = SSUtil.load("txt/tooltip");	
		parserToolTip.parsing(strFileData, "tooltip");	
		while(parserToolTip.next()){
			text += parserToolTip.getInt("count")
				+":"+ parserToolTip.getString("tip")
				+ "\n";
		}
		Debug.Log (text);		
				

		//-----------------------------------------
		//서버에서 받은 데이타가지고 필터하기 
		//-----------------------------------------
		text = "[Web read]\n";
		parserServer.parsing(strServerData, "equipment");		
		while(parserServer.next()){
			text += parserServer.getInt("resultcode")
					  + "\n";
		}	
		Debug.Log (text);
	}
}
