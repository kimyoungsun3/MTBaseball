using UnityEngine;
using System.Collections;

public delegate void VOID_FUN_VOID ();
public delegate void VOID_FUN_STRING ( string _str );
public delegate void VOID_FUN_LONG ( long _val );
public delegate void VOID_FUN_YesNoCancel ( YesNoCancel _result );
public delegate void VOID_FUN_INTINT ( int _val , int _val2 );
public delegate void VOID_FUN_INT ( int _val );
public delegate bool BOOL_FUN_CHAR( char _val); 

public enum YesNoCancel { Yes , No , Cancel }
public enum BuyState { Not, Buy }

public class Constant 
{
	
	#region 샘플용....
	public const float SERVER_RESPONES_TIME			= 60*5f;//5분에 한번씩 콜...
	//public const long HEART_MAX 					= 400;
	//public const int ITEMCODE_COIN_HOUSE 		= 60000;
	//public const int ITEMCODE_COIN_TANK 		= 60001;
	#endregion


	#region 샘플용2....
	//public const int ITEMCODE_XXXX2 			= 60000;
	//public const int ITEMCODE_XXXX3	 		= 60001;
	#endregion

}






















































