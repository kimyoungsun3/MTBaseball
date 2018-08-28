//작성자 : 박세계
//목적	: 지정한 가로사이즈 보다 이미지가 크면 원하는 크기에 맞춰줌
//사용법 : <img src="이미지명" onload="setSize(this, 435, 300)">	-> 435 초과될 경우 가로 300 고정
//			: <img src="이미지명" onload="setSize(this, 435)">			-> 435 초과될 경우 가로 435 고정
function setSize(obj, maxWidth, sWidth) {
	if (sWidth == null)
		sWidth = maxWidth;

	if (obj.width > maxWidth)
		obj.width = sWidth;
}

//작성자 : 박세계
//목적	: 지정한 영역의 텍스트 크기를 작게/크게하기 (pt/px등의 단위 알아서 판단)
//사용법 :
//		<a href="javascript:ViewSize(View, 'm', 8)">글자작게 (최소8)</a>
//		<a href="javascript:ViewSize(View, 'p', 15)">글자크게 (최대15)</a>
//		<div id="View" style="font-size:9pt">해당내용</div>
function ViewSize(area, flag, limitSize) {
	var fontSize = parseInt(area.style.fontSize);
	var fontUnit = area.style.fontSize.substring(fontSize.toString().length);

	if (isNaN(fontSize)) {
		fontSize	= 12;
		fontUnit	= "pt";
	}

	if (flag == "m") {
		if (limitSize != fontSize)
			area.style.fontSize = (fontSize - 1) + fontUnit;
		else
			alert("글자크기를 더이상 작게 할 수 없습니다.");
	}
	else {
		if (limitSize != fontSize)
			area.style.fontSize = (fontSize + 1) + fontUnit;
		else
			alert("글자크기를 더이상 크게 할 수 없습니다.");
	}
}

//작성자 : 박세계
//목적	: 날짜의 형식이 올바른지 체크 (형식 올바른경우 true)
//			: 2004-02-31 등의 없는날짜 체크를 위함임
//비고	: ASP에서는 isDate("2004-02-31") 방식으로 체크가 가능
function dateChk(chkYear, chkMonth, chkDay) {
	var chkDate = new Date(chkYear, chkMonth-1, chkDay);

	if (chkDate) {
		chkYear	= parseInt(chkYear);
		chkMonth	= parseInt(chkMonth-1);
		chkDay	= parseInt(chkDay);

		if (chkYear != chkDate.getFullYear() || chkMonth != chkDate.getMonth() || chkDay != chkDate.getDate())
			return false;
		else
			return true;
	}
	else {
		return false;
	}
}

//작성자	: 김은미
//목적	: winPopup을 위함
function winOpenPop(rURL, Target, W, H, Scrolls) {
	var openWin = window.open(rURL, Target, "width="+W+",height="+H+",left=100,top=200,scrollbars="+Scrolls);
	openWin.focus();
}

//작성자	: 박세계
//목적	: 이미지 클릭시 크기에 맞게 팝업창 열리게 하기
//사용법: <img src="이미지명" onclick="All_Image(this)">
function All_Image(imgURL) {
	winOpenPop("/common/imgView.asp?imgURL=" + imgURL.src, "imgView", 100, 100, "no,resizable=yes");
}

