using UnityEngine;
using System.Collections;

public class DataGiftItem {
	public int 		idx;
	public int 		giftkind;		//메시지(1)		Protocol.GIFTLIST_GIFT_KIND_MESSAGE
									//선물(2)		Protocol.GIFTLIST_GIFT_KIND_GIFT
	public string	message;
	public int 		itemcode;
	public long		cnt;
	public string 	giftdate;
	public string 	giftid;
}
