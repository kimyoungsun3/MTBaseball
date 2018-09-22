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
	public int nSleepTime 		= 10 * 1000;				//     2 * 1000; 2초
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
				powerDBRead();		//2. 데이타 읽기.
				powerWebReadParse();//3. 읽어오기 > 파싱.
				powerDBWrite();  	//4. 기록하기
				disconnect();		//5. db정리.

				nSleepTime = PowerUtil.getSleepTime(powerData.passTime);
				System.out.println("현재회차 >>> "+ powerData.curTurnTime + " 지난시간:" + powerData.passTime + " > " + nSleepTime);

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
	public void powerDBRead(){
		if(Constant.DEBUG_MODE)System.out.println("powerDBRead");
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
			//System.out.println(powerData.curTurnTime + " > " + powerData.passTime);
		}catch(SQLException _e){
			System.out.println("kakaoSendRead error:" + _e);
		}
	}


	public void powerWebReadParse(){
		String _strPage 		= PowerUtil.getWebRead();
		String _strLottoPage 	= PowerUtil.getLottoPart(_strPage);

		//System.out.println(
		//"\n"
		//+ "\n1:" + PowerUtil.getTurnTime(_strLottoPage)
		//+ "\n2:" + PowerUtil.getNormalBall(_strLottoPage)
		//+ "\n3:" + PowerUtil.getPowerBall(_strLottoPage)
		//+ "\n"
		//);

		powerData.curTurnTime = PowerUtil.getTurnTimeInt(_strLottoPage);
		PowerUtil.getNormalBallParse(_strLottoPage, powerData);
		powerData.curTurnNum6 = PowerUtil.getPowerBall(_strLottoPage);
		powerData.display();
	}

	public void powerDBWrite(){
		if(Constant.DEBUG_MODE)System.out.println("powerDBWrite");
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
			_cstmt.setInt(_idxColumn++, powerData.curTurnNum1);
			_cstmt.setInt(_idxColumn++, powerData.curTurnNum2);
			_cstmt.setInt(_idxColumn++, powerData.curTurnNum3);
			_cstmt.setInt(_idxColumn++, powerData.curTurnNum4);
			_cstmt.setInt(_idxColumn++, powerData.curTurnNum5);

			_cstmt.setInt(_idxColumn++, powerData.curTurnNum6);
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
			//System.out.println(powerData.curTurnTime + " > " + powerData.passTime);
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
			System.out.println("mainSleep : "+(_ms/1000)+"초");
			Thread.sleep(_ms);
		}catch(InterruptedException _ie){
			_ie.printStackTrace();
		}
	}
}

