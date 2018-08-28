<%!
	//UltraEdit 파일포맷을 변경하면 된다.
	//파일 > 변환 > (ASCII -> Unicode)
	//파일 > 변환 > (UTF-8 -> Unicode)

	//@@@@
	public String getTel(int _market){
		String _str = "NONE";
		switch(_market){
			case 1: 	_str = "SKT";		break;
			case 2: 	_str = "KT";		break;
			case 3: 	_str = "LGT";		break;
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

	public String getConCode(int _code){
		String _str = "NONE";
		switch(_code){
			case 82: 	_str = "(한글)";	break;
			case 81: 	_str = "(일본)";	break;
			case  1: 	_str = "(영어)";	break;
		}
		return _str;
	}

	//@@@@
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
		}else if(_str != null && _str.length() > 16){
			_str = _str.substring(0, 16);
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
			case 1000: _str = "펫("+ _val +")";	break;
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


	public String getSysCheck(int _val){
		String _str = "";
		switch(_val){
			case -1: 	_str = "bgcolor=#c0c0c0";		break;
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
			case 3: _str = "<font color=red>합성소모("+ _val +")</font>";	break;
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
			case 30:	_str = "유제품("+_kind+")";			break;
			case 31:	_str = "코인("+_kind+")";			break;
			case 32:	_str = "VIP포인트("+_kind+")";		break;
			case 33:	_str = "하트("+_kind+")";			break;
			case 34:	_str = "건초("+_kind+")";			break;
			case 35:	_str = "황금룰렛("+_kind+")";		break;
			case 36:	_str = "황금룰렛티켓("+_kind+")";	break;
			case 37:	_str = "환생포인트("+_kind+")";		break;
			case 60:	_str = "목장기술("+_kind+")";		break;
			case 80:	_str = "보물("+_kind+")";			break;
		}
		return _str;
	}

	public String getSubCategory(int _kind){
		String _str = "모름" + _kind;
		switch(_kind){
			case 30:	_str = "유제품("+_kind+")";			break;
			case 31:	_str = "코인("+_kind+")";			break;
			case 32:	_str = "VIP포인트("+_kind+")";		break;
			case 33:	_str = "하트("+_kind+")";			break;
			case 34:	_str = "건초("+_kind+")";			break;
			case 35:	_str = "황금룰렛("+_kind+")";		break;
			case 36:	_str = "황금룰렛티켓("+_kind+")";	break;
			case 37:	_str = "환생포인트("+_kind+")";		break;
			case 60:	_str = "목장기술("+_kind+")";		break;
			case 80:	_str = "보물("+_kind+")";			break;
		}
		return _str;
	}

	public String getPrice(int _gamecost, int _cashcost){
		String _str = "";
		if(_gamecost != 0)_str += _gamecost + "(코인)";
		if(_cashcost != 0)_str += _cashcost + "(수정)";
		if(_str.equals(""))_str = "무료";
		return _str;
	}

	public String getGrade(int _grade){
		String _str = "모름" + _grade;
		switch(_grade){
			case 0:		_str = "저급("+_grade+")";		break;
			case 1:		_str = "일반("+_grade+")";		break;
			case 2:		_str = "고급("+_grade+")";		break;
			case 3:		_str = "희귀("+_grade+")";		break;
			case 4:		_str = "전설("+_grade+")";		break;
			case 5:		_str = "레전드("+_grade+")";		break;
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
			case -1:	_str = "전체대기중("+_kind+")";	break;
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
			case 3:		_str = "수정합성("+_kind+")";	break;
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
			}else if(_subcategory == 69 && (_num == 11)){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}else if(_subcategory == 910 && (_num == 2 || _num == 3 || _num == 4 || _num == 5 || _num == 6 || _num == 7 || _num == 8 || _num == 9 || _num == 10 || _num == 11 || _num == 12 || _num == 13 )){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}else if(_subcategory == 818 && (_num == 2 || _num == 3 || _num == 4 || _num == 5 || _num == 6)){
				_rtn = "<img src=" + _url + "/" + _value + ".png>";
			}
		}
		return _rtn;
	}


	public String getYabauCheck(int _kind){
		String _str = "";
		switch(_kind){
			case 1:		_str = "리스트 갱신("+_kind+")";	break;
			case 2:		_str = "일반 주사위("+_kind+")";	break;
			case 3:		_str = "수정 주사위("+_kind+")";	break;
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
			case 1:		_str = "일반D,C("+_flag+")";			break;
			case 2:		_str = "<font color=blue>캐쉬B,A("+_flag+")</font>";		break;
			case 3:		_str = "<font color=green>캐쉬A,S("+_flag+")</font>";		break;
			case 4:		_str = "<font color=red>캐쉬A,S("+_flag+")(3+1)</font>";	break;
			case 12:	_str = "무료B,A("+_flag+")";								break;
			case 13:	_str = "무료A,S("+_flag+")";								break;
			case 14:	_str = "무료A,S("+_flag+")(3+1)";							break;
			case 22:	_str = "<font color=blue>티켓B,A("+_flag+")</font>";		break;
			case 23:	_str = "<font color=green>티켓A,S("+_flag+")</font>";		break;
			case 24:	_str = "<font color=red>티켓A,S("+_flag+")(3+1)</font>";	break;
			default:	_str = "모름(" + _flag + ")"; 	break;
		}
		return _str;
	}

	public String getRankResult(int _flag){
		String _str = "";
		switch(_flag){
			case 1:		_str = "<font color=blue>랭킹보여주세요("+_flag+")</font>";			break;
			default:	_str = "<font color=red>랭킹이미봄(" + _flag + ")</font>"; 	break;
		}
		return _str;
	}


	public String getStringDivide(int _size, String _str){
		if(_str != null){
			int _len = _str.length();
			String _tmp = "";
			int _p = 0;
			while(_len > _size){
				_tmp += _str.substring(0, _size) + "<br>";
				_str = _str.substring(_size, _len);
				_len -= _size;

			}
			_tmp += _str + "<br>";

			_str = _tmp;
			/**/
		}
		return _str;
	}


	public String getLogWrite2(int _flag){
		String _str = "";
		switch(_flag){
			case  1:		_str = "<font color=red>로고기록중...("+_flag+")</font>";	break;
			case -1:		_str = "<font color=gray>로고기록안함("+_flag+")</font>";	break;
			default:	_str = "모름(" + _flag + ")"; 	break;
		}
		return _str;
	}

	public String getTSMode(int _val){
		String _str = "";
		switch(_val){
			case 1:		_str = "일반강화("+_val+")";							break;
			case 2:		_str = "<font color=blue>결정강화("+_val+")</font>";	break;
			default:	_str = "모름(" + _val + ")"; 							break;
		}
		return _str;
	}

	public String getWheelMode(int _val){
		String _str = "";
		switch(_val){
			case 20:		_str = "일일룰렛("+_val+")";													break;
			case 21:		_str = "<font color=blue>결정룰렛("+_val+")</font>";	break;
			case 22:		_str = "<font color=gray>황금무료("+_val+")</font>";	break;
			default:	_str = "모름(" + _val + ")"; 							break;
		}
		return _str;
	}



	public String getTSResult(int _val){
		String _str = "";
		switch(_val){
			case  1:	_str = "<font color=blue>강화성공("+_val+")</font>";	break;
			case -1:	_str = "<font color=gray>강화실패("+_val+")</font>";	break;
			default:	_str = "모름(" + _val + ")"; 							break;
		}
		return _str;
	}


	public String getTSStrange(int _val){
		String _str = "";
		switch(_val){
			case  1:	_str = "<font color=red>이상함("+_val+")</font>";		break;
			case -1:	_str = "정상("+_val+")";								break;
			case -2:	_str = "강제정상("+_val+")";							break;
			default:	_str = "모름(" + _val + ")"; 							break;
		}
		return _str;
	}

	public String getGameid(String _id){
		if(_id == null){
			_id = "";
		}else if(_id != null && _id.equals("null")){
			_id = "";
		}
		return _id;
	}

	public String getPart(String _src, String _tar, String _label){
		int _pos1, _pos2;

		_pos1 = _src.indexOf(_tar) + _tar.length();
		_pos2 = _src.indexOf("%", _pos1);
		if(_pos1 == -1 || _pos2 == -1)return "";


		_src = _src.substring(_pos1, _pos2);

		return _label + ":" + _src + "<br>";
	}

	public String getPart4(String _src, String _tar, String _label){
		int _pos1, _pos2;

		_pos1 = _src.indexOf(_tar) + _tar.length();
		_pos2 = _src.indexOf("%", _pos1);
		if(_pos1 == -1 || _pos2 == -1)return "";

		_src = _src.substring(_pos1, _pos2);

		return _label + ":" + _src;
	}

	public String getPart2(String _src, String _tar, String _label){
		int _pos1, _pos2;

		_pos1 = _src.indexOf(_tar) + _tar.length();
		_pos2 = _src.indexOf("%", _pos1);
		if(_pos1 == -1 || _pos2 == -1)return "";

		_src = _src.substring(_pos1, _pos2);
		long i = Long.parseLong(_src);
		java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");


		return _label + ":" + df.format(i) + "<br>";
	}

	public String getPart3(String _src, String _tar, String _label){
		int _pos1, _pos2;

		_pos1 = _src.indexOf(_tar) + _tar.length();
		_pos2 = _src.indexOf("%", _pos1);
		if(_pos1 == -1 || _pos2 == -1)return "";

		_src = _src.substring(_pos1, _pos2);
		String _list[] = _src.split(",");
		String _rtn = "";
		if(_list != null && _list.length >= 16){
			_rtn = _list[15];
		}

		return _label + ":" + _rtn + "<br>";
	}

	public String getParseData(String _src){
		String _rtn = "";

		//코인
		_rtn += getPart2(_src, "14:", "코인");
		_rtn += getPart2(_src, "%13:", "VIP");
		_rtn += getPart(_src, "%9:", "유제품(유제품은 젤뒤에)");
		_rtn += getPart3(_src, "%9:", "결정");
		_rtn += getPart(_src, "%18:", "탱크") + "<br>";

		_rtn += getPart(_src, "%21:", "결정변환기(언락)");
		_rtn += getPart(_src, "%22:", "알바부스터(언락)");
		_rtn += getPart(_src, "%2:",  "알바부스터(단계)");
		_rtn += getPart(_src, "%23:", "동물촉진제(언락)");
		_rtn += getPart(_src, "%25:", "동물촉진제(단계)");
		_rtn += getPart(_src, "%260:","비료(언락)");
		_rtn += getPart(_src, "%250:","비료(단계)");
		_rtn += getPart(_src, "%70:", "사냥총(단계)") + "<br>";

		_rtn += getPart(_src, "%201:","사료창고단계");
		_rtn += getPart(_src, "%210:","보관량");
		_rtn += getPart(_src, "%221:","사료창고 보관보너스단계") + "<br>";

		_rtn += getPart(_src, "%16:", "집");
		_rtn += getPart(_src, "%6:", "년도");
		_rtn += getPart(_src, "%3:", "알바") + "<br>";

		_rtn += getPart(_src, "%17:", "필드");
		_rtn += getPart(_src, "%4:", "동물") + "<br>";

		_rtn += getPart(_src, "%85:", "경작지상태");
		_rtn += getPart(_src, "%86:", "경작지단계")+ "<br>";
		//_rtn += getPart(_src, "%88:", "경작지업글시간");
		//_rtn += getPart(_src, "%93:", "경작지작물정보");

		_rtn += getPart(_src, "%19:", "보유목장");
		_rtn += getPart2(_src, "%24:", "총판매코인");
		_rtn += getPart(_src, "%30:", "생에 첫결제");
		_rtn += getPart(_src, "%400:", "보물^강화");
		/**/

		return _rtn;
	}

	public String getRouletteState(int _flag){
		String _str = "";
		switch(_flag){
			case 1:		_str = "뽑기할수있음("+_flag+")";	break;
			case -1:	_str = "뽑기했음("+_flag+")";		break;
			default:	_str = "모름(" + _flag + ")"; 		break;
		}
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

	public String getRKTeam(int _flag){
		String _str = "";
		switch(_flag){
			case 0:		_str = "짝팀("+_flag+")";	break;
			case 1:		_str = "홀팀("+_flag+")";	break;
			default:	_str = "미정(" + _flag + ")[로그인하면 결정됨]";break;
		}
		return _str;
	}

	public String getCheckRKTeam(int _rkteam1, int _rkteam0){
		String _str = "" ;
		if(_rkteam1 > _rkteam0){
			_str = "<font color=red>홀(" + _rkteam1 + ")</font>  > 짝(" + _rkteam0 + ")";
		}else if(_rkteam1 < _rkteam0){
			_str = "홀(" + _rkteam1 + ")  < <font color=blue>짝(" + _rkteam0 + ")</font> ";
		}else{
			_str += "무승부";
		}
		return _str;
	}

	public String getCheckRKTeam2(long _val1, long _val0){
		String _str = "" ;
		if(_val1 > _val0){
			_str = "<font color=red>홀(" + displayMoney(_val1) + ")</font>  > 짝(" + displayMoney(_val0) + ")";
		}else if(_val1 < _val0){
			_str = "홀(" + displayMoney(_val1) + ")  < <font color=blue>짝(" + displayMoney(_val0) + ")</font> ";
		}else{
			_str = "홀(" + displayMoney(_val1) + ")  (무승부) 짝(" + displayMoney(_val0) + ") ";
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

	public String getCategoryUnit(int _cat){
		String _str = "개";
		if(_cat == 31){
			_str = "코인";
		}else if(_cat == 80){
			_str = "강화";
		}
		return _str;
	}
%>