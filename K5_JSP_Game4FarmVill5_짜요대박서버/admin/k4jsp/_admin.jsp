<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@include file="_define.jsp"%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.adminId, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.adminId.focus();">
<center><br><br><br>
<br>
<center>
<table border=1>
	<tbody>
	<tr>
		<td>
			<a href=notice_list.jsp>공지사항10</a>					<br>
			<a href=sysrecom_list.jsp>추천게임</a>					<br>
			<a href=sysinquire_list.jsp>유저문의</a>				<br><br>

			<a href=cashtotal_list2.jsp>수정구매통계(월별)</a>		<br>
			<a href=statistics_day.jsp>일반 접속/가입통계(일별)</a>	<br>
			<a href=push_list.jsp>@Push관리</a>						<br><br>

			<a href=eventdaily_list.jsp>이벤트(시간지정)</a>		<br>
			<a href=eventdailyuser_list.jsp>이벤트(리스트)</a>		<br>
		</td>
		<td>
			<a href=userinfo_list.jsp>유저정보</a>					<br><br>

			<a href=useritembuylogtotal_mas.jsp>아이템 판매통계(일별)</a><br>
			<a href=useritembuylogtotal_mon.jsp>아이템 판매통계(월별)</a><br>
			<a href=userroullogtotal_mas.jsp>보물뽑기(일별로그)</a>	<br>
			<a href=userroullog_list.jsp>보물뽑기(유저상세)</a>		<br>
			<a href=userroullogtotal_sub2.jsp>보물뽑기(전체통계개별)</a><br>
			<a href=userroullogtotal_sub3.jsp>보물뽑기(전체통계전체)</a><br><br>

			<a href=cashbuy_list.jsp>수정구매로그(유저별상세)</a>	<br>
			<a href=cashtotal_list.jsp>수정구매통계(종류별)</a>		<br>
			<a href=cashtotal_list2.jsp>수정구매통계(월별)</a>		<br><br>
		</td>
		<td>
			<a href=wgiftsend_form.jsp>선물하기</a>					<br>
			<a href=wgiftsend_list.jsp>선물리스트</a>				<br><br>

			<a href=iteminfo_list.jsp>아이템목록</a>				<br><br>

			<a href=systempack_list.jsp>패키지상품(구성하기)</a>	<br>
			(5개의 상품을 한개묶음으로 판매)						<br><br>

			<a href=systemroul_list.jsp>뽑기상품(구성하기.)</a>		<br>
			(40개중 1개의 상품을 하트나 결정으로 뽑기)				<br>
			<a href=systeminfo_list2.jsp>뽑기/강화/회전판/복귀</a>	<br>
			뽑기:할인/보상/확률/무료뽑기							<br>
			강화:강화할인											<br>
			회전판(룰렛):무료회전판
		</td>
		<td>
			<a href=unusual_list.jsp>비정상(관리용)</a>				<br>
			<a href=unusual_list2.jsp>비정상2(관리용)</a>			<br>
			<a href=blockphone_list.jsp>블럭핸드폰(관리용)</a>		<br>
			<a href=notpushphone_list.jsp>Push불가리스트(관리용)</a><br>
			<a href=certno_list.jsp>쿠폰리스트(관리용)</a>			<br>
			<a href=rankschedule_list.jsp>랭키스케쥴(관리용)</a>	<br>
			<a href=changenickname_list.jsp>닉네임변경(관리요)</a>	<br>
			<a href=userrecommand_list.jsp>추천인관리</a>						<br><br>
			
			<a href=userrank_list.jsp>현재랭킹 100위(판매)</a>	<br>
			<a href=userrank2_list.jsp>현재랭킹 100위(환생)</a>	<br>
			<a href=userrank_mas.jsp>개인랭킹 지난랭킹 100위(판매)</a>	<br>
			<a href=userrank_mas2.jsp>환생랭킹 지난랭킹 100위(환생)</a>	<br>
			<a href=userfreecashlog_list.jsp>무료로고(관리요)</a>	<br><br>

			<a href=userroullog_list.jsp>보물뽑기(유저상세)</a>			<br>
			<a href=rouladlist_list.jsp>보물뽑기광고(관리용)</a>	<br>
			<a href=tsupgrade_list.jsp>강화로고(관리용)</a>			<br>
			<a href=wheel_list.jsp>회전판로고(관리용)</a>			<br><br>


			<a href=userrk_list.jsp>개인랭킹대전</a>				<br><br>

			<a href=rebirth_list.jsp>환생로그</a>					<br><br>

			<a href=userchack1_list.jsp>무과금, 5만 결정보유</a>	<br>
			<a href=userchack2_list.jsp>무과금, 2만 VIP보유</a>		<br>
			<a href=userchack3_list.jsp>무과금, 520까지 진화</a>	<br>
			<a href=userchack4_list.jsp>과금, 4배이상 차이발생</a>	<br><br>

			<!--<a href=userchack5_list.jsp>보석강화</a>				<br>-->
		</td>
	</tr>
</tbody></table>
</center>
</body>
