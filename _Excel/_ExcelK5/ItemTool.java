
//####	변경된것 나중에 확인해야 할 것
import java.awt.*;
import java.awt.event.*;
import java.lang.*;
import java.io.*;
import javax.swing.*;
import java.util.*;

public class ItemTool{
	String directory = null,
		   readFile = null,
		   saveFile = null,
		   saveFile2 = null,
		   saveFile3 = null,
		   saveNameFile = null;

	public static void main(String[] args) {
		System.out.println("ItemTool main");
		System.out.println("1. Excel안에 [,]는 사용하지마세요~");
		System.out.println("2. [`] -> [,]로 하시면 자동 변경됩니다.");
		System.out.println("   안녕`~~~ [원문]");
		System.out.println("   안녕,~~~ [xml]");

		//String _str = "a`b`c`d`e`f`g";
		//System.out.println(_str.replace('`', ','));
		if(Constant.DEBUG)System.out.println("ItemTool main");
		ItemTool tool = new ItemTool();
		//tool.textTobyte("help.csv");
		//tool.itemTobyte("questinfo.csv", 2, false, true);
		tool.textTobyte("tooltip.csv");
		tool.textTobyte("openning.csv");
		tool.itemTobyte("iteminfo.csv", 1, true, true);
		tool.itemTobyte("gameinfo.csv", 2, true, true);
		tool.itemTobyte2("package.csv", 1, true);
		tool.itemTobyte2("yabau.csv", 4, true);
		//tool.itemTobyte2("roulette.csv", 2, true);		//old model
		//tool.itemTobyte2("roulettefresh.csv", 3, true);
		//tool.itemTobyte3("roulette.csv", 2, true, 15);
		tool.itemTobyte4("roulette.csv", 1, true, 7);
		tool.itemTobyte4("treasure.csv", 2, true, 7);	//모드, 그룹수
	}

	public String getQueryHeader(int _len, String _strHeader, String[] _params){
		for(int i = 0; i < _len; i++){
			if(i+1 == _len)
				_strHeader += _params[i] + ") ";
			else
				_strHeader += _params[i] + ", ";
		}
		return _strHeader;
	}

