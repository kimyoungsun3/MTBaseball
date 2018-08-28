//�ۼ��� : �ڼ���
//����	: ������ ���λ����� ���� �̹����� ũ�� ���ϴ� ũ�⿡ ������
//���� : <img src="�̹�����" onload="setSize(this, 435, 300)">	-> 435 �ʰ��� ��� ���� 300 ����
//			: <img src="�̹�����" onload="setSize(this, 435)">			-> 435 �ʰ��� ��� ���� 435 ����
function setSize(obj, maxWidth, sWidth) {
	if (sWidth == null)
		sWidth = maxWidth;

	if (obj.width > maxWidth)
		obj.width = sWidth;
}

//�ۼ��� : �ڼ���
//����	: ������ ������ �ؽ�Ʈ ũ�⸦ �۰�/ũ���ϱ� (pt/px���� ���� �˾Ƽ� �Ǵ�)
//���� :
//		<a href="javascript:ViewSize(View, 'm', 8)">�����۰� (�ּ�8)</a>
//		<a href="javascript:ViewSize(View, 'p', 15)">����ũ�� (�ִ�15)</a>
//		<div id="View" style="font-size:9pt">�ش系��</div>
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
			alert("����ũ�⸦ ���̻� �۰� �� �� �����ϴ�.");
	}
	else {
		if (limitSize != fontSize)
			area.style.fontSize = (fontSize + 1) + fontUnit;
		else
			alert("����ũ�⸦ ���̻� ũ�� �� �� �����ϴ�.");
	}
}

//�ۼ��� : �ڼ���
//����	: ��¥�� ������ �ùٸ��� üũ (���� �ùٸ���� true)
//			: 2004-02-31 ���� ���³�¥ üũ�� ������
//���	: ASP������ isDate("2004-02-31") ������� üũ�� ����
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

//�ۼ���	: ������
//����	: winPopup�� ����
function winOpenPop(rURL, Target, W, H, Scrolls) {
	var openWin = window.open(rURL, Target, "width="+W+",height="+H+",left=100,top=200,scrollbars="+Scrolls);
	openWin.focus();
}

//�ۼ���	: �ڼ���
//����	: �̹��� Ŭ���� ũ�⿡ �°� �˾�â ������ �ϱ�
//����: <img src="�̹�����" onclick="All_Image(this)">
function All_Image(imgURL) {
	winOpenPop("/common/imgView.asp?imgURL=" + imgURL.src, "imgView", 100, 100, "no,resizable=yes");
}

