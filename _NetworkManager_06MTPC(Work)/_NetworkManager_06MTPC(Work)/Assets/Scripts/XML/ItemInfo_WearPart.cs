using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemInfo_WearPart {
	public int itemCode;
	public int category;
	public int subcategory;
	public int equpslot;
	public string itemname;
	public bool active;
	public int grade;
	public string icon;

	public long cashcost;
	public long buyamount;
	public string description;
	public float expincrease{
		get {
			return expincrease100 / 100f;
		}
	}
	public int expincrease100;
	public int setcode;

	//public static string GetErrMsg ( ResultCheckCondition _result )
	//{
	//}

	//public ResultCheckCondition CheckCondition ( Dictionary < int , SafeLong > _dicProduct )
	//{
	//}
}
