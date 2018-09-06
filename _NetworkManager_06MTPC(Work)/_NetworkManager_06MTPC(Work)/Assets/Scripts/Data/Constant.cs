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

public class Constant : MonoBehaviour 
{
	public const int 	NULL_VALUE 			= -1;
	public const string NULL_STRING 		= "-1";

	public const float GAME_PLAY_TIME = 5 * 60f;	//5분동안 플레이.
	public const float GAME_SAFE_TIME = 30;			//30초 동안에는 플레이 안됨...

}










