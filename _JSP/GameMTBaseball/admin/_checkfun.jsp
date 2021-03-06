<%!
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
			case 1: _str = "완성의상("+ _val +")";	break;
			case 2: _str = "조각의상("+ _val +")";	break;
			case 3: _str = "소비템("+ _val +")";	break;
			default:_str = "모름(" + _val + ")";	break;
		}
		return _str;
	}
	

	public boolean getInvenKindCountDisplay(int _val){
		boolean _rtn = false;
		switch(_val){
			case 1: _rtn = false;	break;
			case 2: _rtn = true;	break;
			case 3: _rtn = true;	break;
		}
		return _rtn;
	}

	public String getGetHow(int _val){
		String _str = "모름("+ _val +")";
		switch(_val){
			case 0: _str = "기본("+ _val +")";		break;
			case 1: _str = "구매("+ _val +")";		break;
			case 2: _str = "경작("+ _val +")";		break;
			case 3: _str = "교배/뽑기("+ _val +")";		break;
			case 4: _str = "검색("+ _val +")";		break;
			case 5: _str = "선물("+ _val +")";		break;			
			case 17: _str = "무료복구("+ _val +")";		break;
			case 20: _str = "박스뽑기("+ _val +")";		break;
			case 21: _str = "레벨업("+ _val +")";		break;
			case 22: _str = "경매장 구매("+ _val +")";	break;
			case 23: _str = "조합으로 획득("+ _val +")";	break;
			case 24: _str = "초월로 획득("+ _val +")";	break;
			default:_str = "모름("+ _val +")";		break;
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
			case 1:		_str = "장착템("+_kind+")";		break;
			case 15:	_str = "조각템("+_kind+")";		break;
			case 40:	_str = "소모품("+_kind+")";		break;
			case 50:	_str = "다이아선물("+_kind+")";		break;
			case 60:	_str = "볼선물("+_kind+")";		break;
			case 500:	_str = "정보수집("+_kind+")";		break;
			case 510:	_str = "레벨업 보상("+_kind+")";	break;
		}
		return _str;
	}

	//
	public String getSubCategory(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case 1:		_str = "헬멧("+_kind+")";				break;
			case 2:		_str = "상의("+_kind+")";				break;
			case 3:		_str = "하의("+_kind+")";				break;
			case 4:		_str = "장갑("+_kind+")";				break;
			case 5:		_str = "신발("+_kind+")";				break;
			case 6:		_str = "방망이("+_kind+")";			break;
			case 7:		_str = "색깔공("+_kind+")";			break;
			case 8:		_str = "고글("+_kind+")";				break;
			case 9:		_str = "손목 아대("+_kind+")";			break;
			case 10:	_str = "팔꿈치 보호대("+_kind+")";		break;
			case 11:	_str = "벨트("+_kind+")";				break;
			case 12:	_str = "무릎 보호대("+_kind+")";		break;
			case 13:	_str = "양말("+_kind+")";				break;			
			case 15:	_str = "헬멧 조각("+_kind+")";			break;
			case 16:	_str = "상의 조각("+_kind+")";			break;
			case 17:	_str = "하의 조각("+_kind+")";			break;
			case 18:	_str = "장갑 조각("+_kind+")";			break;
			case 19:	_str = "신발 조각("+_kind+")";			break;
			case 20:	_str = "방망이 조각("+_kind+")";		break;
			case 21:	_str = "색깔공 조각("+_kind+")";		break;
			case 22:	_str = "고글 조각("+_kind+")";			break;
			case 23:	_str = "손목 아대 조각("+_kind+")";		break;
			case 24:	_str = "팔꿈치 보호대 조각("+_kind+")";	break;
			case 25:	_str = "벨트 조각("+_kind+")";			break;
			case 26:	_str = "무릎 보호대 조각("+_kind+")";		break;
			case 27:	_str = "양말 조각("+_kind+")";			break;
			case 40:	_str = "조각 랜덤박스("+_kind+")";		break;
			case 41:	_str = "의상 랜덤박스("+_kind+")";		break;
			case 42:	_str = "조언 패키지 박스("+_kind+")";		break;
			case 45:	_str = "조합초월주문서("+_kind+")";		break;
			case 46:	_str = "수수료차감주문서("+_kind+")";		break;
			case 47:	_str = "닉네임 변경권("+_kind+")";		break;
			case 48:	_str = "랜덤 다이아 박스("+_kind+")";		break;
			case 50:	_str = "다이아("+_kind+")";			break;
			case 60:	_str = "볼("+_kind+")";				break;
			case 500:	_str = "정보수집("+_kind+")";			break;
			case 510:	_str = "레벨업 보상("+_kind+")";		break;
		}
		return _str;
	}

	public String getPrice(int _gamecost, int _cashcost){
		String _str = "";
		if(_gamecost != 0)_str += _gamecost + "(코인)";
		if(_cashcost != 0)_str += _cashcost + "(다이아)";
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
			case 3:		_str = "다이아 주사위("+_kind+")";	break;
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
	
	//---------------------------------------------------
	
	public String getTutorial( int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "안봄("+_flag+")";		break;
			case 1:		_str = "봄("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;

	}
	
	public String getSingleFlag( int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "싱글미진행("+_flag+")";		break;
			case 1:		_str = "싱글진행중("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; 	break;
		}
		return _str;
	}
	
	public String getLottoPBGrade(int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "A("+_flag+")";		break;
			case 1:		_str = "B("+_flag+")";		break;
			case 2:		_str = "C("+_flag+")";		break;
			case 3:		_str = "D("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;
	}
	
	public String getLottoPBEvenOdd(int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "짝("+_flag+")";		break;
			case 1:		_str = "홀("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;
	}
	
	public String getLottoPBUnderOver(int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "언더("+_flag+")";		break;
			case 1:		_str = "오버("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;
	}
	
	public String getLottoTBGrade(int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "A("+_flag+")";		break;
			case 1:		_str = "B("+_flag+")";		break;
			case 2:		_str = "C("+_flag+")";		break;
			case 3:		_str = "D("+_flag+")";		break;
			case 4:		_str = "E("+_flag+")";		break;
			case 5:		_str = "F("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;
	}
	
	public String getLottoTBEvenOdd(int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "짝("+_flag+")";		break;
			case 1:		_str = "홀("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;
	}
	
	public String getLottoTBUnderOver(int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "언더("+_flag+")";		break;
			case 1:		_str = "오버("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;
	}
	
	public String getLottoTBGrade2(int _flag ){
		String _str = "";
		switch(_flag){
			case 0:		_str = "소("+_flag+")";		break;
			case 1:		_str = "중("+_flag+")";		break;
			case 2:		_str = "대("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; break;
		}
		return _str;
	}
	
	public String getLottoSelect1(int _flag ){
		String _str = "";
		switch(_flag){
			case 1:		_str = "스트라이크("+_flag+")";							break;
			case 0:		_str = "볼("+_flag+")";								break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>"; break;
		}
		return _str;
	}
	
	public String getLottoSelect2(int _flag ){
		String _str = "";
		switch(_flag){
			case 1:		_str = "직구("+_flag+")";							break;
			case 0:		_str = "변화("+_flag+")";								break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>"; break;
		}
		return _str;
	}
	
	public String getLottoSelect3(int _flag ){
		String _str = "";
		switch(_flag){
			case 1:		_str = "좌("+_flag+")";							break;
			case 0:		_str = "우("+_flag+")";								break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>"; break;
		}
		return _str;
	}
	
	public String getLottoSelect4(int _flag ){
		String _str = "";
		switch(_flag){
			case 1:		_str = "상("+_flag+")";							break;
			case 0:		_str = "하("+_flag+")";								break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>"; break;
		}
		return _str;
	}
	
	public String getGameMode(int _flag){
		String _str = "";
		switch(_flag){
			case 0:		_str = "연습("+_flag+")";							break;
			case 1:		_str = "싱글("+_flag+")";							break;
			case 2:		_str = "멀티("+_flag+")";							break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>"; break;
		}
		return _str;
	} 
	
	public String getSelectMode(int _kind, int _flag, int _flag2){
		String _str = "<font color=blue>모름(" + _flag + ")</font>";
		if(_kind == 1){
			switch(_flag){
				case -1:		_str = "미선택("+_flag+")";				break;
				case  1:		_str = "스트라이크("+_flag+")";				break;
				case  0:		_str = "볼("+_flag+")";					break;
			}
		}else if(_kind == 2){
			switch(_flag){
				case -1:		_str = "미선택("+_flag+")";				break;
				case  1:		_str = "직구("+_flag+")";					break;
				case  0:		_str = "변화구("+_flag+")";				break;
			}
		}else if(_kind == 3){
			switch(_flag){
				case -1:		_str = "미선택("+_flag+")";				break;
				case  1:		_str = "좌("+_flag+")";					break;
				case  0:		_str = "우("+_flag+")";					break;
			}
		}else if(_kind == 4){
			switch(_flag){
				case -1:		_str = "미선택("+_flag+")";				break;
				case  1:		_str = "상("+_flag+")";					break;
				case  0:		_str = "하("+_flag+")";					break;
			}
		}
		
		if(_flag2 != -1){
			_str += "/(" + _flag2 + ")";
		}
		return _str;
	}
	
	public String getGameState(int _flag){
		String _str = "";
		switch(_flag){
			case -1:		_str = "게임진행중("+_flag+")";											break;
			case -2:		_str = "<font color=blue>재로그인롤백처리("+_flag+")</font>";				break;
			case -3:		_str = "<font color=red>시스템 점검 로그인시롤백예정("+_flag+")</font>";		break;
			case  0:		_str = "정상처리("+_flag+")";											break;
			case 10:		_str = "<font color=red>로그인 몰수("+_flag+")</font>";					break;
			case 11:		_str = "<font color=blue>로그인 롤백("+_flag+")</font>";				break;
			case 12:		_str = "<font color=red>관리자 삭제("+_flag+")</font>";					break;
			case 13:		_str = "<font color=blue>관리자 롤백("+_flag+")</font>";				break;
			case 14:		_str = "<font color=red>시스템 점검 로그인시롤백됨("+_flag+")</font>";		break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>";						break;
		}
		return _str;
	}
	
	public String getGameResult(int _flag){
		String _str = "";
		switch(_flag){
			case -1:		_str = "<font color=red>진행중("+_flag+")</font>";	break;
			case  0:		_str = "아웃("+_flag+")";							break;
			case  1:		_str = "1루타("+_flag+")";						break;
			case  2:		_str = "2루타("+_flag+")";						break;
			case  3:		_str = "3루타("+_flag+")";						break;
			case  4:		_str = "홈런("+_flag+")";							break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>";	break;
		}
		return _str;	
	}
	
	public String getRSelect(int _flag){
		String _str = "";
		switch(_flag){
			case -1:		_str = "미판정("+_flag+")";						break;
			case  0:		_str = "<font color=red>패("+_flag+")</font>";	break;
			case  1:		_str = "<font color=blue>승("+_flag+")</font>";	break;
			default:	_str = "<font color=blue>모름(" + _flag + ")</font>";	break;
		}
		return _str;	
	}
	
	public String getColor(int _val){
		String _str = "";
		switch(_val){
			case 0: 	_str = "bgcolor=#eeeeee";		break;
			case 1: 	_str = "bgcolor=#e0e0e0";		break;
		}
		return _str;
	}
	
	public String getColor(int _val, int _val2){
		String _str = "";
		if(_val > _val2){
			_str = "bgcolor=#ff00ff";
		}
		return _str;
	}
	
	
	public String getEarnCompare(int _val, int _val2){
		String _str = "";
		if(_val > _val2){
			_str = "<font color=red>" + _val + "/" + _val2 + "<font>";
		}else{
			_str = "<font color=blue>" + _val + "/" + _val2 + "<font>";
		}
		return _str;
	}	
	
	public String getEarnCompareReverse(long _val, long _pc, long _val2){
		String _str = "";
		if( (_val + _pc) < _val2){
			_str = "<font color=red>(" + _val +" + " + _pc + ")/" + _val2 + "<font>";
		}else{
			_str = "<font color=blue>(" + _val +" + " + _pc + ")/" + _val2 + "<font>";
		}
		return _str;
	}
	
	public String getEarnCompareReverse(int _val, int _pc, int _val2){
		String _str = "";
		if( (_val + _pc) < _val2){
			_str = "<font color=red>(" + _val +" + " + _pc + ")/" + _val2 + "<font>";
		}else{
			_str = "<font color=blue>(" + _val +" + " + _pc + ")/" + _val2 + "<font>";
		}
		return _str;
	}
	
	
	
%>