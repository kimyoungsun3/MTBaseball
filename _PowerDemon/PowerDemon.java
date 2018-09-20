import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
import java.text.*;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.MulticastResult;
import com.google.android.gcm.server.Sender;

public class PowerDemon extends Thread{
	////////////////////////////////////////////////
	//데몬 정의값들
	Connection conn 			= null;
	public int nConnectMode;
	public String strDataBase;
	public int nSleepTime 		= 2 * 1000;				//     2 * 1000; 2초
	PowerData powerData 		= new PowerData();

	public static void main(String[] args) throws UnsupportedEncodingException {
		if(args.length != 1){
			System.out.println("error - REAL or TEST");
		}else{
			PowerDemon _send = new PowerDemon();
			_send.mode(args[0]);
			_send.start();
		}
	}

	public void mode(String _mode){
		if(_mode.equals("TEST")){
			nConnectMode 	= Constant.CONNECT_MODE_TEST;
			strDataBase 	= Constant.DB_PUB_TEST;
			System.out.println("Connect test > power");
		}else{
			nConnectMode 	= Constant.CONNECT_MODE_REAL;
			strDataBase 	= Constant.DB_PUB_REAL;
			System.out.println("Connect real > power");
		}
	}

	// 푸시 실행
	public void start(){
		try{
			while(true){
				System.out.println("================================================");

				connDB();			//1. 접속.
				powerFirstRead();	//2. 데이타 읽기.
				powerSend();		//3. GCM 전송하기.
				powerSendLog();  	//4. 푸시 발송 이력처리.
				disconnect();		//5. db정리.
				System.out.println("현재회차 >>> "+ powerData.curTurnTime + " 지난시간:" + powerData.passTime);

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

	//데이터를 가져온다.
	public void powerFirstRead(){
		if(Constant.DEBUG_MODE)System.out.println("powerFirstRead");
		CallableStatement _cstmt	 	= null;
		StringBuffer _query 			= new StringBuffer();
		ResultSet _result 				= null;
		int _idxColumn					= 1;
		int _resultCode					= -1;

		try{
			//exec spu_LottoPowerBallTime 1, -1, -1, -1, -1, -1, -1, -1, -1			-- 남은시간검색
			_query.append("{ call dbo.spu_LottoPowerBallTime (?, ?, ?, ?, ?,   ?, ?, ?, ?)} ");
			_cstmt = conn.prepareCall(_query.toString());

			_cstmt.setInt(_idxColumn++, Constant.LOTTO_MODE_READ);
			_cstmt.setInt(_idxColumn++, -1);
			_cstmt.setInt(_idxColumn++, -1);
			_cstmt.setInt(_idxColumn++, -1);
			_cstmt.setInt(_idxColumn++, -1);

			_cstmt.setInt(_idxColumn++, -1);
			_cstmt.setInt(_idxColumn++, -1);
			_cstmt.setInt(_idxColumn++, -1);
			_cstmt.registerOutParameter(_idxColumn++, Types.INTEGER);

			//2-2. 스토어즈 프로시져 실행하기
			_result = _cstmt.executeQuery();

			//2-3-1. 코드결과값 받기(1개)
			if(_result.next()){
				_resultCode 			= _result.getInt("rtn");
				powerData.curTurnTime	= _result.getInt("curturntime");
				powerData.passTime		= _result.getInt("passtime");
			}
			System.out.println(powerData.curTurnTime + " > " + powerData.passTime);
		}catch(SQLException _e){
			System.out.println("kakaoSendRead error:" + _e);
		}
	}

	public boolean callWeb(String urlParameters){
		boolean _rtn = false;
		/*
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
		/**/
		return _rtn;
	}


	public void powerSend() throws UnsupportedEncodingException{
		//3-1단계 kakao. 단말 API KEY
		StringBuffer _sb = new StringBuffer();

		/*
		PowerData _data;
		int _cnt = listPowerData.size();
		for(int i = 0; i < _cnt ; i++){
			_data = listPowerData.get(i);
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
		/**/
	}

	public void powerSendLog(){

		if(Constant.DEBUG_MODE)System.out.println("powerSendLog");
		CallableStatement _cstmt	 	= null;
		StringBuffer _query 			= new StringBuffer();
		ResultSet _result 				= null;
		int _idxColumn					= 1;
		int _resultCode					= -1;

		try{
			//exec spu_LottoPowerBallTime 2, 821730, 19, 12, 15, 09, 10, 04, -1		-- 입력...
			_query.append("{ call dbo.spu_LottoPowerBallTime (?, ?, ?, ?, ?,   ?, ?, ?, ?)} ");
			_cstmt = conn.prepareCall(_query.toString());

			_cstmt.setInt(_idxColumn++, Constant.LOTTO_MODE_WRITE);
			_cstmt.setInt(_idxColumn++, powerData.curTurnTime);
			_cstmt.setInt(_idxColumn++, 1);
			_cstmt.setInt(_idxColumn++, 2);
			_cstmt.setInt(_idxColumn++, 3);
			_cstmt.setInt(_idxColumn++, 4);
			_cstmt.setInt(_idxColumn++, 5);

			_cstmt.setInt(_idxColumn++, 6);
			_cstmt.registerOutParameter(_idxColumn++, Types.INTEGER);

			//2-2. 스토어즈 프로시져 실행하기
			_result = _cstmt.executeQuery();

			//2-3-1. 코드결과값 받기(1개)
			PowerData powerData 	= new PowerData();
			if(_result.next()){
				_resultCode 			= _result.getInt("rtn");
				powerData.curTurnTime	= _result.getInt("curturntime");
				powerData.passTime		= _result.getInt("passtime");
			}
			System.out.println(powerData.curTurnTime + " > " + powerData.passTime);
		}catch(SQLException _e){
			System.out.println("kakaoSendRead error:" + _e);
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

