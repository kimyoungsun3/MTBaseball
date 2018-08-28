
import java.util.Random;

class KakaoUtil{




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

}
