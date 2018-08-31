#define DEBUG_ON
using UnityEngine;
using System.Collections;

public class EncodeData : MonoBehaviour {

	void Start () {
		/*
		//게임아이디@전화번호@이동거리(m)@성수개수@자석보유@바나나개수@에너지음료@군두운대여@신발단계@깃털단계@사신거리@		
		//                  01011112222:1500:1000:1:3:1:1:0:1:1000
		//step2:389838735310jipmllC84849495050C9883H4838C9C1C9C9C8C9C938334470396869184271301557746
		//step2:969696310713pgvkrjI60607071818I7469F0696I7I9I7I7I6I7I796981138972627760039201493381
		//step2:533753986303ldrhngE36364647575E4035C6353E4E6E4E4E3E4E453556355548384336796001363150
		//step2:835383280263oduhqgH39394940505H4338C9383H4H6H4H4H3H4H483887985841314639726501688940
		//step2:315331764602jbpfleC14142425353C2813A4131C2C4C2C2C1C2C231344553326162114574201554713
		//step2:563656917716lgrknjE66667677878E7065F6656E7E9E7E7E6E7E756508858578687366090801446480
		string _str  = "gameid@01011112222@1500@1000@1@3@1@1@0@1@1000";
		Debug.Log("step1:" + _str);

		_str = SSUtil.setEncode7(_str);
		Debug.Log("step2:" + _str);
		
		_str = SSUtil.getDecode7(_str);
		Debug.Log("step3:" + _str);
		/**/
		
		
		/*
		string[] _str2 = {
			"2011-01-01", 	"2012-01-01", 	"2013-01-01"
		};
		for(int i = 0; i < _str2.Length; i++){
			Debug.Log(_str2[i] + " => " + SSUtil.isPassedDate(_str2[i]));
		}
		/**/
		
		/*
		//문자 보내기 핸드폰 번호 암호화.
		string[] _str = {
								"01011112222",
								"+821099804739",
		};
		/**/
		
		//01029984222 	> 01029984222 > 22233232411064447423433492071540249
		//+821023386240 > 01023386240 > 11122121344973512312322381960430235
		
		/*
		for(int j = 0; j < 1; j++){
			for(int i = 0; i < _str.Length; i++){
				Debug.Log(_str[i] 
				          + " > " + SSUtil.getCheckPhoneNum(_str[i])
				          + " > " + SSUtil.setEncode6(SSUtil.getCheckPhoneNum(_str[i]))
				          + " > " + SSUtil.setEncode4(SSUtil.getCheckPhoneNum(_str[i]))
				          );
			}
		}
		/**/
		
		/*
		//단순 핸드폰 번호 암호화.
		string[] _str = {
								"01029984222",
								"+821099804739",
								"+821030000699",
								"+821051398485",
								"+821030717221",
								"+821029858823",
								"+821039264328",
								"+821051331428",
								"+821028145365",
								"+821025888403",
								"+821066308416",
								"+821023386240"
		};
		//  01029984222 > 01029984222 > 88998980776200008909908840812129
		//+821099804739 > 01099804739 > 88998987768251708909908849607151
		//+821030000699 > 01030000699 > 88998981888847708909908849607129
		//+821051398485 > 01051398485 > 55665650684393075676675516374145
		//+821030717221 > 01030717221 > 55665658526277675676675516374125
		//+821029858823 > 01029858823 > 77887879652559097898897738596147
		//+821039264328 > 01039264328 > 44554547360876264565564405263139
		//+821051331428 > 01051331428 > 99009094022031719010019950718129
		//+821028145365 > 01028145365 > 66776768470192186787786627485136
		//+821025888403 > 01025888403 > 11221213699951431232231172930140
		//+821066308416 > 01066308416 > 88998984418629408909908849607136
		//+821023386240 > 01023386240 > 44554546772068464565564405263130
		
		for(int i = 0; i < _str.Length; i++){
			Debug.Log(_str[i] 
			          + " > " + SSUtil.getCheckPhoneNum(_str[i])
			          + " > " + SSUtil.setEncode4(SSUtil.getCheckPhoneNum(_str[i])));
		}
		/**/
		
		//string _model3 = "LGE LG-LU6200";
		//string _model32 = "LG-LU6200";
		//Debug.Log(_model3 
		//		+ ":" + _model32 
		//		+ " > " + _model3.IndexOf(_model32));
		
		
		//로그암호화.
		//string _log = "@1,3286.0,-22.0,34.0@1,2776.0,-20.5,36.2@1,3237.0,-32.0,49.0@0,0.0,0.0,0.0@1,2776.0,-20.5,-17.1@0,0.0,0.0,0.0@0,0.0,0.0,0.0@1,3090.0,-26.2,8.1@1,2776.0,-20.5,-3.1@1,1388.0,-20.5,-33.1@0,0.0,0.0,0.0@0,0.0,0.0,0.0@1,2776.0,-20.5,-49.7@0,0.0,0.0,0.0@0,0.0,0.0,0.0@1,2776.0,-20.5,4.6@0,0.0,0.0,0.0@0,0.0,0.0,0.0@1,2776.0,-20.5,-44.2@0,0.0,0.0,0.0@0,0.0,0.0,0.0@0,0.0,0.0,0.0@1,2776.0,-20.5,-12.1@1,3346.0,-28.9,-43.8@0,0.0,0.0,0.0@1,2776.0,-20.5,-31.7@0,0.0,0.0,0.0@1,2776.0,-20.5,-41.2@0,3367.0,0.0,44.5@0,0.0,0.0,0.0@0,0.0,0.0,0.0@0,0.0,0.0,0.0";
		//               8175ZKFMLRPHJFGLLHJFMNHJZKFLQQPHJFGLJHOFMPHLZKFMLMQHJFGMLHJFNSHJZJFJHJFJHJFJHJZKFLQQPHJFGLJHOFGKQHKZJFJHJFJHJFJHJZJFJHJFJHJFJHJZKFMJSJHJFGLPHLFRHKZKFLQQPHJFGLJHOFGMHKZKFKMRRHJFGLJHOFGMMHKZJFJHJFJHJFJHJZJFJHJFJHJFJHJZKFLQQPHJFGLJHOFGNSHQZJFJHJFJHJFJHJZJFJHJFJHJFJHJZKFLQQPHJFGLJHOFNHPZJFJHJFJHJFJHJZJFJHJFJHJFJHJZKFLQQPHJFGLJHOFGNNHLZJFJHJFJHJFJHJZJFJHJFJHJFJHJZJFJHJFJHJFJHJZKFLQQPHJFGLJHOFGKLHKZKFMMNPHJFGLRHSFGNMHRZJFJHJFJHJFJHJZKFLQQPHJFGLJHOFGMKHQZJFJHJFJHJFJHJZKFLQQPHJFGLJHOFGNKHLZJFMMPQHJFJHJFNNHOZJFJHJFJHJFJHJZJFJHJFJHJFJHJZJFJHJFJHJFJHJ204
		//               6071VGBIHNLDFBCHHDFBIJDFVGBHMMLDFBCHFDKBILDHVGBIHIMDFBCIHDFBJODFVFBFDFBFDFBFDFVGBHMMLDFBCHFDKBCGMDGVFBFDFBFDFBFDFVFBFDFBFDFBFDFVGBIFOFDFBCHLDHBNDGVGBHMMLDFBCHFDKBCIDGVGBGINNDFBCHFDKBCIIDGVFBFDFBFDFBFDFVFBFDFBFDFBFDFVGBHMMLDFBCHFDKBCJODMVFBFDFBFDFBFDFVFBFDFBFDFBFDFVGBHMMLDFBCHFDKBJDLVFBFDFBFDFBFDFVFBFDFBFDFBFDFVGBHMMLDFBCHFDKBCJJDHVFBFDFBFDFBFDFVFBFDFBFDFBFDFVFBFDFBFDFBFDFVGBHMMLDFBCHFDKBCGHDGVGBIIJLDFBCHNDOBCJIDNVFBFDFBFDFBFDFVGBHMMLDFBCHFDKBCIGDMVFBFDFBFDFBFDFVGBHMMLDFBCHFDKBCJGDHVFBIILMDFBFDFBJJDKVFBFDFBFDFBFDFVFBFDFBFDFBFDFVFBFDFBFDFBFDF204
		//               5036ALGNMSQIKGHMMIKGNOIKALGMRRQIKGHMKIPGNQIMALGNMNRIKGHNMIKGOTIKAKGKIKGKIKGKIKALGMRRQIKGHMKIPGHLRILAKGKIKGKIKGKIKAKGKIKGKIKGKIKALGNKTKIKGHMQIMGSILALGMRRQIKGHMKIPGHNILALGLNSSIKGHMKIPGHNNILAKGKIKGKIKGKIKAKGKIKGKIKGKIKALGMRRQIKGHMKIPGHOTIRAKGKIKGKIKGKIKAKGKIKGKIKGKIKALGMRRQIKGHMKIPGOIQAKGKIKGKIKGKIKAKGKIKGKIKGKIKALGMRRQIKGHMKIPGHOOIMAKGKIKGKIKGKIKAKGKIKGKIKGKIKAKGKIKGKIKGKIKALGMRRQIKGHMKIPGHLMILALGNNOQIKGHMSITGHONISAKGKIKGKIKGKIKALGMRRQIKGHMKIPGHNLIRAKGKIKGKIKGKIKALGMRRQIKGHMKIPGHOLIMAKGNNQRIKGKIKGOOIPAKGKIKGKIKGKIKAKGKIKGKIKGKIKAKGKIKGKIKGKIK204
		//               3338CNIPOUSKMIJOOKMIPQKMCNIOTTSKMIJOMKRIPSKOCNIPOPTKMIJPOKMIQVKMCMIMKMIMKMIMKMCNIOTTSKMIJOMKRIJNTKNCMIMKMIMKMIMKMCMIMKMIMKMIMKMCNIPMVMKMIJOSKOIUKNCNIOTTSKMIJOMKRIJPKNCNINPUUKMIJOMKRIJPPKNCMIMKMIMKMIMKMCMIMKMIMKMIMKMCNIOTTSKMIJOMKRIJQVKTCMIMKMIMKMIMKMCMIMKMIMKMIMKMCNIOTTSKMIJOMKRIQKSCMIMKMIMKMIMKMCMIMKMIMKMIMKMCNIOTTSKMIJOMKRIJQQKOCMIMKMIMKMIMKMCMIMKMIMKMIMKMCMIMKMIMKMIMKMCNIOTTSKMIJOMKRIJNOKNCNIPPQSKMIJOUKVIJQPKUCMIMKMIMKMIMKMCNIOTTSKMIJOMKRIJPNKTCMIMKMIMKMIMKMCNIOTTSKMIJOMKRIJQNKOCMIPPSTKMIMKMIQQKRCMIMKMIMKMIMKMCMIMKMIMKMIMKMCMIMKMIMKMIMKM204
		//string _log = "@1,2600,-24,10@1,2800,-25,20";
		//               2699DOJPTNNJKPRJONDOJPVNNJKPSJPN178
		//Debug.Log(SSUtil.setLogEncode(_log));
		
		/*
		//랜덤의 범위.
		for(int i = 0; i < 30; i++){
			//0 <= x < 2
			Debug.Log(Random.Range(0, 2));
		}
		
		
		for(int i = 0; i < 3; i++){
			Debug.Log("[" + i + "]:" + SSUtil.getGuestPassword());
		}
			
				
		/*
		////캐쉬코드만들기.
		string _strGameid = "abcduxyz";
		int[] _cash = 	{	2000, 	5000, 	29000, 	50000, 	99000};
		int[] _goldball ={	21, 	55, 	351, 	635, 	1320};		
		for(int i = 0; i < _cash.Length; i++){
			Debug.Log(SSUtil.setCashEncode(_strGameid, _cash[i], _goldball[i]));
		}
		/**/
		
		/*
		//배틀실버 암호화.		
		//핸드폰 번호 암호화.
		string[] _strPassword = {
								"1", 
								"2", 
								"3", 
								"4", 
								"5", 
								"6", 
								"23", 
								"456", 
								"7890", 
								"12345", 
								"678901", 
								"2345678",
								"90123456"
		};
		//1 		> 55566119535250
		//2 		> 44456520864248
		//3 		> 66679913930001
		//4 		> 22236891049012
		//5 		> 77782482518000
		//6 		> 55561646572251
		//23 		> 99911240340247
		//456 		> 77701230245009
		//7890 		> 88825678423011
		//12345 	> 66617890162250
		//678901 	> 88844567897014
		//2345678 	> 55527890123010
		//90123456 	> 222012345678054
		for(int i = 0; i < _strPassword.Length; i++){
			Debug.Log(_strPassword[i] + " > " + SSUtil.setEncode3(_strPassword[i]));
		}
		/**/
		
		/*
		//배틀실버 암호화.		
		//핸드폰 번호 암호화.
		string[] _strPassword = {
								"1", "23", "456", 
								"7890", 
								"12345",
								"0162682109", "01022223333", "07046854975", "01023456789", 
								"01098765423"
		};
		//1:1 			> 5471353135G511319131
		//23:23 		> 3403051235T593347569
		//456:456 		> 7422564350F192659683
		//7890:7890 	> 2929645078S593669333
		//12345:12345 	> 7434721436Q391195993
		//0162682109	> 14563743539925243499
		//01022223333 	> 33326010222900963788
		//07046854975 	> 76051707731370945785
		//01023456789 	> 94191747507579489275
		//01098765423 	> 70822656341354223661

		for(int i = 0; i < _strPassword.Length; i++){
			Debug.Log(_strPassword[i] + " > " + SSUtil.setEncode2(_strPassword[i]));
		}
		/**/
		
		/*
		//패스워드암호화.		
		string[] _strPassword = {"aaaaaa", "a1s2d3f4", "abcdefgh", "12345678", "111111", "00000000", "12345678901234567890"};
		for(int i = 0; i < _strPassword.Length; i++){
			Debug.Log(_strPassword[i] + " > " + SSUtil.setPassword(_strPassword[i]));
		}
		/**/
		//aaaaaa 				> 7575970askeie1595312
		//12345678901234567890 	> 12345678901234567890
		//a1s2d3f4 				> 049000s1i0n7t8445289
		//abcdefgh 				> 810348kradgjsn472567
		//12345678 				> 25690830783252672141
		//111111 				> 37993721339797757114
		//00000000 				> 28282828888888888888
		//12345678901234567890 	> 58709214365870921436


		/*		
		string _strRtn = "";
		string _strCash = "";
		string _strSum = "";
		int _len;
		int _loop;
		
		//1. swap. > 문자가 깨진다. 
		//int[] arr = new int[10];
		//for(int i = 1 ; i < 100; i++){
		//	arr[Random.Range(1, 7)]++;
		//}
		//for(int i = 0; i < arr.Length; i++)
		//	Debug.Log("[" + i + "]=" + arr[i]);
		//int _swap = Random.Range(1, 8); 	// left <= x < right		
		//_strRtn += _swap;
		//Debug.Log("_swap:" + _swap);
		
		//1. loop.
		_loop = Random.Range(1, 10);
		_strRtn += _loop;
		#if DEBUG_ON
			Debug.Log("_loop:" + _loop);
		#endif

		//2. cash
		_cash = (_cash + 12345678);
		_strCash += _cash;
		_len = _strCash.Length;
		#if DEBUG_ON
			Debug.Log("_strCashS:" + _strCash);
		#endif
		while(_len < 8){
			_strCash = "0" + _strCash;
			++_len;
		}
		_strRtn += _strCash;
		#if DEBUG_ON
			Debug.Log("_strCashE:" + _strCash);
		#endif
		
		//3. id.
		_strRtn += _strGameid;
		
		//4. current date.
		string _time = System.DateTime.Now.ToString("yyyyMMddhhmmss") + Random.Range(10, 99);
		_strRtn += _time;
		#if DEBUG_ON
			Debug.Log("_time:" + _time);
		#endif
		
		//5. summar
		#if DEBUG_ON
			Debug.Log("o:[" + _strRtn+"]");
		#endif
		
		System.Text.UTF8Encoding encoding=new System.Text.UTF8Encoding();
		_len = _strRtn.Length;
    	byte[] _arr = encoding.GetBytes(_strRtn);
		int _tmp;
		byte _sum = 0;
		for(int i = 1; i < _len; i++){
			//Debug.Log("_arr["+i+"]:" + _arr[i]);
			_tmp = (int)_arr[i];
			_sum += _arr[i];
			if(_tmp >= 48 && _tmp <= 57){
				_tmp += _loop;
				if(_tmp > 57)_tmp -= 10;
			}else if(_tmp >= 65 && _tmp <= 90){
				_tmp += _loop;
				if(_tmp > 90)_tmp -= 26;
			}else if(_tmp >= 97 && _tmp <= 122){
				_tmp += _loop;
				if(_tmp > 122)_tmp -= 26;
			}else{
				_tmp += _loop;
			}
			_arr[i] = (byte)_tmp;
		}
		
		_strSum = "" + _sum;
		_len = _strSum.Length;
		#if DEBUG_ON
			Debug.Log("_strSumS:" + _strSum);
		#endif
		while(_len < 3){
			_strSum = "0" + _strSum;
			++_len;
		}
		#if DEBUG_ON
			Debug.Log("_strSumE:" + _strSum);
		#endif
		
		_strRtn = System.Text.Encoding.UTF8.GetString(_arr, 0, _arr.Length);
		#if DEBUG_ON
			Debug.Log("c:[" + _strRtn+"]");
		#endif
		
		_strRtn = _strRtn + _strSum;
		
		#if DEBUG_ON
			Debug.Log("d:[" + _strRtn+"]");
		#endif
		//for(int i = 0 ; i < 300; i++){
		//	_sum=(byte)i;
		//	Debug.Log("["+i+"]:" + _sum);
		//}
		//o:[412445678abcd2012081803450619]
		//d:[456889012efgh6456425247894053097]
		//o:[912445678abcd2012081803542497]
		//d:[901334567jklm1901970792431386103]
		//o:[312445678abcd2012081803551235]
		//d:[345778901defg5345314136884568093]
		/**/
	}
	
}
