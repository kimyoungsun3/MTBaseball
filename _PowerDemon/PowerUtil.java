import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
import java.text.*;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.MulticastResult;
import com.google.android.gcm.server.Sender;
import java.util.Random;

class PowerUtil{
	public static String getParseInfo(String _tar, int _len, String _str){
		int _startIdx = _str.indexOf(_tar);
		//System.out.println(" _startIdx:" + _startIdx);
		_startIdx += _len;
		//System.out.println(" _startIdx:" + _startIdx);
		int _endIdx = _str.indexOf("\"", _startIdx);

		if( _startIdx >= 0 && _endIdx >= 0){
			_str = _str.substring(_startIdx, _endIdx);
		}else{
			_str = "testinfo";
		}
		//System.out.println(" > " + _str);
		return _str;
	}

	//--------------------------------------------------------------
	//
	//--------------------------------------------------------------
	public static String getParseString(String _src, String _param1, String _param2){
		String _rtn = "";
		int _idx, _idx2;

		_idx 	= _src.indexOf(_param1);
		_idx2	= _src.indexOf(_param2, _idx);

		if(_idx != -1 && _idx2 != -1){
			_idx += _param1.length();

			_rtn = _src.substring(_idx, _idx2);
		}

		return _rtn;
	}

	//--------------------------------------------------------------
	//
	//--------------------------------------------------------------
	public static String getLottoPart(String _src){
		String _param1 = "<tbody>";
		String _param2 = "<img alt=";
		String _param3 = "src='img/powerball/powerball_ball06.gif'></td><td>76</td>";

		String _rtn = "";
		int _idx, _idx2;

		_idx 	= _src.indexOf(_param1);
		_idx2	= _src.indexOf(_param2, _idx);

		if(_idx != -1 && _idx2 != -1){
			_rtn = _src.substring(_idx, _idx2 + _param2.length() + _param3.length());
		}

		return _rtn;
	}

	//--------------------------------------------------------------
	//
	//--------------------------------------------------------------
	public static String getTurnTime(String _src){
		String _rtn = "";
		int _idx, _idx2;
		String _param1 = "<td>";
		String _param2 = "</td>";

		int _time = 2;
		_idx = 0;
		_idx2 = 0;
		for(int i = 0; i < _time; i++){

			_idx = _src.indexOf(_param1, _idx);
			_idx += _param1.length();
			_idx2 = _src.indexOf(_param2, _idx);
			//System.out.println("---------------------------");
			//System.out.println(i + " > " + _src.substring(_idx, _idx2));
		}
		return _src.substring(_idx, _idx2);
	}

	public static int getTurnTimeInt(String _src){
		String _t = getTurnTime(_src);
		int _rtn = 0;
		try{
			_rtn = Integer.parseInt(_t);
		}catch(Exception e){
			System.out.println("getTurnTimeInt error:" + e);
		}
		return _rtn;
	}

	public static int getInt(String _src){
		int _rtn = -999;
		try{
			_rtn = Integer.parseInt(_src);
		}catch(Exception e){
			System.out.println("getTurnTimeInt error:" + e);
		}
		return _rtn;
	}
	//--------------------------------------------------------------
	//
	//--------------------------------------------------------------
	public static String getNormalBall(String _src){
		String _param1 = "numSort('";
		String _param2 = "');";
		return getParseString(_src, _param1, _param2);
	}

	public static void getNormalBallParse(String _src, PowerData _data){
		String _strBalls = getNormalBall(_src);

		_data.curTurnNum1 = getInt(_strBalls.substring(0, 2));
		_data.curTurnNum2 = getInt(_strBalls.substring(2, 4));
		_data.curTurnNum3 = getInt(_strBalls.substring(4, 6));
		_data.curTurnNum4 = getInt(_strBalls.substring(6, 8));
		_data.curTurnNum5 = getInt(_strBalls.substring(8, 10));
	}

	//--------------------------------------------------------------
	//
	//--------------------------------------------------------------
	public static int getPowerBall(String _src){
		String[] _pbImages = {
			"powerball_ball00",
			"powerball_ball01",
			"powerball_ball02",
			"powerball_ball03",
			"powerball_ball04",
			"powerball_ball05",
			"powerball_ball06",
			"powerball_ball07",
			"powerball_ball08",
			"powerball_ball09"
		};


		for(int i = 0, iMax = _pbImages.length; i < iMax; i++){
			if(_src.indexOf(_pbImages[i]) >= 0){
				return i;
			}
		}

		return -1;
	}

	//--------------------------------------------------------------
	//
	//--------------------------------------------------------------
	public static int getSleepTime(int _passTime){
		int _rtn = 30 * 1000;
		if(      _passTime < 100){
			_rtn = (int)(30 * 1000);
		}else if(_passTime < 200){
			_rtn = (int)(20 * 1000);
		}else if(_passTime < 280){
			_rtn = (int)(10 * 1000);
		}else if(_passTime < 290){
			_rtn = (int)(3 * 1000);
		}else if(_passTime < 294){
			_rtn = (int)(2 * 1000);
		}else if(_passTime < 298){
			_rtn = (int)(1 * 1000);
		}else if(_passTime < 300){
			_rtn = (int)(0.5 * 1000);
		}else if(_passTime < 305){
			_rtn = (int)(0.5 * 1000);
		}else{
			_rtn = 2000;
		}

		return _rtn;
	}

	//--------------------------------------------------------------
	// Web Read
	//--------------------------------------------------------------
	public static String getWebRead(){
		StringBuffer _sb = new StringBuffer();
		try{
			URL _url = new URL(Constant.LOTTO_SERVER);
			HttpURLConnection _httpurl = (HttpURLConnection)_url.openConnection();
			_httpurl.setDoOutput(true);
			_httpurl.setDoInput(true);
			_httpurl.setUseCaches(false);
			_httpurl.setInstanceFollowRedirects(false);
			_httpurl.setRequestMethod("POST");
			_httpurl.setRequestProperty("Connection", "Keep-Alive");
			_httpurl.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			//_httpurl.setRequestProperty("Content-Type", "text/plain");
			_httpurl.setRequestProperty("charset", "utf-8");
			//_httpurl.setRequestProperty("Authorization", "KakaoAK " + Constant.ADMIN_KEY);
			//_httpurl.setRequestProperty("Content-Length", "" + Integer.toString(urlParameters.getBytes().length));
			_httpurl.setUseCaches(false);

			DataOutputStream _wr = new DataOutputStream(_httpurl.getOutputStream());
			//_wr.writeBytes(urlParameters);
			_wr.flush();

			String _strline;
			InputStream _inputStream = new BufferedInputStream(_httpurl.getInputStream());
			BufferedReader _reader = new BufferedReader(new InputStreamReader(_inputStream));
			while((_strline = _reader.readLine()) != null) {
				//System.out.println("msg:" + _strline);
				_sb.append(_strline);
			}
			_wr.close();
			_reader.close();
			_httpurl.disconnect();
		}catch(Exception e){
			System.out.println("PageCountFilter error"+e);
		}

		return _sb.toString();
	}

}
