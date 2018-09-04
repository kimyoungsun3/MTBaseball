<%!
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
%>