//�ۼ���	: ������
//������	: �ڼ���
//����	: trim �Լ���
function trim(str) {
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

//�ۼ���	: ������
//����	: Ctrl+N, F5 ����
//����	: <body onkeydown="return checkKey();">
function checkKey() {
	//Ctrl+N, F5 ����
	if ((event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode >= 112 && event.keyCode <= 123)) {
		//return false;
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
	return true;
}

//�ۼ���	: �ڼ���
//����	: ��� ��쿡�� â�ݱ� ���� ����� �ʰ� ������ â�ݱ�
//����	: <a href="JavaScript:winClose()">â�ݱ�</a>
function winClose() {
	self.opener = self;
	top.window.close();
}

//�ۼ��� : �ڼ���
//����	: �ش� ��Ű������ �� ����
//����	: document.write(getCookieVal("��Ű��", "������Ű��(������ ��������)"))
function getCookieVal(cookieName, subCookieName) {
	//��Ű�� ����
	var cookieVal = document.cookie;

	//��Ű���� ��ó���� ���� �������� ���� �Ǵ�, �������� �ε��� ����
	var cookieStartAt = cookieVal.indexOf(" " + cookieName + "=");
	var cookieEndAt;

	//������Ű ������ ��� �������� (trim �Լ����� ��������)
	if (subCookieName == null)
		subCookieName = "";

	//��Ű, ������Ű trimó��
	cookieName		= trim(cookieName);
	subCookieName	= trim(subCookieName);

	//�������� �ε��� ������ ��ó���� �ִٰ� �Ǵ�, �ٽ� �������� �ε��� ����
	if (cookieStartAt == -1)
		cookieStartAt = cookieVal.indexOf(cookieName + "=");

	//�������� �ε��� ������� ó��
	if (cookieStartAt != -1) {
		//��Ű���� �ش��ϴ� ���۰� �������� �ε��� ����
		cookieStartAt 	= cookieVal.indexOf("=", cookieStartAt) + 1
		cookieEndAt	= cookieVal.indexOf("; ", cookieStartAt);

		//������ �ε��� ������ ��Ű�� �ϳ��̰ų� ������ ������ �Ǵ�
		if (cookieEndAt == -1)
			cookieEndAt = cookieVal.length;

		//��Ű�� ���ϱ�
		cookieVal = cookieVal.substring(cookieStartAt, cookieEndAt);

		if (subCookieName == "") {
			//������Ű ���� ������ ������ �ش� ��Ű�� ���ڵ��Ͽ� ����
			cookieVal = unescape(cookieVal);
		}
		else {
			//������Ű ���� ���Ұ��

			//������Ű���� ��ó���� ���� �������� ���� �Ǵ�, �������� �ε��� ����
			cookieStartAt = cookieVal.indexOf("&" + subCookieName + "=");

			//�������� �ε��� ������ ��ó���� �ִٰ� �Ǵ�, �ٽ� �������� �ε��� ����
			if (cookieStartAt == -1)
				cookieStartAt = cookieVal.indexOf(subCookieName + "=");

			//�������� �ε��� ������� ó��
			if (cookieStartAt != -1) {
				//������Ű���� �ش��ϴ� ���۰� �������� �ε��� ����
				cookieStartAt 	= cookieVal.indexOf("=", cookieStartAt) + 1
				cookieEndAt	= cookieVal.indexOf("&", cookieStartAt);

				//������ �ε��� ������ ������Ű�� �ϳ��̰ų� ������ ������ �Ǵ�
				if (cookieEndAt == -1)
					cookieEndAt = cookieVal.length;

				//������Ű�� ���ϱ�
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

//�ۼ���	: ������
//������	: �ڼ���
//����	: iframe �ε� �� Resize
//����	: <iframe name="ifrm" onload="reSize(this.name)">
function reSize(f) {
	var objBody	= eval(f + ".document.body");
	var objFrame	= document.all[f];

	objFrame.style.height = objBody.scrollHeight + (objBody.offsetHeight - objBody.clientHeight) + 2;
}

//�ۼ���		: �ڼ���
//����		: Replace �Լ�
//���ǻ���	: �Ķ���Ϳ� ���ԽĿ� �ش��ϴ� Ư�����ڰ� ���ԵǸ� �뷫���� (���Խ����� �ν��ϱ� ���� - ���İ�������)
//��� ���	:
//	str_replace("aaAA bbb", "aa", "cc")			-> ��� : "ccAA bbb" (��ҹ��� ������ - Default)
//	str_replace("aaAA bbb", "aa", "cc", "i")	-> ��� : "cccc bbb" (��ҹ��� ��������)
function str_replace(str, old_str , new_str, i) {
	var expStr;

	if (i == "i") {
		//��ҹ��� ��������
		expStr = eval("/" + old_str + "/gi");
	}
	else {
		//��ҹ��� ����
		expStr = eval("/" + old_str + "/g");
	}

	return str.replace(expStr, new_str);
}

//------------ ���ڼ� byte������ ����ϰ� �߶��ִ� �Լ� ���� ------------------//
//�ۼ���	: �ڼ���
//��뿹	: <textarea name="tmpTxt" onKeyUp="byteChk(this, nowLenTxt, 2000)"></textarea>
//
//		���� <span id="nowLenTxt">0</span>/�ִ� 2000byte
//		(���� byte ��Ȳ�� ǥ������ �������� byteChk(this, null, 2000)�� ���)
//
//		�� �ݵ�� �� ���۽� üũ�ϴ� �Լ� �κп� �����ڵ� ���� ��
//		�� (�ѱ� �Է½� �̺�Ʈ �����δ� �Ϻ��ϰ� üũ�� ���ϴ� ��찡 �߻��ϱ� ����) ��
//
//		if (!byteChk(���̸�.tmpTxt, nowLenTxt, 2000)) {
//			return false;
//		}
//
//		�� ������ �ټ� �����ϴ� ���ǻ����� �����ø� ����� ��

function byteChk(chkInput, nowLen, maxLen, pm) {
	var length = calculate_msglen(chkInput.value);

	if (nowLen != null) {
		if (pm == "p")	//���� �����Ǵ�..
		{
			nowLen.innerText = length;
		}else{			//���� ���ҵǴ�..
			nowLen.innerText = maxLen - length;
		}
	}

	if (length > maxLen) {
		alert("�ִ� " + maxLen + "byte�̹Ƿ� �ʰ��� ���� ���� �ڵ����� �����˴ϴ�.");
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
//------------ ���ڼ� byte������ ����ϰ� �߶��ִ� �Լ� �� ------------------//

//�ۼ���	: �ڼ���
//����	: ���� ���� üũ (������ ��ȿ�� ��� true)
//��ȿ����: xx@yyy.zzz (����, ����, �����(_), ��ħǥ(.), �뽬(-)�� ���)
function emailCheck(email) {
	var chkExp = /^\s*[\w\-\.]+\@[\w\-]+(\.[\w\-]+)+\s*$/g;
	return chkExp.test(email);
}

//�ۼ���	: �ڼ���
//����	: ��ϱ��� �̸��� üũ (��ϱ��� �̸����� ��� alertâ�� ���޽��� ��� �� true)
function invalidEmailCheck(email) {
	var invalidEmail		= new Array();
	var tempStr		= email.split("@");

	invalidEmail[0]		= new Array();
	invalidEmail[0][0]	= "hanmail.net";
	invalidEmail[0][1]	= "�Ѹ��ϳ�";
	invalidEmail[1]		= new Array();
	invalidEmail[1][0]	= "daum.net";
	invalidEmail[1][1]	= "������";

	for (i=0; i<invalidEmail.length; i++) {
		if (trim(tempStr[1])== invalidEmail[i][0]) {
			alert("�¶��� ��ǥ���� �������� ���� " + invalidEmail[i][1] + "(" + invalidEmail[i][0] + ")�� ����Ͻ� �� �����ϴ�.");
			return true;
		}
	}

	return false;
}

//�ۼ���	: �ڼ���
//����	: �� �ڵ��̵� (���۰�ü, �̵��Ұ�ü, �����Է¼�)
//��뿹	: <input type="text" name="tel2" size=4 maxlength=4 onKeyUp="tabMove(this, memTel3, 4)">
function tabMove(fromInput, toInput, num) {
	if (trim(fromInput.value).length == num) {
		toInput.focus();
	}
}

//�ۼ���	: �ڼ���
//����	: ���� �ʵ忡�� ���ڸ� �Է� �����ϰ� ���� (���� ���ų� �ڸ����� �´� ������ ��� true)
//����	: <input type="text" name="tel2" size=4 maxlength=4 onblur="numChk(this, '��ȭ��ȣ', 3, 4)">
function numChk(obj, objName, minNum, maxNum) {
	var numVal = trim(obj.value);
	var numLen= numVal.length;

	if (numVal != "") {
		if (isNaN(numVal)) {
			alert(objName + "(��)�� ���ڸ� �Է��� �ֽñ� �ٶ��ϴ�.");
			obj.value="";
			obj.focus();
			return false;
		}

		if (minNum != maxNum) {
			if (numLen < minNum || numLen > maxNum) {
				alert(objName + "(��)�� " + minNum + "~" + maxNum + "�ڸ��� �������� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
				obj.value="";
				obj.focus();
				return false;
			}
		}
		else {
			if (numLen != minNum) {
				alert(objName + "(��)�� " + minNum + "�ڸ��� ��Ȯ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
				obj.value="";
				obj.focus();
				return false;
			}
		}
	}

	return true;
}

// ��ũ�ѹ� �ִ� POP_UP
function f_open_win(url, w, h) {
	var win = window.open(url, "winname", "resizable=no,scrollbars=yes,x=100,y=200,width=" + w + ",height=" + h);
	win.focus();
}

// ��ũ�ѹ� ���� POP_UP
function f_open_win2(url, w, h) {
	var win = window.open(url, "winname", "resizable=no,scrollbars=no,x=100,y=200,width=" + w + ",height=" + h);
	win.focus();
}

// NULL ���� ��ũ
function f_nul_chk(obj, lbl) {
	if (trim(obj.value) == "") {
		alert("�ʼ��׸� " + lbl + " �Է��Ͻʽÿ�.");
		obj.focus();
		return true;
	}
	return false;
}

// ���� üũ
function f_len_chk(obj, lbl, num) {
	if (trim(obj.value).length < num) {
		alert(lbl + " " + num + "���� �̻� �Է��Ͻʽÿ�.");
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
				alert (msg + "�� ��Ÿ�� �Է��� �ּ���.");
				obj2.focus();
				return true;
			}
		}
	}
	if (flag != 1) {
		alert("�ʼ��׸��� " + msg + " �Է����ֽʽÿ�.");
		obj[0].focus();
		return true;
	}
	return false;
}

// ���� ���� üũ
function f_is_num(obj, lbl) {
	var nVal = trim(obj.value);

	if (isNaN(nVal)) {
		alert(lbl + " ���ڸ� �Է��� �� �ֽ��ϴ�.");
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

// ���� ��ư üũ
function f_rdb_chk(obj, msg) {
	var i, flag = 0;
	for (i = 0; i < obj.length; i++) {
		if (obj[i].checked)
			flag = 1;
	}
	if (flag != 1) {
		alert("�ʼ��׸��� " + msg + " �Է����ֽʽÿ�.");
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

		// �ѱ� ���ڼ� ���(����)
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
			alert(lbl + " �ѱ� " + nHan + " ��, ���� " + nByte + " �� �̳��� �Է��Ͻʽÿ�.");
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
		alert("�ʼ��׸��� " + msg + " �Է����ֽʽÿ�.");
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
				alert(lbl + "�����̳� Ư�����ڰ� �� �� �����ϴ�");
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
				alert(lbl + " �����̳� �ѱ۸� �Է��� �����մϴ�.");
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
		alert("�߸��� �ֹι�ȣ�Դϴ�.\n�ٽ� Ȯ���� �ּ���.");
		return true;
	}

	if (CurrAge < num) {
		alert("��ȣ�ڴ� �� " + num + "�� �̻� �����մϴ�.");
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
		alert('�߸��� �ֹι�ȣ�Դϴ�.\n�ٽ� Ȯ���� �ּ���.');
		return true;
	}

	if (flag == 1)
	{
		if (CurrAge < num)
		{
			alert('���� �����ϰ� ��� ȸ�������� �� ' + num + '�� �̻� ���� �����մϴ�.');
			return true;
		}
	}
	else
	{
		if (CurrAge >= num)
		{
			alert('���� �����ϰ� ��� ȸ�������� �� ' + num + '�� �̸��� ���� �����մϴ�.');
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
		alert('��ȭ��ȣ�� ��� �Ѱ����� �Է��ϼž� �մϴ�.');
		obj1.focus();
		return true;
	}
		
	if(obj1.value != '')
	{
		if(obj2.value == '')
		{
			alert('�̵���Ź�ȣ ��Ȯ�ϰ� �Է��ϼž� �մϴ�.');
			obj2.focus();
			return true;
		}
		else if(obj3.value == '')
		{
			alert('�̵���Ź�ȣ ��Ȯ�ϰ� �Է��ϼž� �մϴ�.');
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
			alert('����ȭ��ȣ�� ��Ȯ�ϰ� �Է��ϼž� �մϴ�.');
			obj5.focus();
			return true;
		}
		else if(obj6.value == '')
		{
			alert('����ȭ��ȣ�� ��Ȯ�ϰ� �Է��ϼž� �մϴ�.');
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


//�ۼ���	: ������
//����	: ����ڵ�Ϲ�ȣüũ(10�ڸ��� ��ȣ)
function f_chk_businno(businno) 
{ 
	  if (businno.length != 10) 
	  { 
			 alert("����ڵ�Ϲ�ȣ�� �߸��Ǿ����ϴ�."); 
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
			 alert("����ڵ�Ϲ�ȣ�� �߸��Ǿ����ϴ�."); 
			 return false; 
	  } 
	  return true; 
} 

//�ۼ���	: ������
//����	: ��ȭ��ȣ üũ(������ ��ȿ�� ��� true)
function f_chk_telno(str)
{
	var chkExp = /0\d{1,2}-\d{3,4}-\d{4}\+/g;
	return chkExp.test(str+"+");
}


//�ۼ���	: ������
//����	: Url ���� üũ (������ ��ȿ�� ��� true + http://����)
function f_chk_url(str)
{
	var chkExp = /http:\/\/([\w\-]+\.)+/g;
	return chkExp.test(str);
}

//�ۼ���	: ������
//����	: ���̵����� üũ
function f_chk_nonalphanum(str)
{
	var chkExp = /[\s]+/g;
	return chkExp.test(str);
}


// �޼��� ����Ʈ ��� �ǽð�
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
// �޼��� ����Ʈ ��� ��Ż
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

// ������ ����
function fnOpenWindowpost(url, w, h) {
	var	l, t, wintype ;
	h= h + 20;
	l = (screen.availWidth - w) / 2;
	t = (screen.availHeight - h) / 2;
	wintype	= "scrollbars=1,width=" + w + ",height=" + h + ",top=" + t + ",left=" + l;
	window.open(url, "l_join_Sub", wintype);
}

// ������ �����ؼ� �۾� ó��
function fnHiddenOpenWindowpost(url, w, h) {
	var	l, t, wintype ;
	l = 1000;
	t = 1000;
	wintype	= "scrollbars=1,width=" + w + ",height=" + h + ",top=" + t + ",left=" + l;
	window.open(url, "l_join_Sub", wintype);
}

// ���� üũ
function fnChkLength(obj, sURL)
{
    var posstring=/^([a-zA-Z0-9]{4,10})$/
	if(posstring.test(obj.value)==false)
	 {
		alert(obj.value + " �� ����� �� ���� ���̵� �Դϴ�.  \n ���̵�� ����/������������ 5���� �̻��̾�� �մϴ�")
		return ;
	 }
	var sID = new String(obj.value);
	if (sID.length>=5) 
	   {
		window.open(sURL + "?id=" + sID, "checkid", "scrollbars=0,width=300,height=269,top=200,left=200");
	   }
    else
      {alert (sID.length);
		 alert ("���̵�� ����/������������ 5���� �̻��̾�� �մϴ�.");
		 obj.focus();
      }	   
}

// ȸ�����Խ� üũ
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

// ȭ���Է�â �߰�
// <input type=hidden name=FILECNT value=1>
/*
function FnAddUploadFileForm()
{
	if(parseInt(document.FORM1.FILECNT.value) > 9) {
		alert("÷��ȭ���� 10�������� �����մϴ�.");
		return;
	}
	document.all.ADDFILE.innerHTML += "<input type=file name=UPLOADFILE size=30 align=absmiddle style='border:1px solid #000000;'><br>";
	document.FORM1.FILECNT.value = parseInt(document.FORM1.FILECNT.value,10) + 1;
}
*/