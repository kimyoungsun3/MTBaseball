#define DEBUG_ON
using UnityEngine;
using System.Collections;
using System.Xml;

public class XmlParserTest2 : MonoBehaviour {
	IEnumerator Start(){
		//------------------------------------
		Debug.Log ("#### xml parsing");
		yield return StartCoroutine ( ItemInfo.Co_Init () );
		yield return null;

		//-----------------------------------
		Debug.Log ("#### data search");
		CheckWearPart (105);	//티타늄 헬멧(장착템만 Parsing들어가 있다).
		CheckWearPart (4009);	//존재 안함...

		//-----------------------------------
		Debug.Log ("#### data loop");
		int count = 0;
		foreach (ItemInfo_WearPart _data in ItemInfo.dic_wearPart.Values) {
			Debug.Log(_data.itemCode + " > " + _data.itemname);
			if (count++ > 5)
				break;
		}
	}

	void CheckWearPart(int _itemcode){
		if (ItemInfo.dic_wearPart.ContainsKey (_itemcode)) {
			ItemInfo_WearPart _d = ItemInfo.dic_wearPart [_itemcode];
			Debug.Log (_d.itemCode + " > " + _d.itemname);
		} else {
			Debug.LogWarning (_itemcode + " > Not Found");
		}
	}
}
