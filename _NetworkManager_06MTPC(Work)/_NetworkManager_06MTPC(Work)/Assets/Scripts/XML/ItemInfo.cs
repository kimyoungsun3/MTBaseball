
using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class ItemInfo {
	public static bool clear = false;

	//ItemInfo
	public static Dictionary < int , ItemInfo_WearPart > 	dic_wearPart = null;
	//public static Dictionary < int , Info_PiecePart > 	dic_piecePart = null;
	//public static Dictionary < int , Info_PieceBox > 		dic_pieceBox = null;
	//public static Dictionary < int , Info_WearBox > 		dic_wearBox = null;
	//public static Dictionary < int , Info_AdviceBox > 	dic_adviceBox = null;

	//GameInfo
	//public static Dictionary < int , GameInfo_DealInfo > 	dic_gameInfo_dealInfo = null;
	//public static Dictionary < int , GameInfo_Color > 	dic_gameInfo_color = null;

	//ToolTip
	//public static Dictionary < int , ToolTip > 			dic_tooltip = null;

	public static void Clear ()
	{
		dic_wearPart = null;
		//Info_PiecePart = null;

		clear = false;
	}

	public static IEnumerator Co_Init ()
	{
		string _strParserResult;
		SSParser _parser = new SSParser();

		float _totalLoad 	= 12;
		float _currentLoad 	= 0;

		//-----------------------------------------------
		// iteminfo
		//-----------------------------------------------
		_strParserResult = SSUtil.load("txt/iteminfo");	
		MakeInfo_WearPart ( _parser , _strParserResult );
		//++_currentLoad;		UiLoading.ins.UpdatePersent ( _currentLoad / _totalLoad );	
		yield return null; //게이지바...

		//MakeInfo_PiecePart ( _parser , _strParserResult );
		//++_currentLoad;		UiLoading.ins.UpdatePersent ( _currentLoad / _totalLoad );	
		yield return null;

		//MakeInfo_PieceWear ( _parser , _strParserResult );
		//++_currentLoad;		UiLoading.ins.UpdatePersent ( _currentLoad / _totalLoad );	
		yield return null;

		//MakeInfo_PieceBox ( _parser , _strParserResult );
		//++_currentLoad;		UiLoading.ins.UpdatePersent ( _currentLoad / _totalLoad );	
		yield return null;


		//-----------------------------------------------
		// gameinfo
		//-----------------------------------------------
		_strParserResult = SSUtil.load("txt/gameinfo");	

		//MakeGameInfo_DealInfo ( _parser , _strParserResult );
		//++_currentLoad;		UiLoading.ins.UpdatePersent ( _currentLoad / _totalLoad );	
		yield return null;

		//MakeGameInfo_Color ( _parser , _strParserResult );
		//++_currentLoad;		UiLoading.ins.UpdatePersent ( _currentLoad / _totalLoad );	
		yield return null;

		_parser.release();
	}



	private static void MakeInfo_WearPart ( SSParser _parser , string _target )
	{
		if ( dic_wearPart != null ) 
		{
			return;
		}

		dic_wearPart = new Dictionary<int, ItemInfo_WearPart> ();

		ItemInfo_WearPart _data = null;

		_parser.parsing ( _target , "wearpart" );

		while ( _parser.next () )
		{
			_data = new ItemInfo_WearPart ();

			_data.itemCode 			= _parser.getInt ( "itemcode" );
			_data.category 			= _parser.getInt ( "category" );
			_data.subcategory 		= _parser.getInt ( "subcategory" );
			_data.equpslot 			= _parser.getInt ( "equpslot" );
			_data.itemname 			= _parser.getString ( "itemname" );

			_data.active			= _parser.getInt("active") == 1 ? true : false;
			_data.grade				= _parser.getInt( "grade" );
			_data.icon				= _parser.getString ( "icon" );
			_data.cashcost			= _parser.getInt ( "cashcost" );
			_data.description		= _parser.getString ( "description" );

			_data.expincrease100	= _parser.getInt ( "expincrease100" );
			_data.setcode			= _parser.getInt( "setcode" );

			dic_wearPart.Add ( _data.itemCode , _data );
		}
	}
}
