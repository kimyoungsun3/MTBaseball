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
			<a href=notice_list.jsp>@공지사항10</a>				<br>
			<a href=push_list.jsp>Push관리</a>					<br>
			<a href=sysinquire_list.jsp>@유저문의</a>			<br><br>

			<a href=cashtotal_list2.jsp>루비구매통계(월별)</a>	<br>
			<a href=statistics_day.jsp>일반 접속/가입통계(일별)</a><br>
			<!--<a href=statistics_main.jsp>유저레벨통계(일별)</a>	<br>-->
			<a href=statistics_sub2.jsp>유저레별(관리용)</a><br>
			<a href=statistics_sub3.jsp>유저통신사별(관리용)</a><br><br>

			<a href=sysevent_list.jsp>이벤트공유</a>			<br><br>

			<a href=eventdaily_list.jsp>@이벤트(시간지정)</a>	<br>
			<a href=eventdailyuser_list.jsp>이벤트(리스트)</a>	<br>
		</td>
		<td>
			
			<a href=userinfo_list.jsp>유저정보</a>				<br>
			<a href=useritembuylogtotal_mas.jsp>아이템 판매통계(일별)</a><br>
			<a href=useritembuylogtotal_mon.jsp>아이템 판매통계(월별)</a><br>
			<a href=userroullogtotal_mas.jsp>동물뽑기로그</a>	<br>
			<a href=usertreasurelogtotal_mas.jsp>보물뽑기로그</a><br>
			<a href=useryabau_sub.jsp>주사위통계(일별)</a><br>
			<a href=useryabau_mon.jsp>주사위통계(월별)</a><br>
			<a href=useritemupgradelogtotal_mas.jsp>아이템 강화통계(일별)</a><br><br>
			(일반적인 통계자료를 수집합니다.)					<br><br>

			<a href=cashbuy_list.jsp>루비구매로그(유저별상세)</a>			<br>
			<a href=cashtotal_list.jsp>루비구매통계(종류별)</a>			<br>
			<a href=cashtotal_list2.jsp>루비구매통계(월별)</a>	<br><br>
			<a href=cashtotal_list3.jsp>루비구매통계(일별유니크)</a>	<br><br>
			<!--
			<a href=useretc_push_total.jsp>Push통계</a>			<br><br>
			-->
		</td>
		<td>

			<a href=wgiftsend_form.jsp>선물하기</a>					<br>
			<a href=wgiftsend_list.jsp>선물리스트</a>				<br><br>

			<a href=systeminfo_list.jsp>@루비,코인,하트,업글,룰렛(MAX)</a><br>
			(프로모션 루비, 코인, 하트,악세뽑기 변경)				<br>
			(아이템 테이블 변경되면 한번씩 변경함)					<br>
			(집,탱크,품질,축사,양동이,착유기,주입기Max)				<br><br>
			<a href=systempack_list.jsp>패키지상품(구성하기)</a>	<br>
			(5개의 상품을 한개묶음으로 판매)						<br><br>

			<a href=systeminfo_list2.jsp>@동물뽑기관리</a>			<br>
			(보상, 확률증가, 무료뽑기)								<br>
			<a href=systemroul_list.jsp>동물뽑기상품(구성하기.)</a><br>
			(50개중 1 ~ 10개의 상품을 하트나 루비으로 뽑기)			<br><br>

			<a href=systeminfo_list3.jsp>@보물뽑기관리</a>			<br>
			(보상, 확률증가, 무료뽑기, 강화)								<br>
			<a href=systemroul_list2.jsp>보물뽑기상품(구성하기.)</a><br>
			(50개중 1 ~ 10개의 상품을 하트나 루비으로 뽑기)			<br><br>


			<a href=systemyabau_list.jsp>행운의 주사위(구성하기.)</a><br>
			<a href=systemfarm_list.jsp>목장배틀 구성(구성하기.)</a><br><br>


			<a href=systemboard_list.jsp>게시판</a>					<br>
			<a href=userrank_list.jsp>현재랭킹(판매)</a>			<br>
			<a href=userrank_list2.jsp>현재랭킹(트로피)</a>			<br>
			<a href=userrank_mas.jsp>지난랭킹(판매)</a>				<br>
			<a href=userrank_mas2.jsp>지난랭킹(트로피)</a>			<br>
			<a href=userrk_list.jsp>랭킹대전</a>					<br>
			<!--
			<a href=schoolmaster_list.jsp>학교대항(진행중)</a>		<br>
			<a href=schoollastweek_list.jsp>학교대항지난(지난내용)</a><br><br>
			<a href=roulettelogtotal_list.jsp>룰렛통계</a>		<br>
			<a href=statistics_rank.jsp>랭킹통계</a>			<br>
			-->
		</td>
		<td>
			(비활성화 될 예정)<br>
			<a href=iteminfo_list.jsp>아이템정보(시스템)</a>		<br>
			<a href=iteminfo_list2.jsp>아이템정보(단계별:프로그램)</a>	<br>
			<a href=iteminfo_list3.jsp>아이템정보(단계별:이미지)</a><br>
			<a href=usertradeproduct.jsp>상인만족상품</a><br><br>
			<!--
			<a href=systemroulfresh_list.jsp>뽑기상품Fresh(시스템)</a>	<br>
			(신선도 기준으로 뽑기)								<br><br>
			-->
			<a href=certno_list.jsp>@쿠폰리스트(관리용)</a>		<br><br>
			<a href=systemvip_list.jsp>@VIP 정보(관리용)</a>	<br><br>
			<a href=zcplog_list.jsp>@짜요쿠폰조각 정보(관리용)</a><br>
			<a href=zcpmanager_list.jsp>@짜요장터 상품관리(관리용)</a><br>
			<a href=zcporder_list.jsp>@짜요장터 주문관리(관리용)</a><br><br>


		</td>
		<td>
			(비활성화 될 예정)<br>
			<a href=adminuserbattlebank_list.jsp>유저배틀Bank(관리용)</a><br>
			<a href=adminusersalelog_list.jsp>거래내역(관리용)</a><br>
			<a href=adminfarmbattlelog_list.jsp>목장배틀(관리용)</a><br>
			<a href=adminuserbattlelog_list.jsp>유저배틀(관리용)</a><br>
			<a href=userdellog_list.jsp>유저판매/합성/분해(관리용)</a><br>
			<a href=unusual_list.jsp>비정상내용(관리용)</a>		<br>
			<a href=unusual_list2.jsp>비정상내용2(관리용)</a>	<br>
			<a href=userblock_list.jsp>블럭계정(치트유저)</a>	<br>
			<a href=blockphone_list.jsp>블럭핸드폰(치트유저)</a><br>
			<a href=blockphone_list2.jsp>블럭Push(관계사직원미발송)</a><br>
			<a href=userdelete_list.jsp>삭제계정(관리용)</a>	<br>
			<a href=rouladlist_list.jsp>광고(교배,보물,룰렛)</a>	<br>
			<a href=userroullog_list.jsp>뽑기정보(관리용)</a>	<br>
			<a href=usercomplog_list.jsp>합성정보(관리용)</a>	<br>
			<a href=userpromotelog_list.jsp>승급정보(관리용)</a>	<br>
			<a href=userroullog_list2.jsp>악세뽑기정보(관리용)</a><br>
			<a href=userroullog_list3.jsp>주사위(관리용)</a><br>
			<a href=adminaction_list.jsp>관리자액션(관리용)</a>	<br>
			<a href=statistics_phone.jsp>유니크핸드폰가입(관리용)</a><br>
			<!--<a href=statistics_main.jsp>유저레벨통계(관리용)</a><br>-->
			<a href=statistics_sub2.jsp>유저레별(관리용)</a><br>
			<a href=statistics_sub3.jsp>유저통신사별(관리용)</a><br>
			<a href=usercomreward.jsp>유저퀘스트(관리용)</a><br>
			<a href=usermarket_list.jsp>유저마켓이동(관리용)</a><br>
			<a href=changenickname_list.jsp>닉네임변경(관리용)</a><br>
			<a href=userdielog_list.jsp>유저동물죽은(관리용)</a><br>
			<a href=useralivelog_list.jsp>유저동물부활(관리용)</a><br>
			<a href=userkakaouserid_list.jsp>Kakaouserid(관리용)</a><br>


			<!--
			<a href=zgamename_list.jsp>농장이름(상상관리용)</a>	<br>
			<a href=../_test/farm.htm>전달파일(상상관리용)</a>	<br>
			<a href=zgameinfo_list.jsp>타회사게임(상상관리용)</a><br>
			<a href=zgamemonth_list.jsp>정보입력(상상관리용)</a><br>
			-->

		</td>
	</tr>
</tbody></table>
</center>
</body>