	public void textTobyte(String _str){
		//3. 스트링으로 만들어진것 파싱
		String[] list = (String[]) getReadAndLists(_str);
		int textTotal = list.length;
		//System.out.println("텍스트의 개수:"+textTotal);
		String[] header = null;
		String[] body = null;
		String _cl = "\r\n";
		String _msg;
		String _element = "";

		_msg  = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + _cl;
		_msg += "<rows>" + _cl;


		for(int i = 0; i < textTotal; i++){
			try{
				if(Constant.DEBUG)
					System.out.println("list["+i+"] => ["+list[i]+"]");
				if(list[i].equals("")) continue;

				if(list[i].indexOf("label") >= 0){
					header = list[i].split(",");
					_element = Util.getBraceString(header[0]);
					if(Constant.DEBUG)
						System.out.println("<<header>>:" + header.length);
					continue;
				}else{
					body = list[i].split(",");
					if(Constant.DEBUG)
						System.out.println("<<body>>"+ body.length);
				}

				_msg += "\t<"+_element+">" + _cl;
				for(int j = 1; j < header.length; j++){
					//System.out.println(header[j] + ":" + body[j]);
					_msg += "\t\t<"+header[j]+">";
					_msg += body[j].replace('`', ',') ;
					_msg += "</"+header[j]+">" + _cl;
				}
				_msg += "\t</"+_element+">" + _cl;
			}catch(Exception e){
				System.out.println("textTobyte error file:" + _str + " line:" + i);
			}
		}
		_msg += "</rows>\n";
		if(Constant.DEBUG)
			System.out.println(_msg);

		//3. 저장하기
		try {
			save(directory, saveFile, _msg.getBytes("utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}


	//아이템 변환
	public void itemTobyte(String _str, int _kind, boolean _bXML, boolean _bQuery){
		String[] list = (String[]) getReadAndLists(_str);
		int textTotal = list.length;
		int _errorline = 0;

		System.out.println("텍스트의 개수:"+textTotal);
		String[] header = null;
		String[] body = null;
		String _cl = "\r\n";
		StringBuffer _msg = new StringBuffer();
		String[] strItemCode = new String[textTotal];
		String[] strItemName = new String[textTotal];
		String[] strItemFileName = new String[textTotal];
		String _element = "";
		String _query = "", _query2 = "", _queryHeader = "", _queryB1, _queryB2;
		String[] _queryParams = null;
		boolean _bOverDealBounusInfo = false;
		_query2 = "";

		if(_kind == 1){			//iteminfo
			_query = "use Game4Farmvill5\nGO\n\n";
			_queryHeader = "insert into dbo.tItemInfo(";
			String[] _pp = {
						"labelname", 	"itemcode", 	"category", 	"subcategory", 	"equpslot",
						"itemname", "activate", 	"toplist", 	"grade",		"discount",
						"icon", 	"playerlv", 	"houselv", 	"gamecost", 	"cashcost",
						"buyamount", "sellcost", 	"description",
						"param1", 	"param2", 		"param3", 	"param4", 	"param5",
						"param6", 	"param7", 		"param8", 	"param9", 	"param10",
						"param11", 	"param12", 		"param13", 	"param14", 	"param15",
						"param16", 	"param17", 		"param18", 	"param19", 	"param20",
						"param21", 	"param22", 		"param23", 	"param24", 	"param25",
						"param26", 	"param27", 		"param28", 	"param29", 	"param30"
					};
			_queryParams = _pp;
		}else if(_kind == 2){	//gameinfo
			_query2 = "use Game4Farmvill5\nGO\n\n";
			_query2 += "delete from dbo.tUserSaleRewardItemCode\nGO\n\n";
			_query2 += "if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = -1))\n	begin\n		insert into dbo.tUserSaleRewardItemCode(itemcode) values(-1)\n	end\nGO\n\n";
			_query2 += "if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 901))\n	begin\n		insert into dbo.tUserSaleRewardItemCode(itemcode) values(901)\n	end\nGO\n\n";

			_queryHeader = "insert into dbo.tGameInfo(";
			String[] _pp = {
						"labelname", 	"syscode",
						"param1", 	"param2", 		"param3", 	"param4", 	"param5",
						"param6", 	"param7", 		"param8", 	"param9", 	"param10",
						"param11", 	"param12", 		"param13", 	"param14", 	"param15",
						"param16", 	"param17", 		"param18", 	"param19", 	"param20",
						"param21", 	"param22", 		"param23", 	"param24", 	"param25",
						"param26", 	"param27", 		"param28", 	"param29", 	"param30"
					};
			_queryParams = _pp;
		}

		_msg.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");	_msg.append(_cl);
		_msg.append("<rows>"); 										_msg.append(_cl);

		for(int i = 0; i < textTotal; i++){
			try{
				_errorline = 1;
				if(Constant.DEBUG)
					System.out.println("list["+i+"] => ["+list[i]+"]");
				if(list[i] == null)continue;
				if(list[i].equals("")) continue;
				if(list[i].trim().equals("")) continue;
				if(list[i].indexOf(",,,,,,,,,,,,") == 0){
					//System.out.println(",, > pass");
					continue;
				}
				_errorline = 2;

				if(list[i].indexOf("label") >= 0){
					header = list[i].split(",");
					_element = Util.getBraceString(header[0]);
					//System.out.println(_element + ":" + header[0]);
					if(Constant.DEBUG)
						System.out.println("<<header>>:" + header.length);
					continue;
				}else{
					body = list[i].split(",");
					if(Constant.DEBUG)
						System.out.println("<<body>>"+ body.length);
				}

				_errorline = 3;
				_queryB1 = "";
				_queryB2 = "";
				//System.out.println(header.length +":" + _queryHeader + ":" + _queryParams);
				if(_kind == 2 && (_element.equals("overdealbonusinfo") || _element.equals("bonuscard_slgd"))){
					_queryB2  = "if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 99999))\n";
					_queryB2 += "	begin\n";
					_queryB2 += "		insert into dbo.tUserSaleRewardItemCode(itemcode) values(99999)\n";
					_queryB2 += "	end\nGO\n\n";
					_bOverDealBounusInfo = true;
				}else{
					_queryB1 += getQueryHeader(header.length, _queryHeader, _queryParams) + "\nvalues(" + Util.makeQuery(_element);
					_bOverDealBounusInfo = false;
				}
				_msg.append("\t<"+_element+">");			_msg.append(_cl);
				_errorline = 4;


				for(int j = 1; j < header.length; j++){
					//System.out.println("hb > " + _element + " " + header[j] + ":" + body[j]);
					_errorline = 5;
					if(header[j].indexOf("pass") >= 0){
						//System.out.println(" > " + header[j] + ":" + body[j]);
						continue;
					}

					_errorline = 6;
					if(header[j].equals("")){
						_queryB1 += ", " + Util.makeQuery(Util.getStringInt("-999"));
						continue;
					}

					body[j] = body[j].replace("`", ",");
					_errorline = 7;
					if(header[j].equals("itemcode") || header[j].equals("questcode")){
						strItemCode[i] = body[j];
						//System.out.println("["+i+"]" + strItemCode[i]);
					}else if(header[j].equals("name")){
						strItemName[i] = body[2] + body[j];
						//System.out.println("["+i+"]" + strItemName[i]);
					}else if(_bOverDealBounusInfo && header[j].equals("rewardcode")){
						//_queryB2 += body[j];
						_queryB2 = _queryB2.replace("99999", body[j]);
						//strItemName[i] = body[j];
						//System.out.println("["+i+"]" + strItemName[i]);
					//}else if(header[j].equals("filename")){
					//	strItemFileName[i] = body[j];
					//	//System.out.println("["+i+"]" + strItemFileName[i]);
					}
					_errorline = 8;
					_msg.append("\t\t<"+header[j]+">");
					_msg.append(Util.getStringInt(body[j]).replace('`', ','));
					_msg.append("</");		_msg.append(header[j]);		_msg.append(">");	_msg.append(_cl);

					_errorline = 9;
					_queryB1 += ", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ',')));
				}
				_msg.append("\t</"); _msg.append(_element);		_msg.append(">");		_msg.append(_cl);

				if(_bOverDealBounusInfo){
					_query2  += _queryB2;
				}else{
					_queryB1 += ")\nGO\n\n";
					_query   += _queryB1;
				}

				//gamein -> overdealbonusinfo -> 직접데이타추출.
				//if(_kind == 2 && ){

			}catch(Exception e){
				System.out.println("itemTobyte error file:" + _str + " line:" + i + "(" + _errorline + ")");
			}
		}
		_msg.append("</rows>\n");

		if(Constant.DEBUG){
			System.out.println(_query);
			System.out.println(_msg);
		}

		//동일한 이름이 있는지 검사하기
		//[0]리볼브 = [1]리볼브
		for(int i = 0; i < textTotal; i++){
			for(int j = 0; j < textTotal; j++){
				//System.out.println(strItemCode[i] + ":" + strItemName[i] + ":" + strItemFileName[i]);
				if(i != j){
					if(strItemCode[i] != null && strItemCode[j] != null && strItemCode[i].equals(strItemCode[j])){
						System.out.println("####동일한 코드번호:" + strItemCode[i] + " == " + strItemCode[j]);
						sleep(500);
					}

					if(strItemName[i] != null && strItemName[j] != null && strItemName[i].equals(strItemName[j])){
						System.out.println("####동일한 아이템이름:" + strItemName[i] + " == " + strItemName[j]);
						sleep(500);
					}

					if(strItemFileName[i] != null && strItemFileName[j] != null && strItemFileName[i].equals(strItemFileName[j])){
						System.out.println("####동일한 파일이름:" + strItemFileName[i] + " == " + strItemFileName[j]);
						sleep(500);
					}
				}
			}
		}


		//3. 저장하기
		try {
			if(_bXML){
				save(directory, saveFile, _msg.toString().getBytes("utf-8"));
			}

			if(_bQuery){
				save(directory, saveFile2, _query.getBytes());
			}

			if(_bQuery && _kind == 2){
				save(directory, saveFile3, _query2.getBytes());
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}



	//아이템 변환
	public void itemTobyte2(String _str, int _kind, boolean _bQuery){
		String[] list = (String[]) getReadAndLists(_str);
		int _textTotal = list.length;
		int _errorline = 0;

		String[] header = null;
		System.out.println("텍스트의 개수:"+_textTotal);
		String[] body = null;
		String _query = "", _queryHeader = "", _querysub;

		if(_kind == 1){
			//패키지.
			_query  = "use Game4Farmvill5\nGO\n\n";
			_query += "delete from dbo.tItemInfo where subcategory = 500 and itemcode >= 50021\nGO\n\n";
			_query += "select '패키지 테이블 다시 생성했나요?'\nGO\n\n";
			_queryHeader = "exec spu_FarmD 30, 12, -1    ";
		}else if(_kind == 2){
			//뽑기.
			_query  = "use Game4Farmvill5\nGO\n\n";
			_query += "delete from dbo.tItemInfo where subcategory = 600 and itemcode >= 60004\nGO\n\n";
			_query += "select '교배뽑기 테이블 다시 생성했나요?'\nGO\n\n";
			_queryHeader = "exec spu_FarmD 30, 22, -1    ";
		}else if(_kind == 3){
			//뽑기fresh.
			_query  = "use Game4Farmvill5\nGO\n\n";
			_query += "delete from dbo.tItemInfo where subcategory = 600 and itemcode >= 60004\nGO\n\n";
			_query += "select '교배뽑기(fresh) 테이블 다시 생성했나요?'\nGO\n\n";
			_queryHeader = "exec spu_FarmD 30, 42, -1    ";
		}else if(_kind == 4){
			//뽑기fresh.
			_query  = "use Game4Farmvill5\nGO\n\n";
			_query += "delete from dbo.tItemInfo where subcategory = 700 and itemcode >= 70001\nGO\n\n";
			_query += "select '야바위(fresh) 테이블 다시 생성했나요?'\nGO\n\n";
			_queryHeader = "exec spu_FarmD 30, 45, -1    ";
		}


		for(int i = 0; i < _textTotal; i++){
			try{
				_errorline = 1;
				if(Constant.DEBUG)
					System.out.println("list["+i+"] => ["+list[i]+"]");
				if(list[i] == null)continue;
				if(list[i].equals("")) continue;
				if(list[i].trim().equals("")) continue;
				if(list[i].indexOf(",,,,,,,,,,,,") == 0){
					//System.out.println(",, > pass");
					continue;
				}
				_errorline = 2;

				body = list[i].split(",");
				if(Constant.DEBUG)
					System.out.println("<<body>>"+ body.length);
				_query += _queryHeader;
				_querysub = "";

				for(int j = 1; j < body.length; j++){
					_errorline = 5;
					if(body[j].equals("")){
						_query += ", " + Util.makeQuery(Util.getStringInt("''"));
						continue;
					}

					_errorline = 7;
					if(j >= 10)
						_querysub += body[j] + ";";
					else
						_query += ", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ',')));
				}

				if(_querysub.length() > 3){
					_query += ", '" + _querysub + "'";
				}
				_query += ", '', '', '', '', '', '', ''";
				_query += "\nGO\n\n";
			}catch(Exception e){
				System.out.println("itemTobyte2 error file:" + _str + " line:" + i + "(" + _errorline + ")");
			}
		}

		if(Constant.DEBUG){
			System.out.println(_query);
		}

		//3. 저장하기
		try {
			if(_bQuery){
				save(directory, saveFile2, _query.getBytes());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	//아이템 변환
	public void itemTobyte3(String _str, int _kind, boolean _bQuery, int _STEP_LV){
		String[] list = (String[]) getReadAndLists(_str);
		int _textTotal = list.length;
		int _errorline = 0;
		//int _STEP_LV = 2;
		int _pers[][] = new int[_STEP_LV * 8][8*10];
		int _val, _col, _row;
		StringBuffer _sbh[] = new StringBuffer[_STEP_LV];
		StringBuffer _sb2[] = new StringBuffer[_STEP_LV * 10];
		int _step1Val[][] = new int[_STEP_LV * 10][4 * 10];
		int _step2Val[][] = new int[_STEP_LV * 10][4 * 10];
		for(int k = 0; k < _sb2.length; k++){
			_sb2[k] = new StringBuffer();
		}
		for(int k = 0; k < _sbh.length; k++){
			_sbh[k] = new StringBuffer();
		}

		String[] header = null;
		System.out.println("텍스트의 개수:"+_textTotal);
		String[] body = null;
		String _query = "", _queryHeader = "", _querysub, chasu;

		if(_kind ==  2){
			//뽑기.
			//_query += "delete from dbo.tItemInfo where subcategory = 600 and itemcode >= 60185\nGO\n\n";
			//_query += "delete from dbo.tSystemRoulette where itemcode >= 60185\nGO\n\n";

			chasu = "(4차버젼)";

			_query  = "use Game4Farmvill5\nGO\n\n";
			_query += "delete from dbo.tItemInfo where subcategory = 600 and itemname like '%" + chasu + "%'\nGO\n\n";
			_query += "delete from dbo.tSystemRoulette where packname like '%" + chasu + "%'\nGO\n\n";

			//_query += "select '교배뽑기 테이블 다시 생성했나요?'\nGO\n\n";
			_query += "-- update dbo.tSystemRoulette set packstate = -1 where packname not like '%" + chasu + "%'\nGO\n\n";
			_query += "-- update dbo.tSystemRoulette set packstate =  1 where packname     like '%" + chasu + "%'\nGO\n\n";
			_query += "-- 할인세팅 확인해주세요(20%세팅된것임).\n";
			_query += "-- update dbo.tSystemRoulette set cashcostper = 20, cashcostsale= cashcostcost - (cashcostcost * 20)/100 where packstate = 1\nGO\n\n";
			_queryHeader = "exec spu_FarmD 30, 22, -1    ";
		}

		//////////////////////////////////////////
		//step1 : parsing from excel into array
		//////////////////////////////////////////
		for(int i = 0; i < _textTotal; i++){
			try{
				_errorline = 1;
				if(Constant.DEBUG)
					System.out.println("list["+i+"] => ["+list[i]+"]");
				if(list[i] == null)continue;
				if(list[i].equals("")) continue;
				if(list[i].trim().equals("")) continue;
				if(list[i].indexOf(",,,,,,,,,,,,,,,") == 0){
					if(Constant.DEBUG)
						System.out.println(" > pass");
					continue;
				}
				_errorline = 2;


				body = list[i].split(",");
				if(Constant.DEBUG)
					System.out.println(" > parsing : "+ body.length);
				_row = i;
				_col = 0;
				_errorline = 3;
				for(int j = 1; j < body.length; j++){
					if(Constant.DEBUG)
						System.out.println( body[j]);
					_errorline = 4;

					if(body[j].equals(""))continue;

					//헤더완성하기.
					if(i % 8 == 0){
						switch(j){
							case 1:
								_sbh[i/8].append(_queryHeader);
								break;
							case 2:
							case 3:
							case 4:
							case 5:
							case 6:
							case 7:
							case 8:
								_sbh[i/8].append(", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ','))));
								break;
							case 9:
								_sbh[i/8].append(", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ','))));	//2번넣어주기.
								_sbh[i/8].append(", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ','))));
								break;
						}
					}
					_errorline = 5;

					//헤더까지만 하고 나머지는 패스.
					if(j <= 10)continue;
					_errorline = 6;

					_pers[_row][_col++] =Util.parseInt(body[j], "");
					_errorline = 7;
					if(Constant.DEBUG)System.out.print("[" + _row + "][" + (_col - 1) + "]:" + _pers[_row][_col - 1] + " ");
					_errorline = 8;
				}
				if(Constant.DEBUG)System.out.println("\n");
			}catch(Exception e){
				System.out.println("itemTobyte3(추가 그룹이 몇개) error file:" + _str + " line:" + i + "(" + _errorline + ")" + e);
			}
		}

		if(Constant.DEBUG){
			displayArrayInfo(_pers);
		}

		//////////////////////////////////////////
		//step2 : parsing data
		//////////////////////////////////////////
		int _stepLv = 0, _stepGroup = 0, _loop, _perSum, i, j, _idx;
		int _step1, _step2;
		for(i = 0; i < _pers.length; i+=2){
			_perSum 	= 0;
			_loop 		= 0;

			_stepLv 	= (i / 8) * 10;

			_stepGroup 	= i % 8;
			if(_stepGroup <= 1){
				_stepGroup = 0;
			}else if(_stepGroup <= 3){
				_stepGroup = 10;
			}else if(_stepGroup <= 5){
				_stepGroup = 20;
			}else if(_stepGroup <= 7){
				_stepGroup = 30;
			}

			for(j = 0; j < _pers[i].length; j++){
				_perSum += _pers[i][j];
			}
			if(_perSum != 100)System.out.println("#### 100% 아닌것이 검출됨 검출됨 ####");

			while(_loop < _perSum){
				for(j = 0; j < _pers[i].length; j++){
					if(_pers[i][j] > 0){
						_pers[i][j]--;
						_loop++;

						//메인그룹.
						_idx = _stepLv + (_loop - 1)/10;

						//값.
						_step1 = _stepGroup + ((_loop - 1)%10 + 1);
						_step2 = _pers[i + 1][j];
						_str = _step1 + ":" + _step2 + ";";

						//단순출력용. > 셔플로 변경함.
						//_sb2[_idx].append(_str);
						//if(Constant.DEBUG)
						//	System.out.println("_stepLv:" + _stepLv
						//						+ " _stepGroup:" + _stepGroup
						//						+ " ["+i+"]["+j+"] => " + _idx + " => " + _str);

						_step1Val[_idx][_step1 - 1] = _step1;
						_step2Val[_idx][_step1 - 1] = _step2;
					}
				}
			}
		}


		//////////////////////////////////////////
		//	Data Shuffle
		//////////////////////////////////////////
		for(i = 0; i < _step1Val.length; i++){
			for(j = 0; j < _step1Val[i].length; j++){
				_row = (i/10)*10 	+ Util.random(0, 10);
				_col = (j/10)*10 	+ Util.random(0, 10);

				//_val 					= _step1Val[i   ][j   ];
				//_step1Val[i   ][j   ] = _step1Val[_row][_col];
				//_step1Val[_row][_col] = _val;
				if(Constant.DEBUG)
					System.out.println("org: ["+i+"]["+j+"]:" + _step2Val[i][j] + " => ["+_row+"]["+_col+"]:" + _step2Val[_row][_col]);

				_val 					= _step2Val[i   ][j   ];
				_step2Val[i   ][j   ] 	= _step2Val[_row][_col];
				_step2Val[_row][_col] 	= _val;

				if(Constant.DEBUG)
					System.out.println("cha: ["+i+"]["+j+"]:" + _step2Val[i][j] + " => ["+_row+"]["+_col+"]:" + _step2Val[_row][_col]);
			}
		}

		for(i = 0; i < _step1Val.length; i++){
			for(j = 0; j < _step1Val[i].length; j++){
				_str = _step1Val[i][j] + ":" + _step2Val[i][j] + ";";
				_sb2[i].append(_str);
			}
			if(Constant.DEBUG)System.out.println(_sb2[i]);
		}
		/**/

		//데이타 만들기.
		for(i = 0; i < _sb2.length; i++){
			if(Constant.DEBUG)
				System.out.println("["+i+"]\n" + _sb2[i] + "\n");

			_query += _sbh[i/10].toString() + ", '" + _sb2[i].toString() + "'";
			_query += ", '', '', '', '', '', '', ''";
			_query += "\nGO\n\n";
		}

		//3. 저장하기
		try {
			if(_bQuery){
				save(directory, saveFile2, _query.getBytes());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	//아이템 변환
	public void itemTobyte4(String _str, int _kind, boolean _bQuery, int _STEP_LV){
		String[] list = (String[]) getReadAndLists(_str);
		int _textTotal = list.length;
		int _errorline = 0;
		//int _STEP_LV = 2;
		int _LINE = 10;
		int _pers[][] = new int[_STEP_LV * _LINE][_LINE * 10];
		int _val, _col, _row;
		StringBuffer _sbh[] = new StringBuffer[_STEP_LV];
		StringBuffer _sb2[] = new StringBuffer[_STEP_LV * 10];
		int _step1Val[][] = new int[_STEP_LV * 10][5 * 10];
		int _step2Val[][] = new int[_STEP_LV * 10][5 * 10];
		for(int k = 0; k < _sb2.length; k++){
			_sb2[k] = new StringBuffer();
		}
		for(int k = 0; k < _sbh.length; k++){
			_sbh[k] = new StringBuffer();
		}

		String[] header = null;
		System.out.println("텍스트의 개수:"+_textTotal);
		String[] body = null;
		String _query = "", _queryHeader = "", _querysub, chasu;

		if(_kind ==  1){
			//뽑기.
			//_query += "delete from dbo.tItemInfo where subcategory = 600 and itemcode >= 60185\nGO\n\n";
			//_query += "delete from dbo.tSystemRoulette where itemcode >= 60185\nGO\n\n";

			chasu = "(1차버젼)";

			_query  = "use Game4Farmvill5\nGO\n\n";
			_query += "delete from dbo.tItemInfo where subcategory = 600 and itemname like '%" + chasu + "%'\nGO\n\n";
			_query += "delete from dbo.tSystemRoulette where packname like '%" + chasu + "%'\nGO\n\n";

			//_query += "select '교배뽑기 테이블 다시 생성했나요?'\nGO\n\n";
			_query += "-- update dbo.tSystemRoulette set packstate = -1 where packname not like '%" + chasu + "%'\nGO\n\n";
			_query += "-- update dbo.tSystemRoulette set packstate =  1 where packname     like '%" + chasu + "%'\nGO\n\n";
			_query += "-- 할인세팅 확인해주세요(20%세팅된것임).\n";

			_queryHeader = "exec spu_FarmD 30, 22, -1    ";
		}else if(_kind ==  2){
			//뽑기.
			chasu = "(1차버젼)";

			_query += "use Game4Farmvill5\nGO\n\n";
			_query += "delete from dbo.tItemInfo where subcategory = 1300 and itemname like '%" + chasu + "%'\nGO\n\n";
			_query += "delete from dbo.tSystemTreasure where packname like '%" + chasu + "%'\nGO\n\n";

			//_query += "select '보물뽑기 테이블 다시 생성했나요?'\nGO\n\n";
			_query += " update dbo.tSystemTreasure set packstate = -1 where packname not like '%" + chasu + "%'\nGO\n\n";
			_query += " update dbo.tSystemTreasure set packstate =  1 where packname     like '%" + chasu + "%'\nGO\n\n";

			_queryHeader = "exec spu_FarmD 30, 26, -1    ";
		}

		//////////////////////////////////////////
		//step1 : parsing from excel into array
		//////////////////////////////////////////
		for(int i = 0; i < _textTotal; i++){
			try{
				_errorline = 1;
				if(Constant.DEBUG)
					System.out.println("list["+i+"] => ["+list[i]+"]");
				if(list[i] == null)continue;
				if(list[i].equals("")) continue;
				if(list[i].trim().equals("")) continue;
				if(list[i].indexOf(",,,,,,,,,,,,,,,") == 0){
					if(Constant.DEBUG)
						System.out.println(" > pass");
					continue;
				}
				_errorline = 2;


				body = list[i].split(",");
				if(Constant.DEBUG)
					System.out.println(" > parsing : "+ body.length);
				_row = i;
				_col = 0;
				_errorline = 3;
				for(int j = 1; j < body.length; j++){
					if(Constant.DEBUG)
						System.out.println( body[j]);
					_errorline = 4;

					if(body[j].equals(""))continue;

					//헤더완성하기.
					if(i % 10 == 0){
						switch(j){
							case 1:
								_sbh[i/10].append(_queryHeader);
								break;
							case 2:
							case 3:
							case 4:
							case 5:
							case 6:
							case 7:
							case 8:
								_sbh[i/10].append(", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ','))));
								break;
							case 9:
								_sbh[i/10].append(", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ','))));	//2번넣어주기.
								_sbh[i/10].append(", " + Util.makeQuery(Util.getStringInt(body[j].replace('`', ','))));
								break;
						}
					}
					_errorline = 5;

					//헤더까지만 하고 나머지는 패스.
					if(j <= 10)continue;
					_errorline = 6;

					_pers[_row][_col++] =Util.parseInt(body[j], "");
					_errorline = 7;
					if(Constant.DEBUG)System.out.print("[" + _row + "][" + (_col - 1) + "]:" + _pers[_row][_col - 1] + " ");
					_errorline = 8;
				}
				if(Constant.DEBUG)System.out.println("\n");
			}catch(Exception e){
				System.out.println("itemTobyte4(추가 그룹이 몇개) error file:" + _str + " line:" + i + "(" + _errorline + ")" + e);
			}
		}

		if(Constant.DEBUG){
			displayArrayInfo(_pers);
		}

		//////////////////////////////////////////
		//step2 : parsing data
		//////////////////////////////////////////
		int _stepLv = 0, _stepGroup = 0, _loop, _perSum, i, j, _idx;
		int _step1, _step2;
		for(i = 0; i < _pers.length; i+=2){
			_perSum 	= 0;
			_loop 		= 0;

			_stepLv 	= (i / 10) * 10;

			_stepGroup 	= i % 10;
			if(_stepGroup <= 1){
				_stepGroup = 0;
			}else if(_stepGroup <= 3){
				_stepGroup = 10;
			}else if(_stepGroup <= 5){
				_stepGroup = 20;
			}else if(_stepGroup <= 7){
				_stepGroup = 30;
			}else if(_stepGroup <= 9){
				_stepGroup = 40;
			}

			for(j = 0; j < _pers[i].length; j++){
				_perSum += _pers[i][j];
			}
			if(_perSum != 100)System.out.println("#### 100% 아닌것이 검출됨 검출됨 ####");

			while(_loop < _perSum){
				for(j = 0; j < _pers[i].length; j++){
					if(_pers[i][j] > 0){
						_pers[i][j]--;
						_loop++;

						//메인그룹.
						_idx = _stepLv + (_loop - 1)/10;

						//값.
						_step1 = _stepGroup + ((_loop - 1)%10 + 1);
						_step2 = _pers[i + 1][j];
						_str = _step1 + ":" + _step2 + ";";

						//단순출력용. > 셔플로 변경함.
						//_sb2[_idx].append(_str);
						//if(Constant.DEBUG)
						//	System.out.println("_stepLv:" + _stepLv
						//						+ " _stepGroup:" + _stepGroup
						//						+ " ["+i+"]["+j+"] => " + _idx + " => " + _str);

						_step1Val[_idx][_step1 - 1] = _step1;
						_step2Val[_idx][_step1 - 1] = _step2;
					}
				}
			}
		}


		//////////////////////////////////////////
		//	Data Shuffle
		//////////////////////////////////////////
		for(i = 0; i < _step1Val.length; i++){
			for(j = 0; j < _step1Val[i].length; j++){
				_row = (i/10)*10 	+ Util.random(0, 10);
				_col = (j/10)*10 	+ Util.random(0, 10);

				//_val 					= _step1Val[i   ][j   ];
				//_step1Val[i   ][j   ] = _step1Val[_row][_col];
				//_step1Val[_row][_col] = _val;
				if(Constant.DEBUG)
					System.out.println("org: ["+i+"]["+j+"]:" + _step2Val[i][j] + " => ["+_row+"]["+_col+"]:" + _step2Val[_row][_col]);

				_val 					= _step2Val[i   ][j   ];
				_step2Val[i   ][j   ] 	= _step2Val[_row][_col];
				_step2Val[_row][_col] 	= _val;

				if(Constant.DEBUG)
					System.out.println("cha: ["+i+"]["+j+"]:" + _step2Val[i][j] + " => ["+_row+"]["+_col+"]:" + _step2Val[_row][_col]);
			}
		}

		for(i = 0; i < _step1Val.length; i++){
			for(j = 0; j < _step1Val[i].length; j++){
				_str = _step1Val[i][j] + ":" + _step2Val[i][j] + ";";
				_sb2[i].append(_str);
			}
			if(Constant.DEBUG)System.out.println(_sb2[i]);
		}
		/**/

		//데이타 만들기.
		for(i = 0; i < _sb2.length; i++){
			if(Constant.DEBUG)
				System.out.println("["+i+"]\n" + _sb2[i] + "\n");

			_query += _sbh[i/10].toString() + ", '" + _sb2[i].toString() + "'";
			_query += ", '', '', '', '', '', '', ''";
			_query += "\nGO\n\n";
		}

		//3. 저장하기
		try {
			if(_bQuery){
				save(directory, saveFile2, _query.getBytes());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void displayArrayInfo(int[][] _pers){
		String _str = "";
		for(int i = 0; i < _pers.length; i++){
			_str = "["+i+"]\n";
			for(int j = 0; j < _pers[i].length; j++){
				_str += _pers[i][j] + " ";
			}
			_str += "\n";
			System.out.println(_str);
		}
	}

	public String[] getReadAndLists(String _str){
		directory = System.getProperty("user.dir");
		//String subDirectory = _directory + "//data//";
		byte _buf[];

		readFile = _str.trim();
		saveFile = readFile.substring(0, readFile.indexOf("."))+".xml";
		saveFile2 = readFile.substring(0, readFile.indexOf("."))+"Query.sql";
		saveFile3 = readFile.substring(0, readFile.indexOf("."))+"QuerySub.sql";

		Util.debug("============================================================================");
		Util.debug("1. filter folder : " + directory + "\n readFile:" + readFile+", saveFile:"+ saveFile);
		Util.debug("============================================================================");

		//1. 읽기
		_buf = readFile(directory, _str);

		//2. 읽은것 스트링으로 만들기
		int idx = 0, startIdx = 0;
		int len = _buf.length;
		int lineCount = 0;
		Collection _strArray = new ArrayList();
		String strTmp = "";
		//bufData = new byte[1024*50];
		//byte _tmpTitle[] = new byte[1], _tmpObject[] = new byte[1];

		while(idx < len){
			if(Constant.DEBUG)System.out.println("_buf["+idx+"]:"+_buf[idx]);
			if(_buf[idx] == '\r'){
				if(Constant.DEBUG)System.out.println(startIdx+":"+idx+":"+len);
				strTmp = new String(_buf, startIdx, idx - startIdx).trim();
				if(Constant.DEBUG)System.out.println((lineCount++)+":"+strTmp+":");
				if(strTmp.indexOf("//") >= 0){
					//그냥패스
				}else{
					_strArray.add(strTmp);
				}
			}else if(_buf[idx] == '\n'){
				startIdx = idx+1;
			}
			idx++;
		}
		return (String[]) _strArray.toArray(new String[0]);
	}


	public byte[] readFile(String _directory, String fileName){
		FileInputStream in = null;
		File file = new File(_directory,fileName);
		byte tmp[] = null;
		if(file.exists()){
			try{
				in = new FileInputStream(file);
				int fileSize = in.available();
				tmp = new byte[fileSize];
				in.read(tmp, 0, fileSize);
			}catch(Exception e){
				Util.debug(fileName+"이 읽다 오류:"+e);
			}
			Util.debug(fileName+" 읽음");
		}else{
			Util.debug(fileName+"이 존재안함");
		}
		return tmp;
	}

	public void save(String _directory, String fileName, byte data[]){
		FileOutputStream out = null;
		File file = new File(_directory,fileName);
		try{
			out = new FileOutputStream(file);
			out.write(data);
		}catch(Exception e){
			Util.debug(fileName+"이 쓰다 오류:"+e);
		}
	}

	public void sleep(long _l){
		try{
			Thread.sleep(_l);
		}catch(InterruptedException e){
			System.out.println("GameCanvas sleep error : "+e);
		}
	}
}