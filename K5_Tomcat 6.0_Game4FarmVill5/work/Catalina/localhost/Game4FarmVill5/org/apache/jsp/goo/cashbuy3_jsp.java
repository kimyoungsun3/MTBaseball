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

public final class cashbuy3_jsp extends org.apache.jasper.runtime.HttpJspBase
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



	/*
	ikind	: googlekw
	ucode	: 12999763169054705758.1323631300639409
	idata	:
	idata2	: {"receipt":{"orderId":"12999763169054705758.1323631300639409","packageName":"com.sangsangdigital.mokjanggg","productId":"farm_9900","purchaseTime":1383720381901,"purchaseState":0,"developerPayload":"optimus","purchaseToken":"zmjsgzkhoqngotpchnghpmql.AO-J1Oym516yHp58m15m_oBuGauSWSDajCx5zYnlBmVXjH8lHDv2X-ZXRDE7cuZV9UdZ82VPgDw795V6jVYSV4mmJpJ3y1pxoUXACa-5uAto9CeCBTYzePTPcrbIK4jUdP_592FNuE3I"}, "status":0}

	ikind	: sandbox
	ucode	: 1000000103970175
	idata	: ewoJInNpZ25hdHVyZSIgPSAiQWlvN0RIQ0N4V0o3NURUOE1zS1ljQ3kwbWhIS3pr  N2RoU1lPWEJWN0hBRlE5anNZWHdIekZudGxMSmhPeW1DNUFObU9mb0FaUGQvaVhI  UzNVdFpsblhvcjViU0c2aG5JSk0wMitBeHYvd3NabGwyMTNCeW1SNUlHOG9UaC9L  dlZrZ2ExQXFubTNaeDAxYXZIa2s5Qk9lRUNiUENOSTlVNGZaMmc4V2U3bXhsM0FB  QURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RR  RUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pT  QkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlF  RjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIz  SmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5U  SXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVI  VnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVr  RndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NX  NWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZ  MEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1Yv  cnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRk  S1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJ  ZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNq  QndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBn  RVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERn  UVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0Jn  VUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lC  M1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNl  VFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIw  N2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FR  Vnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xv  SHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5q  K2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2Jw  MGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJw  dXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdS  aGRHVXRjSE4wSWlBOUlDSXlNREV6TFRBMkxURXlJREF4T2pNeU9qSTNJRUZ0WlhK  cFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdW  eUlpQTlJQ0l3WVdNM05UUXpZMkppWkRRM1lqRmhPVGRsTTJaaFpEY3pNamt4WWpB  eU1UTm1ZelV4TldOaUlqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2Ymkx  cFpDSWdQU0FpTVRBd01EQXdNREEzTnpBeU1ETTNOeUk3Q2draVluWnljeUlnUFNB  aU1TNHhMallpT3dvSkluUnlZVzV6WVdOMGFXOXVMV2xrSWlBOUlDSXhNREF3TURB  d01EYzNNREl3TXpjM0lqc0tDU0p4ZFdGdWRHbDBlU0lnUFNBaU1TSTdDZ2tpYjNK  cFoybHVZV3d0Y0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTNNVEF5TlRr  ME56VTRPU0k3Q2draWRXNXBjWFZsTFhabGJtUnZjaTFwWkdWdWRHbG1hV1Z5SWlB  OUlDSkZOVVV6UlVNeU5TMDFSVVpGTFRRd09UTXRPREV4UlMwNFFVWTFNRGM1UlRr  M05FVWlPd29KSW5CeWIyUjFZM1F0YVdRaUlEMGdJbWh2YldWeWRXNW5iMnhrWHpF  MUlqc0tDU0pwZEdWdExXbGtJaUE5SUNJMk16ZzJOVGMwTnpBaU93b0pJbUpwWkNJ  Z1BTQWljMkZ1WjNOaGJtZGthV2RwZEdGc0xtTnZiUzVvYjIxbGNuVnViR1ZoWjNW  bElqc0tDU0p3ZFhKamFHRnpaUzFrWVhSbExXMXpJaUE5SUNJeE16Y3hNREkxT1RR  M05UZzVJanNLQ1NKd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERXpMVEEyTFRF  eUlEQTRPak15T2pJM0lFVjBZeTlIVFZRaU93b0pJbkIxY21Ob1lYTmxMV1JoZEdV  dGNITjBJaUE5SUNJeU1ERXpMVEEyTFRFeUlEQXhPak15T2pJM0lFRnRaWEpwWTJF  dlRHOXpYMEZ1WjJWc1pYTWlPd29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdS  aGRHVWlJRDBnSWpJd01UTXRNRFl0TVRJZ01EZzZNekk2TWpjZ1JYUmpMMGROVkNJ  N0NuMD0iOwoJImVudmlyb25tZW50IiA9ICJTYW5kYm94IjsKCSJwb2QiID0gIjEw  MCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9
	idata2	: {"receipt":{"original_purchase_date_pst":"2013-06-12 01:32:27 America/Los_Angeles", "purchase_date_ms":"1371025947589", "unique_identifier":"0ac7543cbbd47b1a97e3fad73291b0213fc515cb", "original_transaction_id":"1000000077020377", "bvrs":"1.1.6", "transaction_id":"1000000077020377", "quantity":"1", "unique_vendor_identifier":"E5E3EC25-5EFE-4093-811E-8AF5079E974E", "item_id":"638657470", "product_id":"homerungold_15", "purchase_date":"2013-06-12 08:32:27 Etc/GMT", "original_purchase_date":"2013-06-12 08:32:27 Etc/GMT", "purchase_date_pst":"2013-06-12 01:32:27 America/Los_Angeles", "bid":"sangsangdigital.com.homerunleague", "original_purchase_date_ms":"1371025947589"}, "status":0}

	ikind	: skt
	ucode	: TX_00000000091709
	idata	: "{\"signdata\":\"MIIH+gYJKoZIhvcNAQcCoIIH6zCCB+cCAQExDzANBglghkgBZQMEAgEFADBZBgkqhkiG9w0BBwGgTARKMjAxMzEyMDExNzEyNDd8VFhfMDAwMDAwMDAwOTE3MDl8MDEwNDY4MDMwNjZ8T0EwMDY0NjU0NnwwOTEwMDA0MzA4fDIwMDB8fHygggXvMIIF6zCCBNOgAwIBAgIDT7hrMA0GCSqGSIb3DQEBCwUAME8xCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEVMBMGA1UEAwwMQ3Jvc3NDZXJ0Q0EyMB4XDTEyMTIyMTA0MjcwMFoXDTEzMTIyMTE0NTk1OVowgYwxCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEbMBkGA1UECwwS7ZWc6rWt7KCE7J6Q7J247KadMQ8wDQYDVQQLDAbshJzrsoQxJDAiBgNVBAMMG+yXkOyKpOy8gOydtCDtlIzrnpjri5so7KO8KTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMy0j+0TIEctoIbhJp8MD+DFWwas3ejmfasmZ2jXW44y2wHWWHX4UfOVzM9GJMYdjp5BVOgGylTk32dsysjxzQLtChKIJydSfvgrNisfSndzijxxi8yE9CZoe\\/BL+Czgxyq29oEIxUp8izXrrOEaOb\\/9Vd5QbIsK7auGu6CdiN5H+naKAoCcrptQikcSyvuUKrqTEvgIQtpnLIAxHUq5Yd0RBU\\/OW7ToY4I703xhre3arQRaRoeXfUwKQv0zQEUTVkDyS\\/dT0KYETFbWhmSC689\\/t6Odccml9+S98peqxqs7jxYpiT1gOg8EF0HgBW+yy2jWgSfirYvj4DHf7z50kfECAwEAAaOCApAwggKMMIGPBgNVHSMEgYcwgYSAFLZ0qZuSPMdRsSKkT7y3PP4iM9d2oWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICEAQwHQYDVR0OBBYEFBdwpU\\/Z\\/kva797rgtl+huf9m0ooMA4GA1UdDwEB\\/wQEAwIGwDCBgwYDVR0gAQH\\/BHkwdzB1BgoqgxqMmkQFBAEDMGcwLQYIKwYBBQUHAgEWIWh0dHA6Ly9nY2EuY3Jvc3NjZXJ0LmNvbS9jcHMuaHRtbDA2BggrBgEFBQcCAjAqHii8+AAgx3jJncEcx1gAIMcg1qiuMKwEx0AAIAAxsUQAIMeFssiy5AAuMHoGA1UdEQRzMHGgbwYJKoMajJpECgEBoGIwYAwb7JeQ7Iqk7LyA7J20IO2UjOuemOuLmyjso7wpMEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCDnstgCMlYs4YsIkS3E0PdeGKoWB93Wgpowj0jLuQQfEjB\\/BgNVHR8EeDB2MHSgcqBwhm5sZGFwOi8vZGlyLmNyb3NzY2VydC5jb206Mzg5L2NuPXMxZHA2cDExMDYsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89Q3Jvc3NDZXJ0LGM9S1I\\/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBGBggrBgEFBQcBAQQ6MDgwNgYIKwYBBQUHMAGGKmh0dHA6Ly9vY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAjmfND0w8NuggOa9qxt6vGWHyU4YcZBhNJ88AVxnIYeOP+vFO7y2kTguEF+yDV+x+a+Fxc54icRNBi4iwq8xF9C2\\/H6yLAR3YBKLZS+1QdYXtpTp4vnlBuugFNR8FtLni4R3rFfqXf+96V7liApgPVYU31go5YIWJYBJoiXz8\\/mXD3ZNCV8kOOqDtf\\/VFwO1vn8nqCnPCzoe9Sq2dm1+TaRsJD9NTf4E9z4xoPjdz\\/6q97X3D3kcIgUH6jYi\\/hwsGBgqYyKuT4+WImqJilWPjlDFMYI+RVsdiSL1tg4atYnsW6KGoAEk3ve46W04nCZzM3fVvDu4rzsV7zZ1SZ4rbxjGCAYEwggF9AgEBMFYwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTICA0+4azANBglghkgBZQMEAgEFADANBgkqhkiG9w0BAQsFAASCAQCjeaxPvidtQuIV0skqPo4z+PWNKhLCvtskVQRvAIGnvmieCfnP+pOmLrv4VxrD9yeRbG7GfEGRD\\/W66z\\/0+tD6ku8gFYwRMzsXYVYenIiqJtG2havqMHCyGKxhxqdKYkcDwwTTzdRRmzAo2x\\/FWYV1HMQjqYiQntHeSC\\/5I3mGnATCF3ijvKWIUOc0HA59\\/fuWrut2oSAi5nw8IAvzUOMHaA\\/7f7XzHVGd5vV0sMJ1qYL29TA+EdozYh7Y\\/2usNVLZqJ\\/5yz9lbAuQ8ScYu3GIKiAdjQDASy\\/fqngZfz6Tj8PPx4t3PRz3ZXJsH+ZRdPh2ju3+gFUcFWQvOg\\/UP+v1\",\"txid\":\"TX_00000000091709\",\"appid\":\"OA00646546\"}";
	idata2	: {"product":[{"appid":"OA00646546","bp_info":"","charge_amount":2000,"detail_pname":"",            "log_time":"20131201171247","product_id":"0910004308","tid":""}],"message":"정상검증완료.",   "detail":"0000","count":1,"status":0}
	    _data:{"product":[{"appid":"OA00700316","bp_info":"","charge_amount":3300,"detail_pname":"猷⑤퉬 310媛?,"log_time":"20160518173754","product_id":"0910047079","tid":""}],"message":"?뺤긽寃?쬆?꾨즺.","detail":"0000","count":1,"status":0}
	*/



	////////////////////////////////////////
	//SKT 인증하기
	////////////////////////////////////////
	public String callSKTSite(String _strIKind, String _strParam){
		//1-1. 네트워크 정의
		String SKT_URL_TEST 	= "https://iapdev.tstore.co.kr/digitalsignconfirm.iap";
		String SKT_URL_REAL 	= "https://iap.tstore.co.kr/digitalsignconfirm.iap";
		String SKT_REAL			= "real";
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

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/goo/_define.jsp");
    _jspx_dependants.add("/goo/_checkfun.jsp");
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
      out.write(" \r\n");
      out.write("\r\n");
      out.write("\r\n");
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
	boolean DEBUG				= true;


	/////////////////////////////////////////////////////////
	//	SKT
	/////////////////////////////////////////////////////////
	String strSKTAIDList[] = {
						"OA00646546",					//야구.
						"OA00652027",					//목장.
						"OA00700316"					//K5
	};
	int nSKTMoneyList[] = {							//가격
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


	String ikind		= util.getParamStr(request, "ikind", "");	//SKT SandBox or Real
	String idata		= "";										//영수증 전문(3k)
	String idata2		= "";
	int summary, market, cash;

	///////////////////////////////////////////////////
	ikind	= "debug1";
	idata 	= "{\"appid\":\"OA00700316\",\"txid\":\"TX_00000000336707\",\"signdata\":\"MIIIBAYJKoZIhvcNAQcCoIIH9TCCB\\/ECAQExDzANBglghkgBZQMEAgEFADBjBgkqhkiG9w0BBwGgVgRUMjAxNjA1MTgxNzM0NTh8VFhfMDAwMDAwMDAzMzY3MDd8MDEwMzI0ODMxNDR8T0EwMDcwMDMxNnwwOTEwMDQ3MDc5fDMzMDB8fHy357rxIDMxMLCzoIIF7jCCBeowggTSoAMCAQICBAEDYIQwDQYJKoZIhvcNAQELBQAwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTIwHhcNMTUxMjE2MDUyMzAwWhcNMTYxMjIxMTQ1OTU5WjCBjDELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQLDBLtlZzqta3soITsnpDsnbjspp0xDzANBgNVBAsMBuyEnOuyhDEkMCIGA1UEAwwb7JeQ7Iqk7LyA7J20IO2UjOuemOuLmyjso7wpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0Ldr5ayjfKQiow61No6GPTX3M7ooj+IoZ18eN+KDRk7CJjLP+rg6pUZja0bDhwIxjLgeUo5ohJAndCbRwapXRgfegbO5B89dIBhy5qxHpnIPg8pSgyl9YdmBH0OinEJLesv5P0jieLH6FeoRhSRecJZpQXR3XtYMB2pltB4\\/yA6NCN946ytbEU5aRzLYZtqcZ6ubtkZnGW63ZLXR9gc0lhFS07h6yLZp64h4WzD8KivTFC\\/cIWfy59a\\/hZJFFBlu7lw30aSZGqmEQe2Sx1F\\/dGz3E0BObnj0Iqnrl5boBcMUHrKQW\\/uOnr8tCg1Gh4fl+03dWiqrBn9Nlna+2yjAhQIDAQABo4ICjjCCAoowgY8GA1UdIwSBhzCBhIAUtnSpm5I8x1GxIqRPvLc8\\/iIz13ahaKRmMGQxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRYwFAYDVQQDDA1LSVNBIFJvb3RDQSA0ggIQBDAdBgNVHQ4EFgQU08zNJ\\/AGJIS3R7YThWPmVV7WtGowDgYDVR0PAQH\\/BAQDAgbAMIGDBgNVHSABAf8EeTB3MHUGCiqDGoyaRAUEAQMwZzAtBggrBgEFBQcCARYhaHR0cDovL2djYS5jcm9zc2NlcnQuY29tL2Nwcy5odG1sMDYGCCsGAQUFBwICMCoeKLz4ACDHeMmdwRzHWAAgxyDWqK4wrATHQAAgADGxRAAgx4WyyLLkAC4wegYDVR0RBHMwcaBvBgkqgxqMmkQKAQGgYjBgDBvsl5DsiqTsvIDsnbQg7ZSM656Y64ubKOyjvCkwQTA\\/BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEIO0ndMlciC8i4rXTTabKVdLuz5aS3Pb\\/9gsDeciXqGuVMH0GA1UdHwR2MHQwcqBwoG6GbGxkYXA6Ly9kaXIuY3Jvc3NjZXJ0LmNvbTozODkvY249czFkcDlwNzQsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89Q3Jvc3NDZXJ0LGM9S1I\\/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBGBggrBgEFBQcBAQQ6MDgwNgYIKwYBBQUHMAGGKmh0dHA6Ly9vY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAlx3K2jB9idefvdGomJFtXxcg6a2iB\\/ydOcP1G04uTNRX2ddRpT5LS38dUlmreiwepWzBASsDB6FPnt21T9FXSn9Ouyx0FGlaAucluDHjZ+cTCbXtwutGTepy23AR3\\/d7BUeUTrrV1b78SWLhSxySsXCrVlV8vZsVJx3mnDvcyEeJG7wgEzk4ZS9YUzYO3PrWUfgIPY+AXuJs8tPf33O0XlD8OM8AXiw0cGJhnldbv0e0rV9uzlNRKXvFf1BHSSUFm2Xfjxxkxuv0SSRtObS0w4k91ffFBDuQc74IDEGQzjwCErCazer1v5tYToFxSKbq8WO\\/y+hK4FYFCrJ0nU2raDGCAYIwggF+AgEBMFcwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTICBAEDYIQwDQYJYIZIAWUDBAIBBQAwDQYJKoZIhvcNAQELBQAEggEAhG3jak4rgmtsrL4fNnQh4WTzPxigNCtsYL2DycDwJlq9dFyDQTpEoMmGTgcEzFD2NNc+Nshny+jIOKUnbfNyFcoBt5c116sLO8NjGNNSxxD4+eyo6TEpUAwQ3sgKMto+P+lJKkTtb1fook3V2ztViyd3kiqOeGgbiOH867wwGdLJI1Tk\\/b\\/7Ly3Yts3LmrPX0ffmN6g9Ae1gkLnu9PtcOE9KYjejwtedH9aLsAtI18RlfvSGN6OIdeP9E9RdZQhxU9Y6+e7EQKNojVa4f5SMnjapkeUsA8TE+9DkIExzhbIJyG9IhhasAEqAaynHlvTDsCh+RphIuukTpjcs\\/Avh\\/w==\"}";
	summary = 1;
	market 	= SKT;
	cash	= 3300;

	out.print("[kind]" + ikind + "<br><br>");
	out.print("[idata]:" + idata + "<br><br>");
	out.print("[txid]:" + getSKTtxid(idata) + "<br><br>");
	idata2 = callSKTSite(ikind, idata);
	out.print("[idata2]:" + idata2 + "<br><br>");

	//out.print("" + getSKTSuccess(idata2, cash, strSKTAIDList, nSKTMoneyList, strSKTPIDList) + "");
	if(market == SKT){
		if(DEBUG)out.println("[SKT]<br>");

		if(!ikind.equals("")){
			//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
			//2. SKT에서 보내진 데이타를 넘겨서 > URL포팅해서 전달 > SKT에 인증
			idata2 = callSKTSite(ikind, idata);

			//3. 데이타 파싱하기
			boolean _bSKTState = getSKTSuccess(idata2, cash, strSKTAIDList, nSKTMoneyList, strSKTPIDList);
			out.print("[_bSKTState]:" + _bSKTState + "<br><br>");
			if(!_bSKTState){
				if(DEBUG)out.println(" > SKT idata2 error<br>");
				summary = 0;
			}
		}else{
			if(DEBUG)out.println(" > SKT iKind Empty error<br>");
			summary = 0;
		}
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
