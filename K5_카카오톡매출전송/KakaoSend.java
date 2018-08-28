import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
import java.text.*;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.MulticastResult;
import com.google.android.gcm.server.Sender;

public class KakaoSend extends Thread{
	////////////////////////////////////////////////
	//데몬 정의값들
	Connection conn 			= null;
	public int nConnectMode;
	public String strDataBase;
	public int nSleepTime 		= 20 * 1000;				//     5 * 1000; 5초
	ArrayList<KakaoData> listKakaoData = new ArrayList<KakaoData>();

	public static void main(String[] args) throws UnsupportedEncodingException {
		if(args.length != 1){
			System.out.println("error - REAL or TEST");
		}else{
			KakaoSend _send = new KakaoSend();
			_send.mode(args[0]);
			_send.start();
		}
	}

	public void mode(String _mode){
		if(_mode.equals("TEST")){
			nConnectMode = Constant.CONNECT_MODE_TEST;
			strDataBase = Constant.DB_PUB_TEST;
			System.out.println("Connect test > kakao");
		}else{
			nConnectMode = Constant.CONNECT_MODE_REAL;
			strDataBase = Constant.DB_PUB_REAL;
			System.out.println("Connect real > kakao");
		}
	}

	// 푸시 실행
	public void start(){
		try{
			while(true){
				System.out.println("================================================");
				//System.out.println("strKakaoMsgTitle : " + strKakaoMsgTitle);

				connDB();			//1. 접속.
				kakaoSendRead();	//2. 데이타 읽기.
				kakaoSend();		//3. GCM 전송하기.
				kakaoSendLog();  	//4. 푸시 발송 이력처리.
				disconnect();		//5. db정리.
				System.out.println("Total Count >>> "+ listKakaoData.size());

				sleep(nSleepTime);
			}
		}catch(Exception _e){
			System.out.println("start error:" + _e);
		}
	}

	public void connDB(){
		if(Constant.DEBUG_MODE)System.out.println("connDB");
		try {
			if(Constant.DEBUG_DBCONNECT)System.out.println(15);
			Class.forName(Constant.DB_DRIVER);
			if(Constant.DEBUG_DBCONNECT)System.out.println(16);
			conn = DriverManager.getConnection(strDataBase);
			if(Constant.DEBUG_DBCONNECT)System.out.println("DB Connect ok:" + strDataBase);
		} catch (Exception _e) {
			if(Constant.DEBUG_DBCONNECT)System.out.println("DB Connect error:" + _e);
		}

	}

	// 상상게이트에서 디비에서 푸시 데이터를 가져온다.
	public void kakaoSendRead(){
		if(Constant.DEBUG_MODE)System.out.println("kakaoSendRead");
		CallableStatement _cstmt	 	= null;
		StringBuffer _query 			= new StringBuffer();
		ResultSet _result 				= null;
		int _idxColumn					= 1;
		int _resultCode					= -1;
		KakaoData _data;
		listKakaoData.clear();

		try{
			//exec spu_KakaoPayment 1, -1,  '', '', -1						-- 검색
			_query.append("{ call dbo.spu_KakaoPayment (?, ?, ?, ?, ?)} ");
			_cstmt = conn.prepareCall(_query.toString());

			_cstmt.setInt(_idxColumn++, Constant.KAKAO_MODE_LIST);
			_cstmt.setInt(_idxColumn++, -1);
			_cstmt.setString(_idxColumn++, "");
			_cstmt.setString(_idxColumn++, "");
			_cstmt.registerOutParameter(_idxColumn++, Types.INTEGER);

			//2-2. 스토어즈 프로시져 실행하기
			_result = _cstmt.executeQuery();

			//2-3-1. 코드결과값 받기(1개)
			if(_result.next()){
				_resultCode = _result.getInt("rtn");
			}

			if(_resultCode == 1){
				if(_cstmt.getMoreResults()){
					_result = _cstmt.getResultSet();
					int _cash, _market;
					while(_result.next()){
						_data 	= new KakaoData();

						_data.idx 			= _result.getInt("idx");
						_cash	 			= _result.getInt("cash");
						_market		 		= _result.getInt("market");
						_data.kakaogameid	= _result.getString("kakaogameid");
						_data.buy_no		= _result.getString("kakaouk");
						_data.productid		= _result.getString("productid");
						if(_market == Constant.GOOGLE){
							_data.platform		= "google";
							_data.os			= "android";
							_data.country_ios	= "kr";
							_data.price			= "" + _cash;
							_data.currency		= "KRW";
							_data.purchasetoken	= KakaoUtil.getParseInfo("purchaseToken", 16, _result.getString("idata2") );
						}else if(_market == Constant.SKT){
							_data.platform		= "tstore";
							_data.os			= "android";
							_data.country_ios	= "kr";
							_data.price			= "" + _cash;
							_data.currency		= "KRW";
						}else if(_market == Constant.IPHONE){
							_data.platform		= "apple";
							_data.os			= "ios";
							_data.country_ios	= "kr";
							switch(_cash){
								case 3300:	case  299:	_data.price	=  "2.99";	break;
								case 5500:	case  499:	_data.price	=  "4.99";	break;
								case 11000:	case  999:	_data.price	=  "9.99";	break;
								case 33000:	case 2999:	_data.price	= "29.99";	break;
								case 55000:	case 4999:	_data.price	= "49.99";	break;
								case 110000:case 9999:	_data.price	= "99.99";	break;
							}
							_data.currency		= "USD";
						}
						listKakaoData.add(_data);
					}
				}
			}
		}catch(SQLException _e){
			System.out.println("kakaoSendRead error:" + _e);
		}
	}
	public boolean callWeb(String urlParameters){
		boolean _rtn = false;

		try{
			String request = Constant.KAKAOSERVER;
			URL url = new URL(request);
			HttpURLConnection connection = (HttpURLConnection)url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(false);
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Connection", "Keep-Alive");
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.setRequestProperty("charset", "utf-8");
			connection.setRequestProperty("Authorization", "KakaoAK " + Constant.ADMIN_KEY);
			connection.setRequestProperty("Content-Length", "" + Integer.toString(urlParameters.getBytes().length));
			connection.setUseCaches(false);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			wr.writeBytes(urlParameters);
			wr.flush();


			String line;
			InputStream inputStream = new BufferedInputStream(connection.getInputStream());
			BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
			while((line = reader.readLine()) != null) {
				if(Constant.DEBUG_RECE)System.out.println("msg:" + line);
				if(line.equals(Constant.KAKAO_OK_MSG))
					_rtn = true;
				else
					_rtn = false;
			}
			wr.close();
			reader.close();
			connection.disconnect();
		}catch(Exception e){
			System.out.println("PageCountFilter error"+e);
		}
		return _rtn;
		/**/
	}


