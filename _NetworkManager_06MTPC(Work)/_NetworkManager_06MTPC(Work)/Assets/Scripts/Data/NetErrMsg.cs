using UnityEngine;
using System.Collections;

public class NetErrMsg {	
	public static string GetMsg ( int _resultCode )
	{
		string _errMent = null;
		
		switch ( _resultCode )
		{
		case Protocol.RESULT_SUCCESS:
			_errMent = Msg.NET_RESULT_SUCCESS; break;
			
		case Protocol.RESULT_ERROR_ID_DUPLICATE:
			_errMent = Msg.NET_RESULT_ERROR_ID_DUPLICATE; break;
			
		case Protocol.RESULT_NEWVERION_CLIENT_DOWNLOAD:
			_errMent = Msg.NET_RESULT_NEWVERION_CLIENT_DOWNLOAD; break;
			
		case Protocol.RESULT_ERROR_SERVER_CHECKING:		
			_errMent = Msg.NET_RESULT_ERROR_SERVER_CHECKING; break;
			
		case Protocol.RESULT_ERROR_BLOCK_USER:
			_errMent = Msg.NET_RESULT_ERROR_BLOCK_USER; break;
			
		case Protocol.RESULT_ERROR_NOT_FOUND_GAMEID:
			_errMent = Msg.NET_RESULT_ERROR_NOT_FOUND_GAMEID; break;
			
		case Protocol.RESULT_ERROR_NOT_FOUND_PASSWORD:
			_errMent = Msg.NET_RESULT_ERROR_NOT_FOUND_PASSWORD; break;

		case Protocol.RESULT_ERROR_GIFTITEM_NOT_FOUND:	
			_errMent = Msg.NET_RESULT_ERROR_GIFTITEM_NOT_FOUND; break;
			
		case Protocol.RESULT_ERROR_GIFTITEM_ALREADY_GAIN:
			_errMent = Msg.NET_RESULT_ERROR_GIFTITEM_ALREADY_GAIN; break;
			
		case Protocol.RESULT_ERROR_NOT_SUPPORT_MODE:	
			_errMent = Msg.NET_RESULT_ERROR_NOT_SUPPORT_MODE; break;

		case Protocol.RESULT_ERROR_NOT_FOUND_ITEMCODE:
			_errMent = Msg.NET_RESULT_ERROR_NOT_FOUND_ITEMCODE; break;
						
		case Protocol.RESULT_ERROR_CASHCOST_LACK:
			_errMent = Msg.NET_RESULT_ERROR_CASHCOST_LACK; break;
								
		case Protocol.RESULT_ERROR_UPGRADE_FULL:		
			_errMent = Msg.NET_RESULT_ERROR_UPGRADE_FULL; break;	

		case Protocol.RESULT_ERROR_PARAMETER:		
			_errMent = Msg.NET_RESULT_ERROR_PARAMETER; break;

		case Protocol.RESULT_ERROR_LISTIDX_NOT_FOUND:
			_errMent = Msg.NET_RESULT_ERROR_LISTIDX_NOT_FOUND; break;

		default :
			_errMent = Msg.NET_NOT_FOUND_ERR + "\n( code : "+ _resultCode.ToString () +" )"; break;
		}	
		
		return _errMent ;
	}
}