//작성자	: 김은미
//수정자	: 박세계
//목적	: trim 함수임
function trim(str) {
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

//작성자	: 김은미
//목적	: Ctrl+N, F5 막기
//사용법	: <body onkeydown="return checkKey();">
function checkKey() {
	//Ctrl+N, F5 막기
	if ((event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode >= 112 && event.keyCode <= 123)) {
		//return false;
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
	return true;
}

//작성자	: 박세계
//목적	: 어떠한 경우에도 창닫기 여부 물어보지 않고 강제로 창닫기
//사용법	: <a href="JavaScript:winClose()">창닫기</a>
function winClose() {
	self.opener = self;
	top.window.close();
}

//작성자 : 박세계
//목적	: 해당 쿠키명으로 값 리턴
//사용법	: document.write(getCookieVal("쿠키명", "서브쿠키명(없을시 생략가능)"))
function getCookieVal(cookieName, subCookieName) {
	//쿠키값 저장
	var cookieVal = document.cookie;

	//쿠키명이 맨처음에 있지 않을경우로 먼저 판단, 시작지점 인덱스 구함
	var cookieStartAt = cookieVal.indexOf(" " + cookieName + "=");
	var cookieEndAt;

	//서브쿠키 생략될 경우 공백지정 (trim 함수사용시 에러방지)
	if (subCookieName == null)
		subCookieName = "";

	//쿠키, 서브쿠키 trim처리
	cookieName		= trim(cookieName);
	subCookieName	= trim(subCookieName);

	//시작지점 인덱스 없을시 맨처음에 있다고 판단, 다시 시작지점 인덱스 구함
	if (cookieStartAt == -1)
		cookieStartAt = cookieVal.indexOf(cookieName + "=");

	//시작지점 인덱스 있을경우 처리
	if (cookieStartAt != -1) {
		//쿠키값에 해당하는 시작과 끝지점의 인덱스 구함
		cookieStartAt 	= cookieVal.indexOf("=", cookieStartAt) + 1
		cookieEndAt	= cookieVal.indexOf("; ", cookieStartAt);

		//끝지점 인덱스 없을시 쿠키가 하나이거나 마지막 값으로 판단
		if (cookieEndAt == -1)
			cookieEndAt = cookieVal.length;

		//쿠키값 구하기
		cookieVal = cookieVal.substring(cookieStartAt, cookieEndAt);

		if (subCookieName == "") {
			//서브쿠키 값을 원하지 않을시 해당 쿠키값 디코딩하여 리턴
			cookieVal = unescape(cookieVal);
		}
		else {
			//서브쿠키 값을 원할경우

			//서브쿠키명이 맨처음에 있지 않을경우로 먼저 판단, 시작지점 인덱스 구함
			cookieStartAt = cookieVal.indexOf("&" + subCookieName + "=");

			//시작지점 인덱스 없을시 맨처음에 있다고 판단, 다시 시작지점 인덱스 구함
			if (cookieStartAt == -1)
				cookieStartAt = cookieVal.indexOf(subCookieName + "=");

			//시작지점 인덱스 있을경우 처리
			if (cookieStartAt != -1) {
				//서브쿠키값에 해당하는 시작과 끝지점의 인덱스 구함
				cookieStartAt 	= cookieVal.indexOf("=", cookieStartAt) + 1
				cookieEndAt	= cookieVal.indexOf("&", cookieStartAt);

				//끝지점 인덱스 없을시 서브쿠키가 하나이거나 마지막 값으로 판단
				if (cookieEndAt == -1)
					cookieEndAt = cookieVal.length;

				//서브쿠키값 구하기
				cookieVal = unescape(cookieVal.substring(cookieStartAt, cookieEndAt));
			}
			else {
				cookieVal = null;
			}
		}
	}
	else {
		cookieVal = null;
	}

	return cookieVal;
}

//작성자	: 김은미
//수정자	: 박세계
//목적	: iframe 로딩 시 Resize
//사용법	: <iframe name="ifrm" onload="reSize(this.name)">
function reSize(f) {
	var objBody	= eval(f + ".document.body");
	var objFrame	= document.all[f];

	objFrame.style.height = objBody.scrollHeight + (objBody.offsetHeight - objBody.clientHeight) + 2;
}

//작성자		: 박세계
//목적		: Replace 함수
//주의사항	: 파라미터에 정규식에 해당하는 특수문자가 포함되면 대략낭패 (정규식으로 인식하기 때문 - 차후개선예정)
//사용 방법	:
//	str_replace("aaAA bbb", "aa", "cc")			-> 결과 : "ccAA bbb" (대소문자 구별함 - Default)
//	str_replace("aaAA bbb", "aa", "cc", "i")	-> 결과 : "cccc bbb" (대소문자 구별안함)
function str_replace(str, old_str , new_str, i) {
	var expStr;

	if (i == "i") {
		//대소문자 구별안함
		expStr = eval("/" + old_str + "/gi");
	}
	else {
		//대소문자 구별
		expStr = eval("/" + old_str + "/g");
	}

	return str.replace(expStr, new_str);
}

//------------ 글자수 byte단위로 계산하고 잘라주는 함수 시작 ------------------//
//작성자	: 박세계
//사용예	: <textarea name="tmpTxt" onKeyUp="byteChk(this, nowLenTxt, 2000)"></textarea>
//
//		현재 <span id="nowLenTxt">0</span>/최대 2000byte
//		(현재 byte 상황을 표시하지 않으려면 byteChk(this, null, 2000)을 사용)
//
//		★ 반드시 폼 전송시 체크하는 함수 부분에 다음코드 삽입 ★
//		★ (한글 입력시 이벤트 만으로는 완벽하게 체크를 못하는 경우가 발생하기 때문) ★
//
//		if (!byteChk(폼이름.tmpTxt, nowLenTxt, 2000)) {
//			return false;
//		}
//
//		※ 사용법이 다소 복잡하니 문의사항이 있으시면 세계로 ※

function byteChk(chkInput, nowLen, maxLen, pm) {
	var length = calculate_msglen(chkInput.value);

	if (nowLen != null) {
		if (pm == "p")	//점점 증가되는..
		{
			nowLen.innerText = length;
		}else{			//점점 감소되는..
			nowLen.innerText = maxLen - length;
		}
	}

	if (length > maxLen) {
		alert("최대 " + maxLen + "byte이므로 초과된 글자 수는 자동으로 삭제됩니다.");
		chkInput.value = chkInput.value.replace(/\r\n$/, "");
		chkInput.value = assert_msglen(chkInput.value, nowLen, maxLen);

		chkInput.focus();

		return false;
	}
	else {
		return true;
	}
}

function calculate_msglen(message) {
	var nbytes = 0;

	for (i=0; i<message.length; i++) {
		var ch = message.charAt(i);
		if (escape(ch).length > 4) {
			nbytes += 2;
		} else {
			nbytes += 1;
		}
	}

	return nbytes;
}

function assert_msglen(message, nowLen, maxLen) {
	var inc = 0;
	var nbytes = 0;
	var msg = "";
	var msglen = message.length;

	for (i=0; i<msglen; i++) {
		var ch = message.charAt(i);
		if (escape(ch).length > 4) {
			inc = 2;
		} else {
			inc = 1;
		}
		if ((nbytes + inc) > maxLen) {
			break;
		}
		nbytes += inc;
		msg += ch;
	}

	if (nowLen != null) {
		nowLen.innerText = nbytes;
	}

	return msg;
}
//------------ 글자수 byte단위로 계산하고 잘라주는 함수 끝 ------------------//

//작성자	: 박세계
//목적	: 메일 형식 체크 (형식이 유효할 경우 true)
//유효형식: xx@yyy.zzz (영문, 숫자, 언더바(_), 마침표(.), 대쉬(-)만 허용)
function emailCheck(email) {
	var chkExp = /^\s*[\w\-\.]+\@[\w\-]+(\.[\w\-]+)+\s*$/g;
	return chkExp.test(email);
}

//작성자	: 박세계
//목적	: 등록금지 이메일 체크 (등록금지 이메일일 경우 alert창에 경고메시지 출력 후 true)
function invalidEmailCheck(email) {
	var invalidEmail		= new Array();
	var tempStr		= email.split("@");

	invalidEmail[0]		= new Array();
	invalidEmail[0][0]	= "hanmail.net";
	invalidEmail[0][1]	= "한메일넷";
	invalidEmail[1]		= new Array();
	invalidEmail[1][0]	= "daum.net";
	invalidEmail[1][1]	= "다음넷";

	for (i=0; i<invalidEmail.length; i++) {
		if (trim(tempStr[1])== invalidEmail[i][0]) {
			alert("온라인 우표제의 시행으로 인해 " + invalidEmail[i][1] + "(" + invalidEmail[i][0] + ")은 등록하실 수 없습니다.");
			return true;
		}
	}

	return false;
}

//작성자	: 박세계
//목적	: 탭 자동이동 (시작개체, 이동할개체, 지정입력수)
//사용예	: <input type="text" name="tel2" size=4 maxlength=4 onKeyUp="tabMove(this, memTel3, 4)">
function tabMove(fromInput, toInput, num) {
	if (trim(fromInput.value).length == num) {
		toInput.focus();
	}
}

//작성자	: 박세계
//목적	: 각종 필드에서 숫자만 입력 가능하게 제한 (값이 없거나 자릿수에 맞는 숫자일 경우 true)
//사용법	: <input type="text" name="tel2" size=4 maxlength=4 onblur="numChk(this, '전화번호', 3, 4)">
function numChk(obj, objName, minNum, maxNum) {
	var numVal = trim(obj.value);
	var numLen= numVal.length;

	if (numVal != "") {
		if (isNaN(numVal)) {
			alert(objName + "(은)는 숫자만 입력해 주시기 바랍니다.");
			obj.value="";
			obj.focus();
			return false;
		}

		if (minNum != maxNum) {
			if (numLen < minNum || numLen > maxNum) {
				alert(objName + "(은)는 " + minNum + "~" + maxNum + "자리의 범위내로 입력하여 주시기 바랍니다.");
				obj.value="";
				obj.focus();
				return false;
			}
		}
		else {
			if (numLen != minNum) {
				alert(objName + "(을)를 " + minNum + "자리로 정확히 입력하여 주시기 바랍니다.");
				obj.value="";
				obj.focus();
				return false;
			}
		}
	}

	return true;
}

// 스크롤바 있는 POP_UP
function f_open_win(url, w, h) {
	var win = window.open(url, "winname", "resizable=no,scrollbars=yes,x=100,y=200,width=" + w + ",height=" + h);
	win.focus();
}

// 스크롤바 없는 POP_UP
function f_open_win2(url, w, h) {
	var win = window.open(url, "winname", "resizable=no,scrollbars=no,x=100,y=200,width=" + w + ",height=" + h);
	win.focus();
}

// NULL 여부 테크
function f_nul_chk(obj, lbl) {
	if (trim(obj.value) == "") {
		alert("필수항목 " + lbl + " 입력하십시오.");
		obj.focus();
		return true;
	}
	return false;
}

// 길이 체크
function f_len_chk(obj, lbl, num) {
	if (trim(obj.value).length < num) {
		alert(lbl + " " + num + "문자 이상 입력하십시오.");
		obj.focus();
		return true;
	}
	return false;
}

function f_rdb_chk2(obj, msg, num, obj2) {
	var i, flag = 0;
	for (i = 0; i < obj.length; i++) {
		if (obj[i].checked) {
			flag = 1;
			if ((i == (num - 1)) && (trim(obj2.value)=="")) {
				alert (msg + "의 기타을 입력해 주세요.");
				obj2.focus();
				return true;
			}
		}
	}
	if (flag != 1) {
		alert("필수항목인 " + msg + " 입력해주십시오.");
		obj[0].focus();
		return true;
	}
	return false;
}

// 숫자 여부 체크
function f_is_num(obj, lbl) {
	var nVal = trim(obj.value);

	if (isNaN(nVal)) {
		alert(lbl + " 숫자만 입력할 수 있습니다.");
		obj.focus();
		return true;
	}

	return false;
}

function f_peop_no_chk(ssn1, ssn2){
	var i;
	var chk=0;
	var nowYear = String(new Date().getYear());
	var nYear = ssn1.substring(0,2);
	var nMonth = ssn1.substring(2,4);
	var nDay = ssn1.substring(4,6);
	var nSex = ssn2.charAt(0);
	var endDay = 31;

	if (ssn1 == "" || ssn2 == "")
	{
		return false;
	}
	if (ssn1.length!=6) {
		return false;
	}
	
	if (ssn2.length!=7) {
		return false;
	}

	if (parseInt(nYear, 10) > parseInt(nowYear.substring(2,4), 10)) {
		nYear = parseInt("19" + String(nYear), 10);
	}else{
		nYear = parseInt("20" + nYear, 10);
	}
	if ((nYear < 2000) && (nSex != "1") && (nSex != "2")) {		
		return false;
	}		
	if ((nYear >= 2000) && (nSex != "3") && (nSex != "4")) {
		return false;
	}

	if (parseInt(nMonth, 10) > 12 || parseInt(nMonth, 10) < 1) {
		return false;
	}					

	if (nMonth == "02" && ((nYear%400) == 0 || ((nYear%100) > 0 && (nYear%4) == 0))) {
		endDay = 29;
	}else if (nMonth == 2)
	{
		endDay = 28;
	}

	if (nMonth =="04") endDay = 30;
	if (nMonth =="06") endDay = 30;
	if (nMonth =="09") endDay = 30;
	if (nMonth =="11") endDay = 30;

	if (parseInt(nDay, 10) > endDay || parseInt(nDay, 10) < 1) {
		return false;
	}			
	
	for (i=0; i<6; i++) {
		chk += ( (i+2) * parseInt( ssn1.charAt(i) ));
	}
	
	for (i=6; i<12; i++) {
		chk += ( (i%8+2) * parseInt( ssn2.charAt(i-6) ));
	}
	
	chk = 11 - (chk%11);
	chk %= 10;
	
	if (chk != parseInt( ssn2.charAt(6))) {
		return false;
	}
	else {
		return true;
	}
}

// 라디오 버튼 체크
function f_rdb_chk(obj, msg) {
	var i, flag = 0;
	for (i = 0; i < obj.length; i++) {
		if (obj[i].checked)
			flag = 1;
	}
	if (flag != 1) {
		alert("필수항목인 " + msg + " 입력해주십시오.");
		obj[0].focus();
		return true;
	}
	return false;
}

function f_byte_chk(obj, nByte, lbl) {
	with(Math) {

		var nLength = obj.value.length;
		var nCnt = 0;
		var nHan, nTemp, sTemp;

		// 한글 문자수 계산(버림)
		nHan	= nByte / 2;
		nTemp = round(nHan);

		if (nHan != nTemp)
			nHan = nTemp - 1;

		for (i = 0; i < nLength; i++) {
			sTemp = escape(obj.value.substring(i, i+1));
			if (sTemp.substring(1,2) == "u" || parseInt(sTemp.substring(1,3), 16) > 127)
				nCnt += 2;
			else
				nCnt += 1;
		}
		if (nCnt > nByte) {
			alert(lbl + " 한글 " + nHan + " 자, 영문 " + nByte + " 자 이내로 입력하십시오.");
			obj.focus();
			return true;
		}
		return false;
	}
}

function f_is_email(s) {
	var sChk = "";
	var nCnt = 0;
	var nLen = s.length;
	var regDoNot = /(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/;
//	var regMust = /^[a-zA-Z0-9\-\.\_]+\@[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3})$/;
	var regMust = /^[-a-zA-Z0-9_]+@([-a-zA-Z0-9]+\.)+[a-zA-Z]{2,3}$/;

	if (s.indexOf(" ") != -1 || s.indexOf("<") != -1 || s.indexOf(">") != -1) {
		return false;
	}

	if (s.indexOf("@") == -1) {
		return false;
	}

	if (s.indexOf(".") == -1) {
		return false;
	}

	if (s.indexOf(".") - s.indexOf("@") == 1) {
		return false;
	}

	if (s.charAt(s.length-1) == ".") {
		return false;
	}

	if (s.charAt(s.length-1) == "@") {
		return false;
	}

	if (s.length < 7) {
		return false;
	}
	else {
		for (i = 0 ; i < nLen ; i++) {
			temp = s.substring(i,i+1);
			if ((temp == "@" && i < 2) || (temp == "." && i < 4)) {
				return false;
			}
			else {
				if (temp == "@" || temp == ".") sChk = sChk + temp;
			}
		}
		if (sChk.substring(0,2) == "@.") {
			if (!regDoNot.test(s) && regMust.test(s))
				return true;
			else
				return false;
		}
		else
			return false;
	}
}

function f_chb_chk(obj, msg) {
	var i, flag = 0;
	for (i = 0; i < obj.length; i++) {
		if (obj[i].checked)
			flag = 1;
	}
	if (flag != 1) {
		alert("필수항목인 " + msg + " 입력해주십시오.");
		obj[0].focus();
		return true;
	}
	return false;
}

function f_spcl_chk(obj, lbl) {
	with(Math) {
		var nVal		= trim(obj.value);
		var nLength = nVal.length;

		for (i = 0; i < nLength; i++) {
			 if (((nVal.charCodeAt(i) >=  0)  && (nVal.charCodeAt(i) <  48)) ||
					((nVal.charCodeAt(i) >  57) && (nVal.charCodeAt(i) <  65)) ||
					((nVal.charCodeAt(i) >  90) && (nVal.charCodeAt(i) <  97)) ||
					((nVal.charCodeAt(i) > 122) && (nVal.charCodeAt(i) < 128)) ||
					((nVal.charCodeAt(i) >= 0xD7A4) && (nVal.charCodeAt(i) <= 0xF8FF)) ||
					((nVal.charCodeAt(i) >= 0xFA0C)))
			{
				alert(lbl + "공백이나 특수문자가 들어갈 수 없습니다");
				obj.focus();
				return true;
			}
		}
		return false;
	}
}

function f_name_spcl_chk(obj, lbl) {
	with(Math) {
		var nVal		= trim(obj.value);
		var nLength = nVal.length;

		for (i = 0; i < nLength; i++) {
			ch = nVal.charCodeAt(i);
			if ((ch >= 97 && ch <= 122) || (ch >= 65 && ch <= 90) || (ch == 32) || (ch >= 0xAC00 && ch <= 0xD7A3)) {
				continue;
			}
			else
			{
				alert(lbl + " 영문이나 한글만 입력이 가능합니다.");
				obj.focus();
				return true;
			}
		}
		return false;
	}
}

function f_is_parent(obj1, obj2, num) {
	var Today		= new Date();
	var CurrYear	= Today.getYear();
	var CurrAge;

	if (CurrYear < 1900) {
		CurrYear = CurrYear + 1900;
	}

	if (obj2.value.substring(0, 1) == "1" || obj2.value.substring(0, 1) == "2") {
		CurrAge = CurrYear - parseInt("19" + obj1.value.substring(0, 2));
	}
	else if (obj2.value.substring(0, 1) == "3" || obj2.value.substring(0, 1) == "4") {
		CurrAge = CurrYear - parseInt("20" + obj1.value.substring(0, 2));
	}
	else {
		alert("잘못된 주민번호입니다.\n다시 확인해 주세요.");
		return true;
	}

	if (CurrAge < num) {
		alert("보호자는 만 " + num + "세 이상만 가능합니다.");
		return true;
	}
	return false;
}

function f_is_age(obj1, obj2, num, flag)
{
	Today     = new Date();
   CurrYear  = Today.getYear();
	CurrMonth = Today.getMonth() + 1;
	CurrDay   = Today.getDate();

   if (CurrYear < 1900) {
      CurrYear = CurrYear + 1900;
   }

	if (obj2.value.substring(0, 1) == "1" || obj2.value.substring(0, 1) == "2" )
	{
		CurrAge = CurrYear - parseInt("19" + obj1.value.substring(0, 2));
	}
	else if (obj2.value.substring(0, 1) == "3" || obj2.value.substring(0, 1) == "4" )
	{
		CurrAge = CurrYear - parseInt("20" + obj1.value.substring(0, 2));
	}
	else
	{
		alert('잘못된 주민번호입니다.\n다시 확인해 주세요.');
		return true;
	}

	if (flag == 1)
	{
		if (CurrAge < num)
		{
			alert('지금 가입하고 계신 회원가입은 만 ' + num + '세 이상만 가입 가능합니다.');
			return true;
		}
	}
	else
	{
		if (CurrAge >= num)
		{
			alert('지금 가입하고 계신 회원가입은 만 ' + num + '세 미만이 가입 가능합니다.');
			return true;
		}
	}
	return false;
}

function f_is_valid_date(stringValue, flag) 
{
	if ((flag != -1) && (flag != 0) && (flag != 1))
		return false;

	var theString = new String(stringValue);
		
	// determine the delimiter character (must be "/" "-" or space)
	var delimiterCharacter

	if ( theString.indexOf('/') > 0 )
		delimiterCharacter = '/';
	else
		if ( theString.indexOf('-') > 0 )
			delimiterCharacter = '-';
		else
			if ( theString.indexOf(' ') > 0 )
				delimiterCharacter = ' ';
			else
				return false;
					
	// split the string into an array of tokens
	var theTokens = theString.split(delimiterCharacter);
	
	// there must be either two or three tokens
	if ( theTokens.length != 3)
		return false;
		
	// convert the tokens to String objects, which will be needed later,
	// stripping a single leading 0
	var tokenIndex;
        
	for ( tokenIndex = 0; tokenIndex < theTokens.length; tokenIndex++ ) {
		theTokens[tokenIndex] = new String(theTokens[tokenIndex])			
		if ( theTokens[tokenIndex].charAt(0) == '0' )
			theTokens[tokenIndex] = theTokens[tokenIndex].substring(1, theTokens[tokenIndex].length);

		numericValue = parseInt(theTokens[tokenIndex]);
		if ((tokenIndex == 0) && ((numericValue < 1900) || (numericValue > 9999))) {
			return false;
		}
		else {
			if ((tokenIndex == 1) && ((numericValue < 1) || (numericValue > 12))) {
				return false;
			}    
			else {
				if ((tokenIndex == 2) && ((numericValue < 1) || (numericValue > 31))) 
					return false;
			}
		}
	}

	// make sure it's a valid date (we were testing days using a value
	// of 31, and that might be too many for the actual month)
   if  (!f_is_date(theTokens[0], theTokens[1], theTokens[2]))
   	return false;
        
	Today     = new Date();
	CurrYear  = Today.getYear();
	if (CurrYear < 1900) {
		CurrYear = CurrYear + 1900;
	}          
	CurrMonth = Today.getMonth() + 1;
	CurrDay   = Today.getDate();

	if  (flag == 0) 
		return true;
	else {
		if  (flag == -1) {
			if (parseInt(theTokens[0]) > CurrYear) {
				return false;
			}
			else {
				if (parseInt(theTokens[0]) == CurrYear) {
					if (parseInt(theTokens[1]) > CurrMonth)
						return false;
					else
						if (parseInt(theTokens[1]) == CurrMonth)
							if (parseInt(theTokens[2]) > CurrDay)
								return false;
				}
			}                     
		}
		else {
			if (parseInt(theTokens[0]) < CurrYear) {
				return false;
			}
			else {
				if (parseInt(theTokens[0]) == CurrYear) {
					if (parseInt(theTokens[1]) < CurrMonth)
						return false;
					else
						if (parseInt(theTokens[1]) == CurrMonth)
							if (parseInt(theTokens[2]) < CurrDay)
								return false;
				}
			}                     
		}
	}    
	return true;
}

function f_nul_num2(obj1, obj2, obj3, obj4, obj5, obj6)
{
	if(obj1.value == '' && obj4.value == '')
	{
		alert('전화번호는 적어도 한가지는 입력하셔야 합니다.');
		obj1.focus();
		return true;
	}
		
	if(obj1.value != '')
	{
		if(obj2.value == '')
		{
			alert('이동통신번호 정확하게 입력하셔야 합니다.');
			obj2.focus();
			return true;
		}
		else if(obj3.value == '')
		{
			alert('이동통신번호 정확하게 입력하셔야 합니다.');
			obj3.focus();
			return true;
		}
		else
			return false;
		return true;
	}
	
	if(obj4.value != '')
	{
		if(obj5.value == '')
		{
			alert('집전화번호를 정확하게 입력하셔야 합니다.');
			obj5.focus();
			return true;
		}
		else if(obj6.value == '')
		{
			alert('집전화번호를 정확하게 입력하셔야 합니다.');
			obj6.focus();
			return true;
		}
		else
			return false;
		return true;
	}

	return false;
}

function f_is_date(year, month, day)
{
	var daysInMonth = f_make_array(12);
			daysInMonth[1] = 31;
			daysInMonth[2] = 29;
			daysInMonth[3] = 31;
			daysInMonth[4] = 30;
        	daysInMonth[5] = 31;
        	daysInMonth[6] = 30;
        	daysInMonth[7] = 31;
        	daysInMonth[8] = 31;
        	daysInMonth[9] = 30;
        	daysInMonth[10] = 31;
        	daysInMonth[11] = 30;
        	daysInMonth[12] = 31;

            
 	var intYear  = parseInt(year);
	var intMonth = parseInt(month);
	var intDay   = parseInt(day);
	if ( intDay > daysInMonth[intMonth] ) return false; 
	if ( ( intMonth == 2 ) && ( intDay > f_days_in_february(intYear) ) ) return false;
	return true;
 }
 
 function f_make_array(n) 
{
	for ( var i = 1; i <= n; i++ ) {
		this[i] = 0
	} 
	return this
}

function f_days_in_february(year) 
{
	return ( ((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}


//작성자	: 임은희
//목적	: 사업자등록번호체크(10자리의 번호)
function f_chk_businno(businno) 
{ 
	  if (businno.length != 10) 
	  { 
			 alert("사업자등록번호가 잘못되었습니다."); 
			 return false; 
	  } 
			
	  var sumMod = 0; 
	  sumMod += parseInt(businno.substring(0,1)); 
	  sumMod += parseInt(businno.substring(1,2)) * 3 % 10; 
	  sumMod += parseInt(businno.substring(2,3)) * 7 % 10; 
	  sumMod += parseInt(businno.substring(3,4)) * 1 % 10; 
	  sumMod += parseInt(businno.substring(4,5)) * 3 % 10; 
	  sumMod += parseInt(businno.substring(5,6)) * 7 % 10; 
	  sumMod += parseInt(businno.substring(6,7)) * 1 % 10; 
	  sumMod += parseInt(businno.substring(7,8)) * 3 % 10; 
	  sumMod += Math.floor(parseInt(businno.substring(8,9)) * 5 / 10); 
	  sumMod += parseInt(businno.substring(8,9)) * 5 % 10; 
	  sumMod += parseInt(businno.substring(9,10)); 
			
	  if (sumMod % 10 != 0) 
	  { 
			 alert("사업자등록번호가 잘못되었습니다."); 
			 return false; 
	  } 
	  return true; 
} 

//작성자	: 임은희
//목적	: 전화번호 체크(형식이 유효할 경우 true)
function f_chk_telno(str)
{
	var chkExp = /0\d{1,2}-\d{3,4}-\d{4}\+/g;
	return chkExp.test(str+"+");
}


//작성자	: 임은희
//목적	: Url 형식 체크 (형식이 유효할 경우 true + http://포함)
function f_chk_url(str)
{
	var chkExp = /http:\/\/([\w\-]+\.)+/g;
	return chkExp.test(str);
}

//작성자	: 임은희
//목적	: 아이디형식 체크
function f_chk_nonalphanum(str)
{
	var chkExp = /[\s]+/g;
	return chkExp.test(str);
}


// 메세지 바이트 계산 실시간
function string_len_calc (str)
{
  var len = 0;

  for (var i=0; i < str.length; i++) {
    var n = str.charCodeAt(i);
    if ((n >= 0)  && (n < 256))
      len ++;
    else
      len += 2;
  }
  return len;
}
// 메세지 바이트 계산 토탈
function string_len_util (str)
{
  var len = 0;

  for (var i=0; i < str.length; i++) {
    if (str.charCodeAt(i) > 128)
      len += 2;
    else
      len ++;
  }

  return len;
}

// 윈도우 오픈
function fnOpenWindowpost(url, w, h) {
	var	l, t, wintype ;
	h= h + 20;
	l = (screen.availWidth - w) / 2;
	t = (screen.availHeight - h) / 2;
	wintype	= "scrollbars=1,width=" + w + ",height=" + h + ",top=" + t + ",left=" + l;
	window.open(url, "l_join_Sub", wintype);
}

// 윈도우 오픈해서 작업 처리
function fnHiddenOpenWindowpost(url, w, h) {
	var	l, t, wintype ;
	l = 1000;
	t = 1000;
	wintype	= "scrollbars=1,width=" + w + ",height=" + h + ",top=" + t + ",left=" + l;
	window.open(url, "l_join_Sub", wintype);
}

// 길이 체크
function fnChkLength(obj, sURL)
{
    var posstring=/^([a-zA-Z0-9]{4,10})$/
	if(posstring.test(obj.value)==false)
	 {
		alert(obj.value + " 는 사용할 수 없는 아이디 입니다.  \n 아이디는 영문/숫자조합으로 5글자 이상이어야 합니다")
		return ;
	 }
	var sID = new String(obj.value);
	if (sID.length>=5) 
	   {
		window.open(sURL + "?id=" + sID, "checkid", "scrollbars=0,width=300,height=269,top=200,left=200");
	   }
    else
      {alert (sID.length);
		 alert ("아이디는 영문/숫자조합으로 5글자 이상이어야 합니다.");
		 obj.focus();
      }	   
}

// 회원가입시 체크
function checkValue(f)
{
    var j = f.elements.length
    var i;
    var re;
    var args;
    var result;
    
    for (i=0; i<j; i++)
    {
    	result = false;
        if (typeof(f.elements[i].tag) == "undefined") continue;

        args = f.elements[i].tag.split("||", 3);
        
        if (args[0]=='C') 
        {
            result = eval(args[1]+"(f.elements[i], f.elements[i].value);");
        }
        else if ((args[0]=='N') && (f.elements[i].value.length==0))
        {
			result = true;
        }
        else if ((args[0]=='M') || (args[0]=='N') ||
            ((args[0]=='O') && (f.elements[i].value.length>0)))
        {
            re = new RegExp(args[1], "gi");
            result = re.test(f.elements[i].value);
        }
        if (result == false)
        {
            if (args[2] != "") alert(args[2]);
            if (f.elements[i].type != "hidden")
				f.elements[i].focus();
            return false;
        }
    }
    return true;
}

// 화일입력창 추가
// <input type=hidden name=FILECNT value=1>
/*
function FnAddUploadFileForm()
{
	if(parseInt(document.FORM1.FILECNT.value) > 9) {
		alert("첨부화일은 10개까지만 가능합니다.");
		return;
	}
	document.all.ADDFILE.innerHTML += "<input type=file name=UPLOADFILE size=30 align=absmiddle style='border:1px solid #000000;'><br>";
	document.FORM1.FILECNT.value = parseInt(document.FORM1.FILECNT.value,10) + 1;
}
*/