	public void kakaoSend() throws UnsupportedEncodingException{
		//3-1단계 kakao. 단말 API KEY
		StringBuffer _sb = new StringBuffer();

		KakaoData _data;
		int _cnt = listKakaoData.size();
		for(int i = 0; i < _cnt ; i++){
			_data = listKakaoData.get(i);
			_sb.setLength(0);
			_sb.append("partner_order_id=" 	+ _data.buy_no);
			_sb.append("&os=" 				+ _data.os);
			_sb.append("&platform=" 		+ _data.platform);
			_sb.append("&country_iso=" 		+ _data.country_ios);
			_sb.append("&price=" 			+ _data.price);
			_sb.append("&currency=" 		+ _data.currency);
			_sb.append("&user_id=" 			+ _data.kakaogameid);
			_sb.append("&product_id=" 		+ _data.productid);
			_sb.append("&purchase_token=" 	+ _data.purchasetoken);

			if(Constant.DEBUG_PARAM)System.out.println(" send:" + _sb.toString());
			_data.rtn = callWeb(_sb.toString());
			if(Constant.DEBUG_PARAM)System.out.println(" rece:" + _data.rtn);
		}

	}

	public void kakaoSendLog(){
		if(listKakaoData.size() <= 0) return;

		if(Constant.DEBUG_MODE)System.out.println("kakaoSendLog");
		CallableStatement _cstmt	 	= null;
		StringBuffer _query 			= new StringBuffer();
		ResultSet _result 				= null;
		int _idxColumn					= 1;
		int _resultCode					= -1;
		KakaoData _data;
		int _point 						= -1;
		int _cnt 						= 0;
		StringBuffer _paramsuc				= new StringBuffer("");
		StringBuffer _paramerr				= new StringBuffer("");


		if(listKakaoData.size() == 0){
			if(Constant.DEBUG_MODE)System.out.println(" > 처리건수 없음");
			_point = -1;
		}else{
			_cnt = listKakaoData.size();
			for(int i = 0; i < _cnt ; i++){
				_data = listKakaoData.get(i);
				if(_data.rtn){
					_paramsuc.append(_data.idx);
					if(i + 1 != _cnt){
						_paramsuc.append(",");
					}
				}else{
					_paramerr.append(_data.idx);
					if(i + 1 != _cnt){
						_paramerr.append(",");
					}
				}

				if(_data.idx > _point)_point = _data.idx;
			}
			if(Constant.DEBUG_MODE)System.out.println(" > 처리:" + _paramsuc);

			try {
				//exec spu_KakaoPayment 2, 89,  '89, 86, 87, 88, 89', '', -1		-- 전송완료
				_query.append("{ call dbo.spu_KakaoPayment (?, ?, ?, ?, ?)} ");
				_cstmt = conn.prepareCall(_query.toString());

				_cstmt.setInt(_idxColumn++, Constant.KAKAO_MODE_SENDED);
				_cstmt.setInt(_idxColumn++, _point);
				_cstmt.setString(_idxColumn++, _paramsuc.toString());
				_cstmt.setString(_idxColumn++, _paramerr.toString());
				_cstmt.registerOutParameter(_idxColumn++, Types.INTEGER);

				//2-2. 스토어즈 프로시져 실행하기
				_result = _cstmt.executeQuery();

				//2-3-1. 코드결과값 받기(1개)
				if(_result.next()){
					_resultCode = _result.getInt("rtn");
					if(_resultCode == 1){
						System.out.println(" 정상 기록[" + _cnt + "]");
					}else{
						System.out.println(" 정상 오류");
					}
				}
			}catch(SQLException _e){
				System.out.println("kakaoSendRead error:" + _e);
			}
		}
	}

	public void disconnect(){
		if (conn != null){
			try {
				conn.close();
			} catch (Exception e) {}
		}
	}

	public void sleep(int _ms){
		try{
			System.out.println("mainSleep : "+(_ms/60000)+"분");
			Thread.sleep(_ms);
		}catch(InterruptedException _ie){
			_ie.printStackTrace();
		}
	}

}
