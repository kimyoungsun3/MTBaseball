package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import common.util.DbUtil;
import formutil.FormUtil;
import java.sql.*;
import java.util.*;
import java.text.*;

public final class userinfo_005flist_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


	//UltraEdit 파일포맷을 변경하면 된다.
	//파일 > 변환 > (ASCII -> Unicode)
	//파일 > 변환 > (UTF-8 -> Unicode)

	public String getTel(int _market){
		String _str = "NONE";
		switch(_market){
			case 1: 	_str = "SKT";		break;
			case 5: 	_str = "GOOGLE";	break;
			case 6: 	_str = "NHN";		break;
			case 7: 	_str = "IPHONE";	break;
		}
		return _str;
	}
	public String getTel2(int _market){
		String _str = "NONE";
		switch(_market){
			case 0: 	_str = "All";		break;
			case 1: 	_str = "SKT";		break;
			case 2: 	_str = "KT";		break;
			case 3: 	_str = "LGT";		break;
			case 5: 	_str = "GOOGLE";	break;
			case 6: 	_str = "NHN";		break;
			case 7: 	_str = "IPHONE";	break;
		}
		return _str;
	}

	public String getTel(int _market, int _buytype){
		String _str = getTel(_market);

		if(_buytype == 0){
			_str += "(무료)";
		}else{
			_str += "(유료)";
		}
		return _str;
	}

	public String getBytType(int _kind){
		String _str = "(무료)";
		if(_kind == 1){
			_str = "<font color=blue>(유료)</font>";
		}else if(_kind == 2){
			_str = "<font color=blue>(유료 > 재가입)</font>";
		}
		return _str;
	}

	public String getPlatform(int _kind){
		String _str = "NONE";
		switch(_kind){
			case 1: 	_str = "Android";		break;
			case 2: 	_str = "IPhone";		break;
			case 3: 	_str = "FACKBOOK";	break;
			case 4: 	_str = "NHN";		break;
		}
		return _str;
	}

	public String getFriend(int _val){
		String _str = "NONE("+ _val +")";
		switch(_val){
			case 0: _str = "친구신청대기("+ _val +")";		break;
			case 1: _str = "친구수락대기("+ _val +")";		break;
			case 2: _str = "상호친구("+ _val +")";		break;
		}
		return _str;
	}

	public String getFriendKind(int _val){
		String _str = "NONE("+ _val +")";
		switch(_val){
			case 1: _str = "게임친구("+ _val +")";		break;
			case 2: _str = "카톡친구("+ _val +")";		break;
		}
		return _str;
	}

	public String getKakaoMessageBlocked(int _val){
		String _str = "NONE("+ _val +")";
		switch(_val){
			case -1: _str = "메세지블럭아님("+ _val +")";		break;
			case  1: _str = "<font color=red>메세지블럭임("+ _val +")</font>";		break;
		}
		return _str;
	}

	public String getKakaoStatus(int _val){
		String _str = "NONE("+ _val +")";
		switch(_val){
			case  1: _str = "진행중("+ _val +")";		break;
			case -1: _str = "<font color=red>유저가버림("+ _val +")</font>";break;
		}
		return _str;
	}

	public String getKakaoSend(int _val){
		String _str = "NONE("+ _val +")";
		switch(_val){
			case -1: _str = "대기중("+ _val +")";		break;
			case  1: _str = "<font color=blue>전송완료("+ _val +")</font>";		break;
			case -444: _str = "<font color=red>오류발생("+ _val +")</font>";	break;
		}
		return _str;
	}

	//public String getFormatDate(String _date, int _size){
	//	if(_date == null || _date.equals("")){
	//		_date = "";
	//	}else if(_date.length() <= _size){
	//		//그대로 출력
	//	}else if(_date.length() > _size){
	//		_date = _date.substring(0, _size);
	//	}
	//	return _date;
	//}


	public String getDate(String _str){
		if(_str == null){
			_str = "날짜미정";
		}else if(_str.equals("NULL")){
			_str = "날짜미정";
		}else if(_str != null && _str.length() > 16){
			_str = _str.substring(0, 16);
		}
		return _str;
	}

	public String getDateShort(String _str){
		if(_str == null){
			_str = "날짜미정";
		}else if(_str != null && _str.length() > 16){
			_str = _str.substring(10, 16);
		}
		return _str;
	}

	public String getDateShort2(String _str){
		if(_str == null){
			_str = "날짜미정";
		}else if(_str != null && _str.length() > 16){
			_str = _str.substring(10, 19);
		}
		return _str;
	}

	public String getDate19(String _str){
		if(_str == null){
			_str = "날짜미정";
		}else if(_str != null && _str.length() > 19){
			_str = _str.substring(0, 19);
		}
		return _str;
	}

	public String getDate10(String _str){
		if(_str == null){
			_str = "날짜미정";
		}else if(_str != null && _str.length() > 10){
			_str = _str.substring(0, 10);
		}
		return _str;
	}

	public String getDate16(String _str){
		if(_str == null){
			_str = "날짜미정";
		}else if(_str != null && _str.length() > 16){
			_str = _str.substring(0, 16);
		}
		return _str;
	}

	public String getWheelToday(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: _str = "안돌림("+ _val +")";								break;
			case 1: _str = "<font color=red>무료돌림("+ _val +")</font>";		break;
		}
		return _str;
	}

	public String getZCPChance(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case  1: _str = "돌림있음("+ _val +")";	break;
			case -1: _str = "돌림없음("+ _val +")";	break;
		}
		return _str;
	}

	public String getZCPSaleFresh(int _bound, int _val){
		String _str;
		if( _val >= _bound){
			_str = "<font color=blue>출현가능(거래신선도:"+ _val +")</font>";
		}else{
			_str = "<font color=red>안나옴(거래신선도:"+ _val +")<br>(최소:"+_bound+"이상 거래신선도 필요)</font>";
		}
		return _str;
	}

	public String getZCPMode(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 1: _str = "무료돌림("+ _val +")";	break;
			case 2: _str = "유료돌림("+ _val +")";	break;
		}
		return _str;
	}

	public String getTradeState(int _state){
		String _str;
		if(_state == 1){
			_str = "오픈("+ _state +")";
		}else{
			_str = "<font color=red>잠김("+ _state +")<br>박스와 목장보상이 하락함</font>";
		}
		return _str;
	}

	public String getRKStartState(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 1: _str = "<font color=blue>참여중("+ _val +")</font>";	break;
			case 0: _str = "<font color=red>미참여("+ _val +")</font>";		break;
		}
		return _str;
	}

	public String getRKTeam(int _val){
		String _str = "미참여("+ _val +")";
		switch(_val){
			case 0: _str = "<font color=red>짝수팀("+ _val +")</font>";		break;
			case 1: _str = "<font color=blue>홀수팀("+ _val +")</font>";	break;
		}
		return _str;
	}

	public String getWheelFree(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: _str = "<font color=red>무료없음("+ _val +")</font>";		break;
			case 1: _str = "<font color=blue>무료있음("+ _val +")</font>";		break;
		}
		return _str;
	}


	public String getUpgradeState(int _state){
		String _str = "미진행("+ _state +")";
		if(_state == 1){
			_str = "진행중("+ _state +")";
		}
		return _str;
	}

	public String getSeedItemcode(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 905: _str = "건초";		break;
			case 800: _str = "치료제";		break;
			case 1100: _str = "촉진제";		break;
			case 2000: _str = "하트";		break;
		}
		return _str;
	}

	public String getComRewardKind(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: _str = "코인("+ _val +")";		break;
			case 1: _str = "캐쉬("+ _val +")";		break;
			case 2: _str = "하트("+ _val +")";		break;
			case 3: _str = "건초("+ _val +")";		break;
			case 4: _str = "우정포인트("+ _val +")";break;
			case 5: _str = "아이템코드("+ _val +")";break;
		}
		return _str;
	}

	public String getComRewardCheckPart(int _kind, int _val){
		String _str = "모름("+ _kind +")";
		switch(_kind){
			case 0: _str = "없음("+ _kind +")";					break;

			case 1: _str = "누적늑대잡이("+ _kind +")";			break;

			case 11: _str = "누적판매금액("+ _kind +")";		break;
			case 12: _str = "누적하트획득("+ _kind +")";		break;
			case 13: _str = "누적건초획득("+ _kind +")";		break;
			case 14: _str = "최고거래성공횟수("+ _kind +")";	break;
			case 15: _str = "최고신선도("+ _kind +")";			break;
			case 16: _str = "최고배럴("+ _kind +")";			break;
			case 17: _str = "최고판매금액("+ _kind +")";		break;
			case 18: _str = "누적배럴("+ _kind +")";			break;

			case 21: _str = "누적일반교배("+ _kind +")";		break;
			case 22: _str = "누적프리미엄교배("+ _kind +")";	break;

			case 30: _str = "필드동물수량("+ _kind +")";		break;
			case 31: _str = "명성레벨("+ _kind +")";			break;
			case 32: _str = "친구추가("+ _kind +")";			break;
			case 33: _str = "친구하트선물("+ _kind +")";		break;

			case 40: _str = "경작지확장("+ _kind +")";			break;
			case 41: _str = "동물인벤확장("+ _kind +")";		break;
			case 42: _str = "소비인벤확장("+ _kind +")";		break;
			case 43: _str = "악세인벤확장("+ _kind +")";		break;

			case 50: _str = "집("+ _kind +")";					break;
			case 51: _str = "탱크("+ _kind +")";				break;
			case 52: _str = "양동이("+ _kind +")";				break;
			case 53: _str = "착유기("+ _kind +")";				break;
			case 54: _str = "주입기("+ _kind +")";				break;
			case 55: _str = "정화시설("+ _kind +")";			break;
			case 56: _str = "저온보관("+ _kind +")";			break;

			case 61: _str = "소모템일반 촉진제("+ _kind +")";	break;
			case 62: _str = "소모템일반 치료제("+ _kind +")";	break;
			case 63: _str = "소모템농부("+ _kind +")";			break;
			case 64: _str = "소모템늑대용 공포탄("+ _kind +")";	break;
			case 65: _str = "소모템긴급지원("+ _kind +")";		break;

			case 70: _str = "필드동물배치("+ _kind +")";		break;
		}
		_str += " " + _val + "개";
		return _str;
	}

	public String getComRewardInitPart(int _kind){
		String _str = "모름("+ _kind +")";
		switch(_kind){
			case 0: _str = "없음("+ _kind +")";					break;

			case 1: _str = "누적늑대잡이("+ _kind +")";			break;

			case 11: _str = "누적판매금액("+ _kind +")";		break;
			case 12: _str = "누적하트획득("+ _kind +")";		break;
			case 13: _str = "누적건초획득("+ _kind +")";		break;
			case 14: _str = "최고거래성공횟수("+ _kind +")";	break;
			case 15: _str = "최고신선도("+ _kind +")";			break;
			case 16: _str = "최고배럴("+ _kind +")";			break;
			case 17: _str = "최고판매금액("+ _kind +")";		break;
			case 18: _str = "누적배럴("+ _kind +")";			break;

			case 21: _str = "누적일반교배("+ _kind +")";		break;
			case 22: _str = "누적프리미엄교배("+ _kind +")";	break;

			case 30: _str = "필드동물수량("+ _kind +")";		break;
			case 31: _str = "명성레벨("+ _kind +")";			break;
			case 32: _str = "친구추가("+ _kind +")";			break;
			case 33: _str = "친구하트선물("+ _kind +")";		break;

			case 40: _str = "경작지확장("+ _kind +")";			break;
			case 41: _str = "동물인벤확장("+ _kind +")";		break;
			case 42: _str = "소비인벤확장("+ _kind +")";		break;
			case 43: _str = "악세인벤확장("+ _kind +")";		break;

			case 50: _str = "집("+ _kind +")";					break;
			case 51: _str = "탱크("+ _kind +")";				break;
			case 52: _str = "양동이("+ _kind +")";				break;
			case 53: _str = "착유기("+ _kind +")";				break;
			case 54: _str = "주입기("+ _kind +")";				break;
			case 55: _str = "정화시설("+ _kind +")";			break;
			case 56: _str = "저온보관("+ _kind +")";			break;

			case 61: _str = "소모템일반 촉진제("+ _kind +")";	break;
			case 62: _str = "소모템일반 치료제("+ _kind +")";	break;
			case 63: _str = "소모템농부("+ _kind +")";			break;
			case 64: _str = "소모템늑대용 공포탄("+ _kind +")";	break;
			case 65: _str = "소모템긴급지원("+ _kind +")";		break;

			case 70: _str = "필드동물배치("+ _kind +")";		break;
		}
		return _str;
	}

	public String getComRewardCheckPass(int _isPass){
		String _str = "모름("+ _isPass +")";
		switch(_isPass){
			case -1: _str = "완료("+ _isPass +")";		break;
			case  1: _str = "패스("+ _isPass +")";		break;
		}
		return _str;
	}

	public String getETGrade(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: _str = "Non("+ _val +")";		break;
			case 1: _str = "Bad("+ _val +")";		break;
			case 2: _str = "Normal("+ _val +")";	break;
			case 3: _str = "Good("+ _val +")";		break;
			case 4: _str = "Excellent("+ _val +")";	break;
		}
		return _str;
	}

	/////////////////////////////////////////////
	public String getDanilga(int _subcategory, int _gamecost, int _cashcost, int _buyamount, int _sellcost){
		String _str = "";
		if(_subcategory >= 50){
			_str = "";
			if(_subcategory >= 60 && _subcategory <= 66){
				if(_gamecost > 0 && _cashcost > 0){
					_str = "<font color=red>코인/캐쉬 2개가 존재</font>";
				}
			}
		}else if(_gamecost <= 0 && _cashcost <= 0){
			_str = "<font color=red>코인/캐쉬 구매 (0코인)</font>";
		}else if(_sellcost <= 0){
			_str = "<font color=red>판매단가(0코인)</font>";
		}else if(_cashcost == 0 && _gamecost > 0){
			if(_gamecost/_buyamount < _sellcost){
				_str = "<font color=red>구매가(" + (_gamecost/_buyamount) + ") < 판매가(" + (_sellcost) + ")</font>";
			}else if(_gamecost/_buyamount == _sellcost){
				_str = "<font color=blue>구매가(" + (_gamecost/_buyamount) + ") == 판매가(" + (_sellcost) + ")</font>";
			}
		}
		return _str;
	}

	/////////////////////////////////////////////
	public int getAllowedGroup3(int _kind, int _lv){
		int _cnt = 0;
		switch(_kind){
			case 1: 	//소
				_cnt = 5;
				break;
			case 2:		//양
				if(_lv < 15)		_cnt = 1;
				else if(_lv < 30)	_cnt = 2;
				else				_cnt = 2;
				break;
			case 3:		//산양
				if(_lv < 15)		_cnt = 0;
				else if(_lv < 30)	_cnt = 0;
				else if(_lv < 45)	_cnt = 1;
				else				_cnt = 1;
				break;
		}
		return _cnt;
	}

	public int getAllowedGroup4(int _kind, int _lv){
		int _cnt = 0;
		switch(_kind){
			case 1: 	//소
				_cnt = 5;
				break;
			case 2:		//양
				if(_lv < 15)		_cnt = 1;
				else if(_lv < 30)	_cnt = 2;
				else				_cnt = 3;
				break;
			case 3:		//산양
				if(_lv < 15)		_cnt = 0;
				else if(_lv < 30)	_cnt = 1;
				else if(_lv < 45)	_cnt = 2;
				else				_cnt = 3;
				break;
		}
		return _cnt;
	}

	public String getInvenKind(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 1: _str = "가축("+ _val +")";		break;
			case 3: _str = "소모품("+ _val +")";	break;
			case 4: _str = "액세서리("+ _val +")";	break;
			case 40: _str = "직접지급("+ _val +")";	break;
			case 60: _str = "정보용("+ _val +")";	break;
			case 1000: _str = "펫("+ _val +")";		break;
			case 1040: _str = "줄기세포("+ _val +")";break;
			case 1200: _str = "보물("+ _val +")";	break;
		}
		return _str;
	}

	public String getGetHow(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: _str = "기본("+ _val +")";		break;
			case 1: _str = "구매("+ _val +")";		break;
			case 2: _str = "경작("+ _val +")";		break;
			case 3: _str = "교배/뽑기("+ _val +")";	break;
			case 4: _str = "검색("+ _val +")";		break;
			case 5: _str = "선물("+ _val +")";		break;
			case 6: _str = "펫[오늘만판매]("+ _val +")";break;
			case 7: _str = "펫[뽑기]("+ _val +")";	break;
			case 9: _str = "악세뽑기("+ _val +")";	break;
			case 10: _str = "악세해제("+ _val +")";	break;
			case 11: _str = "합성("+ _val +")";		break;
			case 18: _str = "승급("+ _val +")";		break;
			case 13: _str = "직접("+ _val +")";		break;
			case 14: _str = "거래("+ _val +")";		break;
			case 15: _str = "동물분해("+ _val +")";	break;
			case 16: _str = "보물분해("+ _val +")";	break;
			case 17: _str = "무료긴급지원("+ _val +")";	break;
			case 19: _str = "유저배틀박스("+ _val +")";	break;
			case 20: _str = "짜요쿠폰룰렛("+ _val +")";	break;
		}
		return _str;
	}


	public String getFieldIdx(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case -2: _str = "<font color=red>병원("+ _val +")</font>";		break;
			case -1: _str = "<font color=blue>인벤토리("+ _val +")</font>";		break;
			case 0: _str = "필드("+ _val +")";		break;
			case 1: _str = "필드("+ _val +")";		break;
			case 2: _str = "필드("+ _val +")";		break;
			case 3: _str = "필드("+ _val +")";		break;
			case 4: _str = "필드("+ _val +")";		break;
			case 5: _str = "필드("+ _val +")";		break;
			case 6: _str = "필드("+ _val +")";		break;
			case 7: _str = "필드("+ _val +")";		break;
			case 8: _str = "필드("+ _val +")";		break;
		}
		return _str;
	}

	public String checkNeedHelpCNT(int _val, int _cnt){
		String _str = "";
		switch(_val){
			case -2: _str = "필요도움("+ _cnt +")";		break;
		}
		return _str;
	}

	public String getDiseasestate(int _val){
		String _str = "모름("+ _val +")";
		if(_val == 0){
			_str = "노질병("+ _val +")";
		}else if(_val > 0){
			_str = "<font color=red>질병("+ _val +")</font>";
		}
		return _str;
	}


	public String getDiestate(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case -1: 	_str = "생존("+ _val +")";		break;
			case 1: 	_str = "<font color=red>죽음("+ _val +")</font>";		break;
		}
		return _str;
	}

	public String getDieMode(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case -1: _str = "생존("+ _val +")";								break;
			case 1: _str = "<font color=red>눌러("+ _val +")</font>";		break;
			case 2: _str = "<font color=red>늑대("+ _val +")</font>";		break;
			case 3: _str = "<font color=red>터져("+ _val +")</font>";		break;
			case 4: _str = "<font color=red>질병("+ _val +")</font>";		break;
		}
		return _str;
	}

	public String getUserItemState(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: _str = "<font color=red>병원에서밀림("+ _val +")</font>";	break;
			case 1: _str = "<font color=red>판매함("+ _val +")</font>";			break;
			case 2: _str = "<font color=red>우편에서삭제("+ _val +")</font>";	break;
			case 3: _str = "<font color=red>합성소모("+ _val +")</font>";		break;
			case 4: _str = "<font color=red>동물세포분해("+ _val +")</font>";	break;
			case 5: _str = "<font color=red>보물세포분해("+ _val +")</font>";	break;
			case 6: _str = "<font color=red>승급소모("+ _val +")</font>";		break;
			case 10: _str = "<font color=red>짜요장터소모("+ _val +")</font>";	break;
			case 11: _str = "<font color=red>만기자동삭제("+ _val +")</font>";	break;
		}
		return _str;
	}

	public String getMBoardState(int _kind){
		String _str = "추천작성함";
		if(_kind == 0){
			_str = "추천미작성";
		}
		return _str;
	}

	public String getFarmBuyState(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case -1: 	_str = "<font color=red>미보유("+ _val +")</font>";		break;
			case 1: 	_str = "<font color=blue>보유중("+ _val +")</font>";		break;
		}
		return _str;
	}

	public String getSchoolKind(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 1: 	_str = "초등학교("+ _val +")";		break;
			case 2: 	_str = "중학교("+ _val +")";		break;
			case 3: 	_str = "고등학교("+ _val +")";		break;
			case 4: 	_str = "대학교("+ _val +")";		break;
		}
		return _str;
	}

	public String getInQuireState(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: 	_str = "문의중("+ _val +")";		break;
			case 1: 	_str = "처리중("+ _val +")";		break;
			case 2: 	_str = "완료("+ _val +")";		break;
		}
		return _str;
	}

	public String getInQuireStateColor(int _val){
		String _str = "";
		switch(_val){
			case 1: 	_str = "bgcolor=#ffe020";		break;
			case 2: 	_str = "bgcolor=#c0c0c0";		break;
		}
		return _str;
	}

	//public String getInQuireStateValue(int _val){
	//	String _str = "";
	//	switch(_val){
	//		case 0: 	_str = "문의중";		break;
	//		case 1: 	_str = "확인중";		break;
	//		case 2: 	_str = "처리완료";		break;
	//		case 3: 	_str = "모름";		break;
	//	}
	//	return _str;
	//}


	public String getEpiResult(int _val){
		String _str = "모름(" + _val + ")";
		switch(_val){
			case  1: 	_str = "<font color=blue>만족(" + _val + ")</font>";		break;
			case -1: 	_str = "<font color=red>불만족(" + _val + ")</font>";		break;
		}
		return _str;
	}


	//@@@@
	public String getCheckValue(int _v1, int _v2, String _t1, String _f1){
		if(_v1 == _v2)
			return _t1 + "(" + _v1 + ")";
		else
			return _f1 + "(" + _v1 + ")";
	}

	//@@@@
	public String getCheckValueOri(int _v1, int _v2, String _t1, String _f1){
		if(_v1 == _v2)
			return _t1;
		else
			return _f1;
	}

	public String getCheckValueOri2(int _v1[], int _v2, String _t1, String _f1){
		int _len = _v1.length;
		for(int i = 0; i < _len; i++){
			if(_v1[i] == _v2){
				return _t1;
			}else{
				continue;
			}
		}
		return _f1;
	}

	//@@@@
	public String getSelect(int _result, int _value){
		if(_result == _value)
			return "selected";
		else
			return "";
	}

	public String getSelect(String _result, String _value){
		if(_result != null && _value != null && _result.equals(_value))
			return "selected";
		else
			return "";
	}


	public String checkPush(int _value){
		if(_value == 1)
			return "(허용)";
		else
			return "<font color=red>(거부)</font>";
	}

	public String getPushData(String _value){
		if(_value == null || _value.equals("") || _value.equals("editxxxxxx")){
			_value = "<font color=red>발송불가(PC생성)</font>";
		}else if(_value.equals("iPhoneEmpty")){
			_value = "<font color=red>iPhone(Push ID 못받음:폰푸쉬 설정 거부 or 프로비젼이 틀림) 나 푸쉬안받아요!!!</font>";
		}
		return _value;
	}

	//////////////////////////////////////////////////////////
	public String getDeleteState(int _result){
		String _str;
		if(_result == 1)_str = "<font color=red>삭제상태(" + _result + ")</font>";
		else _str = "삭제아님(" + _result + ")";
		return _str;
	}

	public String getBlockState(int _result){
		String _str;
		if(_result == 1)_str = "<font color=red>블럭상태(" + _result + ")</font>";
		else _str = "블럭아님(" + _result + ")";
		return _str;
	}

	public String displayMoney(String _src){
		long i = Long.parseLong(_src);
		java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");

		return df.format(i) + "";
	}

	public String displayMoney(long i){
		java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
		return df.format(i) + "";
	}


	public String getXXX(String _str, int _idx){
		String _rtn = "";
		int _len = _str.length();
		int _size = _len - _idx;

		String _tmp = "";
		for(int i = 0; i < _size; i++){
			_tmp += "X";
		}

		if(_len >= _idx + _size){
			_rtn = _str.substring(0, _idx) + _tmp;
		}
		return _rtn;
	}
	public String getXXX2(String _str, int _idx){
		String _rtn = "";
		int _len = _str.length();
		if(_len == 0)return "";
		if(_len > 60)_len = 60;
		if(_idx >= _len)_idx = _len - 1;
		int _size = _len - _idx;

		String _tmp = "";
		for(int i = 0; i < _size; i++){
			_tmp += "X";
		}

		if(_len >= _idx + _size){
			_rtn = _str.substring(0, _idx) + _tmp;
		}
		return _rtn;
	}


	///////////////////////////////////////////////
	// 선물쪽
	///////////////////////////////////////////////
	//
	public String getCategory(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case 1:		_str = "가축("+_kind+")";			break;
			case 3:		_str = "소모품("+_kind+")";			break;
			case 4:		_str = "액세서리("+_kind+")";		break;
			case 44:	_str = "건초("+_kind+")";			break;
			case 19:	_str = "우정포인트("+_kind+")";		break;
			case 40:	_str = "하트("+_kind+")";			break;
			case 50:	_str = "캐쉬선물("+_kind+")";		break;
			case 51:	_str = "코인선물("+_kind+")";		break;
			case 52:	_str = "뽑기("+_kind+")";			break;
			case 53:	_str = "대회("+_kind+")";			break;
			case 60:	_str = "업글("+_kind+")";			break;
			case 67:	_str = "인벤확장("+_kind+")";		break;
			case 68:	_str = "경작지확장("+_kind+")";		break;
			case 818:	_str = "도감("+_kind+")";			break;
			case 500:	_str = "정보수집("+_kind+")";		break;
			case 30:	_str = "황금티켓("+_kind+")";		break;
			case 31:	_str = "싸움티켓("+_kind+")";		break;
			case 1000:	_str = "펫("+_kind+")";				break;
			case 1040:	_str = "줄기세포("+_kind+")";		break;
			case 1200:	_str = "보물("+_kind+")";			break;
			case 37:	_str = "유저배틀박스("+_kind+")";	break;
			case 38:	_str = "짜요쿠폰("+_kind+")";		break;
			case 39:	_str = "낙농 포인트("+_kind+")";	break;
		}
		return _str;
	}

	//
	public String getSubCategory(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case 1:		_str = "소("+_kind+")";			break;
			case 2:		_str = "양("+_kind+")";			break;
			case 3:		_str = "산양("+_kind+")";		break;
			case 7:		_str = "씨앗("+_kind+")";		break;
			case 8:		_str = "총알("+_kind+")";		break;
			case 9:		_str = "치료제("+_kind+")";		break;
			case 44:	_str = "건초("+_kind+")";		break;
			case 11:	_str = "일꾼("+_kind+")";		break;
			case 12:	_str = "촉진제("+_kind+")";		break;
			case 13:	_str = "부활석("+_kind+")";		break;
			case 16:	_str = "합선시간단축("+_kind+")";break;
			case 15:	_str = "가축 악세사리("+_kind+")";break;
			case 19:	_str = "우정포인트("+_kind+")";	break;
			case 40:	_str = "하트("+_kind+")";		break;
			case 41:	_str = "긴급요청("+_kind+")";	break;
			case 22:	_str = "동물일반교배티켓("+_kind+")";break;
			case 23:	_str = "동물프림교배티켓("+_kind+")";break;
			case 25:	_str = "보물일반티켓("+_kind+")";break;
			case 26:	_str = "보물프림티켓("+_kind+")";break;
			case 50:	_str = "캐쉬("+_kind+")";		break;
			case 51:	_str = "코인("+_kind+")";		break;
			case 52:	_str = "뽑기("+_kind+")";		break;
			case 53:	_str = "대회("+_kind+")";		break;
			case 60:	_str = "집("+_kind+")";			break;
			case 61:	_str = "탱크("+_kind+")";		break;
			case 62:	_str = "저온보관("+_kind+")";	break;
			case 63:	_str = "정화시설("+_kind+")";	break;
			case 64:	_str = "양동이("+_kind+")";		break;
			case 65:	_str = "착유기("+_kind+")";		break;
			case 66:	_str = "주입기("+_kind+")";		break;
			case 67:	_str = "인벤확장("+_kind+")";	break;
			case 68:	_str = "경작지확장("+_kind+")";	break;
			case 818:	_str = "도감("+_kind+")";		break;
			case 500:	_str = "정보수집("+_kind+")";	break;
			case 30:	_str = "황금티켓("+_kind+")";	break;
			case 31:	_str = "싸움티켓("+_kind+")";	break;
			case 1000:	_str = "펫("+_kind+")";			break;
			case 1040:	_str = "줄기세포("+_kind+")";	break;
			case 1200:	_str = "보물("+_kind+")";		break;
			case 35:	_str = "합성의 훈장("+_kind+")";break;
			case 36:	_str = "승급의 꽃("+_kind+")";	break;
			case 37:	_str = "유저배틀박스("+_kind+")";break;
			case 38:	_str = "짜요쿠폰("+_kind+")";	break;
			case 39:	_str = "낙농 포인트("+_kind+")";	break;
		}
		return _str;
	}

	public String getPrice(int _gamecost, int _cashcost){
		String _str = "";
		if(_gamecost != 0)_str += _gamecost + "(코인)";
		if(_cashcost != 0)_str += _cashcost + "(루비)";
		if(_str.equals(""))_str = "무료";
		return _str;
	}

	public String getGrade(int _grade){
		String _str = "모름(" + _grade + ")";
		switch(_grade){
			case 0:		_str = "저급("+_grade+")";		break;
			case 1:		_str = "일반("+_grade+")";		break;
			case 2:		_str = "고급("+_grade+")";		break;
			case 3:		_str = "희귀("+_grade+")";		break;
			case 4:		_str = "황금("+_grade+")";		break;
			case 5:		_str = "전설("+_grade+")";		break;
			case 6:		_str = "붉은("+_grade+")";		break;
			case 7:		_str = "신화("+_grade+")";		break;
			case 8:		_str = "지존("+_grade+")";		break;
			case 9:		_str = "레전("+_grade+")";		break;
			case 10:	_str = "신용("+_grade+")";		break;
		}
		return _str;
	}

	public String getGiftKind(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case 1:		_str = "메시지("+_kind+")";		break;
			case 2:		_str = "선물("+_kind+")";		break;
			case -1:	_str = "메시지삭제("+_kind+")";	break;
			case -2:	_str = "선물삭제("+_kind+")";	break;
			case -3:	_str = "선물받아감("+_kind+")";	break;
			case -4:	_str = "선물판매("+_kind+")";	break;
		}
		return _str;
	}

	public String getGiftKindColor(int _kind){
		String _str = "";
		switch(_kind){
			case 1:		_str = "";					break;
			case 2:		_str = "";					break;
			case -1:	_str = "bgcolor=#d9d9d9";	break;
			case -2:	_str = "bgcolor=#a9a9a9";	break;
			case -3:	_str = "bgcolor=#d9d9d9";	break;
			case -4:	_str = "bgcolor=#a9a9a9";	break;
		}
		return _str;
	}

	public String getSubString(String _str){
		if(_str != null && _str.length() > 20){
			_str = _str.substring(0, 20) + "...";
		}
		return _str;
	}

	public String getGainState(int _state){
		if(_state == 0)
			return "안받아감";
		else
			return "받아감";
	}

	public String getShotMsg(String _str, int _size){
		int _len = _str.length();
		if(_len < _size){
			return _str;
		}else{
			return _str.substring(0, _size) + "...";
		}
	}

	public String getIsNull(String _str, String _strInit){
		String _rtn;
		if(_str == null || _str.equals("null")){
			_rtn = _strInit;
		}else{
			_rtn = _str;
		}
		return _rtn;
	}

	public String getIsMode(int _mode, int _w1, int _w2, int _win){
		String _rtn;
		if(_mode == 5){
			_rtn = "배틀모드:" + _w1 + "연승";
		}else if(_mode == 6){
			_rtn = "스프린트모드:" + _w2 + "연승";
		}else{
			_rtn = "모름:"+ _mode + ":" + _w1 + ":" + _w2;
		}

		if(_win == 1)
			_rtn += "(승)";
		else
			_rtn += "(패)";
		return _rtn;
	}




	//////////////////////////////////////////////////////////////////////
	/////////////////////////////////
	//	퀘스트 변수
	/////////////////////////////////
	public static final int
			QUEST_STATE_END						= 0,	//완료(0).
			QUEST_STATE_WAIT					= 1,	//대기중(1).
			QUEST_STATE_ING						= 2;	//진행중(2).

	public static final int
			QUEST_KIND_UPGRADE					= 100,	//강화.
			QUEST_KIND_MATING					= 200,	//교배.
			QUEST_KIND_MACHINE 					= 300, 	//머신.
			QUEST_KIND_MEMORIAL 				= 400, 	//암기.
			QUEST_KIND_FRIEND 					= 500, 	// 친구.
			QUEST_KIND_POLL 					= 600, 	//폴대.
			QUEST_KIND_BOARD 					= 700, 	//보드.
			QUEST_KIND_CEIL 					= 800, 	//천장.
			QUEST_KIND_BATTLE 					= 900, 	//배틀.
			QUEST_KIND_SPRINT 					= 1000; //스프.

	public static final int
		 	QUEST_SUBKIND_POINT_ACCRUE			= 1,	//누적.
			QUEST_SUBKIND_POINT_BEST			= 2,	//최고.
			QUEST_SUBKIND_FRIEND_ADD			= 3,	//추가.
			QUEST_SUBKIND_FRIEND_VISIT			= 4,	//방문.
			QUEST_SUBKIND_HR_CNT				= 5,	//홈런누적.
			QUEST_SUBKIND_HR_COMBO				= 6,	//홈런콤보.
			QUEST_SUBKIND_WIN_CNT				= 7,	//승누적.
			QUEST_SUBKIND_WIN_STREAK			= 8,	//승연승.
			QUEST_SUBKIND_CNT					= 9;	//플레이.


	public String getQuestState(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case QUEST_STATE_END:		_str = "<font color=black>완료("+_kind+")</font>";	break;
			case QUEST_STATE_WAIT:		_str = "<font color=red>대기중("+_kind+")</font>";	break;
			case QUEST_STATE_ING:		_str = "<font color=blue>진행중("+_kind+")</font>";	break;
		}
		return _str;
	}


	public String getQuestDate(String _str){
		if(_str == null || _str.equals("NULL") || _str.equals("null")){
			_str = "미정";
		}else{
			_str = _str.substring(0, 19);
		}
		return _str;
	}

	public String getQuestKind(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case QUEST_KIND_UPGRADE:	_str = "강화("+_kind+")";	break;
			case QUEST_KIND_MATING:		_str = "교배("+_kind+")";	break;
			case QUEST_KIND_MACHINE:	_str = "머신("+_kind+")";	break;
			case QUEST_KIND_MEMORIAL:	_str = "암기("+_kind+")";	break;
			case QUEST_KIND_FRIEND:		_str = "친구("+_kind+")";	break;
			case QUEST_KIND_POLL:		_str = "폴대("+_kind+")";	break;
			case QUEST_KIND_BOARD:		_str = "보드("+_kind+")";	break;
			case QUEST_KIND_CEIL:		_str = "천장("+_kind+")";	break;
			case QUEST_KIND_BATTLE:		_str = "배틀("+_kind+")";	break;
			case QUEST_KIND_SPRINT:		_str = "스프("+_kind+")";	break;
		}
		return _str;
	}

	public String getQuestSubKind(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case QUEST_SUBKIND_POINT_ACCRUE:	_str = "점수/히트/거리누적("+_kind+")";		break;
			case QUEST_SUBKIND_POINT_BEST:		_str = "최고("+_kind+")";		break;
			case QUEST_SUBKIND_FRIEND_ADD:		_str = "추가("+_kind+")";		break;
			case QUEST_SUBKIND_FRIEND_VISIT:	_str = "방문("+_kind+")";		break;
			case QUEST_SUBKIND_HR_CNT:			_str = "홈런누적("+_kind+")";	break;
			case QUEST_SUBKIND_HR_COMBO:		_str = "홈런콤보("+_kind+")";	break;
			case QUEST_SUBKIND_WIN_CNT:			_str = "승누적("+_kind+")";		break;
			case QUEST_SUBKIND_WIN_STREAK:		_str = "승연승("+_kind+")";		break;
			case QUEST_SUBKIND_CNT:				_str = "횟수/플레이("+_kind+")";		break;
		}
		return _str;
	}


	public String getQuestClear(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case 0:		_str = "노클리어("+_kind+")";			break;
			case 1:		_str = "<font color=blue>퀘시작시클리어("+_kind+")</font>";	break;
			case 2:		_str = "<font color=blue>보상시클리어("+_kind+")</font>";	break;
		}
		return _str;
	}

	public String getQuestInit(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case 1:		_str = "<font color=red>처음Q("+_kind+")</font>";		break;
			case 0:		_str = "연속Q("+_kind+")";		break;
		}
		return _str;
	}

	//@@@@ Notice 관련 함수들
	public String getDBCheckURL(String _url){
		String[] _url2 = _url.split("&");
		int _len = _url2.length;
		if(_len >= 2){
			_url = "";
			for(int i = 0; i < _len; i++){
				_url += _url2[i] + "&amp;";
				if(i + 1 == _len - 1){
					_url += _url2[i + 1];
					break;
				}
			}
		}
		return _url;
	}

	public String getChangeCashVS(int _cashcost, int _gamecost){
		String _str = "<font color=red>조작유저</font>";
		if(_cashcost == 10 || _cashcost == 50 || _cashcost == 100 || _cashcost == 300 || _cashcost == 500){
			_str = "" + (_gamecost/_cashcost);
		}
		return _str;
	}

	public static boolean checkDate(String _date) {
		try {
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
			java.util.Date result = formatter.parse(_date);
			String resultStr = formatter.format(result);
			if (resultStr.equalsIgnoreCase(_date))
				return true;
			else
				return false;
		} catch (Exception e) {
			return false;
		}
	}

	public int parseStringToInt(String _strNum){
		int _num = -9999;
		try {
			_num = Integer.parseInt(_strNum);
		} catch (Exception e) {
		}
		return _num;
	}




	public String getPushSendKind(int _kind){
		String _str = "";
		switch(_kind){
			case 1:		_str = "단체 유저 단순 푸쉬("+_kind+")";	break;
			case 3:		_str = "단체 유저 URL 푸쉬("+_kind+")";		break;
			default:	_str = "모름(" + _kind + ")";				break;
		}
		return _str;
	}

	public String getEventState(int _kind){
		String _str = "";
		switch(_kind){
			case 0:		_str = "대기중("+_kind+")";	break;
			case 1:		_str = "진행중("+_kind+")";	break;
			default:	_str = "모름(" + _kind + ")";break;
		}
		return _str;
	}

	public String getEventPush(int _kind){
		String _str = "";
		switch(_kind){
			case 0:		_str = "대기중("+_kind+")";	break;
			case 1:		_str = "발송함("+_kind+")";	break;
			default:	_str = "모름(" + _kind + ")";break;
		}
		return _str;
	}

	public String getEventStateMaster(int _kind){
		String _str = "";
		switch(_kind){
			case 0:		_str = "전체대기중("+_kind+")";	break;
			case 1:		_str = "전체진행중("+_kind+")";	break;
			default:	_str = "모름(" + _kind + ")";break;
		}
		return _str;
	}

	public String getComposeResult(int _kind){
		String _str = "";
		switch(_kind){
			case 0:		_str = "<font color=red>실패("+_kind+")</font>";	break;
			case 1:		_str = "<font color=blue>성공("+_kind+")</font>";	break;
			default:	_str = "모름(" + _kind + ")";break;
		}
		return _str;
	}
	public String getComposeKind(int _kind){
		String _str = "";
		switch(_kind){
			case 1:		_str = "풀합성("+_kind+")";	break;
			case 2:		_str = "확률합성("+_kind+")";	break;
			case 3:		_str = "루비합성("+_kind+")";	break;
			default:	_str = "모름(" + _kind + ")";break;
		}
		return _str;
	}
	public String getPromoteKind(int _kind){
		String _str = "";
		switch(_kind){
			case 1:		_str = "풀승급("+_kind+")";	break;
			//case 2:	_str = "확률승급("+_kind+")";	break;
			//case 3:	_str = "루비승급("+_kind+")";	break;
			default:	_str = "모름(" + _kind + ")";break;
		}
		return _str;
	}
	public String getIPhoneCoupon(int _kind){
		String _str = "모름("+_kind+")";
		switch(_kind){
			case 0:		_str = "비활성화("+_kind+")";	break;
			case 1:		_str = "활성화("+_kind+")";	break;
		}
		return _str;
	}

	public String checkImgParam(int _view, int _subcategory, int _num, String _value, String _url){
		String _rtn = _value;
		if(_view == 1){
			if(_subcategory == 1010 && (_num == 6 || _num == 7 || _num == 8 || _num == 9 || _num == 10 || _num == 11 || _num == 12)){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}else if(_subcategory == 69 && (_num == 11 || _num == 23 || _num == 24 || _num == 25 || _num == 26)){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}else if(_subcategory == 901 && (_num == 2 )){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}else if(_subcategory == 910 && (_num == 3 || _num == 5 || _num == 6 || _num == 7 || _num == 8 || _num == 9 || _num == 10 || _num == 11 || _num == 12 || _num == 13 || _num == 14 )){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}else if(_subcategory == 818 && (_num == 2 || _num == 3 || _num == 4 || _num == 5 || _num == 6)){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}
		}else if(_value.equals("-999")){
			_rtn = "";
		}
		return _rtn;
	}

	public String checkImgParam2(int _view, int _subcategory, int _num, String _value, String _url, int _code){
		String _rtn = _value;
		if(_view == 1){
			if(_subcategory == 901 && _code == 5 && (_num == 2 || _num == 4)){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}
		}else if(_value.equals("-999")){
			_rtn = "";
		}
		return _rtn;
	}


	public String getYabauCheck(int _kind){
		String _str = "";
		switch(_kind){
			case 1:		_str = "리스트 갱신("+_kind+")";	break;
			case 2:		_str = "일반 주사위("+_kind+")";	break;
			case 3:		_str = "루비 주사위("+_kind+")";	break;
			case 4:		_str = "받아가기("+_kind+")";		break;
			default:	_str = "모름(" + _kind + ")";break;
		}
		return _str;
	}

	public String getYabauResult(int _result){
		String _str = "";
		switch(_result){
			case 1:		_str = "성공("+_result+")";	break;
			case 0:		_str = "실패("+_result+")";	break;
			case -1:	_str = "";					break;
			default:	_str = "모름(" + _result + ")";break;
		}
		return _str;
	}


	public String getReturnState(int _flag){
		String _str = "";
		switch(_flag){
			case 1:		_str = "<font color=red>복귀작동중("+_flag+")</font>";	break;
			case 0:		_str = "<font color=blue>복귀미작동("+_flag+")</font>";	break;
			default:	_str = "모름(" + _flag + ")"; 	break;
		}
		return _str;
	}

	public String getRtnStep(int _result){
		String _str = "";
		if(_result > 0){
			_str = "<font color=red>복귀진행("+_result+")</font>";
		}else if(_result == -1){
			_str = "활성유저("+_result+")";
		}else{
			_str = "모름("+_result+")";
		}
		/**/
		return _str;
	}

	public String getCheckRoulMode(int _flag){
		String _str = "";
		switch(_flag){
			case 1:		_str = "일반교배("+_flag+")";									break;
			case 2:		_str = "<font color=blue>루비교배("+_flag+")</font>";			break;
			case 4:		_str = "<font color=blue>루비교배10+1("+_flag+")</font>";		break;

			case 11:	_str = "일반게이지교배("+_flag+")";								break;
			case 12:	_str = "<font color=blue>루비게이지교배("+_flag+")</font>";		break;
			case 14:	_str = "<font color=blue>루비게이지교배10+1("+_flag+")</font>";	break;

			case 21:	_str = "일반티켓교배("+_flag+")";								break;
			case 22:	_str = "<font color=blue>루비티켓교배("+_flag+")</font>";		break;
			case 24:	_str = "<font color=blue>루비티켓교배10+1("+_flag+")</font>";	break;
			default:	_str = "모름(" + _flag + ")"; 	break;
		}
		return _str;
	}


	public String getCheckRoulMode2(int _flag){
		String _str = "";
		switch(_flag){
			case 1:		_str = "일반보물뽑기("+_flag+")";									break;
			case 2:		_str = "<font color=blue>루비보물뽑기("+_flag+")</font>";			break;
			case 4:		_str = "<font color=blue>루비보물뽑기10+1("+_flag+")</font>";		break;

			case 11:	_str = "일반게이지뽑기("+_flag+")";								break;
			case 12:	_str = "<font color=blue>루비보물게이지뽑기("+_flag+")</font>";		break;
			case 14:	_str = "<font color=blue>루비보물게이지뽑기10+1("+_flag+")</font>";	break;

			case 21:	_str = "일반티켓뽑기("+_flag+")";								break;
			case 22:	_str = "<font color=blue>루비보물티켓뽑기("+_flag+")</font>";		break;
			case 24:	_str = "<font color=blue>루비보물티켓뽑기10+1("+_flag+")</font>";	break;
			default:	_str = "모름(" + _flag + ")"; 	break;
		}
		return _str;
	}

	public String getCategoryUnit(int _cat){
		String _str = "개";
		if(_cat == 31){
			_str = "코인";
		}else if(_cat == 80){
			_str = "강화";
		}
		return _str;
	}

	public String getCertMainKind(int _val){
		String _str = "";
		if(_val == 1){
			_str = "1인1매";
		}else if(_val == 2){
			_str = "공용형";
		}
		return _str;
	}

	public int getGiftCount(int _subcategory, int _buyamount, int _sendcnt){
		int _rtn = 0;
		if(_sendcnt > 0)
		{
			_rtn = _sendcnt;
		}
		//else if(_subcategory == 50)
		//{
		//	_rtn = _cashcost;
		//}
		else
		{
			_rtn = _buyamount;
		}
		return _rtn;
	}

	public String getStemCellUpgrade( int _invenKind, int _upcnt, int _upstepmax ){
		String _rtn = "";
		if(_invenKind != 1) return _rtn;

		_rtn = _upcnt + " / " + _upstepmax;
		return _rtn;
	}


	public String getStemCellInfo( int _invenKind, int _freshstem100, int _attstem100, int _timestem100, int _defstem100, int _hpstem100 ){
		String _rtn = "";
		if(_invenKind != 1) return _rtn;

		_rtn  = _freshstem100 + " / " + _attstem100 + " / " + _timestem100 + " / " + _defstem100 + " / " + _hpstem100;
		return _rtn;
	}

	public String getBattleResult( int _result )
	{
		String _rtn = "";
		if( _result == 1 ) _rtn = "<font color=blue>승</font>";
		else if( _result == -1 ) _rtn = "<font color=red>패</font>";
		else _rtn = "<font color=green>진행중</font>";
		return _rtn;
	}


	public String getGoldTicketUsed( int _flag ){
		String _str = "";
		switch(_flag){
			case 1:		_str = "사용("+_flag+")";		break;
			default:	_str = "미사용(" + _flag + ")"; break;
		}
		return _str;

	}

	public String getUserBattleFlag(int _val){
		String _str = "NONE("+ _val +")";
		switch(_val){
			case  1: _str = "진행중("+ _val +")";	break;
			case  0: _str = "완료("+ _val +")";		break;
		}
		return _str;
	}


	public String getTradeCloseDealer(int _val){
		String _str = "NONE("+ _val +")";
		switch(_val){
			case  1: _str = "<font color=blue>상인열림("+ _val +")</font>";	break;
			case -1: _str = "<font color=red>상인닫힘("+ _val +")</font>";	break;
		}
		return _str;
	}

	public String getCheckRKTeam(int _rkteam1, int _rkteam0){
		String _str = "" ;
		if(_rkteam1 > _rkteam0){
			_str = "<font color=blue>청(" + _rkteam1 + ")</font>  > 백(" + _rkteam0 + ")";
		}else if(_rkteam1 < _rkteam0){
			_str = "청(" + _rkteam1 + ")  < <font color=red>백(" + _rkteam0 + ")</font> ";
		}else{
			_str += "무승부";
		}
		return _str;
	}

	public String getCheckRKTeam2(long _val1, long _val0){
		String _str = "" ;
		if(_val1 > _val0){
			_str = "<font color=blue>청(" + displayMoney(_val1) + ")</font>  > 백(" + displayMoney(_val0) + ")";
		}else if(_val1 < _val0){
			_str = "청(" + displayMoney(_val1) + ")  < <font color=red>백(" + displayMoney(_val0) + ")</font> ";
		}else{
			_str = "청(" + displayMoney(_val1) + ")  (무승부) 백(" + displayMoney(_val0) + ") ";
		}
		return _str;
	}


	public String getRTReward(int _flag){
		String _str = "";
		switch(_flag){
			case 0:		_str = "미지급("+_flag+")";							break;
			case 1:		_str = "<font color=red>지급("+_flag+")</font>";	break;
		}
		return _str;
	}



  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(3);
    _jspx_dependants.add("/admin/_define.jsp");
    _jspx_dependants.add("/admin/_constant.jsp");
    _jspx_dependants.add("/admin/_checkfun.jsp");
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
      response.setContentType("text/html; charset=euc-kr");
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
request.setCharacterEncoding("EUC-KR");
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
	int 				SKT 					= 1,
						GOOGLE 					= 5,
						NHN 					= 6,
						IPHONE					= 7;

	int 				BUYTYPE_FREE			= 0,	//무료가입 : 리워드 최소.
					 	BUYTYPE_PAY 			= 1;	//유료가입 : 리워드 많음.

	int					KIND_USER_MESSAGE				= 1,
						KIND_USER_BLOCK_LOG				= 2,
						KIND_USER_BLOCK_RELEASE			= 8,
						KIND_USER_DELETE_LOG			= 10,
						KIND_USER_DELETE_RELEASE		= 11,
						KIND_BATTLE_SEARCHLOG			= 15,
						KIND_USER_UNUSUAL_LOG			= 4,
						KIND_SEARCH_ITEMINFO			= 5,
						KIND_ITEM_BUY_LOG				= 6,
						KIND_USER_SEARCH				= 7,
						KIND_USER_ITEM_UPGRADE 			= 9,
						KIND_USER_CASH_CHANGE			= 12,
						KIND_USER_CASH_BUY				= 13,
						KIND_USER_CASH_PLUS				= 16,
						KIND_USER_CASH_MINUS			= 23,
						KIND_USER_CASH_LOG_DELETE		= 17,
						KIND_USER_DELETEID				= 18,
						KIND_USER_SETTING				= 19,
						KIND_NOTICE_SETTING				= 20,
						KIND_STATISTICS_INFO			= 21,
						KIND_OPEN_TEST					= 22,
						KIND_ADMIN_LOGIN				= 25,
						KIND_NEWINFO_LIST				= 26;

      out.write('\r');
      out.write('\n');

	String pwdateid = "1234";
	int YEAR = 2013;
	int MONTH = 12;
	int DATE = 30;
	int HOUR = 23;
	int MIN = 59;

	boolean bExpire 					= false;
	boolean bExpire2 					= true;
	java.text.SimpleDateFormat format 	= new java.text.SimpleDateFormat("yyyyMMdd");
	java.text.SimpleDateFormat format6 	= new java.text.SimpleDateFormat("yyyyMM");
	java.text.SimpleDateFormat format19 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.text.SimpleDateFormat format16 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	java.text.SimpleDateFormat formatdd = new java.text.SimpleDateFormat("dd");
	java.util.Date now 					= new java.util.Date();
	java.util.Date end 					= new java.util.Date(YEAR - 1900, MONTH - 1, DATE, HOUR, MIN);
	if(now.getTime() >= end.getTime()){
		bExpire = true;
	}else{
		bExpire = false;
	}

	String adminip 				= request.getRemoteAddr();
	String adminid 				= (String)session.getAttribute("adminId");
	Integer adminGrade 			= (Integer)session.getAttribute("adminGrade");
	if(adminGrade == null || adminGrade < 1000){
		out.println("관리자만이 접근 할 수 있습니다.");
		response.sendRedirect("_login.jsp");
		return;
	}else if(adminGrade >= 1000){
		bExpire = false;
	}

	boolean bAdmin 				= false;
	if(adminip.indexOf("192.168.0") >= 0){
		bAdmin = true;
	}
	bAdmin = true;

	String strIP = request.getLocalAddr();
	String strPort;
	String strServerName = "";
	boolean bRealServer = false;
	if(strIP.equals("192.168.0.11")){
		strIP = "121.138.201.251";
		strPort = "40012";
		strServerName = "<font size=10 color=gray>[K5(짜요 타이쿤)(Test)]</font>";
		bRealServer = false;
	}else{
		strIP = "175.117.144.244";
		strPort = "8882";
		strServerName = "<font size=10 color=red>[K5(짜요 타이쿤)(Real)]</font>";
		bRealServer = true;
	}
	String imgroot	= "http://" + strIP + ":" + strPort + "/Game4FarmVill5/admin/item";
	//페이지 기능에 사용되는 변수


      out.write("<br><br>\r\n");
      out.write("<center>\r\n");
      out.print(strServerName);
      out.write("<font size=10 color=blue><a href=_admin.jsp>[메인]</a></font>\r\n");
      out.write("</center>");
      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");

	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int idxColumn				= 1;
	int idxPage					= FormUtil.getParamInt(request, "idxPage", 1);
	int maxPage					= 1;

	String gameid 				= util.getParamStr(request, "gameid", "");
	String phone 				= util.getParamStr(request, "phone", "");
	String kakaouserid			= util.getParamStr(request, "kakaouserid", "");
	String kakaotalkid			= util.getParamStr(request, "kakaotalkid", "");
	String kakaogameid			= util.getParamStr(request, "kakaogameid", "");
	int kakaomsginvitecnt		= 0;
	int questing = 0, questwait = 0, questend = 0, total = 0;
	boolean bList;
	if(gameid.equals("") && phone.equals("") && kakaouserid.equals("") && kakaotalkid.equals("") && kakaogameid.equals("")){
		bList = true;
	}else{
		bList = false;
	}

	int anireplistidx			= -1;
	int comreward				= -1;
	int num						= 0;
	int earncoin				= 0;
	int schoolidx				= -1;
	int famelv					= 0;
	int kind					= 0;
	int battleanilistidx[]		= {-1, -1, -1};
	int userbattleanilistidx[]	= {-1, -1, -1};

	try{

      out.write("\r\n");
      out.write("<html><head>\r\n");
      out.write("<title></title>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=euc-kr\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"image/intra.css\" type=\"text/css\">\r\n");
      out.write("<script type=\"text/javascript\" async=\"\" src=\"http://www.google-analytics.com/ga.js\"></script><script type=\"text/javascript\" async=\"\" src=\"http://www.google-analytics.com/ga.js\"></script><script language=\"javascript\" src=\"image/script.js\"></script>\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("<!--\r\n");
      out.write("function f_Submit(f) {\r\n");
      out.write("\tif(f_nul_chk(f.gameid, '아이디를')) return false;\r\n");
      out.write("\telse return true;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("//-->\r\n");
      out.write("</script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js\"></script><script type=\"text/javascript\" src=\"chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js\"></script></head>\r\n");
      out.write("\r\n");
      out.write("<!--<body bgcolor=\"#ffffff\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\" onload=\"javascript:document.GIFTFORM.gameid.focus();\">-->\r\n");
      out.write("</head>\r\n");
      out.write("<body bgcolor=\"#ffffff\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\">\r\n");
      out.write("<table align=center>\r\n");
      out.write("\t<tbody>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t<div  style=\"border:1px solid #D7D6D6;background:#FCFCFC;padding:36px 0;\">\r\n");
      out.write("\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t유저 아이디를 정확히 입력하세요.<br>\r\n");
      out.write("\t\t\t\t\t\t\t(상제 유저정보를 컨트롤 가능합니다. 유저수는 farm_유저수(나머지)_더미(3자리))<br>\r\n");
      out.write("\t\t\t\t\t\t\t<font color=red>과금 기록 없이 2000루비/100만코인 이상 이면 블럭계정, 블럭핸드폰, 블럭카톡(자동이니까 유의하세요.)</font>\r\n");
      out.write("\t\t\t\t\t\t\t<a href=userinfo_list.jsp><img src=images/refresh2.png alt=\"화면갱신\"></a>\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"userinfo_list.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>게임아이디(farmxx)</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input name=\"gameid\" type=\"text\" value=\"");
      out.print(gameid);
      out.write("\" maxlength=\"16\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:300px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t\t<form name=\"GIFTFORM\" method=\"post\" action=\"userinfo_list.jsp\" onsubmit=\"return f_Submit(this);\">\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>폰번호검색(>아이디검색)</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input name=\"phone\" type=\"text\" value=\"");
      out.print(phone);
      out.write("\" maxlength=\"16\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:300px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t카톡회원번호(>17자리)<br>\r\n");
      out.write("\t\t\t\t\t\t\t카톡-> 설정 -> 정보검색용(kakaouserid)\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input name=\"kakaouserid\" type=\"text\" value=\"");
      out.print(kakaouserid);
      out.write("\" maxlength=\"60\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:300px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\tuuid(>30여자리)<br>\r\n");
      out.write("\t\t\t\t\t\t\t카톡-> 친구연결정보\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input name=\"kakaotalkid\" type=\"text\" value=\"");
      out.print(kakaotalkid);
      out.write("\" maxlength=\"60\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:300px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\tkakaogameid(>약13여자리)<br>\r\n");
      out.write("\t\t\t\t\t\t\t게임 -> 설정 -> 1xxx숫자로된것\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input name=\"kakaogameid\" type=\"text\" value=\"");
      out.print(kakaogameid);
      out.write("\" maxlength=\"60\" tabindex=\"1\" style=\"border:1px solid #EBEBEB;background:#FFFFFF;width:300px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t<td style=\"padding-left:5px;\"><input name=\"image\" type=\"image\" src=\"images/btn_send.gif\" border=\"0\" tabindex=\"3\"></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t");

					//2. 데이타 조작
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'SangSang', '', '', '', '', '', '', '', '', ''
					//exec spu_FarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '01022223333', '', '', '', '', '', '', '', ''
					query.append("{ call dbo.spu_FarmD (?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?)} ");
					cstmt = conn.prepareCall(query.toString());
					cstmt.setInt(idxColumn++, 7);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, -1);
					cstmt.setInt(idxColumn++, idxPage);
					cstmt.setString(idxColumn++, gameid);
					cstmt.setString(idxColumn++, phone);
					cstmt.setString(idxColumn++, kakaouserid);
					cstmt.setString(idxColumn++, kakaotalkid);
					cstmt.setString(idxColumn++, kakaogameid);
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");
					cstmt.setString(idxColumn++, "");

					//2-2. 스토어즈 프로시져 실행하기
					result = cstmt.executeQuery();
					
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>gameid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t");

					while(result.next()){
						if(gameid.equals(result.getString("gameid"))){
							anireplistidx = result.getInt("anireplistidx");
							for(int jj = 1; jj <= 3; jj++){
								battleanilistidx[ jj - 1 ] 		= result.getInt("battleanilistidx" + jj);
								userbattleanilistidx[ jj - 1 ] 	= result.getInt("userbattleanilistidx" + jj);
							}
						}
					
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td width=200>\r\n");
      out.write("\t\t\t\t\t\t\t\tID : <a href=userinfo_list.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("gameid"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\tPW : ");
      out.print(result.getString("password"));
      out.write("\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t생성일: ");
      out.print(getDate(result.getString("regdate")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t접속일:(");
      out.print(result.getString("concnt"));
      out.write("회)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=6&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<!-- 잘사용안함 , 아래의 출석일을 주로 사용한다.-->\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getDate(result.getString("condate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t폰:<a href=userinfo_list.jsp?phone=");
      out.print(result.getString("phone"));
      out.write('>');
      out.print(result.getString("phone"));
      out.write("</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--SMS발송 : ");
      out.print(result.getString("smssendcnt"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("smsjoincnt"));
      out.write("\t<br>-->\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=4&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getCheckValue(result.getInt("kkopushallow"), 1, "푸쉬발송가능", "<font color=red>푸쉬발송거절</font>"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getBlockState(result.getInt("blockstate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=10&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDeleteState(result.getInt("deletestate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t캐쉬카피: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=13&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("cashcopy"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t결과카피: <a href=usersetting_ok.jsp?p1=19&p2=88&p3=14&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("resultcopy"));
      out.write("</a><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=2&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">일괄블럭</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=18&p2=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">개발진짜삭제</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=18&p2=2&ps1=");
      out.print(result.getString("gameid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">개발맥스초기화</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=wgiftsend_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write(" target=_blank>선물/쪽지</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=push_list.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&personal=1 target=_blank>푸쉬발송</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t대전참여상태 \t: ");
      out.print(getRKStartState(result.getInt("rkstartstate")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t팀\t\t \t\t: ");
      out.print(getRKTeam(result.getInt("rkteam")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t판매수익 \t\t: ");
      out.print(result.getString("rksalemoney"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t생산배럴 \t\t: ");
      out.print(result.getString("rksalebarrel"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t배틀포인트\t\t: ");
      out.print(result.getString("rkbattlecnt"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t동물교배,보물뽑기 : ");
      out.print(result.getString("rkbogicnt"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t친구포인트 \t\t: ");
      out.print(result.getString("rkfriendpoint"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t룰렛포인트 \t\t: ");
      out.print(result.getString("rkroulettecnt"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t늑대포인트\t\t: ");
      out.print(result.getString("rkwolfcnt"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t(\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=86&p3=60&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t개발:미참여로 돌리기\r\n");
      out.write("\t\t\t\t\t\t\t  \t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t)\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(getTel(result.getInt("market")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(getBytType(result.getInt("buytype")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(getPlatform(result.getInt("platform")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(result.getString("ukey"));
      out.write(",\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(result.getString("version"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t세션ID:");
      out.print(result.getString("sid"));
      out.write("<br><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t게시판: ");
      out.print(getMBoardState(result.getInt("mboardstate")));
      out.write("<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t출석일:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getDate(result.getString("attenddate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t출석횟수:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=2&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("attendcnt"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t복귀단계:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=89&p3=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getRtnStep(result.getInt("rtnstep")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t복귀진행월:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=89&p3=2&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("rtnplaycnt"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t복귀요청사람:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("rtngameid"));
      out.write('(');
      out.print(getDate19(result.getString("rtndate")));
      out.write(")<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t\t대회참여횟수 : ");
      out.print(result.getString("contestcnt"));
      out.write("\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t별칭 : ");
      out.print(result.getString("nickname"));
      out.write("\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t-->\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t파라미터(0 ~ 9):<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
for(int i = 0; i < 10; i++){
										out.print( result.getString("param" + i) + "/");
									}
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t광고번호 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=31&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("adidx"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t학교가입현황:\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");

									schoolidx = result.getInt("schoolidx");
									out.print(schoolidx);
									
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=94&p3=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t학교강제탈퇴\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=schooluser_list.jsp?schoolidx=");
      out.print(result.getInt("schoolidx"));
      out.write(">학교보기</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=94&p3=8&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t학교지난 다시보기(");
      out.print(result.getInt("schoolresult"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 userId \t: <a href=userinfo_list.jsp?kakaouserid=");
      out.print(result.getString("kakaouserid"));
      out.write('>');
      out.print(result.getString("kakaouserid"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 talkId \t: <a href=userinfo_list.jsp?kakaotalkid=");
      out.print(result.getString("kakaotalkid"));
      out.write('>');
      out.print(result.getString("kakaotalkid"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 gameid \t: <a href=userinfo_list.jsp?kakaogameid=");
      out.print(result.getString("kakaogameid"));
      out.write('>');
      out.print(result.getString("kakaogameid"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 nickName \t: ");
      out.print(result.getString("kakaonickname"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=56&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t( ");
      out.print(result.getString("nicknamechange"));
      out.write("회)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 profile \t: <img src=");
      out.print(result.getString("kakaoprofile"));
      out.write("><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 메세지블럭 : <a href=usersetting_ok.jsp?p1=19&p2=88&p3=10&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=>");
      out.print(getKakaoMessageBlocked(result.getInt("kakaomsgblocked")));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 현재상태 \t:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=88&p3=12&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getKakaoStatus(result.getInt("kakaostatus")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 초대인원수: <a href=userminus_form3.jsp?p1=19&p2=88&p3=1&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=kakaomsgInviteCount>");
      out.print((kakaomsginvitecnt = result.getInt("kakaomsginvitecnt")));
      out.write("</a>명을 초대<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 1일초대인원: <a href=userminus_form3.jsp?p1=19&p2=88&p3=8&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=kakaomsgInviteTodayCnt>");
      out.print(result.getInt("kakaomsginvitetodaycnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 1일초대날짜 : <a href=usersetting_ok.jsp?p1=19&p2=88&p3=9&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=kakaomsgInviteTodayCnt>");
      out.print(getDate19(result.getString("kakaomsginvitetodaydate")));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t카톡 부활팝업 : <a href=usersetting_ok.jsp?p1=19&p2=88&p3=15&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(result.getInt("kkhelpalivecnt"));
      out.write("</a><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t루비(캐쉬) : <a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=0>");
      out.print(result.getString("cashcost"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t코인 : <a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=1>");
      out.print(result.getString("gamecost"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t건초 : <a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=2>");
      out.print(result.getString("feed"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(<a href=userminus_form3.jsp?p1=19&p2=86&p3=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("feedmax"));
      out.write("</a>)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t하트 : <a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=3>");
      out.print(result.getString("heart"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(<a href=userminus_form3.jsp?p1=19&p2=86&p3=2&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("heartmax"));
      out.write("</a>)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t하트 1일전송 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=87&p3=57&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=heartsendcnt>");
      out.print(result.getString("heartsendcnt"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t   (");
      out.print(getDate10(result.getString("heartsenddate")));
      out.write(")<br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t우정포인트 : <a href=userminus_form3.jsp?p1=19&p2=86&p3=13&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("fpoint"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t(");
      out.print(result.getString("fpointmax"));
      out.write(")<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t황금티켓 : <a href=userminus_form3.jsp?p1=19&p2=86&p3=21&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("goldticket"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t/<a href=userminus_form3.jsp?p1=19&p2=86&p3=22&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("goldticketmax"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t(<a href=usersetting_ok.jsp?p1=19&p2=86&p3=23&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getDateShort2(result.getString("goldtickettime")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t싸움티켓 : <a href=userminus_form3.jsp?p1=19&p2=86&p3=31&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("battleticket"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t/<a href=userminus_form3.jsp?p1=19&p2=86&p3=32&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("battleticketmax"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t(<a href=usersetting_ok.jsp?p1=19&p2=86&p3=33&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getDateShort2(result.getString("battletickettime")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t싸움목장: ");
      out.print(result.getString("battlefarmidx"));
      out.write('(');
      out.print(result.getString("battleanilistidx1"));
      out.write('/');
      out.print(result.getString("battleanilistidx2"));
      out.write('/');
      out.print(result.getString("battleanilistidx3"));
      out.write('/');
      out.print(result.getString("battleanilistidx4"));
      out.write('/');
      out.print(result.getString("battleanilistidx5"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\tstar : ");
      out.print(result.getString("star"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t분해 : ");
      out.print(result.getString("apartbuycnt"));
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t동물인벤Max : ");
      out.print(result.getString("invenanimalmax"));
      out.write("(<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=45>");
      out.print(result.getString("invenanimalstep"));
      out.write("</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t소비인벤Max : ");
      out.print(result.getString("invencustommax"));
      out.write("(<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=46>");
      out.print(result.getString("invencustomstep"));
      out.write("</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t줄기인벤Max : ");
      out.print(result.getString("invenstemcellmax"));
      out.write("(<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=47>");
      out.print(result.getString("invenstemcellstep"));
      out.write("</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t보물인벤Max : ");
      out.print(result.getString("inventreasuremax"));
      out.write("(<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=49>");
      out.print(result.getString("inventreasurestep"));
      out.write("</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--임시아이템 : ");
      out.print(result.getString("tempitemcode"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("tempcnt"));
      out.write("\t<br>-->\r\n");
      out.write("\t\t\t\t\t\t\t\t필드0 : ");
      out.print(getCheckValue(result.getInt("field0"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드1 : ");
      out.print(getCheckValue(result.getInt("field1"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드2 : ");
      out.print(getCheckValue(result.getInt("field2"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드3 : ");
      out.print(getCheckValue(result.getInt("field3"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드4 : ");
      out.print(getCheckValue(result.getInt("field4"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드5 : ");
      out.print(getCheckValue(result.getInt("field5"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드6 : ");
      out.print(getCheckValue(result.getInt("field6"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드7 : ");
      out.print(getCheckValue(result.getInt("field7"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드8 : ");
      out.print(getCheckValue(result.getInt("field8"), 1, "오픈", "닫힘"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t낙농포인트 : <a href=userminus_form3.jsp?p1=19&p2=87&p3=60&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=cashpoint>");
      out.print(result.getString("cashpoint"));
      out.write("</a>원 <br>\r\n");
      out.write("\t\t\t\t\t\t\t\t(실구매금액 VIP)<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t무료룰렛: <a href=usersetting_ok.jsp?p1=19&p2=86&p3=50&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getWheelToday(result.getInt("wheeltodaycnt")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t  </a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=51&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getDate10(result.getString("wheeltodaydate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t  </a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t황금룰렛: <a href=usersetting_ok.jsp?p1=19&p2=86&p3=52&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t게이지 : ");
      out.print(result.getInt("wheelgauage"));
      out.write(" / 100\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t  </a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=53&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getWheelFree(result.getInt("wheelfree")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t  </a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t  전체 ");
      out.print(result.getInt("bkwheelcnt"));
      out.write("회<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t짜요쿠폰조각룰렛:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=86&p3=61&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getZCPChance(result.getInt("zcpchance")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t룰렛등장 : ");
      out.print( getZCPSaleFresh(70, result.getInt("salefresh")) );
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t상승효과(");
      out.print(result.getInt("zcpplus"));
      out.write("%)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t일일등장횟수 : (\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=86&p3=62&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getInt("zcpappearcnt"));
      out.write("회등장\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t무료횟수(");
      out.print(result.getInt("bkzcpcntfree"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t유료횟수(");
      out.print(result.getInt("bkzcpcntcash"));
      out.write(") <br><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t입력폰 : ");
      out.print(result.getString("phone2"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t입력주소 : ");
      out.print(result.getString("address1"));
      out.write(' ');
      out.print(result.getString("address1"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t           ");
      out.print(result.getString("zipcode"));
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t대표동물: ");
      out.print(result.getString("anireplistidx"));
      out.write('(');
      out.print(result.getString("anirepitemcode"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("anirepacc1"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("anirepacc2"));
      out.write(")<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t대표멘트: ");
      out.print(result.getString("anirepmsg"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t게임년월:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Game Year(2013 ~ 2999)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gameyear"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>년\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=2&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Game Month(1 ~ 12)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gamemonth"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>월\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=3&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Game Day(0 ~ 70)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("frametime"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>frame\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t피버 : ");
      out.print(result.getString("fevergauge"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t양동이 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?mode=81&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("bottlelittle"));
      out.write("</a> 총리터 (+");
      out.print(result.getInt("tsskillbottlelittle"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?mode=82&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("bottlefresh"));
      out.write("</a> 총신선도\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t탱크 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?mode=83&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("tanklittle"));
      out.write("</a> 총리터\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?mode=84&gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("tankfresh"));
      out.write("</a> 총신선도\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t연속거래성공:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=6&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Trade Success(0 ~ )\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("tradecnt"));
      out.write('(');
      out.print(result.getString("tradecntold"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t연속상장횟수:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=7&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Prize Count(0 ~ )\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("prizecnt"));
      out.write('(');
      out.print(result.getString("prizecntold"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t연속거래실패성공:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=9&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Trade Fail(0 ~ )\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("tradefailcnt"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--(연속성공과 실패는 상호배타)-->\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<정책지원금:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t <a href=usersetting_ok.jsp?p1=19&p2=64&p3=55&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(" alt=\"(다시보기)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getInt("settlestep"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t연도와 로고가 초기화됨\r\n");
      out.write("\t\t\t\t\t\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<상인정보><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t거래성공횟수:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=10&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Trade Fail(0 ~ )\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("tradesuccesscnt"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t거래상인번호:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getInt("tradeclosedealer"));
      out.write('(');
      out.print(getTradeState(result.getInt("tradestate")));
      out.write(")<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t명성도(누적) :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=4&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Fame(0 ~ )\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("fame"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t레벨 : ");
      out.print(result.getString("famelv"));
      out.write("(최고:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=8&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Fame(0 ~ 50)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("famelvbest"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=65&p3=5&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change Fame LV(1 ~ 50)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("famelv"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t\t\t알바템 사용: ");
      out.print(result.getInt("albause"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getInt("albausesecond"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getInt("albausethird"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t촉진템 사용: ");
      out.print(result.getInt("boosteruse"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t늑대 출현: ");
      out.print(result.getInt("wolfappear"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t교배/하트선물(받기대기중):");
      out.print(result.getString("heartget"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t(로그인하면 알려주는 용도임)<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t펫 정보\t\t: ");
      out.print(result.getInt("petitemcode"));
      out.write('(');
      out.print(result.getInt("petlistidx"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=54&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t개발재연결\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t펫 쿨타임\t: ");
      out.print(result.getInt("petcooltime"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t펫(할인)\t: ");
      out.print(result.getInt("pettodayitemcode"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t펫(체험)\t: <a href=usersetting_ok.jsp?p1=19&p2=64&p3=5&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getInt("pettodayitemcode2"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t  </a><br>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t총알 : ");
      out.print(result.getString("bulletlistidx"));
      out.write("(번)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t백신 : ");
      out.print(result.getString("vaccinelistidx"));
      out.write("(번)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t알바 : ");
      out.print(result.getString("albalistidx"));
      out.write("(번)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t촉진제 : ");
      out.print(result.getString("boosterlistidx"));
      out.write("(번)<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t[분기별내역]<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t판매배럴(분기) \t\t: ");
      out.print(result.getString("qtsalebarrel"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t판매수익(분기) \t\t: ");
      out.print(result.getString("qtsalecoin"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t획득명성(분기) \t\t: ");
      out.print(result.getString("qtfame"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t사용건초(분기) \t\t: ");
      out.print(result.getString("qtfeeduse"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t연속거래횟수(분기): ");
      out.print(result.getString("qttradecnt"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t최고거래가(분기): ");
      out.print(result.getString("qtsalecoinbest"));
      out.write("<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t행운의 주사위<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t번호 \t\t:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=52&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("yabauidx"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t교체비용 \t: ");

												famelv = result.getInt("famelv") / 10 + 1;
												famelv = famelv * famelv * 100;
												out.println(famelv);
											
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t현재단계 \t: ");
      out.print(result.getInt("yabaustep"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t방금돌린주사위: ");
      out.print(result.getInt("yabaunum"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t시도횟수\t:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t         <a href=userminus_form3.jsp?p1=19&p2=64&p3=53&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Yabauistrycount>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getInt("yabaucount"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<br><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t동물일일구매 : <a href=usersetting_ok.jsp?p1=19&p2=64&p3=57&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("anibuycnt"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t   </a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t   <a href=usersetting_ok.jsp?p1=19&p2=64&p3=58&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t  \t(");
      out.print(getDate10(result.getString("anibuydate")));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t   </a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t유저배틀박스/완료시간 <br>\r\n");
      out.write("\t\t\t\t\t\t\t\t1번 : ");
      out.print(result.getInt("boxslot1"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=1&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t개발삭제\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  </a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  <br>\r\n");
      out.write("\t\t\t\t\t\t\t\t2번 : ");
      out.print(result.getInt("boxslot2"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=2&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t개발삭제\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  </a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t3번 : ");
      out.print(result.getInt("boxslot3"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=3&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t개발삭제\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  </a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t4번 : ");
      out.print(result.getInt("boxslot4"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  <a href=usersetting_ok.jsp?p1=19&p2=86&p3=42&p4=4&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t개발삭제\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  </a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t진행중:");
      out.print(result.getInt("boxslotidx"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  (<a href=usersetting_ok.jsp?p1=19&p2=86&p3=41&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t");
      out.print(getDateShort2(result.getString("boxslottime")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  </a>)<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t트로피(티어):\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=64&p3=59&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=trophy>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t");
      out.print(result.getInt("trophy"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>(");
      out.print(result.getInt("tier"));
      out.write(")<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t유저배틀상태:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getUserBattleFlag(result.getInt("userbattleflag")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t박스로테이션번호:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=64&p3=60&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=boxrotidx>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t");
      out.print(result.getInt("boxrotidx"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t집 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=51>");
      out.print(result.getString("housestep"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=50&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getUpgradeState(result.getInt("housestate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("housetime")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t탱크 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=53>");
      out.print(result.getString("tankstep"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=52&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getUpgradeState(result.getInt("tankstate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("tanktime")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t양동이 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=55>");
      out.print(result.getString("bottlestep"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=54&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getUpgradeState(result.getInt("bottlestate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("bottletime")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t착유기 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=57>");
      out.print(result.getString("pumpstep"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=56&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getUpgradeState(result.getInt("pumpstate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("pumptime")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t주입기 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=59>");
      out.print(result.getString("transferstep"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=58&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getUpgradeState(result.getInt("transferstate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("transfertime")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t축사 환경 개선 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=61>");
      out.print(result.getString("purestep"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=60&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getUpgradeState(result.getInt("purestate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("puretime")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t품질향상 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userminus_form.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write("&mode=63>");
      out.print(result.getString("freshcoolstep"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=62&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getUpgradeState(result.getInt("freshcoolstate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("freshcooltime")));
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t합성대기 :\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=44&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getDate(result.getString("bgcomposewt")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t[영구누정정보(신규목장구매조건)]<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t일반교배\t\t:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=87&p3=41&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=anigrade1cnt>");
      out.print(result.getString("anigrade1cnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t프리미엄교배(횟수/게이지)\t:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=87&p3=42&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=anigrade2cnt>");
      out.print(result.getString("anigrade2cnt"));
      out.write("</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=87&p3=45&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=anigrade2gauage>");
      out.print(result.getString("anigrade2gauage"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t프리미엄10교배(횟수/게이지)\t:\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=87&p3=46&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=anigrade4cnt>");
      out.print(result.getString("anigrade4cnt"));
      out.write("</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=87&p3=47&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=anigrade4gauage>");
      out.print(result.getString("anigrade4gauage"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t일반보물 뽑기:\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=100&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(result.getString("tsgrade1cnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t프리미엄 보물뽑기(횟수/게이지):\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=101&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(result.getString("tsgrade2cnt"));
      out.write("</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=102&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(result.getString("tsgrade2gauage"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t프리미엄10 보물뽑기(횟수/게이지):\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=103&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(result.getString("tsgrade4cnt"));
      out.write("</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=104&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(result.getString("tsgrade4gauage"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t누적보물강화횟수\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=53&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkaniupcnt>");
      out.print(result.getString("tsupcnt"));
      out.write("</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t누적배틀참여\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=54&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkaniupcnt>");
      out.print(result.getString("bgbattlecnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t누적동물강화\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=55&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkaniupcnt>");
      out.print(result.getString("bganiupcnt"));
      out.write("</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t보물슬롯\t: \t");
      out.print(result.getString("tslistidx1"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("tslistidx2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("tslistidx3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("tslistidx4"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("tslistidx5"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t합성횟수\t:<a href=userminus_form3.jsp?p1=19&p2=87&p3=43&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bgcomposecnt>");
      out.print(result.getString("bgcomposecnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t누적거래\t:<a href=userminus_form3.jsp?p1=19&p2=87&p3=44&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bgtradecnt>");
      out.print(result.getString("bgtradecnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t최고연속거래:<a href=userminus_form3.jsp?p1=19&p2=87&p3=56&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bgcttradecnt>");
      out.print(result.getString("bgcttradecnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t[보물 보유효과]<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t루배생산 : ");
      out.print(result.getString("tsskillcashcost"));
      out.write("&nbsp;&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t\t\t\t\t\t하트생산 : ");
      out.print(result.getString("tsskillheart"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t코인생산 : ");
      out.print(result.getString("tsskillgamecost"));
      out.write("&nbsp;&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t\t\t\t\t\t우포생산 : ");
      out.print(result.getString("tsskillfpoint"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t부활생산 : ");
      out.print(result.getString("tsskillrebirth"));
      out.write("&nbsp;&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t\t\t\t\t\t알바생산 : ");
      out.print(result.getString("tsskillalba"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t특수탄생산 : ");
      out.print(result.getString("tsskillbullet"));
      out.write("&nbsp;&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t\t\t\t\t\t슈퍼백신생산 : ");
      out.print(result.getString("tsskillvaccine"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t건초생산 : ");
      out.print(result.getString("tsskillfeed"));
      out.write("&nbsp;&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t\t\t\t\t\t특수촉진제생산 : ");
      out.print(result.getString("tsskillbooster"));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t경쟁모드(\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=userminus_form3.jsp?p1=19&p2=64&p3=45&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t");

									comreward = result.getInt("comreward");
									out.print(comreward);
								
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</a>)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시늑대잡이(1)\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=1&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktwolfkillcnt>");
      out.print(result.getString("bktwolfkillcnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시판매금액(11)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=11&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktsalecoin>");
      out.print(result.getString("bktsalecoin"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시하트획득(12)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=12&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkheart>");
      out.print(result.getString("bkheart"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시건초획득(13)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=13&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkfeed>");
      out.print(result.getString("bkfeed"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시연속성공횟수(14): <a href=userminus_form3.jsp?p1=19&p2=87&p3=14&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktsuccesscnt>");
      out.print(result.getString("bktsuccesscnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t최고신선도(15) \t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=15&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktbestfresh>");
      out.print(result.getString("bktbestfresh"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t최고배럴(16) \t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=16&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktbestbarrel>");
      out.print(result.getString("bktbestbarrel"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t최고판매금액(17)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=17&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktbestcoin>");
      out.print(result.getString("bktbestcoin"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t누적배럴(18) \t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=18&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktbestbarrel>");
      out.print(result.getString("bkbarrel"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시일반교배(21)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=21&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkcrossnormal>");
      out.print(result.getString("bkcrossnormal"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시프리미엄교배(22): <a href=userminus_form3.jsp?p1=19&p2=87&p3=22&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkcrosspremium>");
      out.print(result.getString("bkcrosspremium"));
      out.write("</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t임시일반보물뽑기(23)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=48&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktsgrade1cnt>");
      out.print(result.getString("bktsgrade1cnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시프림보물뽑기(24)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=49&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bktsgrade2cnt>");
      out.print(result.getString("bktsgrade2cnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시보물강화횟수(25)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=50&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=tsupcnt>");
      out.print(result.getString("bktsupcnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시배틀참여횟수(26)\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=51&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkbattlecnt>");
      out.print(result.getString("bkbattlecnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시동물강화(27)\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=52&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkaniupcnt>");
      out.print(result.getString("bkaniupcnt"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시동물분해(28)\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=58&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkapartani>");
      out.print(result.getString("bkapartani"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시보물분해(29)\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=59&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkapartts>");
      out.print(result.getString("bkapartts"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t임시동물합성(20)\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=61&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=bkcomposecnt>");
      out.print(result.getString("bkcomposecnt"));
      out.write("</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t친구랭킹포인트\t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=31&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=ttsalecoin>");
      out.print(result.getString("ttsalecoin"));
      out.write("</a><br>\r\n");
      out.write("\t\t\t\t\t\t\t\t에피소드포인트 \t\t: <a href=userminus_form3.jsp?p1=19&p2=87&p3=32&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=etsalecoin>");
      out.print(result.getString("etsalecoin"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t(");
      out.print(result.getString("etremain"));
      out.write(")<br><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t지난 친구간성적<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(result.getInt("lmcnt"));
      out.write('명');
      out.write('중');
      out.write(' ');
      out.print(result.getInt("lmrank"));
      out.write('위');
      out.write('(');
      out.print(result.getInt("lmsalecoin"));
      out.write("점)<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t1위 ");
      out.print(result.getString("l1kakaonickname"));
      out.write('(');
      out.print(result.getString("l1gameid"));
      out.write(')');
      out.write(' ');
      out.print(result.getInt("l1salecoin"));
      out.write('점');
      out.write(' ');
      out.write('(');
      out.print(result.getInt("l1itemcode"));
      out.write(',');
      out.write(' ');
      out.print(result.getInt("l1acc1"));
      out.write(',');
      out.write(' ');
      out.print(result.getInt("l1acc2"));
      out.write(")<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t2위 ");
      out.print(result.getString("l2kakaonickname"));
      out.write('(');
      out.print(result.getString("l2gameid"));
      out.write(')');
      out.write(' ');
      out.print(result.getInt("l2salecoin"));
      out.write('점');
      out.write(' ');
      out.write('(');
      out.print(result.getInt("l2itemcode"));
      out.write(',');
      out.write(' ');
      out.print(result.getInt("l2acc1"));
      out.write(',');
      out.write(' ');
      out.print(result.getInt("l2acc2"));
      out.write(")<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t3위 ");
      out.print(result.getString("l3kakaonickname"));
      out.write('(');
      out.print(result.getString("l3gameid"));
      out.write(')');
      out.write(' ');
      out.print(result.getInt("l3salecoin"));
      out.write('점');
      out.write(' ');
      out.write('(');
      out.print(result.getInt("l3itemcode"));
      out.write(',');
      out.write(' ');
      out.print(result.getInt("l3acc1"));
      out.write(',');
      out.write(' ');
      out.print(result.getInt("l3acc2"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t필드동물수량(30)\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t명성레벨(31)\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t친구추가(32)\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t친구하트선물(33)\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t경작지확장(40)\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t동물인벤확장(41)\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t소비인벤확장(42)\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t악세인벤확장(43)\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t집(50)\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t탱크(51)\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t양동이(52)\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t착유기(53)\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t주입기(54)\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t정화시설(55)\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t저온보관(56)\t\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t소모템일반 촉진제(61)\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t소모템일반 치료제(62)\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t소모템농부(63)\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t소모템늑대용 공포탄(64)\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t소모템긴급지원(65)\t\t<br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t필드에 동물배치(70)\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=12>\r\n");
      out.write("\t\t\t\t\t\t\t\t푸쉬");
      out.print(checkPush(result.getInt("kkopushallow")));
      out.write(':');
      out.print(getPushData(result.getString("pushid")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\tprofile : ");
      out.print(result.getString("kakaoprofile"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t");

						if(bList){
							maxPage = result.getInt("maxPage");
						}
					}
      out.write("\r\n");
      out.write("\t\t\t\t\t");
if(bList){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=12 align=center>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userinfo_list.jsp?idxPage=");
      out.print((idxPage - 1 < 1)?1:(idxPage-1));
      out.write("><<</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(idxPage);
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(maxPage);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userinfo_list.jsp?idxPage=");
      out.print((idxPage + 1 > maxPage)?maxPage:(idxPage + 1));
      out.write(">>></a>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>유저 카톡 정보\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>kakaouserid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>kakaotalkid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>gameid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>kakaodata</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>가입일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>삭제일(클릭시 재가입초기화)</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("kakaouserid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("kakaotalkid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cnt"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("cnt2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("kakaodata"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=41&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getDate(result.getString("deldate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
if(gameid.equals(result.getString("gameid"))){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<font color=blue>활성계정상태</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=43&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&ps3=");
      out.print(result.getString("kakaouserid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t(연결끊기)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}else{
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=42&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&ps3=");
      out.print(result.getString("kakaouserid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t재연결(조심히 사용하삼)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>유저 마켓이동.\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>전마켓</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>새마켓</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>버젼</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>레벨</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>베스트레벨</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>년/월</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getTel(result.getInt("market")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>-></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getTel(result.getInt("marketnew")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("version"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("famelv"));
      out.write('(');
      out.print(result.getString("fame"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("famelvbest"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameyear"));
      out.write('년');
      out.write(' ');
      out.print(result.getString("gamemonth"));
      out.write("월</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("changedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>유저보유템\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>listidx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>이름</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>개수</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>인벤종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>획득방식</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>획득일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>랜덤씨리얼</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<td>필드번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>여물통상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>질병상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>죽음상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>필요도움</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>펫/보물(업글)/쿠폰(만기일)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>업글</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>줄기세포(신/공/타/방/HP)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>사용하트/코인</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr ");
      out.print(getCheckValueOri(anireplistidx, result.getInt("listidx"), "bgcolor=#ffe020", ""));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(getCheckValueOri2(userbattleanilistidx, result.getInt("listidx"), "bgcolor=#ff80a0", ""));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(getCheckValueOri2(battleanilistidx, result.getInt("listidx"), "bgcolor=#ff8020", ""));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("listidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
if(result.getInt("invenkind") == 3){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=userminus_form2.jsp?p1=19&p2=71&p3=");
      out.print(result.getString("listidx"));
      out.write("&p4=");
      out.print(result.getString("cnt"));
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("cnt"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getInvenKind(result.getInt("invenkind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getGetHow(result.getInt("gethow")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("randserial"));
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getFieldIdx(result.getInt("fieldidx")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anistep"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("manger"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDiseasestate(result.getInt("diseasestate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDieMode(result.getInt("diemode")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(checkNeedHelpCNT(result.getInt("fieldidx"), result.getInt("needhelpcnt")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=11&p4=");
      out.print(result.getString("listidx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("diedate") == null?"":result.getString("diedate"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
if( result.getInt("invenkind") == 1000 ){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=67&p3=");
      out.print(result.getInt("listidx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change PetUpgrade(1 ~ 6)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("petupgrade"));
      out.write(" (펫)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}else if( result.getInt("invenkind") == 1200 ){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=69&p3=");
      out.print(result.getInt("listidx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change TreasureUpgrade(0 ~ ");
      out.print(result.getString("upstepmax"));
      out.write(")\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("treasureupgrade"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a> /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=\"userminus_form3.jsp?p1=19&p2=70&p3=");
      out.print(result.getInt("listidx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(result.getString("gameid"));
      out.write("&title=Change TreasureUpgrade(7 ~ 99)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("upstepmax"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t(보물)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}else if( result.getInt("expirekind") == 1 ){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("expiredate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=110&p4=");
      out.print(result.getString("listidx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t(개발만기하기)\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=31&p3=");
      out.print(result.getString("listidx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">개발삭제</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getStemCellUpgrade( result.getInt("invenkind"), result.getInt("upcnt"), result.getInt("upstepmax") ));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getStemCellInfo( result.getInt("invenkind"), result.getInt("freshstem100"), result.getInt("attstem100"), result.getInt("timestem100"), result.getInt("defstem100"), result.getInt("hpstem100") ));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("usedheart"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("usedgamecost"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t<br><br>유저 정보 검색이 늦어져서 링크로 옮김<br>\r\n");
      out.write("\t\t\t\t<a href=userdielog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>동물 죽음</a><br><br>\r\n");
      out.write("\t\t\t\t<a href=useralivelog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>동물 부활</a><br><br>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userdellog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>유저 삭제동물/판매된동물/분해(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>listidx[idx]</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>이름</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>개수</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>인벤종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>획득방식</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>획득일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>랜덤씨리얼</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<td>필드번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>여물통상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>질병상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>죽음상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>머리악세</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>꼬리악세</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>업글</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>줄기세포(신/공/타/방/HP)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>삭제순번</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("listidx"));
      out.write(' ');
      out.write('[');
      out.print(result.getString("idx"));
      out.write("]</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cnt"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getInvenKind(result.getInt("invenkind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getGetHow(result.getInt("gethow")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("randserial"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getFieldIdx(result.getInt("fieldidx")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anistep"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("manger"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDiseasestate(result.getInt("diseasestate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDieMode(result.getInt("diemode")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("acc1"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("acc2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getStemCellUpgrade( result.getInt("invenkind"), result.getInt("upcnt"), result.getInt("upstepmax") ));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getStemCellInfo( result.getInt("invenkind"), result.getInt("freshstem100"), result.getInt("attstem100"), result.getInt("timestem100"), result.getInt("defstem100"), result.getInt("hpstem100") ));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write('(');
      out.print(getDate(result.getString("writedate2")));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getUserItemState(result.getInt("state")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>유저 경작지\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>필드번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>이름</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t심은시간 ->\r\n");
      out.write("\t\t\t\t\t\t\t\t완료시간\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t획득상품\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>즉시완료캐쉬</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");

						int _fs = -1;
						while(result.next()){
							_fs = result.getInt("itemcode");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t");
if(_fs >= 0){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getInt("seedidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("seedstartdate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(");
      out.print(result.getString("param2"));
      out.write("초) ->\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate19(result.getString("seedenddate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getSeedItemcode(result.getInt("param6")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(");
      out.print(result.getString("param1"));
      out.write(")개\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("param5"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t");
}else if(_fs == -1){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getInt("seedidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=4>구매 or 빈상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t");
}else if(_fs == -2){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getInt("seedidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=4>미구매</td>\r\n");
      out.write("\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=85&p3=1&p4=");
      out.print(result.getString("seedidx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발비구매</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=85&p3=2&p4=");
      out.print(result.getString("seedidx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발구매(빈곳)</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=85&p3=3&p4=");
      out.print(result.getString("seedidx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발시간완료</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>유저 농장\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<!--<td>gameid</td>-->\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>농장</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>원가(현재가)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>1시간당 수입</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>수입</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구매</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>상승률</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>걷어들인총수입</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>사고팔기</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구분</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>star</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>남은횟수</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("farmidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write(' ');
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gamecost"));
      out.write('(');
      out.print(result.getString("gamecost2"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("hourcoin"));
      out.write("(Max:");
      out.print(result.getString("maxcoin"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
if(result.getInt("buystate") == 1){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getInt("hourcoin2") > result.getInt("maxcoin") ? result.getInt("maxcoin") : result.getInt("hourcoin2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=21&p4=");
      out.print(result.getString("itemcode"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getDate(result.getString("incomedate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=22&p4=");
      out.print(result.getString("itemcode"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getFarmBuyState(result.getInt("buystate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t(");
      out.print(result.getString("buydate"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
}else{
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td colspan=3>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=64&p3=22&p4=");
      out.print(result.getString("itemcode"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
      out.print(getFarmBuyState(result.getInt("buystate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("raisepercent"));
      out.write('%');
      out.write(' ');
      out.write('(');
      out.print(result.getString("raiseyear"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("incomett"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("buycount"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getCheckValue(result.getInt("buywhere"), 1, "직접구매", "에피소드보상"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("star"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("playcnt"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>유저 에피소드 진행도\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>이름</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보상년도</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>획득점수</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>등급</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보상템</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write(' ');
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("etyear"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("etsalecoin"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getETGrade(result.getInt("etgrade")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("etcheckvalue1"));
      out.write('[');
      out.print(getEpiResult(result.getInt("etcheckresult1")));
      out.write("] /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("etcheckvalue2"));
      out.write('[');
      out.print(getEpiResult(result.getInt("etcheckresult2")));
      out.write("] /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("etcheckvalue3"));
      out.write('[');
      out.print(getEpiResult(result.getInt("etcheckresult3")));
      out.write("] /\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("etreward1"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("etreward2"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("etreward3"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("etreward4"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("getdate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=usercomreward.jsp?gameid=");
      out.print(gameid);
      out.write(">경쟁모드 보상</a>(진행번호 : ");
      out.print(comreward);
      out.write(")</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>경쟁모드(상태)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>이름</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보상종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>수량/아이템</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>체크1</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>체크2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>다음번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>초기화1</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>초기화2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write('(');
      out.print(result.getString("idx2"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameyear"));
      out.write('년');
      out.write(' ');
      out.print(result.getString("gamemonth"));
      out.write("월(LV : ");
      out.print(result.getString("famelv"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode"));
      out.write('(');
      out.print(getComRewardCheckPass(result.getInt("ispass")));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getComRewardKind(result.getInt("param1")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("param2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getComRewardCheckPart(result.getInt("param3"), result.getInt("param4")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getComRewardCheckPart(result.getInt("param5"), result.getInt("param6")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("param8"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getComRewardInitPart(result.getInt("param9")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getComRewardInitPart(result.getInt("param10")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("getdate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=95&p3=");
      out.print(result.getString("itemcode"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>튜토리얼 모드 진행</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>튜토리얼모드(상태)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>이름</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보상종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>수량/아이템</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>다음번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameyear"));
      out.write('년');
      out.write(' ');
      out.print(result.getString("gamemonth"));
      out.write("월(LV : ");
      out.print(result.getString("famelv"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode"));
      out.write('(');
      out.print(getComRewardCheckPass(result.getInt("ispass")));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getComRewardKind(result.getInt("param1")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("param2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("param3"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=96&p3=");
      out.print(result.getString("itemcode"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=wgiftsend_list.jsp?gameid=");
      out.print(gameid);
      out.write("  target=_blank>선물 받은 리스트(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>인덱스</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>유저</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>아이템</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>등급</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>수령일</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<td>가격</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>선물자</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>선물일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>삭제</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr ");
      out.print(getGiftKindColor(result.getInt("giftkind")));
      out.write(">\r\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idxt"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.print(getGiftKind(result.getInt("giftkind")));
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t");
if(result.getInt("giftkind") == 2 || result.getInt("giftkind") == -2  || result.getInt("giftkind") == -3  || result.getInt("giftkind") == -4  ){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("itemname"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(");
      out.print(result.getString("itemcode"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(getGiftCount(result.getInt("subcategory"), result.getInt("buyamount"), result.getInt("cnt")));
      out.write("개)\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getGrade(result.getInt("grade")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("gaindate")));
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getPrice(result.getInt("gamecost"), result.getInt("cashcost")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("giftid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("giftdate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
if(result.getInt("gainstate") == 0){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<a href=/Game4/hlskt/giftgain.jsp?idx=");
      out.print(result.getString("idxt"));
      out.write(">선물강제받기</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}else{
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");
      out.print(getGainState(result.getInt("gainstate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("message"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t");
}else{
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=4>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("message"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("giftid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=2>");
      out.print(getDate(result.getString("giftdate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=27&p2=21&p4=");
      out.print(result.getInt("idxt"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write("&idx=");
      out.print(result.getInt("idxt"));
      out.write(">삭제마킹</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=27&p2=22&p4=");
      out.print(result.getInt("idxt"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write("&idx=");
      out.print(result.getInt("idxt"));
      out.write(">개발원복</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=27&p2=23&p4=");
      out.print(result.getInt("idxt"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">개발삭제</a>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=useritembuylog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>구매 로그(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>itemname</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>개수</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>코인구매가/원가</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>캐쉬구매가/원가</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>buydate</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cnt"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gamecost"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("gamecost2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cashcost"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("cashcost2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("buydate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=cashbuy_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>캐쉬로그(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>ikind</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구매자(gameid)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>선물받은사람(giftid)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>통신사인증(acode)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>클라인증(ucode)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구매루비(cashcost)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구매캐쉬(cash)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>kakaouk</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구매일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ikind"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getIsNull(result.getString("giftid"), ""));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("acode"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ucode"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cashcost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cash"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("kakaouk"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("writedate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=17&p2=1&p3=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">로그삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=12>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getXXX2(result.getString("idata"), 40));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getXXX2(result.getString("idata2"), 40));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=cashchange_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>캐쉬환전(더보기 1:100)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>gameid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비(캐쉬) -> 코인환전</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>환전일</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("cashcost"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t->\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gamecost"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>생애첫결제 내역</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구매자(gameid)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>itemcode</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>구매일</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("itemname"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t( ");
      out.print(result.getString("itemcode"));
      out.write(" )\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("writedate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=17&p2=11&p3=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(result.getString("gameid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(result.getString("gameid"));
      out.write(">로그삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=unusual_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>비정상행동(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>비정상유저</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>비정상내용</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>비정상날짜</td>\r\n");
      out.write("\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자확인상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자확인날짜</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자확인내용</td>\r\n");
      out.write("\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("comment"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("writedate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("chkstate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("chkdate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("chkcomment"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=unusual_list2.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>비정상정보(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>비정상유저</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>비정상내용</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>비정상날짜</td>\r\n");
      out.write("\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자확인상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자확인날짜</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자확인내용</td>\r\n");
      out.write("\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("comment"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("writedate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("chkstate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("chkdate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("chkcomment"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userblock_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>유저블럭(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>블럭유저</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>블럭날짜</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>블럭내용</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>IP</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리해제일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>해제코멘트</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>해제하기</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("comment"));
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("adminid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("adminip"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("releasedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("comment2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getBlockState(result.getInt("blockstate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userdelete_list.jsp?gameid=");
      out.print(gameid);
      out.write(">유저삭제(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>삭제유저</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>삭제날짜</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>삭제내용</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리자</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>IP</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>관리해제일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>해제코멘트</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>해제하기</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("comment"));
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("adminid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("adminip"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("releasedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("comment2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDeleteState(result.getInt("deletestate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>친구<!--<a href=userfriend_list.jsp?gameid=");
      out.print(gameid);
      out.write(">친구 10명만 출력됨(더보기)</a>-->\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>gameid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>친구아이디</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>친구상태</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>친구종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>하트전송일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>도와줘요청일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>친구동물빌리기</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t<td>친밀도</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>친구등록일</td>\r\n");
      out.write("\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("friendid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getFriend(result.getInt("state")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getFriendKind(result.getInt("kakaofriendkind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=64&p3=3&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(result.getString("friendid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(getDate(result.getString("senddate")));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=88&p3=4&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(getDate(result.getString("helpdate")));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=88&p3=11&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write('>');
      out.print(getDate(result.getString("rentdate")));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=97&p3=1&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(result.getString("friendid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발거절</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=97&p3=2&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(result.getString("friendid"));
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">상호승인</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("familiar"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userkakaoinvite_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>카톡 친구 초대(");
      out.print(kakaomsginvitecnt);
      out.write("명 초대중)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>gameid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>receuuid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>cnt</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>senddate</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("receuuid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cnt"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=88&p3=2&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=kakaomsgInviteCount>");
      out.print(getDate(result.getString("senddate")));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=88&p3=3&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=kakaomsgInviteCount>개발삭제</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>카톡 도와줘 친구야(대기[내가 <- 다른친구])\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>gameid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>friendid</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>listidx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>helpdate</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("friendid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("listidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=88&p3=6&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=kakaomsgInviteCount>");
      out.print(getDate(result.getString("helpdate")));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=usersetting_ok.jsp?p1=19&p2=88&p3=7&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&gameid=");
      out.print(gameid);
      out.write("&title=kakaomsgInviteCount>개발삭제</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userroullog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>동물뽑기(교배:더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>kind</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>명성도</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비/코인/하트</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getCheckRoulMode(result.getInt("kind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameyear"));
      out.write('년');
      out.write(' ');
      out.print(result.getString("gamemonth"));
      out.write("월</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("framelv"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcodename"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("cashcost"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("gamecost"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("heart"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode0name"));
      out.write('(');
      out.print(result.getString("itemcode0"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode1name"));
      out.write('(');
      out.print(result.getString("itemcode1"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode2name"));
      out.write('(');
      out.print(result.getString("itemcode2"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode3name"));
      out.write('(');
      out.print(result.getString("itemcode3"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode4name"));
      out.write('(');
      out.print(result.getString("itemcode4"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode5name"));
      out.write('(');
      out.print(result.getString("itemcode5"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode6name"));
      out.write('(');
      out.print(result.getString("itemcode6"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode7name"));
      out.write('(');
      out.print(result.getString("itemcode7"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode8name"));
      out.write('(');
      out.print(result.getString("itemcode8"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode9name"));
      out.write('(');
      out.print(result.getString("itemcode9"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode10name"));
      out.write('(');
      out.print(result.getString("itemcode10"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("frienditemname"));
      out.write('(');
      out.print(result.getString("frienditemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=usertreasurelog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>보물뽑기(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>kind</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>명성도</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비/코인/하트</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getCheckRoulMode2(result.getInt("kind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameyear"));
      out.write('년');
      out.write(' ');
      out.print(result.getString("gamemonth"));
      out.write("월</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("framelv"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcodename"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("cashcost"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("gamecost"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("heart"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode0name"));
      out.write('(');
      out.print(result.getString("itemcode0"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode1name"));
      out.write('(');
      out.print(result.getString("itemcode1"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode2name"));
      out.write('(');
      out.print(result.getString("itemcode2"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode3name"));
      out.write('(');
      out.print(result.getString("itemcode3"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode4name"));
      out.write('(');
      out.print(result.getString("itemcode4"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode5name"));
      out.write('(');
      out.print(result.getString("itemcode5"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode6name"));
      out.write('(');
      out.print(result.getString("itemcode6"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode7name"));
      out.write('(');
      out.print(result.getString("itemcode7"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode8name"));
      out.write('(');
      out.print(result.getString("itemcode8"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode9name"));
      out.write('(');
      out.print(result.getString("itemcode9"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode10name"));
      out.write('(');
      out.print(result.getString("itemcode10"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=usercomplog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>합성(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>명성도</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비(캐쉬)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>코인</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>하트</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>합성티켓</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameyear"));
      out.write('년');
      out.write(' ');
      out.print(result.getString("gamemonth"));
      out.write("월</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("famelv"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getComposeKind(result.getInt("kind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcodename"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cashcost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gamecost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("heart"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ticket"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode0name"));
      out.write('(');
      out.print(result.getString("itemcode0"));
      out.write('/');
      out.print(result.getString("itemcode1"));
      out.write('/');
      out.print(result.getString("itemcode2"));
      out.write('/');
      out.print(result.getString("itemcode3"));
      out.write('/');
      out.print(result.getString("itemcode4"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("bgcomposename"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t([");
      out.print(result.getString("bgcomposeic"));
      out.write(']');
      out.write(' ');
      out.print(getComposeResult(result.getInt("bgcomposert")));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userpromotelog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>승급(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>명성도</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비(캐쉬)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>코인</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>하트</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>승급티켓</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>승급(전)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>승급(예정)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>승급(결과)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameyear"));
      out.write('년');
      out.write(' ');
      out.print(result.getString("gamemonth"));
      out.write("월</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("famelv"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getPromoteKind(result.getInt("kind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcodename"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cashcost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gamecost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("heart"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ticket"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode0"));
      out.write('/');
      out.print(result.getString("itemcode1"));
      out.write('/');
      out.print(result.getString("itemcode2"));
      out.write('/');
      out.print(result.getString("itemcode3"));
      out.write('/');
      out.print(result.getString("itemcode4"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("resultlist"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("bgpromotename"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(");
      out.print(result.getString("bgpromoteic"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userroullog_list2.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>악세뽑기(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>framelv</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비(캐쉬)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>코인</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("framelv"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cashcost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gamecost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode0name"));
      out.write('(');
      out.print(result.getString("itemcode0"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode1name"));
      out.write('(');
      out.print(result.getString("itemcode1"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode2name"));
      out.write('(');
      out.print(result.getString("itemcode2"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode3name"));
      out.write('(');
      out.print(result.getString("itemcode3"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode4name"));
      out.write('(');
      out.print(result.getString("itemcode4"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=userroullog_list3.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>행운의 주사위(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>idx</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>framelv</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비(캐쉬)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계1</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계3</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계4</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계5</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계6</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>주사위결과/획득단계</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>코인</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>단계</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>리스트 갱신</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>시도횟수</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>남은금액(코인)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>남은금액(루비)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=userroullog_list3.jsp?gameid=");
      out.print(result.getString("gameid"));
      out.write('>');
      out.print(result.getString("gameid"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("framelv"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemcode"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getYabauCheck(result.getInt("kind")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");

								kind = result.getInt("kind");
								if(kind == 1){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
}else if(kind == 4){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack11"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack21"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack31"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack41"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack51"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack61"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("yabaustep"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
}else if(kind == 3 || kind == 2){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack11"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack21"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack31"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack41"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack51"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("pack61"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(getYabauResult(result.getInt("result")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cashcost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gamecost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("yabaustep"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("yabauchange"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("yabaucount"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("remaingamecost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("remaincashcost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>펫도감</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>펫(itemcode)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>획득일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("getdate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=92&p3=");
      out.print(result.getString("itemcode"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>동물도감:(개인보유)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물(itemcode)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("itemname"));
      out.write('(');
      out.print(result.getString("itemcode"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=90&p3=");
      out.print(result.getString("itemcode"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>동물도감(개인보상)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>도감번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>도감동물(아이템코드)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>도감보상</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("param1"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("param2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("param3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("param4"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("param5"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("param6"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("param7"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("param8"));
      out.write('(');
      out.print(result.getString("param9"));
      out.write("개)\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=91&p3=");
      out.print(result.getString("param1"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>\r\n");
      out.write("\t\t\t\t\t학교대항(10명만 나옴)\r\n");
      out.write("\t\t\t\t\t");
if(schoolidx != -1){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<a href=schooluser_list.jsp?schoolidx=");
      out.print(schoolidx);
      out.write(" target=_blank>(더보기)</a>\r\n");
      out.write("\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>이름</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>계정</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>인원</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>점수</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=94&p3=1&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발탈퇴</a></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("schoolname"));
      out.write('(');
      out.print(result.getString("schoolidx"));
      out.write(')');
      out.write('[');
      out.print(result.getString("schoolarea"));
      out.write(' ');
      out.write(',');
      out.write(' ');
      out.print(getSchoolKind(result.getInt("schoolkind")));
      out.write("]</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("gameid"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("cnt"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("point2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>\r\n");
      out.write("\t\t\t\t\t학교 대항 개인정보\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>학교번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>누적거래</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>최근거래</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("schoolidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("point"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("joindate"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=adminusersalelog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>거래정보(최근10개만 보임) 더보기</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>거래일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>명성도/레벨</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>사용건초</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>총수익(0)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>판매금액(1)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>상인요구</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>상장금액(2)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>게임중획득금액(3)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>성과템(초과성과템)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>골드티켓</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>로그(소스보기로)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>루비/코인/하트/건초/우정</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>유제품</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
							earncoin += result.getInt("salecoin") + result.getInt("prizecoin"); 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(num++);
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gameyear"));
      out.write("년\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gamemonth"));
      out.write("월\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("fame"));
      out.write('/');
      out.print(result.getString("famelv"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("feeduse"));
      out.write("개</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getInt("salebarrel")*(result.getInt("saledanga") + result.getInt("saleplusdanga")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t+ ");
      out.print(result.getInt("prizecoin"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t+ ");
      out.print(result.getInt("playcoin"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("saletrader"));
      out.write("번상인\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(단가:");
      out.print(result.getString("saledanga"));
      out.write("코인 + 추가:");
      out.print(result.getString("saleplusdanga"));
      out.write("코인)\r\n");
      out.write("\t\t\t\t\t\t\t\t\tx ");
      out.print(result.getString("salebarrel"));
      out.write('배');
      out.write('럴');
      out.write('(');
      out.print(result.getString("salefresh"));
      out.write("신선도) =\r\n");
      out.write("\t\t\t\t\t\t\t\t\t판매금:");
      out.print(result.getString("salecoin"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("saletrader"));
      out.write("번상인\r\n");
      out.write("\t\t\t\t\t\t\t\t\t배럴:");
      out.print(result.getString("orderbarrel"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t신선:");
      out.print(result.getString("orderfresh"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t연속:");
      out.print(result.getString("tradecnt"));
      out.write("회\r\n");
      out.write("\t\t\t\t\t\t\t\t\t상장:");
      out.print(result.getString("prizecnt"));
      out.write("회\r\n");
      out.write("\t\t\t\t\t\t\t\t\t수익금:");
      out.print(result.getString("prizecoin"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t수익금:");
      out.print(result.getString("playcoin"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t(최대Max:");
      out.print(result.getString("playcoinmax"));
      out.write(")\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("saleitemcode"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("goldticket"));
      out.write("남음 /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getGoldTicketUsed(result.getInt("goldticketused")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=66&p3=1&p4=");
      out.print(result.getString("idx2"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(getDate(result.getString("writedate")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<!--\r\n");
      out.write("\t\t\t\t\t\t\t\t\tuserinfo \t: ");
      out.print(result.getString("userinfo"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\taniitem\t\t: ");
      out.print(result.getString("aniitem"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\tcusitem\t\t: ");
      out.print(result.getString("cusitem"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\ttradeinfo \t: ");
      out.print(result.getString("tradeinfo"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t-->\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("cashcost"));
      out.write("/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gamecost"));
      out.write("/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("heart"));
      out.write("/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("feed"));
      out.write("/\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("fpoint"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("milkproduct"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=14>\r\n");
      out.write("\t\t\t\t\t\t\t\t총수익 : ");
      out.print(earncoin);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br>저장정보(개발후 삭제합니다.)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>fevergauge</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>bottlelittle/fresh</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>tanklittle/fresh</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>feeduse</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>boosteruse</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>albause</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>wolfappear/killcnt</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gameyear"));
      out.write("년\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("gamemonth"));
      out.write("월\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("frametime"));
      out.write("일\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("fevergauge"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("bottlelittle"));
      out.write(" \t/ ");
      out.print(result.getString("bottlefresh"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("tanklittle"));
      out.write("\t\t/ ");
      out.print(result.getString("tankfresh"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("feeduse"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("boosteruse"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("albause"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("albausesecond"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("albausethird"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("wolfappear"));
      out.write("\t\t/ ");
      out.print(result.getString("wolfkillcnt"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><a href=usersetting_ok.jsp?p1=19&p2=66&p3=11&p4=");
      out.print(result.getString("idx"));
      out.write("&ps1=");
      out.print(gameid);
      out.write("&ps2=");
      out.print(adminid);
      out.write("&branch=userinfo_list&gameid=");
      out.print(gameid);
      out.write(">개발삭제</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=10>\r\n");
      out.write("\t\t\t\t\t\t\t\t\tuserinfo \t: ");
      out.print(getSubString(result.getString("userinfo")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\taniitem\t\t: ");
      out.print(getSubString(result.getString("aniitem")));
      out.write("<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t\tcusitem\t\t: ");
      out.print(getSubString(result.getString("cusitem")));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=adminfarmbattlelog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>목장배틀정보(최근10개만 보임) 더보기</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>배틀번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<!--<td>gameid</td>-->\r\n");
      out.write("\t\t\t\t\t\t\t<td>목장번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>결과</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>적동물</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물1</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물3</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물1</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물3</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물4</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물5</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>참여일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>플레이타임</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보상템</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보상코인</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>star</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("farmidx"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getBattleResult(result.getInt("result")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("enemydesc"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anidesc1"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anidesc2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anidesc3"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts1name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts2name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts3name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts4name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts5name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("playtime"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("reward1"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("reward2"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("reward3"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("reward4"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t/ ");
      out.print(result.getString("reward5"));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("rewardgamecost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("star"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=14>\r\n");
      out.write("\t\t\t\t\t\t\t\t총수익 : ");
      out.print(earncoin);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=adminuserbattlelog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>유저배틀정보(최근10개만 보임) 더보기</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>배틀번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>결과</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>trophy(tier)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물1</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물3</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물1</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물3</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물4</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물5</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>상대방(gameid/nickname)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>상대방(trophy/tier)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>상대방(bankidx)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>참여일</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>플레이타임</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getBattleResult(result.getInt("result")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("trophy"));
      out.write('(');
      out.print(result.getString("tier"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anidesc1"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anidesc2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("anidesc3"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts1name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts2name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts3name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts4name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("ts5name"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("othergameid"));
      out.write('(');
      out.print(result.getString("othernickname"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("othertrophy"));
      out.write('(');
      out.print(result.getString("othertier"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=adminuserbattlebank_list.jsp?idx=");
      out.print(result.getString("otheridx"));
      out.write(" target=_blank>");
      out.print(result.getString("otheridx"));
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("playtime"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=14>\r\n");
      out.write("\t\t\t\t\t\t\t\t총수익 : ");
      out.print(earncoin);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					num = 1;
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=adminuserbattlebank_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>유저배틀뱅크(최근10개만 보임) 더보기</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td>뱅크번호</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>트로피(티어)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물1(코드/강화/att/def/hp/time)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>동물3</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물1(강화)</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물2</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물3</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물4</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>보물5</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>참여일</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getInt("trophy"));
      out.write('(');
      out.print(result.getInt("tier"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("aniitemcode1"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("upcnt1"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("attstem1"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("defstem1"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("hpstem1"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("timestem1"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("aniitemcode2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("upcnt2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("attstem2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("defstem2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("hpstem2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("timestem2"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("aniitemcode3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("upcnt3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("attstem3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("defstem3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("hpstem3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.print(result.getString("timestem3"));
      out.write(" /\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("treasure1"));
      out.write('(');
      out.print(result.getString("treasureupgrade1"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("treasure2"));
      out.write('(');
      out.print(result.getString("treasureupgrade2"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("treasure3"));
      out.write('(');
      out.print(result.getString("treasureupgrade3"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("treasure4"));
      out.write('(');
      out.print(result.getString("treasureupgrade4"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("treasure5"));
      out.write('(');
      out.print(result.getString("treasureupgrade5"));
      out.write(")</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=14>\r\n");
      out.write("\t\t\t\t\t\t\t\t총수익 : ");
      out.print(earncoin);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
if(cstmt.getMoreResults()){
					result = cstmt.getResultSet();
      out.write("\r\n");
      out.write("\t\t\t\t\t<br><br><a href=zcplog_list.jsp?gameid=");
      out.print(gameid);
      out.write(" target=_blank>로그(더보기)</a>\r\n");
      out.write("\t\t\t\t\t<table border=1>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>종류</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>사용캐쉬/보유캐쉬</td>\r\n");
      out.write("\t\t\t\t\t\t\t<td>buydate</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
while(result.next()){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("idx2"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getZCPMode(result.getInt("mode")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(result.getString("usedcashcost"));
      out.write(' ');
      out.write('/');
      out.write(' ');
      out.print(result.getString("ownercashcost"));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>");
      out.print(getDate(result.getString("writedate")));
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\r\n");
      out.write("</tbody></table>\r\n");
      out.write("\r\n");
      out.write("\r\n");


  	}catch(Exception e){
  		String _strErr = "error:" + e;
  		out.println(_strErr);
		System.out.println(_strErr);
	}

    //3. 송출, 데이타 반납
    if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);

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
