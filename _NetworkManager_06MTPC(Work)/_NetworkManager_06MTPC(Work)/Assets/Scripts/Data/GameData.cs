using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class GameData {

	#region etc
	public static string 	pathUrl = "";
	public static string 	recurl = "";
	public static int 		lastBuyCashCode = 0;
	#endregion


	#region 선물 정보 읽기.
	public static List < DataGiftItem > listGiftItem = new List<DataGiftItem> ();
	public static void ReadGiftItem ( SSParser _parser , string _xml , string _target )
	{
		DataGiftItem _data = null;
		listGiftItem = new List<DataGiftItem> ();

		_parser.parsing(_xml, _target);

		while(_parser.next())
		{
			_data = new DataGiftItem ();

			_data.idx			= _parser.getInt("idx");				//선물 고유번호. 선물 받을 때 사용하는 코드.
			_data.giftkind		= _parser.getInt("giftkind");			//선물, 쪽지분류.
																		//메시지(1)		Protocol.GIFTLIST_GIFT_KIND_MESSAGE
																		//선물(2)		Protocol.GIFTLIST_GIFT_KIND_GIFT
			_data.message		= _parser.getString("message");			//메시지 내용.
			_data.itemcode		= _parser.getInt("itemcode");			//선물 아이템 코드.
			_data.cnt			= _parser.getInt64("cnt");				//선물수량.
			_data.giftdate		= _parser.getString("giftdate");		//선물 일자.
			_data.giftid		= _parser.getString("giftid");			//선물한 유저.

			listGiftItem.Add ( _data );
		}
	}

	public static DataGiftItem GetGiftItem ( int _idx )
	{
		DataGiftItem _targetData = null;
		for ( int i = 0 ; i < listGiftItem.Count; i++ )
		{
			
			if ( listGiftItem[ i ].idx == _idx )
			{
				_targetData = listGiftItem[ i ];
				break;
			}
		}
		
		return _targetData;
	}
	#endregion

	#region 랜덤 씨리얼.
	public static string serial_itembuy;
	public static string serial_boxopen;

	public static void Init_RandSerial ()
	{
		ChangeSeiral_ItemBuy ();
		ChangeSeiral_BoxOpen ();
	}

	public static void ChangeSeiral_ItemBuy ()
	{
		serial_itembuy = SSUtil.getRandSerial ();
	}

	public static void ChangeSeiral_BoxOpen ()
	{
		serial_boxopen = SSUtil.getRandSerial ();
	}

	#endregion

}
