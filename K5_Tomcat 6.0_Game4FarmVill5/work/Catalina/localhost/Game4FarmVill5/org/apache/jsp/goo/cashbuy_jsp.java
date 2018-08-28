package org.apache.jsp.goo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;
import java.net.*;
import java.io.*;
import org.json.simple.*;

public final class cashbuy_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


	//UltraEdit 파일포맷을 변경하면 된다.
	//파일 > 변환 > (ASCII -> Unicode)
	//파일 > 변환 > (UTF-8 -> Unicode)


	public int getInt(String _str, int _idx, int _size){
		int _rtn = 0;
		int _len = _str.length();
		if(_len >= _idx + _size){
			try{
				_rtn = Integer.parseInt(_str.substring(_idx, _idx + _size));
			}catch(Exception e){
			}

		}
		return _rtn;
	}

	public int getIntFromFloat(String _str){
		int _rtn = 0;
		try{
			_rtn = (int)Float.parseFloat(_str);
		}catch(Exception e){

		}
		return _rtn;
	}
	public String getString(String _str, int _idx, int _size){
		String _rtn = "";
		int _len = _str.length();
		if(_len >= _idx + _size){
			_rtn = _str.substring(_idx, _idx + _size);
		}
		return _rtn;
	}

	public byte getByte(byte _data, int _loop){
		int _tmp = (int)_data;
		if(_tmp >= 48 && _tmp <= 57){
			_tmp -= _loop;
			if(_tmp < 48)_tmp += 10;
		}else if(_tmp >= 65 && _tmp <= 90){
			_tmp -= _loop;
			if(_tmp < 65)_tmp += 26;
		}else if(_tmp >= 97 && _tmp <= 122){
			_tmp -= _loop;
			if(_tmp < 97)_tmp += 26;
		}else{
			_tmp += _loop;
		}

		return (byte)_tmp;
	}

	public byte getByte2(byte _data, int _loop){
		int _tmp = (int)_data;
		if(_tmp >= 48 && _tmp <= 57){
			_tmp -= _loop;
			if(_tmp < 48)_tmp += 10;
		}else if(_tmp >= 65 && _tmp <= 90){
			_tmp -= _loop;
			if(_tmp < 65)_tmp += 26;
		}else if(_tmp >= 97 && _tmp <= 122){
			_tmp -= _loop;
			if(_tmp < 97)_tmp += 26;
		//}else{
		//	_tmp += _loop;
		}

		return (byte)_tmp;
	}

	public String getDencode2(String _str, int _checkLen){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_size = getInt(_str, 0, 3);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = "-2";
			}else{
				_str = getString(_str, 3, _size);
			}

			//out.print(" _len:" + _len);
			//out.print(" _loop:" + _loop);
			//out.print(" _size:" + _size);
			//out.print(" _sum:" + _sum);
			//out.print(" _sum2:" + _sum2);
			//out.print(" _str:" + _str);
			//out.print(" gmode:" + gmode);
		}
		return _str;
	}

	public String getDencode32(int _crypt, String _str, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_crypt == 1){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte2(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_size = getInt(_str, 0, 3);
			if(_size <= 0){
				_str = "";
			}else{
				_str = getString(_str, 3, _size);
			}

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}
			//_str = "_loop:" + _loop
			//		+ " _size:" + _size
			//		+ " _str:[" + _str + "]"
			//		+ " _len2:" + _len2
			//		+ " _sum2:" + _sum2
			//		+ " _sum:" + _sum;
		}
		return _str;
	}

	public String getDencode4(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 3);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 3, _size);
			}
		}
		return _str;
	}

	public String getDencode5(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 4, 4);
			_str = getString(_str, 1, _len - (1+4));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 4);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 4, _size);
			}
		}
		return _str;
	}


	public String getDencode6(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _loop1, _loop2, _size;
		int _key, _key2, _key3;
		byte _sum, _sum2;
		byte[] gsbByte;
		_len = _str.length();

		if(_len >= _checkLen){
			_loop1 = getInt(_str, 0, 1);
			_loop2 = getInt(_str, 1, 1);
			_key3 = getInt(_str, _len - 4, 4)/3;
			_sum = (byte)getInt(_str, _len - 8, 4);
			_str = getString(_str, 4, _len - (4+4+4));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				_loop = i%2==0?_loop1:_loop2;

				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 4);
			_key = getInt(_str, 4, 4);
			_key2 = getInt(_str, _str.length() - 4, 4)/2;

			if(_sum != _sum2 || _key != _key2 || _key != _key3){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 8, _size);
			}
		}
		return _str;
	}



	////////////////////////////////////////
	//iPhone 인증하기
	////////////////////////////////////////
	public String callAppleSite(String _strIKind, String _strParam){
		//1-1. 네트워크 정의
		String APPLE_URL_SANDBOX 	= "https://sandbox.itunes.apple.com/verifyReceipt";
		String APPLE_URL_ITUNES 	= "https://buy.itunes.apple.com/verifyReceipt";
		String APPLE_SANDBOX		= "sandbox";
		String _strURL;

		//1-2. 변수 전의 
		URL url;
		URLConnection conn;
		HttpURLConnection  hurlc;
		InputStream is;
		InputStreamReader isr;
		BufferedReader br;
		PrintWriter out;
		String line;
		StringBuilder sb = new StringBuilder("");

		//2-1. 분류하기
		JSONObject _jsonObj = new JSONObject();
		_jsonObj.put("receipt-data", _strParam);
		_strParam = _jsonObj.toString();
		if(_strIKind.equalsIgnoreCase(APPLE_SANDBOX)){
			_strURL = APPLE_URL_SANDBOX;
		}else{
			_strURL = APPLE_URL_ITUNES;
		}

		//Apple에서 검사해서오기
		try{
			//URL객체를 생성하고 해당 URL로 접속한다.
			url = new URL(_strURL);
			conn = url.openConnection();
			hurlc = (HttpURLConnection )conn;

			hurlc.setRequestMethod("POST");
			hurlc.setConnectTimeout(30 * 1000);
			hurlc.setDoOutput(true);
			hurlc.setDoInput(true);
			hurlc.setDefaultUseCaches(false);
			hurlc.setUseCaches(false);

			out = new PrintWriter(hurlc.getOutputStream());
			out.println(_strParam);
			out.close();

			//내용을 읽어오기위한 InputStream객체를 생성한다..
			is = hurlc.getInputStream();
			isr = new InputStreamReader(is);
			br = new BufferedReader(isr);
			//내용을 읽어서 화면에 출력한다..
			while((line = br.readLine()) != null){
				sb.append(line);
			}

			//연결종료
			if(br != null)br.close();
			if(isr != null)isr.close();
			if(is != null)is.close();
			if(hurlc != null)hurlc.disconnect();
		}catch(Exception e){
			sb.append("error");
		}
	    return sb.toString();
	}

	////////////////////////////////////////
	//iPhone 인증하기 > 데이타 파싱해서 검사
	////////////////////////////////////////
	public boolean getiPhoneSuccess(String _data, String _dollar, String pack[], String _listName[]){
		String _success;
		String _str, _str2;
		int _len = _listName.length;
		boolean _bSuccess = false;
		boolean _bPackageName = false;
		boolean _bItemID = false;

		try{
			Object _obj2 = JSONValue.parse("[0, " + _data + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);

			_success = _obj3.get("status").toString();
			if(_success != null && _success.equals("0")){
				_bSuccess = true;
			}

			//홈런리그 베이스볼 2013	Apple ID : 634876829 	Bundle ID : sangsangdigital.com.homerunleague
			//homerungold_15   638657470
			//homerungold_55   638657906
			//homerungold_114  638657925
			//homerungold_400  638658016
			//homerungold_635  638658206
			//homerungold_1320 638658446
			//3. 결과를 출력하기(디코딩전) _obj3.get("bid")
			//{
			//	"receipt":
			//		{
			//			"bid":"sangsangdigital.com.homerunleague", 		//게임 패키지 이름
			//			"product_id":"homerungold_55", 					//아이템 고유이름
			//			"item_id":"638657906", 							//아이템 번호
			//			/////////////////////////////////////////////////////
			//			"bvrs":"1.1.6", 								//현재버젼
			//			"quantity":"1",
			//			"unique_identifier":"fcc805a490d7cd66bd5a093bf86cd77d82d007c0",
			//			"unique_vendor_identifier":"DE0CE74A-ADA8-4E8C-9960-2D52276D68C7", //폰기기에 고유값인듯 iPhone1(1), iPhone2(2) 매번 바뀌는것이 아님.
			//			/////////////////////////////////////////////////////
			//			"original_purchase_date_pst":"2013-06-11 05:46:45 America/Los_Angeles",
			//			"purchase_date_ms":"1370954805373",
			//			"original_transaction_id":"1000000076918950",
			//			"transaction_id":"1000000076918950",
			//			"purchase_date":"2013-06-11 12:46:45 Etc/GMT",
			//			"original_purchase_date":"2013-06-11 12:46:45 Etc/GMT",
			//			"purchase_date_pst":"2013-06-11 05:46:45 America/Los_Angeles",
			//			"original_purchase_date_ms":"1370954805373"
			//		},
			//	"status":0
			//}
			_array = (JSONArray)JSONValue.parse("[0, " + _obj3.get("receipt")+"]");
			_obj3 = (JSONObject)_array.get(1);

			_str = _obj3.get("bid").toString();
			if(_str != null){
				for(int i = 0; i < pack.length; i++){
					if(_str.equalsIgnoreCase(pack[i])){
						_bPackageName = true;
						break;
					}
				}
			}

			//달러금액(499) > homerungold_55 > 638657906
			for(int i = 0; i < _len; i+= 3){
				if(_dollar != null && _dollar.equalsIgnoreCase(_listName[i])){
					_str 	= _obj3.get("product_id").toString();
					_str2 	= _obj3.get("item_id").toString();
					if(_str != null && _str.equalsIgnoreCase(_listName[i + 1])
						&& _str2 != null && _str2.equalsIgnoreCase(_listName[i + 2])){
							_bItemID = true;
					}
					break;
				}
			}
		}catch(Exception e){}

		return (_bItemID);
		//return (_bSuccess && _bPackageName && _bItemID);
	}

	public String getiPhoneInfo(String _data, String _strName){
		String _str = "xxxx";

		try{
			Object _obj2 = JSONValue.parse("[0, " + _data + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);

			//3. 결과를 출력하기(디코딩전) _obj3.get("bid")
			//{
			//	"receipt":
			//		{
			//			"bid":"sangsangdigital.com.homerunleague", 		//게임 패키지 이름
			//			"product_id":"homerungold_55", 					//아이템 고유이름
			//			"item_id":"638657906", 							//아이템 번호
			//			/////////////////////////////////////////////////////
			//			"bvrs":"1.1.6", 								//현재버젼
			//			"quantity":"1",
			//			"unique_identifier":"fcc805a490d7cd66bd5a093bf86cd77d82d007c0",
			//			"unique_vendor_identifier":"DE0CE74A-ADA8-4E8C-9960-2D52276D68C7", //폰기기에 고유값인듯 iPhone1(1), iPhone2(2) 매번 바뀌는것이 아님.
			//			/////////////////////////////////////////////////////
			//			"original_purchase_date_pst":"2013-06-11 05:46:45 America/Los_Angeles",
			//			"purchase_date_ms":"1370954805373",
			//			"original_transaction_id":"1000000076918950",
			//			"transaction_id":"1000000076918950",
			//			"purchase_date":"2013-06-11 12:46:45 Etc/GMT",
			//			"original_purchase_date":"2013-06-11 12:46:45 Etc/GMT",
			//			"purchase_date_pst":"2013-06-11 05:46:45 America/Los_Angeles",
			//			"original_purchase_date_ms":"1370954805373"
			//		},
			//	"status":0
			//}
			_array = (JSONArray)JSONValue.parse("[0, " + _obj3.get("receipt")+"]");
			_obj3 = (JSONObject)_array.get(1);

			_str 	= _obj3.get(_strName).toString();
		}catch(Exception e){
			_str = "error";
		}

		return _str;
	}

	////////////////////////////////////////
	//정보를 디스플레이한다.
	////////////////////////////////////////
	public String getiPhoneInfo(String _strAppleRetrun){
		StringBuffer _sb = new StringBuffer();
		try{
			Object _obj2 = JSONValue.parse("[0, " + _strAppleRetrun + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);
			_sb.append("=================================<br>");
			_sb.append(_obj3.get("status")+"<br>");

			_array = (JSONArray)JSONValue.parse("[0, " + _obj3.get("receipt")+"]");
			_obj3 = (JSONObject)_array.get(1);
			_sb.append(_obj3.get("bid")+"<br>");			//게임 패키지 이름
			_sb.append(_obj3.get("product_id")+"<br>");	//아이템 고유이름
			_sb.append(_obj3.get("item_id")+"<br>");		//아이템 번호
			_sb.append(_obj3.get("bvrs")+"<br>");			//현재버젼

			_sb.append("================================="+"<br>");
			_sb.append(_obj3.get("quantity")+"<br>");
			_sb.append(_obj3.get("unique_identifier")+"<br>");
			_sb.append(_obj3.get("unique_vendor_identifier")+"<br>");		//폰기기에 고유값인듯 iPhone1(1), iPhone2(2) 매번 바뀌는것이 아님.

			//_sb.append("================================="+"<br>");
			//_sb.append(_obj3.get("transaction_id")+"<br>");
			//_sb.append(_obj3.get("original_transaction_id")+"<br>");
			//_sb.append(_obj3.get("purchase_date_ms")+"<br>");
			//_sb.append(_obj3.get("original_purchase_date_ms")+"<br>");
			//_sb.append(_obj3.get("purchase_date")+"<br>");
			//_sb.append(_obj3.get("original_purchase_date")+"<br>");
			//_sb.append(_obj3.get("purchase_date_pst")+"<br>");
			//_sb.append(_obj3.get("original_purchase_date_pst")+"<br>");
		}catch(Exception e){}

		return _sb.toString();
	}

	////////////////////////////////////////
	//Google 인증하기 > 데이타 파싱해서 검사
	////////////////////////////////////////
	public boolean getGoogleSuccess(int _market, String _data, String _dollar, String pack[], String _listName[]){
		String _success;
		String _str, _str2;
		int _len = _listName.length;
		boolean _bSuccess 		= false;
		boolean _bSuccess2 		= false;
		boolean _bPackageName 	= false;
		boolean _bItemID 		= false;

		try{
			Object _obj2 = JSONValue.parse("[0, " + _data + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);

			_success = _obj3.get("status").toString();
			if(_success != null && _success.equals("0")){
				_bSuccess = true;
			}

			//홈런리그 베이스볼 2013
			//OrderID : "+purchase.getOriginalJson()				//{"orderId":"12999763169054705758.1319607302512252","packageName":"com.sangsangdigital.homerunleagueggtest3","productId":"homerun_1500","purchaseTime":1378184267000,"purchaseState":0,"purchaseToken":"gqzrcllpeiqlbfgpkxuhrcon.AO-J1Oy4jD7ZPpMeuhB9YwlYiqlc-K8GShu6uPG0aTDZzFfvRxXWF6-ucThc6F6gUkVuyZvrxwqp0KG2wetmZvLvP2JgD3eR4J9a_6yd4CQSScMcqwVgNpCAXPmRBxuLIzKTHZeDdqCUq2WS0OhkIDze8kVIGI0fCA"}
			//OrderID : "+purchase.getOrderId());					//12999763169054705758.1319607302512252
			//PackageName : " + purchase.getPackageName()			//com.sangsangdigital.homerunleagueggtest3
			//PurchaseTime :" + purchase.getPurchaseTime()			//1378184267000
			//PurchaseState : " + purchase.getPurchaseState()		//0
			//developerPayload : " + purchase.getDeveloperPayload()//
			//PurchaseToken : " + purchase.getToken());				//gqzrcllpeiqlbfgpkxuhrcon.AO-J1Oy4jD7ZPpMeuhB9YwlYiqlc-K8GShu6uPG0aTDZzFfvRxXWF6-ucThc6F6gUkVuyZvrxwqp0KG2wetmZvLvP2JgD3eR4J9a_6yd4CQSScMcqwVgNpCAXPmRBxuLIzKTHZeDdqCUq2WS0OhkIDze8kVIGI0fCA
			//Siginature : " + purchase.getSignature());			//kkFYkE55k8wHQmZaRTok+UDUo4jveRB78k3Na5u2UESJnXCSzEvwk8BTAIV7Lk85UrSKR1IjT1RtlOhgQEpsU9u3LsrcOwHds+iaoIDZxgd9IG2enJ/1TpjqZy31Pd/amYF3tgJaI0K+V5Y5gfSalR5I/lnYVfxwPtjpS7CIvQx8jtfoZc93cfJnZ+PYPWXYMozzs4nQUlQD/cSY/5GDGcxCSJZSZoiDLHQGcN3Bs8ciHxrJATTF0PPkdFo2wYLr+vT0nIcvQ0h83FSk+i9CymY2nRrgeK/qewP5+fBmry1QyK0qLYnmOKyrPN7sENgDvyFzVCh6BhLPUo9Km/81UA==
			//strBuyMessage											//{ "receipt":{"orderId":"12999763169054705758.1319607302512252","packageName":"com.sangsangdigital.homerunleagueggtest3","productId":"homerun_1500","purchaseTime":1378184267000,"purchaseState":0,"purchaseToken":"gqzrcllpeiqlbfgpkxuhrcon.AO-J1Oy4jD7ZPpMeuhB9YwlYiqlc-K8GShu6uPG0aTDZzFfvRxXWF6-ucThc6F6gUkVuyZvrxwqp0KG2wetmZvLvP2JgD3eR4J9a_6yd4CQSScMcqwVgNpCAXPmRBxuLIzKTHZeDdqCUq2WS0OhkIDze8kVIGI0fCA"}, "status":0}
			//
			//com.sangsangdigital.homerunleaguegg
			//{"receipt":{"orderId":"12999763169054705758.1360878718610924","packageName":"sangsangdigital.com.homerunleague2","productId":"homerun_1500","purchaseTime":1374813819000,"purchaseState":0,"purchaseToken":"wgisshwcpzoqilugqcvzejxo.AO-J1Oy2J9NDm3SRQHLWCJ1rZqCnjOFeO_uLULyjqeZ7OpKcpIMfR7aa2iFwCzeeqF_UfNNsFwVNanNKLinv2RMg_UoTRET2QN1UZSGS8p_vaSdPBA497qlb_bl0mAsU4kArP8hLjtZB"},"status":0}
			//{"receipt":{"orderId":"12999763169054705758.1360878718610924","packageName":"sangsangdigital.com.homerunleague","productId":"homerun_1500","purchaseTime":1374813819000,"purchaseState":0,"purchaseToken":"wgisshwcpzoqilugqcvzejxo.AO-J1Oy2J9NDm3SRQHLWCJ1rZqCnjOFeO_uLULyjqeZ7OpKcpIMfR7aa2iFwCzeeqF_UfNNsFwVNanNKLinv2RMg_UoTRET2QN1UZSGS8p_vaSdPBA497qlb_bl0mAsU4kArP8hLjtZB"},"status":0}
			//{"receipt":{"orderId":"12999763169054705758.1360878718610924","packageName":"com.sangsang.tempestsagagoogle","productId":"ts104","purchaseTime":1374813819000,"purchaseState":0,"purchaseToken":"wgisshwcpzoqilugqcvzejxo.AO-J1Oy2J9NDm3SRQHLWCJ1rZqCnjOFeO_uLULyjqeZ7OpKcpIMfR7aa2iFwCzeeqF_UfNNsFwVNanNKLinv2RMg_UoTRET2QN1UZSGS8p_vaSdPBA497qlb_bl0mAsU4kArP8hLjtZB"},"status":0}
			//{
			//	"receipt":
			//		{
			//			"orderId":"12999763169054705758.1360878718610924",
			//			"packageName":"com.sangsang.tempestsagagoogle",
			//			"productId":"ts104",
			//			"purchaseTime":1374813819000,
			//			"purchaseState":0,
			//			"purchaseToken":"wgisshwcpzoqilugqcvzejxo.AO-J1Oy2J9NDm3SRQHLWCJ1rZqCnjOFeO_uLULyjqeZ7OpKcpIMfR7aa2iFwCzeeqF_UfNNsFwVNanNKLinv2RMg_UoTRET2QN1UZSGS8p_vaSdPBA497qlb_bl0mAsU4kArP8hLjtZB"
			//		},
			//	"status":0
			//}
			_array = (JSONArray)JSONValue.parse("[0, " + _obj3.get("receipt")+"]");
			_obj3 = (JSONObject)_array.get(1);

			_str = _obj3.get("packageName").toString();
			if(_str != null){
				for(int i = 0; i < pack.length; i++){
					if(_str.equalsIgnoreCase(pack[i])){
						_bPackageName = true;
						break;
					}
				}
			}


			_success = _obj3.get("purchaseState").toString();
			if(_success != null && _success.equals("0")){
				_bSuccess2 = true;
			}

			//1500 > homerun_1500 or turn_homerun_1500
			int iidx = 1;
			if(_market == 5){
				iidx = 1;
			}else{
				iidx = 2;
			}
			for(int i = 0; i < _len; i+= 3){
				if(_dollar != null && _dollar.equalsIgnoreCase(_listName[i])){
					_str 	= _obj3.get("productId").toString();
					if(_str != null && _str.equalsIgnoreCase(_listName[i + iidx])){
						_bItemID = true;
					}
					break;
				}
			}
		}catch(Exception e){
			System.out.println("_checkfun2 error:" + e);
		}

		return (_bSuccess && _bSuccess2 && _bPackageName && _bItemID);	//정상
		//return (_bSuccess);											//테스트용
		//return (_bSuccess2);
		//return (_bPackageName);
		//return (_bItemID);
	}

	////////////////////////////////////////
	//정보를 디스플레이한다.
	////////////////////////////////////////
	public String getGoogleInfo(String _strAppleRetrun){
		StringBuffer _sb = new StringBuffer();
		try{
			Object _obj2 = JSONValue.parse("[0, " + _strAppleRetrun + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);
			_sb.append("=================================<br>");
			_sb.append(_obj3.get("status")+"<br>");

			_array = (JSONArray)JSONValue.parse("[0, " + _obj3.get("receipt")+"]");
			_obj3 = (JSONObject)_array.get(1);
			_sb.append(_obj3.get("orderId")+"<br>");
			_sb.append(_obj3.get("packageName")+"<br>");
			_sb.append(_obj3.get("productId")+"<br>");
			_sb.append(_obj3.get("purchaseTime")+"<br>");
			_sb.append(_obj3.get("purchaseState")+"<br>");
			_sb.append(_obj3.get("purchaseToken")+"<br>");
		}catch(Exception e){}

		return _sb.toString();
	}


	////////////////////////////////////////
	//SKT 인증하기
	////////////////////////////////////////
	public String callSKTSite(String _strIKind, String _strParam){
		//1-1. 네트워크 정의
		String SKT_URL_TEST 	= "https://iapdev.tstore.co.kr/digitalsignconfirm.iap";
		String SKT_URL_REAL 	= "https://iap.tstore.co.kr/digitalsignconfirm.iap";
		String SKT_REAL			= "skt";
		String _strURL;
		StringBuilder sb = new StringBuilder("");

		///////////////////////////////////////////
		// "	-> \"
		//	\	-> \\
		//_strParam = "{\"signdata\":\"M\"}";
		//_strParam = "{\"signdata\":\"M\",\"txid\":\"TX_00000000091701\",\"appid\":\"OA00646546\"}";
		///////////////////////////////////////////
		//	[원본]	> [디코딩]
		///////////////////////////////////////////
		//"{\"signdata\":\"MIIH+gYJKoZIhvcNAQcCoIIH6zCCB+cCAQExDzANBglghkgBZQMEAgEFADBZBgkqhkiG9w0BBwGgTARKMjAxMzEyMDExNzEyNDd8VFhfMDAwMDAwMDAwOTE3MDl8MDEwNDY4MDMwNjZ8T0EwMDY0NjU0NnwwOTEwMDA0MzA4fDIwMDB8fHygggXvMIIF6zCCBNOgAwIBAgIDT7hrMA0GCSqGSIb3DQEBCwUAME8xCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEVMBMGA1UEAwwMQ3Jvc3NDZXJ0Q0EyMB4XDTEyMTIyMTA0MjcwMFoXDTEzMTIyMTE0NTk1OVowgYwxCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEbMBkGA1UECwwS7ZWc6rWt7KCE7J6Q7J247KadMQ8wDQYDVQQLDAbshJzrsoQxJDAiBgNVBAMMG+yXkOyKpOy8gOydtCDtlIzrnpjri5so7KO8KTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMy0j+0TIEctoIbhJp8MD+DFWwas3ejmfasmZ2jXW44y2wHWWHX4UfOVzM9GJMYdjp5BVOgGylTk32dsysjxzQLtChKIJydSfvgrNisfSndzijxxi8yE9CZoe\\/BL+Czgxyq29oEIxUp8izXrrOEaOb\\/9Vd5QbIsK7auGu6CdiN5H+naKAoCcrptQikcSyvuUKrqTEvgIQtpnLIAxHUq5Yd0RBU\\/OW7ToY4I703xhre3arQRaRoeXfUwKQv0zQEUTVkDyS\\/dT0KYETFbWhmSC689\\/t6Odccml9+S98peqxqs7jxYpiT1gOg8EF0HgBW+yy2jWgSfirYvj4DHf7z50kfECAwEAAaOCApAwggKMMIGPBgNVHSMEgYcwgYSAFLZ0qZuSPMdRsSKkT7y3PP4iM9d2oWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICEAQwHQYDVR0OBBYEFBdwpU\\/Z\\/kva797rgtl+huf9m0ooMA4GA1UdDwEB\\/wQEAwIGwDCBgwYDVR0gAQH\\/BHkwdzB1BgoqgxqMmkQFBAEDMGcwLQYIKwYBBQUHAgEWIWh0dHA6Ly9nY2EuY3Jvc3NjZXJ0LmNvbS9jcHMuaHRtbDA2BggrBgEFBQcCAjAqHii8+AAgx3jJncEcx1gAIMcg1qiuMKwEx0AAIAAxsUQAIMeFssiy5AAuMHoGA1UdEQRzMHGgbwYJKoMajJpECgEBoGIwYAwb7JeQ7Iqk7LyA7J20IO2UjOuemOuLmyjso7wpMEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCDnstgCMlYs4YsIkS3E0PdeGKoWB93Wgpowj0jLuQQfEjB\\/BgNVHR8EeDB2MHSgcqBwhm5sZGFwOi8vZGlyLmNyb3NzY2VydC5jb206Mzg5L2NuPXMxZHA2cDExMDYsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89Q3Jvc3NDZXJ0LGM9S1I\\/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBGBggrBgEFBQcBAQQ6MDgwNgYIKwYBBQUHMAGGKmh0dHA6Ly9vY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAjmfND0w8NuggOa9qxt6vGWHyU4YcZBhNJ88AVxnIYeOP+vFO7y2kTguEF+yDV+x+a+Fxc54icRNBi4iwq8xF9C2\\/H6yLAR3YBKLZS+1QdYXtpTp4vnlBuugFNR8FtLni4R3rFfqXf+96V7liApgPVYU31go5YIWJYBJoiXz8\\/mXD3ZNCV8kOOqDtf\\/VFwO1vn8nqCnPCzoe9Sq2dm1+TaRsJD9NTf4E9z4xoPjdz\\/6q97X3D3kcIgUH6jYi\\/hwsGBgqYyKuT4+WImqJilWPjlDFMYI+RVsdiSL1tg4atYnsW6KGoAEk3ve46W04nCZzM3fVvDu4rzsV7zZ1SZ4rbxjGCAYEwggF9AgEBMFYwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTICA0+4azANBglghkgBZQMEAgEFADANBgkqhkiG9w0BAQsFAASCAQCjeaxPvidtQuIV0skqPo4z+PWNKhLCvtskVQRvAIGnvmieCfnP+pOmLrv4VxrD9yeRbG7GfEGRD\\/W66z\\/0+tD6ku8gFYwRMzsXYVYenIiqJtG2havqMHCyGKxhxqdKYkcDwwTTzdRRmzAo2x\\/FWYV1HMQjqYiQntHeSC\\/5I3mGnATCF3ijvKWIUOc0HA59\\/fuWrut2oSAi5nw8IAvzUOMHaA\\/7f7XzHVGd5vV0sMJ1qYL29TA+EdozYh7Y\\/2usNVLZqJ\\/5yz9lbAuQ8ScYu3GIKiAdjQDASy\\/fqngZfz6Tj8PPx4t3PRz3ZXJsH+ZRdPh2ju3+gFUcFWQvOg\\/UP+v1\",\"txid\":\"TX_00000000091709\",\"appid\":\"OA00646546\"}";
		//{"product":[{"appid":"OA00646546","bp_info":"","charge_amount":2000,"detail_pname":"","log_time":"20131201171247","product_id":"0910004308","tid":""}],"message":"정상검증완료.","detail":"0000","count":1,"status":0}

		//1-2. 변수 전의
		URL url;
		URLConnection conn;
		HttpURLConnection  hurlc;
		InputStream is;
		InputStreamReader isr;
		BufferedReader br;
		PrintWriter out;
		String line;

		//2-1. 분류하기
		if(_strIKind.equalsIgnoreCase(SKT_REAL)){
			_strURL = SKT_URL_REAL;
		}else{
			_strURL = SKT_URL_TEST;
		}

		//Apple에서 검사해서오기
		try{
			//URL객체를 생성하고 해당 URL로 접속한다.
			url = new URL(_strURL);
			conn = url.openConnection();
			hurlc = (HttpURLConnection )conn;

			hurlc.setRequestProperty("Content-Type", "application/json");
			hurlc.setRequestMethod("POST");
			hurlc.setConnectTimeout(30 * 1000);
			hurlc.setDoOutput(true);
			hurlc.setDoInput(true);
			hurlc.setDefaultUseCaches(false);
			hurlc.setUseCaches(false);

			out = new PrintWriter(hurlc.getOutputStream());
			out.print(_strParam);
			out.close();

			//내용을 읽어오기위한 InputStream객체를 생성한다..
			is = hurlc.getInputStream();
			isr = new InputStreamReader(is, "UTF-8");
			br = new BufferedReader(isr);
			//내용을 읽어서 화면에 출력한다..
			while((line = br.readLine()) != null){
				sb.append(line);
			}

			//연결종료
			if(br != null)br.close();
			if(isr != null)isr.close();
			if(is != null)is.close();
			if(hurlc != null)hurlc.disconnect();
		}catch(Exception e){
			sb.append("error");
		}
	    return sb.toString();
	}

	////////////////////////////////////////
	//SKT 인증하기 > 데이타 파싱해서 검사
	////////////////////////////////////////
	public boolean getSKTSuccess(String _data, int _money, String _aids[], int _moneys[], String _pids[]){
		String _status = null, _detail = null, _appid = null, _charge_amount = null, _product_id = null;
		int _len;
		int _money2;
		boolean _debug		= false;
		boolean _bStatus 	= false;
		boolean _bDetail 	= false;
		boolean _bMoney 	= false;
		boolean _bMoney2 	= false;
		boolean _baid 		= false;
		boolean _bpid 		= false;

		String _strRetrun = "";

		try{
			//{"product":[{"appid":"OA00700316","bp_info":"","charge_amount":3300,"detail_pname":"루비 310개","log_time":"20160518173458","product_id":"0910047079","tid":""}],"message":"정상검증완료.","detail":"0000","count":1,"status":0}
			//
			//{
			//	"product":[
			//		{
			//		"appid":"OA00700316",
			//		"bp_info":"",
			//		"charge_amount":3300,
			//		"detail_pname":"루비 310개",
			//		"log_time":"20160518173458",
			//		"product_id":"0910047079",
			//		"tid":""
			//		}
			//	],
			//	"message":"정상검증완료.",
			//	"detail":"0000",
			//	"count":1,
			//	"status":0
			//}

			Object _obj = JSONValue.parse( _data );
			JSONObject _object = (JSONObject) _obj;
			JSONArray _product = (JSONArray) _object.get("product");

			if(_debug){
				System.out.println("strc:" + _data);
				System.out.println("detmessageail:" + _object.get("message").toString());
				System.out.println("detail:" 		+ _object.get("detail").toString());
				System.out.println("count:"			+ _object.get("count").toString());
				System.out.println("status:" 		+ _object.get("status").toString());
				for (Object jobj : _product.toArray()) {
					System.out.println("appid:" + ((JSONObject) jobj).get("appid").toString());
					System.out.println("product_id:" + ((JSONObject) jobj).get("product_id").toString());
				}
			}

			_status = _object.get("status").toString();
			if(_status != null && _status.equals("0")){
				_bStatus = true;
			}

			_detail = _object.get("detail").toString();
			if(_detail != null && _detail.equals("0000")){
				_bDetail = true;
			}

			for (Object jobj : _product.toArray()) {
				_appid 			= ((JSONObject) jobj).get("appid").toString();
				_charge_amount 	= ((JSONObject) jobj).get("charge_amount").toString();
				_product_id 	= ((JSONObject) jobj).get("product_id").toString();
			}

			if(_charge_amount == null || _charge_amount.equals("")){
				_money2 = -9999;
			}else{
				_money2 = Integer.parseInt(_charge_amount);
			}

			if(_money == _money2){
				_bMoney = true;
			}

			_len = _moneys.length;
			for(int i = 0; i < _len; i++){
				if(_money == _moneys[i]){
					_bMoney2 = true;
					break;
				}
			}

			_len = _aids.length;
			if(_appid != null){
				for(int i = 0; i < _len; i++){
					if(_appid.equalsIgnoreCase(_aids[i])){
						_baid = true;
						break;
					}
				}
			}

			_len = _pids.length;
			if(_product_id != null){
				for(int i = 0; i < _len; i++){
					if(_product_id.equalsIgnoreCase(_pids[i])){
						_bpid = true;
						break;
					}
				}
			}
		}catch(Exception e){
			//_strRetrun += "e:" + e;
			//System.out.println("e:" + e);
		}

		//_strRetrun = _bStatus +":"+ _bDetail +":"+ _bMoney +":"+ _bMoney2 +":"+ _baid +":"+ _bpid;
		//return _strRetrun;
		return (_bStatus && _bDetail && _bMoney && _bMoney2 && _baid && _bpid);

	}

	public String getSKTtxid(String _data){
		String _str;
		String _strRetrun = "";

		try{
			Object _obj2 = JSONValue.parse("[0, " + _data + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);

			_strRetrun = _obj3.get("txid").toString();

		}catch(Exception e){
			//_strRetrun += "e:" + e;
		}

		return _strRetrun;
	}

	//////////////////////////////////////////////
	// Kakao 서버통신 > 데몬이 처리한다.
	//////////////////////////////////////////////


	////////////////////////////////////////
	//NHN 인증하기 > 데이타 파싱해서 검사
	////////////////////////////////////////
	public boolean getNHNSuccess(String _data, String _pids[], String _paymentSeq){
		String _str, _str3;
		int _len;
		boolean _bStatus 	= false;
		boolean _bpid 		= false;
		boolean _bpay 		= false;

		//String _strRetrun = "";

		try{
			Object _obj2 = JSONValue.parse("[0, " + _data + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);

			//{
			//	"receipt":
			//		{
			//			"extra":"extra",
			//			"environment":"TEST",
			//			"paymentSeq":"1004745009",
			//			"productCode":"1000007929",
			//			"paymentTime":1404129513498,
			//			"approvalStatus":"APPROVED"},
			//	"nonce":7433694377350428587
			//}
			_str3 = _obj3.get("receipt").toString();
			_str3 = "[0, " + _str3 + "]";
			_array = (JSONArray)JSONValue.parse(_str3);
			_obj3 = (JSONObject)_array.get(1);

			_str = _obj3.get("approvalStatus").toString();
			if(_str != null && _str.equals("APPROVED")){
				_bStatus = true;
			}

			_str = _obj3.get("productCode").toString();
			_len = _pids.length;
			if(_str != null){
				for(int i = 0; i < _len; i++){
					if(_str.equalsIgnoreCase(_pids[i])){
						_bpid = true;
						break;
					}
				}
			}

			_str = _obj3.get("paymentSeq").toString();
			if(_str != null && _str.equals(_paymentSeq)){
				_bpay = true;
			}
		}catch(Exception e){
			//_strRetrun += "e:" + e;
		}

		//return (_bStatus +":"+ _bpid +":"+ _bpay + ":[" + _strRetrun + "]");
		return (_bStatus && _bpid && _bpay);
	}

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(3);
    _jspx_dependants.add("/goo/_define.jsp");
    _jspx_dependants.add("/goo/_checkfun.jsp");
    _jspx_dependants.add("/goo/_checkfun2.jsp");
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=utf-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
request.setCharacterEncoding("utf-8");
      out.write('\r');
      out.write('\n');
      formutil.FormUtil util = null;
      synchronized (_jspx_page_context) {
        util = (formutil.FormUtil) _jspx_page_context.getAttribute("util", PageContext.PAGE_SCOPE);
        if (util == null){
          util = new formutil.FormUtil();
          _jspx_page_context.setAttribute("util", util, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');

	//마켓패치용 정의파일 
				int 	SKT 					= 1,
						GOOGLE 					= 5,
						NHN						= 6,
						IPHONE					= 7;

				 int 	PTC_NOTICE			= 28,	//[notice.jsp]
						PTS_NOTICE			= 28,
						PTC_AGREEMENT		= 81,	//sysagreement.jsp
						PTS_AGREEMENT		= 81,
						PTC_SYSINQUIRE		= 82,	//sysinquire.jsp
						PTS_SYSINQUIRE		= 82,

						PTC_CREATEID		= 0,	//createid.jsp
						PTS_CREATEID		= 0,
						PTC_CREATEGUEST		= 22,	//createguest.jsp
						PTS_CREATEGUEST		= 22,
						PTC_NEWSTART		= 87,	//newstart.jsp
						PTS_NEWSTART		= 87,
						PTC_KFADD			= 88,	//kfadd.jsp
						PTS_KFADD			= 88,
						PTC_KFRESET			= 96,	//kfreset.jsp
						PTS_KFRESET			= 96,
						PTC_KFINVITE		= 89,	//kfinvite.jsp
						PTS_KFINVITE		= 89,
						PTC_KFHELP			= 90,	//kfhelp.jsp
						PTS_KFHELP			= 90,
						PTC_KFHELPLIST		= 98,	//kfhelplist.jsp
						PTS_KFHELPLIST		= 98,
						PTC_KCHECKNN		= 91,	//kchecknn.jsp
						PTS_KCHECKNN		= 91,

						PTC_LOGIN			= 1,	//login.jsp
						PTS_LOGIN			= 1,
						PTC_CHANGEPW		= 32,	//changepw.jsp
						PTS_CHANGEPW		= 32,
						PTC_DELETEID		= 11, 	//deleteid.jsp
						PTS_DELETEID		= 11,
						PTC_DAILYREWARD		= 41, 	//dailyreward.jsp
						PTS_DAILYREWARD		= 41,
						PTC_GIFTGAIN		= 21, 	//giftgain.jsp
						PTS_GIFTGAIN		= 21,

						PTC_ITEMBUY			= 8,	//itembuy.jsp
						PTS_ITEMBUY			= 8,
						PTC_ITEMSELL		= 50,	//itemsell.jsp
						PTS_ITEMSELL		= 50,
						PTC_ITEMSELLLIST	= 111,	//itemselllist.jsp
						PTS_ITEMSELLLIST	= 111,
						PTC_ITEMQUICK		= 51,	//itemquick.jsp
						PTS_ITEMQUICK		= 51,
						PTC_ITEMACC			= 52,	//itemacc.jsp
						PTS_ITEMACC			= 52,
						PTC_ITEMACCNEW		= 102,	//itemaccnew.jsp
						PTS_ITEMACCNEW		= 102,
						PTC_ITEMINVENEXP	= 53,	//iteminvenexp.jsp
						PTS_ITEMINVENEXP	= 53,

						PTC_FACUPGRADE		= 54,	//facupgrade.jsp
						PTS_FACUPGRADE		= 54,

						PTC_SEEDBUY			= 55,	//seedbuy.jsp
						PTS_SEEDBUY			= 55,
						PTC_SEEDPLANT		= 56,	//seedplant.jsp
						PTS_SEEDPLANT		= 56,
						PTC_SEEDHARVEST		= 57,	//seedharvest.jsp
						PTS_SEEDHARVEST		= 57,

						PTC_TRADE			= 58,	//trade.jsp
						PTS_TRADE			= 58,
						PTC_SAVE			= 59,	//save.jsp
						PTS_SAVE			= 59,
						PTC_TRADECASH		= 71,	//tradecash.jsp
						PTS_TRADECASH		= 71,
						PTC_TRADECONTINUE	= 74,	//tradecontinue.jsp
						PTS_TRADECONTINUE	= 74,
						PTC_TRADECHANGE		= 103,	//tradechange.jsp
						PTS_TRADECHANGE		= 103,
						PTC_RANKLIST		= 124, 	//ranklist.jsp
						PTS_RANKLIST		= 124,

						PTC_PACKBUY			= 60,	//packbuy.jsp
						PTS_PACKBUY			= 60,
						PTC_ROULBUY			= 61,	//roulbuy.jsp
						PTS_ROULBUY			= 61,
						PTC_TREASUREBUY		= 112,	//treasurebuy.jsp
						PTS_TREASUREBUY		= 112,
						PTC_ROULACC			= 94,	//roulacc.jsp
						PTS_ROULACC			= 94,

						PTC_TREASUREUPGRADE	= 113,	//treasureupgrade.jsp
						PTS_TREASUREUPGRADE	= 113,
						PTC_TREASUREWEAR	= 114,	//treasurewear.jsp
						PTS_TREASUREWEAR	= 114,

						PTC_DOGAMLIST		= 44, 	//dogamlist.jsp
						PTS_DOGAMLIST		= 44,
						PTC_DOGAMREWARD		= 42, 	//dogamreward.jsp
						PTS_DOGAMREWARD		= 42,

						PTC_TUTORIAL		= 30,	//tutorial.jsp
						PTS_TUTORIAL		= 30,
						PTC_TUTOSTEP		= 75,	//tutostep.jsp
						PTS_TUTOSTEP		= 75,
						PTC_COMPETITION		= 63,	//competition.jsp
						PTS_COMPETITION		= 63,
						PTC_USERPARAM		= 64,	//userparam.jsp
						PTS_USERPARAM		= 64,
						PTC_CHANGEINFO		= 7,	//changeinfo.jsp
						PTS_CHANGEINFO		= 7,

						PTC_ANISET			= 46,	//aniset.jsp
						PTS_ANISET			= 46,
						PTC_ANIDIE			= 47,	//anidie.jsp
						PTS_ANIDIE			= 47,
						PTC_ANIREVIVAL		= 48,	//anirevival.jsp
						PTS_ANIREVIVAL		= 48,
						PTC_ANIUSEITEM		= 49,	//aniuseitem.jsp
						PTS_ANIUSEITEM		= 49,
						PTC_ANIREPREG		= 43,	//anirepreg.jsp
						PTS_ANIREPREG		= 43,
						PTC_ANIHOSLIST		= 45,	//anihoslist.jsp
						PTS_ANIHOSLIST		= 45,
						PTC_ANIURGENCY		= 62,	//aniurgency.jsp
						PTS_ANIURGENCY		= 62,
						PTC_ANIRESTORE		= 92,	//anirestore.jsp
						PTS_ANIRESTORE		= 92,
						PTC_ANICOMPOSE		= 97,	//anicompose.jsp
						PTS_ANICOMPOSE		= 97,
						PTC_ANICOMPOSEINIT	= 100,	//anicomposeinit.jsp
						PTS_ANICOMPOSEINIT	= 100,
						PTC_ANIPROMOTE		= 117,	//anipromote.jsp
						PTS_ANIPROMOTE		= 117,
						PTC_ANIUPGRADE		= 108, 	//aniupgrade.jsp
						PTS_ANIUPGRADE		= 108,
						PTC_ANIBATTLESTART	= 109, 	//anibattlestart.jsp
						PTS_ANIBATTLESTART	= 109,
						PTC_ANIBATTLERESULT	= 110, 	//anibattleresult.jsp
						PTS_ANIBATTLERESULT	= 110,
						PTC_ANIBATTLEPLAYCNTBUY	= 115, 	//anibattleplaycntbuy.jsp
						PTS_ANIBATTLEPLAYCNTBUY	= 115,
						PTC_APARTITEMCODE	= 116, 	//apartitemcode.jsp
						PTS_APARTITEMCODE	= 116,

						PTC_UBBOXOPENOPEN	= 118, 	//ubboxopenopen.jsp
						PTS_UBBOXOPENOPEN	= 118,
						PTC_UBBOXOPENCASH	= 119, 	//ubboxopencash.jsp
						PTS_UBBOXOPENCASH	= 119,
						PTC_UBBOXOPENCASH2	= 125, 	//ubboxopencash2.jsp
						PTS_UBBOXOPENCASH2	= 125,
						PTC_UBBOXOPENGETITEM= 120, 	//ubboxopengetitem.jsp
						PTS_UBBOXOPENGETITEM= 120,
						PTC_UBSEARCH		= 121, 	//ubsearch.jsp
						PTS_UBSEARCH		= 121,
						PTC_UBRESULT		= 122, 	//ubresult.jsp
						PTS_UBRESULT		= 122,
						PTC_WHEEL			= 126, 	//wheel.jsp
						PTS_WHEEL			= 126,
						PTC_RKRANK			= 127,	//rkrank.jsp
						PTS_RKRANK			= 127,
						PTC_ZCPCHANCE		= 128,	//zcpchance.jsp
						PTS_ZCPCHANCE		= 128,
						PTC_ZCPBUY			= 129,	//zcpbuy.jsp
						PTS_ZCPBUY			= 129,

						PTC_FWBUY			= 68,	//fwbuy.jsp
						PTS_FWBUY			= 68,
						PTC_FWSELL			= 69,	//fwsell.jsp
						PTS_FWSELL			= 69,
						PTC_FWINCOME		= 70,	//fwincome.jsp
						PTS_FWINCOME		= 70,
						PTC_FWINCOMEALL		= 95,	//fwincomeall.jsp
						PTS_FWINCOMEALL		= 95,

						PTC_FSEARCH			= 16, 	//fsearch.jsp
						PTS_FSEARCH			= 16,
						PTC_FADD			= 17, 	//fadd.jsp
						PTS_FADD			= 17,
						PTC_FDELETE			= 18, 	//fdelete.jsp
						PTS_FDELETE			= 18,
						PTC_FAPPROVE		= 65, 	//fapprove.jsp
						PTS_FAPPROVE		= 65,
						PTC_FHEART			= 66, 	//fheart.jsp
						PTS_FHEART			= 66,
						PTC_FPROUD			= 123, 	//fproud.jsp
						PTS_FPROUD			= 123,
						PTC_FPOINT			= 67,	//fpoint.jsp
						PTS_FPOINT			= 67,
						PTC_FMYFRIEND		= 19, 	//fmyfriend.jsp
						PTS_FMYFRIEND		= 19,
						PTC_FVISIT			= 20, 	//fvisit.jsp
						PTS_FVISIT			= 20,
						PTC_PUSHMSG			= 34,	//sendpush.jsp
						PTS_PUSHMSG			= 34,
						PTC_FBWRITE			= 72,	//fbwrite.jsp
						PTS_FBWRITE			= 72,
						PTC_FBREAD			= 73,	//fbread.jsp
						PTS_FBREAD			= 73,
						PTC_FRENT			= 93, 	//frent.jsp
						PTS_FRENT			= 93,
						PTC_FRETURN			= 107, 	//freturn.jsp
						PTS_FRETURN			= 107,

						PTC_SCHOOLSEARCH	= 76,	//schoolsearch.jsp
						PTS_SCHOOLSEARCH	= 76,
						PTC_SCHOOLJOIN		= 77,	//schooljoin.jsp
						PTS_SCHOOLJOIN		= 77,
						PTC_SCHOOLTOP		= 78,	//schooltop.jsp
						PTS_SCHOOLTOP		= 78,
						PTC_SCHOOLUSERTOP	= 79,	//schoolusertop.jsp
						PTS_SCHOOLUSERTOP	= 79,

						PTC_CERTNO			= 80,	//certno.jsp
						PTS_CERTNO			= 80,

						PTC_CASHBUY			= 14,	//cashbuy.jsp
						PTS_CASHBUY			= 14,

						PTC_PETTODAY		= 83,	//pettoday.jsp
						PTS_PETTODAY		= 83,
						PTC_PETROLL			= 84,	//petroll.jsp
						PTS_PETROLL			= 84,
						PTC_PETUPGRADE		= 85,	//petupgrade.jsp
						PTS_PETUPGRADE		= 85,
						PTC_PETWEAR			= 86,	//petwear.jsp
						PTS_PETWEAR			= 86,
						PTC_PETEXP			= 101,	//petexp.jsp
						PTS_PETEXP			= 101,

						PTC_YABAUCHANGE		= 104,	//yabauchange.jsp
						PTS_YABAUCHANGE		= 104,
						PTC_YABAUREWARD		= 105,	//yabaureward.jsp
						PTS_YABAUREWARD		= 105,
						PTC_YABAU			= 106,	//yabau.jsp
						PTS_YABAU			= 106,


						PTC_XXXXX			= 99,
						PTS_XXXXX			= 99,	//_xxxxx.jsp

						PTC_ROULETTE		= 6,	//roulette.jsp
						PTS_ROULETTE		= 6,
						PTC_ROULETTE2		= 37,	//roulette2.jsp
						PTS_ROULETTE2		= 37,


						PTC_RECHARGEACTION	= 12, 	//rechargeaction.jsp
						PTS_RECHARGEACTION	= 12,

						PTC_RANK			= 13,	//rank.jsp
						PTS_RANK			= 13,

						PTC_SENDSMS			= 33,	//sendsms.jsp
						PTS_SENDSMS			= 33;





	String strIP = request.getLocalAddr();
	String strPort;
	if(strIP.equals("192.168.0.11")){
		strIP = "210.123.107.7";
		strPort = "40009";
	}else{
		strIP = "14.63.218.20";
		strPort = "8989";
	}

	boolean DEBUG_LOG_PARAM = false;
	StringBuffer DEBUG_LOG_STR	= new StringBuffer();


      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");

	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;
	boolean DEBUG				= false;
	boolean DEBUG2				= false;
	DEBUG_LOG_PARAM 			= false;

	/////////////////////////////////////////////////
	//	iPhone 데이타
	//	com.sangsangdigital.farmip
	//	com.pictosoft.farmtycoon.apple
	/////////////////////////////////////////////////
	String striPhonePackageName[] = {
						//"sangsangdigital.com.homerunleague",					//야구.
						//"com.sangsangdigital.farmip",							//목장.
						//"com.pictosoft.farmtycoon.apple",
						"com.marbles.farmvill5ip"								//목장5.
	};
	String striPhoneListName[] = {
						//"199",	"homerungold_15", 			"638657470",	//야구.
						//"499",	"homerungold_55",  			"638657906",
						//"899",	"homerungold_114",  		"638657925",
						//"2699",	"homerungold_400",  		"638658016",
						//"4599",	"homerungold_635",  		"638658206",
						//"8999",	"homerungold_1320",  		"638658446",
						"299",		"farm_3300", 				"792552120",	//목장5.
						"499",		"farm_5500",  				"792552123",
						"999",		"farm_11000",  				"792552130",
						"2999",		"farm_33000",  				"792552166",
						"4999",		"farm_55000",  				"792552168",
						"9999",		"farm_110000",  			"792552170"
	};

	/////////////////////////////////////////////////
	//	Android Googel 데이타
	//	com.sangsangdigital.farmgg
	/////////////////////////////////////////////////
	String strAndroidPackageName[] = {
						//"com.sangsangdigital.homerunleaguegg",				//야구.
						"com.sangsangdigital.farmgg",							//목장T.
						"com.sangsangdigital.farmggtest",
						"com.marbles.farmvill5gg"								//목장5.
	};
	String strAndroidListName[] = {
						//"2000",	"homerun_1500",		"turn_homerun_1500",	//야구.
						//"5000",	"homerun_5000",		"turn_homerun_5000",
						//"9900",	"homerun_9900",		"turn_homerun_9900",
						//"29000",	"homerun_29000",	"turn_homerun_29000",
						//"55000",	"homerun_50000",	"turn_homerun_50000",
						//"99000",	"homerun_99000",	"turn_homerun_99000",

						"3300",		"farm_3300",		"farm2_3300",			//목장.
						"5500",		"farm_5500",		"farm2_5500",
						"11000",	"farm_11000",		"farm2_11000",
						"33000",	"farm_33000",		"farm2_33000",
						"55000",	"farm_55000",		"farm2_55000",
						"110000",	"farm_110000",		"farm2_110000"
	};
	String strAndroidReceiptCode[] = {
						"GPA.",													//신규.
						"12999763169054705758."									//목장T.
	};

	/////////////////////////////////////////////////////////
	//	SKT
	//	com.marbles.farmvill5sk
	/////////////////////////////////////////////////////////
	String strSKTAIDList[] = {
						"OA00646546",					//야구.
						"OA00652027",					//목장.
						"OA00700316"					//K5
	};
	int nSKTMoneyList[] = {						//가격
						3300,
						5500,
						11000,
						33000,
						55000,
						110000
	};
	String strSKTPIDList[] = {
						//상상					픽토
						"0910047079", 			"0910007674",
						"0910047080",  			"0910007676",
						"0910047081",  			"0910007677",
						"0910047082",  			"0910007678",
						"0910047083",  			"0910007679",
						"0910047084",  			"0910007680"
	};
	/////////////////////////////////////////////////////////
	//	NHN
	//	com.sangsangdigital.farmnhn
	/////////////////////////////////////////////////////////
	//String strNHNAIDList[] = {
	//					"TCTK407241403247287967"		//목장.
	//};
	//int nNHNMoneyList[] = {						//가격
	//					1100,
	//					5500,
	//					9900,
	//					33000,
	//					55000,
	//					99000
	//};
	//String strNHNPIDList[] = {
	//					//픽토
	//					"1000007929",
	//					"1000007928",
	//					"1000007927",
	//					"1000007926",
	//					"1000007925",
	//					"1000007924"
	//};

	int summary 		= 0;

	//1. 데이타 받기
	int mode			= util.getParamInt(request, "mode", 	1);
	String gameid 		= util.getParamStr(request, "gameid", 	"");
	String password		= util.getParamStr(request, "password", "");
	String giftid 		= util.getParamStr(request, "giftid", 	"");

	int market			= util.getParamInt(request, "market", 	1);
	int itemcode		= util.getParamInt(request, "itemcode", 0);
	String cashcost		= util.getParamStr(request, "cashcost", "0");
	String cash			= util.getParamStr(request, "cash", 	"0");
	int cashcost2		= 0;
	int cash2			= 0;
	String ucode		= util.getParamStr(request, "ucode", 	"");
	String kakaogameid	= util.getParamStr(request, "kakaogameid", "");

	String ikind		= util.getParamStr(request, "ikind", 	"");	//iPhone(sandbox, real), google( )
	String acode		= util.getParamStr(request, "acode", 	"");
	String idata		= util.getParamStr(request, "idata", 	"");
	String idata2		= util.getParamStr(request, "idata2", "");
	/////////////////////////////////////////////////////////////////////
	//		파라미터 받기
	/////////////////////////////////////////////////////////////////////
	if(DEBUG_LOG_PARAM){
		DEBUG_LOG_STR.append(this);
		DEBUG_LOG_STR.append("\r\n?mode=" 			+ mode);
		DEBUG_LOG_STR.append("\r\n&gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n&giftid=" 		+ giftid);
		DEBUG_LOG_STR.append("\r\n&password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n&market=" 		+ market);

		DEBUG_LOG_STR.append("\r\n&itemcode=" 		+ itemcode);
		DEBUG_LOG_STR.append("\r\n&cashcost=" 		+ cashcost);
		DEBUG_LOG_STR.append("\r\n&cash=" 			+ cash);
		DEBUG_LOG_STR.append("\r\n&ucode=" 			+ ucode);
		DEBUG_LOG_STR.append("\r\n&kakaogameid=" 	+ kakaogameid);

		DEBUG_LOG_STR.append("\r\n&ikind=" 			+ ikind);
		DEBUG_LOG_STR.append("\r\n&acode=" 			+ acode);
		DEBUG_LOG_STR.append("\r\n&idata=" 			+ idata);
		DEBUG_LOG_STR.append("\r\n&idata2=" 		+ idata2);

		System.out.println(DEBUG_LOG_STR.toString());
	}
	/////////////////////////////////////////////////////////////////////

	try{
		if(DEBUG)System.out.println("[Input Data]<br>"
							+ "mode:" + mode + " <br>"
							+ " gameid:" + gameid + " <br>"
							+ " giftid:" + giftid + " <br>"
							+ " password:" + password + " <br>"
							+ " acode:" + acode + " <br>"
							+ " ucode:" + ucode + " <br>"
							+ " market:" + market + " <br>"
							+ " itemcode:" + itemcode + " <br>"
							+ " cash:" + cash + " <br>"
							+ " cashcost:" + cashcost + " <br>"
							+ " ikind:" + util.getParamStr(request, "ikind", "") + " <br>"
							+ "==============================================<br>");

		//구매한 골든볼. 캐쉬.
		cashcost 	= getDencode4(cashcost, 	14+14, "-1");
		cash 		= getDencode4(cash, 		14+14, "-2");
		if(DEBUG)System.out.println("cashcost:" + cashcost + ", cash:" + cash + "<br>");

		if(ucode == null){
			if(DEBUG)System.out.println(" > ucode is null<br>");
			summary = 0;
		}else if(ucode.length() < (3+1+8+4+14+2+3)){
			//유효하지 않는 길이도 리턴한다.
			if(DEBUG)System.out.println(" > size lack:" + ucode.length() + "<br>");
			summary = 0;
		}else{
			//유효성검사
			//out.println("3");
			int _len = ucode.length();
			int _loop = getInt(ucode, 3, 1);
			byte _sum = (byte)getInt(ucode, _len - 3, 3);
			String ucode2 = getString(ucode, 4, _len - (3+1+3));
			byte[] ucodeByte = ucode2.getBytes();
			int _len2 = ucodeByte.length;
			byte _sum2 = 0;
			for(int i = 0; i < _len2; i++){
				ucodeByte[i] = getByte(ucodeByte[i], _loop);
				_sum2 += ucodeByte[i];
			}

			//서머리검사
			if(_sum != _sum2){
				summary = 0;
			}else{
				summary = 1;
			}
			String ucode3 = new String(ucodeByte);
			//골드와 캐쉬
			cash2 = getInt(ucode3, 0, 8) - 12345678;
			cashcost2 = getInt(ucode3, 8, 8) - 87654321;

			if(DEBUG)System.out.println("[ucode(parsing)]:" + ucode + "<br>"
								+ " _loop:" + _loop + "<br>"
								//+ " " + getString(ucode, _len - 3, 3) + "<br>"
								+ " _sum:" + _sum + "<br>"
								+ " _sum2:" + _sum2 + "<br>"
								+ " ucode2:" + ucode2 + "<br>"
								+ " ucode3:" + ucode3 + "<br>"
								+ " summary1:" + summary + "<br>"
								+ " _len:" + _len + "<br>"
								+ " _len2:" + _len2 + "<br>"
								+ " cash2:" + cash2 + "<br>"
								+ " cashcost2:" + cashcost2 + "<br>"
								+ " cash:" + cash + "<br>"
								+ " cashcost:" + cashcost + "<br>"
								+ "===========================================<br>");
		}


		if(market == IPHONE){
			if(DEBUG)System.out.println("[iPhone]<br>");

			if(!ikind.equals("")){
				//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
				//2. iPhone에서 보내진 데이타를 넘겨서 > URL포팅해서 전달 > Apple에 인증
				if(DEBUG)System.out.println(" > ikind:"+ikind+"<br>");
				if(DEBUG)System.out.println(" > idata:"+idata+"<br>");
				idata2 = callAppleSite(ikind, idata);
				if(DEBUG)System.out.println(" > idata2:"+idata2+"<br>");
				if(DEBUG)System.out.println(" > cash:"+cash+"<br>");
				if(DEBUG)System.out.println(" > striPhonePackageName:"+striPhonePackageName[0]+"<br>");
				if(DEBUG)System.out.println(" > striPhoneListName:"+striPhoneListName[0]+"<br>");

				//3. 데이타 파싱하기
				boolean biPhoneState = getiPhoneSuccess(idata2, cash, striPhonePackageName, striPhoneListName);
				if(!biPhoneState){
					if(DEBUG)System.out.println(" > iPhone idata2 error<br>");
					summary = 0;
				}else{
					acode = getiPhoneInfo(idata2, "original_transaction_id");
					if(DEBUG)System.out.println(" > acode:" + acode);
				}
			}else{
				if(DEBUG)System.out.println(" > iPhone iKind Empty error<br>");
				summary = 0;
			}
		}else if(market == SKT){
			if(DEBUG)System.out.println("[SKT]<br>");

			if(!ikind.equals("")){
				//0. txid을 받아오기.
				acode = getSKTtxid(idata);
				if(DEBUG)System.out.println("idata:" + idata);
				if(DEBUG)System.out.println("acode:" + acode);
				if(DEBUG)System.out.println("ikind:" + ikind);

				//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
				//2. SKT에서 보내진 데이타를 넘겨서 > URL포팅해서 전달 > SKT에 인증
				idata2 = callSKTSite(ikind, idata);
				if(DEBUG)System.out.println("idata2:" + idata2);

				//3. 데이타 파싱하기
				boolean _bSKTState = getSKTSuccess(idata2, Integer.parseInt(cash), strSKTAIDList, nSKTMoneyList, strSKTPIDList);
				if(!_bSKTState){
					if(DEBUG)System.out.println(" > SKT idata2 error<br>");
					summary = 0;
				}
			}else{
				if(DEBUG)System.out.println(" > SKT iKind Empty error<br>");
				summary = 0;
			}
		//}else if(market == NHN){
		//	if(DEBUG)System.out.println("[NHN]<br>");
		//	//ikind		: TEST, REAL
		//	//acode		: 1004745009
		//	//idata		: {"receipt":{"extra":"extra","environment":"TEST","paymentSeq":"1004745009","productCode":"1000007929","paymentTime":1404129513498,"approvalStatus":"APPROVED"},"nonce":7433694377350428587}
		//	//idata2	: {"signature":"isGg3PAYv2R\/BqJbvITBeGmRiUWq5vnmP4UE0vBDmHOWgep79agQugScVYSH9Ctg5dRganZ5Li39\/tdDB2\/gKIeuMgQV1cSFTYqKgDHbW9PNAfakTt9zWB+csGRlCPvl4iEWWeqfQL4oEv54DDsQRXhmbS+S1n3C3HnSXtbzZFY="}
        //
		//	if(!ikind.equals("")){
		//		//0. 데이타를 그대로 받음.
		//		if(DEBUG)System.out.println("ikind:" + ikind);
		//		if(DEBUG)System.out.println("acode:" + acode);
		//		if(DEBUG)System.out.println("idata:" + idata);
		//		if(DEBUG)System.out.println("idata2:" + idata2);
        //
		//		//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
		//		//2. 데이타 파싱하기
		//		boolean _bNHNState = getNHNSuccess(idata2, strNHNPIDList, acode);
		//		if(!_bNHNState){
		//			if(DEBUG)System.out.println(" > NHN idata2 error<br>");
		//			summary = 0;
		//		}
		//	}else{
		//		if(DEBUG)System.out.println(" > NHN iKind Empty error<br>");
		//		summary = 0;
		//	}
		}else if(market == GOOGLE){
			//http://203.234.238.249:40009/Game4Farm/goo/cashbuy.jsp?mode=1&gameid=xxxx2&giftid=&password=049000s1i0n7t8445289&ucode=41767890323443210907dddd88679776060099800130&market=5&itemcode=5000&cash=4448644482164575548488776181&cashcost=8880086160708919982822110190&ikind=GoogleID&idata2=12999763169054705758.1319607302512252&acode={ "receipt":{"orderId":"12999763169054705758.1319607302512252","packageName":"com.sangsangdigital.homerunleagueggtest3","productId":"homerun_1500","purchaseTime":1378184267000,"purchaseState":0,"purchaseToken":"gqzrcllpeiqlbfgpkxuhrcon.AO-J1Oy4jD7ZPpMeuhB9YwlYiqlc-K8GShu6uPG0aTDZzFfvRxXWF6-ucThc6F6gUkVuyZvrxwqp0KG2wetmZvLvP2JgD3eR4J9a_6yd4CQSScMcqwVgNpCAXPmRBxuLIzKTHZeDdqCUq2WS0OhkIDze8kVIGI0fCA"}, "status":0}
			//http://203.234.238.249:40009/Game4Farm/goo/cashbuy.jsp?mode=1&gameid=xxxx2&giftid=&password=049000s1i0n7t8445289&ucode=41767890323443210907dddd88679776060099800130&market=5&itemcode=5000&cash=4448644482164575548488776181&cashcost=8880086160708919982822110190&ikind=googlekw&acode=12999763169054705758.1319607302512252&idata2={ "receipt":{"orderId":"12999763169054705758.1319607302512252","packageName":"com.sangsangdigital.homerunleagueggtest3","productId":"homerun_1500","purchaseTime":1378184267000,"purchaseState":0,"purchaseToken":"gqzrcllpeiqlbfgpkxuhrcon.AO-J1Oy4jD7ZPpMeuhB9YwlYiqlc-K8GShu6uPG0aTDZzFfvRxXWF6-ucThc6F6gUkVuyZvrxwqp0KG2wetmZvLvP2JgD3eR4J9a_6yd4CQSScMcqwVgNpCAXPmRBxuLIzKTHZeDdqCUq2WS0OhkIDze8kVIGI0fCA"}, "status":0}
			//http://203.234.238.249:40009/Game4Farm/goo/cashbuy.jsp?mode=1&gameid=xxxx2&password=049000s1i0n7t8445289&giftid=&kakaogameid=91188455545412240&ikind=googlekw&acode=12999763169054705758.1324208103674906&idata=&idata2=%7b+%22receipt%22%3a%7b%22orderId%22%3a%2212999763169054705758.1323631300639409%22%2c%22packageName%22%3a%22com.sangsangdigital.mokjanggg%22%2c%22productId%22%3a%22farm_9900%22%2c%22purchaseTime%22%3a1383720381901%2c%22purchaseState%22%3a0%2c%22developerPayload%22%3a%22optimus%22%2c%22purchaseToken%22%3a%22zmjsgzkhoqngotpchnghpmql.AO-J1Oym516yHp58m15m_oBuGauSWSDajCx5zYnlBmVXjH8lHDv2X-ZXRDE7cuZV9UdZ82VPgDw795V6jVYSV4mmJpJ3y1pxoUXACa-5uAto9CeCBTYzePTPcrbIK4jUdP_592FNuE3I%22%7d%2c+%22status%22%3a0%7d&ucode=21256789122332109888cccc77569586550600348142&market=5&itemcode=5000&cash=7771887713897817087728225180&cashcost=8880900703408928198839336192

			if(DEBUG)System.out.println("[Google]<br>");

			if(ikind.equals("googlekw")){
				//1. json형태 데이타를 받기.
				//3. 데이타 파싱하기
				if(DEBUG)System.out.println(" market:" + market + "<br>"
									+ " idata:" + idata + "<br>"
									+ " cash:" + cash + "<br>"
									+ " strAndroidPackageName:" + strAndroidPackageName + "<br>"
									+ " strAndroidListName:" + strAndroidListName + "<br>");


				boolean bGoogleState = getGoogleSuccess(market, idata2, cash, strAndroidPackageName, strAndroidListName);
				if(DEBUG)System.out.println(" > bGoogleState:" + bGoogleState + "<br>");

				if(!bGoogleState){
					if(DEBUG)System.out.println(" > Google bGoogleState error<br>");
					summary = 0;
				}

				//인증키 검사하기.
				int _len = strAndroidReceiptCode.length;
				int _check = 0;
				for(int i = 0; i < _len; i++){
					if(acode.indexOf(strAndroidReceiptCode[i]) == 0){
						_check++;
						break;
					}
				}

				if(_check == 0){
					if(DEBUG)System.out.println(" > Google ReceiptCode error<br>");
					summary = 0;
				}
			}else{
				if(DEBUG)System.out.println(" > Google GoogleID Empty error<br>");
				summary = 0;
			}
		}else{
			if(DEBUG)System.out.println("[SKT]<br>");
		}

		if(DEBUG2)System.out.println(
							"mode:" + mode
							+ " gameid:" +  gameid
							+ " giftid:" +  giftid
							+ " password:" +  password
							+ " acode:" +  acode
							+ " ucode:" +  ucode
							+ " market:" +  market
							+ " summary:" +  summary
							+ " itemcode:" +  itemcode
							+ " cashcost:" +  cashcost
							+ " cash:" +  cash
							+ " cashcost2:" +  cashcost2
							+ " cash2:" +  cash2
							+ " ikind:" +  ikind
							+ " idata:" +  idata
							+ " idata2:" +  idata2
							+ " kakaogameid:" + kakaogameid
							);

		//2. 데이타 조작
		//exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945c2', 5, 1, 5000, 20,    2000, 20,    2000, '', '', '', -1	-- 구매
		//exec spu_CashBuy 2, 'xxxx3', 'xxxx2', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d2', 5, 1, 5000, 20,    2000, 20,    2000, '', '', '', -1	-- 선물
		query.append("{ call dbo.spu_CashBuy (?, ?, ?, ?, ?, 	?, ?, ?, ?, ?, 	?, ?, ?, ?, ?, 	?, ?, ?)} ");
		cstmt = conn.prepareCall(query.toString());

		cstmt.setInt(idxColumn++, mode);
		cstmt.setString(idxColumn++, gameid);
		cstmt.setString(idxColumn++, giftid);
		cstmt.setString(idxColumn++, password);
		cstmt.setString(idxColumn++, acode);
		cstmt.setString(idxColumn++, ucode);
		cstmt.setInt(idxColumn++, market);
		cstmt.setInt(idxColumn++, summary);
		cstmt.setInt(idxColumn++, itemcode);
		cstmt.setString(idxColumn++, cashcost);
		cstmt.setString(idxColumn++, cash);
		cstmt.setInt(idxColumn++, cashcost2);
		cstmt.setInt(idxColumn++, cash2);
		cstmt.setString(idxColumn++, ikind);
		cstmt.setString(idxColumn++, idata);
		cstmt.setString(idxColumn++, idata2);
		cstmt.setString(idxColumn++, kakaogameid);
		cstmt.registerOutParameter(idxColumn++, Types.INTEGER);

		//2-2. 스토어즈 프로시져 실행하기
		result = cstmt.executeQuery();

		//2-3-1. 코드결과값 받기(1개)
		if(result.next()){
			resultCode = result.getInt("rtn");
			resultMsg.append(result.getString(2));
		}

		msg.append("<?xml version='1.0' encoding='utf-8'?>\n");
		msg.append("<rows>\n");
		msg.append("	<result>\n");
		msg.append("		<code>");			msg.append(PTS_CASHBUY); 				msg.append("</code>\n");
		msg.append("		<resultcode>");		msg.append(resultCode);    				msg.append("</resultcode>\n");
		msg.append("		<resultmsg>");		msg.append(resultMsg.toString());		msg.append("</resultmsg>\n");
		msg.append("	</result>\n");


	    //행동력 데이타를 갱신해준다.
		if(resultCode == 1){
			if(cstmt.getMoreResults()){
				result = cstmt.getResultSet();
				if(result.next()){
					msg.append("	<cashbuy>\n");
					msg.append("		<gameid>");			msg.append(result.getString("gameid"));   		msg.append("</gameid>\n");
					msg.append("		<cashcost>");		msg.append(result.getString("cashcost"));    	msg.append("</cashcost>\n");
					msg.append("		<gamecost>");		msg.append(result.getString("gamecost"));    	msg.append("</gamecost>\n");
					msg.append("		<heart>");			msg.append(result.getString("heart"));    		msg.append("</heart>\n");
					msg.append("		<feed>");			msg.append(result.getString("feed"));    		msg.append("</feed>\n");

					msg.append("		<cashpoint>");		msg.append(result.getString("cashpoint"));    	msg.append("</cashpoint>\n");
					msg.append("	</cashbuy>\n");
				}
			}
		}
	    msg.append("</rows>\n");
	}catch(Exception e){
		System.out.println("==============================");
		System.out.println("e:" + e);
		DEBUG_LOG_STR.append(this);

		DEBUG_LOG_STR.append("\r\n?mode=" 			+ mode);
		DEBUG_LOG_STR.append("\r\n&gameid=" 		+ gameid);
		DEBUG_LOG_STR.append("\r\n&password=" 		+ password);
		DEBUG_LOG_STR.append("\r\n&giftid=" 		+ giftid);

		DEBUG_LOG_STR.append("\r\n&market=" 		+ market);
		DEBUG_LOG_STR.append("\r\n&itemcode=" 		+ itemcode);
		DEBUG_LOG_STR.append("\r\n&cashcost=" 		+ cashcost);
		DEBUG_LOG_STR.append("\r\n&cash=" 			+ cash);
		DEBUG_LOG_STR.append("\r\n&ucode=" 			+ ucode);
		DEBUG_LOG_STR.append("\r\n&kakaogameid=" 	+ kakaogameid);

		DEBUG_LOG_STR.append("\r\n&ikind=" 			+ ikind);
		DEBUG_LOG_STR.append("\r\n&acode=" 			+ acode);
		DEBUG_LOG_STR.append("\r\n&idata="	 		+ idata);
		DEBUG_LOG_STR.append("\r\n&idata2=" 		+ idata2);
		System.out.println(DEBUG_LOG_STR.toString());
	}
	/**/


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);

      out.write('\r');
      out.write('\n');
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else log(t.getMessage(), t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
